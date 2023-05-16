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

    def new_function(verb)
        p verb
        exit
    end

    def name_for_verb(verb)
        if verb.children.empty?
            function_name = {
                "+" => "I64_add",
                "-" => "I64_sub",
                "*" => "I64_mul",
                "%" => "I64_div",
            }[verb.raw]
        else
            new_function verb
        end
    end

    # only called at a top level
    def evaluate_verb(expression)
        verb = expression.raw
        if verb.children.empty?
            # regular verb
            case expression.dtype
            when StellerJ::LLVMEmitter::IType
                child_regs = expression.children.map { |noun| compile_expression noun }
                primitive_name = {
                    "+" => "add",
                    "-" => "sub",
                    "*" => "mul",
                    "%" => "sdiv",
                }[verb.raw]
                raise "Unhandled primitive verb #{verb.raw}" if primitive_name.nil?
                @emitter.primitive primitive_name, expression.dtype, child_regs
            when StellerJ::LLVMEmitter::JITensor
                case verb.raw
                when "$"
                    raw_values = expression.children.map { |noun| noun.raw }
                    if /[0-9_]/ === raw_values[0] && /[0-9_]/ === raw_values[1]
                        dim = raw_values[0].split.map &:to_i
                        total_elements = dim.inject(:*)
                        values = raw_values[1].split
                        if values.size < total_elements
                            values *= (total_elements.to_f / values.size).ceil
                        end
                        if values.size > total_elements
                            values = values[0...total_elements]
                        end
                        local_tensor_with_values values, dim, expression.dtype
                    else
                        raise "TODO: dynamic shape $"
                    end

                else
                    child_regs = expression.children.map { |noun| compile_expression noun }
                    method_name = {
                        "+" => "JITensor_add_vec_vec",
                        "-" => "JITensor_sub_vec_vec",
                        "*" => "JITensor_mul_vec_vec",
                        "%" => "JITensor_div_vec_vec",
                    }[verb.raw]
                    raise "Unimplemented: #{verb.raw} tensor" if method_name.nil?
                    out_reg = @emitter.next_register!
                    @emitter.alloca out_reg, expression.dtype
                    @emitter.clear_tensor out_reg, expression.dtype
                    @emitter.call method_name, child_regs + [ out_reg ]
                    out_reg
                end
            else
                raise "Unhandled dyad type: #{expression.dtype}"
            end
        else
            name = name_for_verb verb.children[0]
            child_regs = expression.children.map { |noun| compile_expression noun }
            p name, child_regs
            reg = @emitter.call "JITensor_fold", child_regs + [ "@#{name}", "0" ]
            # %35 = call i64 @JITensor_fold(%struct.JITensor* noundef %2, i64 (i64, i64)* noundef @I64_add, i64 noundef 0)
            # exit
            # raise 'todo: adverb/verb' 
        end
    end

    def local_tensor_with_values(values, dim, dtype)
        reg = @emitter.next_register!
        @emitter.alloca reg, dtype
        @emitter.init_tensor reg, dtype, dim
        values.each.with_index { |value, idx|
            @emitter.comment "storing value in tensor, #{value} at #{idx}"
            @emitter.tensor_store reg, dim, idx, value, dtype
        }
        reg
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
                    local_tensor_with_values values, dim, expression.dtype
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
        when 1, 2
            evaluate_verb expression
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
            p group
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
