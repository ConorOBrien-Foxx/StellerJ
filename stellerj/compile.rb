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
            case expression.dtype
            when StellerJ::LLVMEmitter::IType
                if /[0-9_]/ === expression.raw[0]
                    @emitter.basic_constant expression.raw, expression.dtype
                else
                    @emitter.load expression.raw, expression.dtype
                end
            when StellerJ::LLVMEmitter::JITensor
                if /[0-9_]/ === expression.raw[0]
                    values = expression.raw.split
                    dim = [ values.size ]
                    reg = @emitter.next_register!
                    @emitter.alloca reg, expression.dtype
                    @emitter.init_tensor reg, expression.dtype, dim
                    values.each.with_index { |value, idx|
                        @emitter.comment "storing value in tensor, #{value} at #{idx}"
                        @emitter.tensor_store reg, dim, idx, value, expression.dtype
                    }
                    reg
                else
                    reg = @emitter.next_register!
                    @emitter.alloca reg, expression.dtype
                    @emitter.clear_tensor reg, expression.dtype
                    @emitter.call "JITensor_copy_value", [ "%#{expression.raw}", reg ]
                    reg
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
            case expression.dtype
            when StellerJ::LLVMEmitter::IType
                primitive_name = {
                    "+" => "add",
                    "-" => "sub",
                    "*" => "mul",
                    "%" => "sdiv",
                }[expression.raw]
                raise "Unhandled primitive verb #{primitive_name}" if primitive_name.nil?
                @emitter.primitive primitive_name, expression.dtype, child_regs
            when StellerJ::LLVMEmitter::JITensor
                method_name = {
                    "+" => "JITensor_add_vec_vec",
                    "-" => "JITensor_sub_vec_vec",
                    "*" => "JITensor_mul_vec_vec",
                    "/" => "JITensor_div_vec_vec",
                }[expression.raw]
                raise "Unimplemented: #{expression.raw} tensor" if method_name.nil?
                out_reg = @emitter.next_register!
                @emitter.alloca out_reg, expression.dtype
                @emitter.clear_tensor out_reg, expression.dtype
                @emitter.call method_name, child_regs + [ out_reg ]
                out_reg
            else
                raise "Unhandled dyad type: #{expression.dtype}"
            end
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

    def assign_int_tensor_expression_to(group)
        variable = group.variable
        expression = group.expression
        unless @allocated[variable]
            # @emitter.init_tensor variable, expression.dtype
            @emitter.alloca variable, expression.dtype
            @emitter.clear_tensor variable, expression.dtype
            @allocated[variable] = true
        end
        register = compile_expression group.expression
        @emitter.call "JITensor_copy_value", [ register, "%#{variable}" ]
    end

    def compile_group(group)
        case group
        when StellerJ::Grouper::VariableAssignment
            case group.expression.dtype
            when StellerJ::LLVMEmitter::IType
                assign_int_expression_to group
            when StellerJ::LLVMEmitter::JITensor
                assign_int_tensor_expression_to group
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
