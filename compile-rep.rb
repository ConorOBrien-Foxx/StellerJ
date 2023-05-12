require 'strscan'

require 'colorize' # gem install colorize

Token = Struct.new :raw, :type, :line, :col

name = "[a-zA-Z_]+"
control_words = %w(
    assert break continue for if else elseif end do
    return select case fcase throw while whilst
    try catcht
    for_NAME goto_NAME label_NAME
).map { |word| word.sub("NAME", name) + "\\." }
$match_control = /#{control_words * "|"}/
$match_string = /'(''|[^'])*'/
$match_comment = /NB\..*(?:\n|$)/

def parent_symbol(word)
    case word
    when "if.";             :if
    when "while.";          :while
    when "whilst.";         :whilst
    when "try.";            :try
    when /^for/;            :for
    when "case.", "fcase."; :case
    when "select.";         :select
    # for context termination
    when "end.";            :end
    else;                   nil
    end
end

EVALUATED = 1
UNEVALUATED = 2
def evaluation_code(parent)
    case parent
    when :if, :while, :whilst, :for, :case, :select
        #, :try
        UNEVALUATED
    else
        EVALUATED
    end
end

def control_code(word, parent, do_parent)
    case word
    # 0: unused?
    # 1: evaluated expression
    # 2: held expression
    when "do."
        case do_parent
        when :if, :while, :whilst;  3
        when :for;                  18
        when :case;                 24
        else
            raise "Expected known parent for do., got #{do_parent}"
        end
    when "end."
        case parent
        when :if, :for, :while, :whilst, :try;  6
        when :select;                           26
        else
            raise "Expected known parent for end., got #{parent}"
        end
    when "if.";         4
    when "else.";       5
    # if./for./while./whilst.'s end.
    when "while.";      7
    when "whilst.";     8
    when "elseif.";     9
    when "try.";        10
    when "catch.";      11
    # 12?
    when "continue.";   13
    when /^label_/;     14
    when /^goto_/;      15
    when "return.";     16
    when /^for/;        17
    # 18 - for.'s do.
    when "break.";      19
    when "select.";     20
    # 21?
    when "case.";       22
    when "fcase.";      23
    # 24 - case.'s do.
    when "assert.";     25
    # 26 - case.'s end.
    when "throw.";      27
    when "catchd.";     28
    when "catcht.";     29
    else
        raise "Unhandled word: #{word}"
    end
end

