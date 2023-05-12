module StellerJ
    Verbs = %w(=. =: + - % * i. ? $)
    Adverbs = %w(/ ~)
    Conjunctions = %w(@ & .)
    Control = %w(for. do. end. if. else.)
    
    # StellerJ::Tokenizer
    require_relative './tokenize.rb'
    
    
    def self.tokenize(code)
        Tokenizer::tokenize code
    end
end
