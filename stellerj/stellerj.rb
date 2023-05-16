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

    # StellerJ::Grouper
    require_relative './grouper.rb'
    
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
    def self.group(tokens)
        Grouper::group tokens
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
lhs =: 5
rhs =: 9
result =: lhs + rhs
"

code = "
y =: 10 12 13 0 4 0 9
NB. y =: y * y + y
z =: +/ y
echo z
NB. echo z
"

code = "
x =: 10 10  $  1 2 3
echo x * x
"

tokens = StellerJ.tokenize(code)
parsed = StellerJ::parse(tokens)
grouped = StellerJ::group(parsed)
compiled = StellerJ::compile(grouped)

start = compiled.index "declare i32 @putchar(i32)"
puts compiled[start+25..-1]
File.write "temp.ll", compiled

unless Gem.win_platform?
    puts "Compiling..."
    system "llc temp.ll && gcc -no-pie temp.s -o temp.out"
    if $?.exitstatus == 0
        puts "Running..."
        system "./temp.out"
    end
end