$control_roster = [
    [$match_comment, :comment],
    [$match_string, :sequence], # string
    [$match_control, :control],
    [/\s+/, :sequence], # whitespace
    [/./, :sequence],
]
$tokenize_roster = [
    [/\d[\d ]*/, :noun],
    [$match_control, :control],
    [/\S[.:]+/, :command],
    [/#{name}/, :word],
    [/\S/, :command],
    [/\r?\n/, :linesep],
    [/\s/, :whitespace],
    # since . does not match LF, removing whitespace will cause program to hang
    [/./, :unknown],
]
def tokenize(string, roster)
    ss = StringScanner.new string
    tokens = []
    line = 0
    col = 0
    until ss.eos?
        token = Token.new
        roster.each { |reg, type|
            token.raw = ss.scan reg
            unless token.raw.nil?
                token.line = line
                token.col = col
                token.type = type
                lf_count = token.raw.count("\n")
                line += lf_count
                if lf_count.zero?
                    col += token.raw.size
                else
                    col = 0
                end
                break
            end
        }
        tokens << token# unless token.type == :whitespace
    end
    tokens
end

def show_tokens(tokens)
    tokens.each.with_index { |token, i|
        print "#{i}:".ljust 4
        print "#{token.line}:#{token.col}".ljust 8
        print token.type.to_s.ljust 12
        puts  token.raw
    }
end

def group_control(code)
    tokenize(code, $control_roster)
    # .tap { |tokens| p "TOKENS!"; p tokens }
    .reject { |token| token.type == :comment }
    .slice_when { |a, b| a.type != b.type }
    .flat_map { |sub|
        sub_type = sub[0].type
        case sub_type
        when :sequence
            # use the correct line: first non-whitespace token, if applicable
            base = sub.find { |token| /\S/ =~ token.raw } || sub[0]
            result = base.dup
            result.raw = sub.map(&:raw).join.strip
            result
        when :control
            sub # handled by flat map
        else
            raise "Unhandled roster type #{sub_type}"
        end
    }
    .reject { |token| token.raw.empty? }
end

def box_control(code)
    parent_stack = []
    evaluate_parent_stack = []
    do_parent = nil
    group_control(code)
    .map.with_index { |token, i|
        table = case token.type
        when :control
            # p [token.raw, parent_stack]
            code = control_code token.raw, parent_stack.last, do_parent
            evaluate_parent = do_parent = parent_symbol(token.raw)
            parent = evaluate_parent || parent_stack.last
                # p evaluate_parent
            if evaluate_parent == :end
                parent_stack.pop
                evaluate_parent_stack.pop
            elsif evaluate_parent == :case
                # modify the top
                do_parent = evaluate_parent
            elsif evaluate_parent
                # things that must be matched
                parent_stack << parent
                evaluate_parent_stack << evaluate_parent
            end
            
            # TODO: target line
            # TARGETS:
            # if. for. while. whilst. select. case. fcase.
            # - targets expression body (next line, usually)
            # throw. fixed 65535
            target = case token.raw
            when "throw.";      -1
            else;               nil
            end
            [ code, target, token.line ]
        when :sequence
            code = evaluation_code do_parent
            [ code, -1, token.line ]
        else
            raise "Unhandled token type: #{token.type}"
        end
        [ i, table, token.raw ]
    }
end

def test(code, cases)
    parsed_cases = cases
        # .strip
        .lines
        .each_slice(2)
        .map(&:last)[0...-1]
        .map { |line|
            /(\d+)\s*([│|])\s*(\d+) (\d+) (\d+)\s*\2(.+?)\2/ =~ line
            line = $1.to_i
            # sep = $2
            ins_code = $3.to_i
            target = $4.to_i
            if target == 65535
                target = -1
            else
                target = nil # TODO
            end
            source_line = $5.to_i
            raw = $6.strip
            [line, [ins_code, target, source_line], raw]
        }
    # puts "Testing:"
    code.lines.each { |line|
        puts "| #{line}"
    }
    # puts
    # puts "Result:"
    box_control(code).zip(parsed_cases) { |row, expected|
        if row[0...-1] != expected[0...-1]
            puts "- #{row.inspect}".light_red
            puts "+ #{expected.inspect}".light_yellow
        else
            puts row.inspect.green
        end
    }
    # puts "-"*50
    # puts
end

# below generated using J's output of 1 (5!:7) <'perm'
# https://www.jsoftware.com/help/dictionary/dx005.htm
# instruction number ; (control word code ; goto line number ; source line number) ; raw
# line number 65535: -1/eof/none

test <<CODE, <<TEST
z=. i.1 0
for. i.y do. z=.,/(0,.1+z){"2 1\:"1=i.>:{:$z end.
CODE
┌─┬─────────┬───────────────────────────────┐
│0│1 65535 0│z=.i.1 0                       │
├─┼─────────┼───────────────────────────────┤
│1│17 2 1   │for.                           │
├─┼─────────┼───────────────────────────────┤
│2│2 65535 1│i.y                            │
├─┼─────────┼───────────────────────────────┤
│3│18 6 1   │do.                            │
├─┼─────────┼───────────────────────────────┤
│4│1 65535 1│z=.,/(0,.1+z){"2 1\:"1=i.>:{:$z│
├─┼─────────┼───────────────────────────────┤
│5│6 3 1    │end.                           │
└─┴─────────┴───────────────────────────────┘
TEST


test <<CODE, <<TEST
select. y
fcase. 'A' do.
case. 'a' do.
  smoutput 'select a'
fcase. 'B' do.
case. 'b' do.
  smoutput 'select b'
case. do.    NB. optional catch-all case
  smoutput 'none of these'
end.
CODE
┌──┬─────────┬───────────────────────┐
│0 │20 1 0   │select.                │
├──┼─────────┼───────────────────────┤
│1 │2 65535 0│y                      │
├──┼─────────┼───────────────────────┤
│2 │23 3 1   │fcase.                 │
├──┼─────────┼───────────────────────┤
│3 │2 65535 1│'A'                    │
├──┼─────────┼───────────────────────┤
│4 │24 6 1   │do.                    │
├──┼─────────┼───────────────────────┤
│5 │22 8 2   │case.                  │
├──┼─────────┼───────────────────────┤
│6 │2 65535 2│'a'                    │
├──┼─────────┼───────────────────────┤
│7 │24 10 2  │do.                    │
├──┼─────────┼───────────────────────┤
│8 │1 65535 3│smoutput'select a'     │
├──┼─────────┼───────────────────────┤
│9 │23 19 4  │fcase.                 │
├──┼─────────┼───────────────────────┤
│10│2 65535 4│'B'                    │
├──┼─────────┼───────────────────────┤
│11│24 13 4  │do.                    │
├──┼─────────┼───────────────────────┤
│12│22 15 5  │case.                  │
├──┼─────────┼───────────────────────┤
│13│2 65535 5│'b'                    │
├──┼─────────┼───────────────────────┤
│14│24 17 5  │do.                    │
├──┼─────────┼───────────────────────┤
│15│1 65535 6│smoutput'select b'     │
├──┼─────────┼───────────────────────┤
│16│22 19 7  │case.                  │
├──┼─────────┼───────────────────────┤
│17│24 18 7  │do.                    │
├──┼─────────┼───────────────────────┤
│18│1 65535 8│smoutput'none of these'│
├──┼─────────┼───────────────────────┤
│19│26 20 9  │end.                   │
└──┴─────────┴───────────────────────┘
TEST

test <<CODE, <<TEST
 try. 
  sub y
 catcht.
  select. type_jthrow_
   case. 'aaaa' do. 'throw aaaa'  
   case. 'bbb'  do. 'throw bbb'   
   case. 'cc'   do. 'throw cc' 
   case.        do. throw.   NB. handled by a higher-level catcht. (if any)
  end.
 end.
CODE
┌──┬──────────┬────────────┐
│0 │10 2 0    │try.        │
├──┼──────────┼────────────┤
│1 │1 65535 1 │sub y       │
├──┼──────────┼────────────┤
│2 │29 21 2   │catcht.     │
├──┼──────────┼────────────┤
│3 │20 4 3    │select.     │
├──┼──────────┼────────────┤
│4 │2 65535 3 │type_jthrow_│
├──┼──────────┼────────────┤
│5 │22 6 4    │case.       │
├──┼──────────┼────────────┤
│6 │2 65535 4 │'aaaa'      │
├──┼──────────┼────────────┤
│7 │24 10 4   │do.         │
├──┼──────────┼────────────┤
│8 │1 65535 4 │'throw aaaa'│
├──┼──────────┼────────────┤
│9 │22 20 5   │case.       │
├──┼──────────┼────────────┤
│10│2 65535 5 │'bbb'       │
├──┼──────────┼────────────┤
│11│24 14 5   │do.         │
├──┼──────────┼────────────┤
│12│1 65535 5 │'throw bbb' │
├──┼──────────┼────────────┤
│13│22 20 6   │case.       │
├──┼──────────┼────────────┤
│14│2 65535 6 │'cc'        │
├──┼──────────┼────────────┤
│15│24 18 6   │do.         │
├──┼──────────┼────────────┤
│16│1 65535 6 │'throw cc'  │
├──┼──────────┼────────────┤
│17│22 20 7   │case.       │
├──┼──────────┼────────────┤
│18│24 19 7   │do.         │
├──┼──────────┼────────────┤
│19│27 65535 7│throw.      │
├──┼──────────┼────────────┤
│20│26 21 8   │end.        │
├──┼──────────┼────────────┤
│21│6 22 9    │end.        │
└──┴──────────┴────────────┘
TEST

test <<CODE, <<TEST
if. y<0 do. type_jthrow_=: 'aaaa' throw. end.
if. y<4 do. type_jthrow_=: 'bbb'  throw. end.
if. y<8 do. type_jthrow_=: 'cc'   throw. end.
(":y),' not thrown'
CODE
┌──┬──────────┬────────────────────┐
│0 │4 1 0     │if.                 │
├──┼──────────┼────────────────────┤
│1 │2 65535 0 │y<0                 │
├──┼──────────┼────────────────────┤
│2 │3 6 0     │do.                 │
├──┼──────────┼────────────────────┤
│3 │1 65535 0 │type_jthrow_=:'aaaa'│
├──┼──────────┼────────────────────┤
│4 │27 65535 0│throw.              │
├──┼──────────┼────────────────────┤
│5 │6 6 0     │end.                │
├──┼──────────┼────────────────────┤
│6 │4 7 1     │if.                 │
├──┼──────────┼────────────────────┤
│7 │2 65535 1 │y<4                 │
├──┼──────────┼────────────────────┤
│8 │3 12 1    │do.                 │
├──┼──────────┼────────────────────┤
│9 │1 65535 1 │type_jthrow_=:'bbb' │
├──┼──────────┼────────────────────┤
│10│27 65535 1│throw.              │
├──┼──────────┼────────────────────┤
│11│6 12 1    │end.                │
├──┼──────────┼────────────────────┤
│12│4 13 2    │if.                 │
├──┼──────────┼────────────────────┤
│13│2 65535 2 │y<8                 │
├──┼──────────┼────────────────────┤
│14│3 18 2    │do.                 │
├──┼──────────┼────────────────────┤
│15│1 65535 2 │type_jthrow_=:'cc'  │
├──┼──────────┼────────────────────┤
│16│27 65535 2│throw.              │
├──┼──────────┼────────────────────┤
│17│6 18 2    │end.                │
├──┼──────────┼────────────────────┤
│18│1 65535 3 │(":y),' not thrown' │
└──┴──────────┴────────────────────┘
TEST
