# converts parsed trees to LLVM IR

require_relative './llvm-emit'

# TODO: use ! for methods

class StellerJ::Compiler
    Variable = Struct.new(:name, :dtype, :static_value, :dim, :initialized) {
        def register
            "%#{name}"
        end

        def to_named_temp
            Variable.new(self.temp_name, dtype, nil, nil, false)
        end

        def temp_name
            "#{name}_temp"
        end
    }

    def initialize(parsed)
        @groups = parsed
        @emitter = StellerJ::LLVMEmitter.new
        @variables = {}
        @verbs = {}
        @allocated = {}
        @last_assigned = nil
    end

    # returns a register value holding the final value
    def compile_expression(expression)
        case expression.children.size
        when 0
            # leaf node
            p ["Compiling expression", expression]
            case expression.dtype
            when StellerJ::LLVMEmitter::IType
                if /[0-9_]/ === expression.raw[0]
                    @emitter.basic_constant expression.raw, expression.dtype
                else
                    @emitter.load expression.raw, expression.dtype
                end
            else
                raise "TODO: compile expression #{expression.dtype}"
            end
        when 1
            # monad
            raise "TODO: monad"
        when 2
            # dyad
            child_regs = expression.children.map { |noun| compile_expression noun }
            # TODO: more operators
            @emitter.primitive "add", expression.dtype, child_regs
        else
            raise "Unexpected number of children in expression #{expression.children.size}"
        end
    end
    
    def assign_int_expression_to(group)
        variable = group.variable
        expression = group.expression
        unless @allocated[variable]
            @emitter.alloca variable, expression.dtype
            @allocated[variable] = true
        end
        register = compile_expression group.expression
        @emitter.store variable, register, expression.dtype
    end

    def compile_group(group)
        case group
        when StellerJ::Grouper::VariableAssignment
            case group.expression.dtype
            when StellerJ::LLVMEmitter::IType
                assign_int_expression_to group
            when StellerJ::LLVMEmitter::JITensor
                raise "TODO: assign to JITensor"
            else
                raise "Unhandled assignment of type #{group.dtype}"
            end

        when StellerJ::Grouper::VerbAssignment
            raise "TODO: Verb assignment"

        when StellerJ::Grouper::EchoStatement
            case group.expression.dtype
            when StellerJ::LLVMEmitter::IType
                reg = compile_expression group.expression
                @emitter.call "putn", [ reg ]
            when StellerJ::LLVMEmitter::JITensor
                reg = compile_expression group.expression
                @emitter.call "JITensor_dump", [ reg ]
            else
                raise "Unhandled dump of type #{group.dtype}"
            end

        else
            raise "Unhandled group type: #{group}"
        end
    end

    def compile
        @groups.each { |group|
            compile_group group
        }
        @emitter.compile
    end

    # TODO: more than one function
    
    def self.compile(parsed)
        compiler = self.new parsed
        compiler.compile
    end
end
