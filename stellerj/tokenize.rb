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
    end
    
    # implements J's ;:
    def tokenize
        @code
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
    
    def self.tokenize(code)
        self.new(code).tokenize
    end
end
