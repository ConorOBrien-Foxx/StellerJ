# Tokenizing J code is relatively simple

# is a class instead of a method for potential future complexity
class StellerJ::Tokenizer
    @@ScanRegex = Regexp.new [
        /'(?:''|[^'])+'/,               # string
        /NB\.(?:[^.:].*)?(?:\n|$)/,     # comment
        /[A-Za-z][A-Za-z_0-9]*[.:]*/,   # word
        /\s+/,                          # spaces
        /\{\{|\}\}/,                    # direct definitions
        # note: a lexical number string in J merely begins with a number
        %r{
            [0-9_][.a-zA-Z0-9_]* # initial number
            (?:
                \s+ # at least 1 space
                [0-9_][.a-zA-Z0-9_]* # another number
            )*
            [.:]*
        }x,                             # number
        /.[.:]*/,                       # other
    ].join "|"
    
    def initialize(code)
        @code = code
        @tokens = nil
    end
    
    # TODO: include position in tokenization
    # implements J's ;:
    # tokenizes a single line
    def tokenize!
        @tokens = @code
            .scan(@@ScanRegex)
            .reject { |s| /^\s+$/ === s }
            # some validation happens here
            .flat_map { |s|
                raise "open quote" if s == "'"
                s.strip!
                # there probably is a way to handle this with regex
                # if is number
                if /^[0-9_]/ === s
                    s
                        # preserve whitespace in split
                        .split(/(?<=\s)/)
                        .chunk { |n| n.include? ":" }
                        .flat_map { |iscon, group|
                            iscon ? group : group * ""
                        }
                        .map(&:strip)
                else
                    s
                end
            }
    end
    
    def classify!
        raise "classify before tokenize" if @tokens.nil?
        types = @tokens.map { |token|
            if StellerJ::Verbs.include? token
                :verb
            elsif StellerJ::Adverbs.include? token
                :adverb
            elsif StellerJ::Conjunctions.include? token
                :conjunction
            elsif StellerJ::Control.include? token
                :control
            elsif StellerJ::Copula.include? token
                :copula
            elsif /for_[A-Za-z][A-Za-z_0-9]*\./ === token
                :control
            elsif /^NB\.(?:[^.:].*)?(?:\n|$)$/ === token
                :comment
            elsif /[A-Za-z]/ === token[0]
                :word
            elsif /[0-9_]/ === token[0]
                :data
            elsif "{{" == token
                :ddfn_start
            elsif "}}" == token
                :ddfn_end
            elsif "'" == token[0]
                # :string
                :data
            elsif "(" == token
                :paren_start
            elsif ")" == token
                :paren_end
            else
                raise "unknown token #{token.inspect}"
            end
        }
        @tokens = @tokens.zip(types)
    end
    
    def run!
        tokenize!
        classify!
        @tokens
    end
    
    # tokenizes multiple lines
    # TODO: different tokenization contexts
    # (e.g. 0 : 0)
    def self.tokenize(code)
        code.lines.map { |line|
            self.new(line).run!
        }
    end
end
