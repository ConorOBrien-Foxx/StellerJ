module StellerJ
    Copula = %w(=. =:)
    Verbs = %w(+ - % * i. ? $)
    Adverbs = %w(/ ~)
    Conjunctions = %w(@ & . ")
    Control = %w(
        for. do. end. if. else.
        op. conj. adj.
    )
    
    # StellerJ::Tokenizer
    require_relative './tokenize.rb'
    
    # StellerJ::Parser
    require_relative './parse.rb'
    
    # aliases for poignant methods
    def self.tokenize(code)
        Tokenizer::tokenize code
    end
    def self.parse(tokens)
        Parser::parse tokens
    end
end

code = "
+@(-@*)
".strip
# {{ x + y }}/ 4 3 NB. lol
# 5 (+@-&*) 3

# 5 *@+&- 3
# 2 * ((4 + 9) * 7 % - 3)
# 3 + 4 * 5 - 9
# 4 + 9 * - 3
# x =. 'adsdf'
# y =. (5 - 3) + 5
# echo x + y

tokens = StellerJ.tokenize(code)
p StellerJ::parse(tokens)

# StellerJ.tokenize(code).each { |line|
    # p line
# }

