module StellerJ
    Copula = %w(=. =:)
    Verbs = %w(+ - % * i. ? $)
    # TODO: change back to %w arrays for nice style
    # VSCode doesn't like %w with / or " in it :/
    Adverbs = %w(~) + ["/"]
    Conjunctions = %w(@ & .) + ['"']
    Control = %w(
        for. do. end. if. else.
        op. conj. adj.
    )
    
    # StellerJ::Tokenizer
    require_relative './tokenize.rb'
    
    # StellerJ::Parser
    require_relative './parse.rb'
    
    # StellerJ::Compile
    require_relative './compile.rb'
    
    # StellerJ::LLVMEmitter
    require_relative './llvm-emit.rb'
    
    # aliases for poignant methods
    def self.tokenize(code)
        Tokenizer::tokenize code
    end
    def self.parse(tokens)
        Parser::parse tokens
    end
    def self.compile(tokens)
        Compiler::compile tokens
    end
end


code = "
x =: 10 10  $  1 2 3
"

code = "
x =: 10.4
y =: 12.9
z =: (x * x) + y
".strip

code = "
x =: 1 2 3 4 5 6 7 8
y =: 3 0 5 0 7 0 9 0
z =: x + y + y
z =: z + z + z + z + z
"

tokens = StellerJ.tokenize(code)
parsed = StellerJ::parse(tokens)
compiled = StellerJ::compile(parsed)

start = compiled.index "define dso_local i32 @main()"
puts compiled[start..-1]
File.write "temp.ll", compiled

unless Gem.win_platform?
    puts "Compiling..."
    system "llc temp.ll && gcc -no-pie temp.s -o temp.out"
    if $?.exitstatus == 0
        puts "Running..."
        system "./temp.out"
    end
end
