# converts parsed trees to LLVM IR

require_relative './llvm-emit'

# TODO: use ! for methods

class StellerJ::Compiler
    Variable = Struct.new(:name, :dtype, :dim) {
        def register
            "%#{name}"
        end
    }

    def initialize(parsed)
        @trees = parsed
        @emitter = StellerJ::LLVMEmitter.new
        @variables = {}
        @last_assigned = nil
    end
    
    def type_for_data(data)
        if data.include? " "
            entries = data.split
            types = entries.map { |entry| type_for_data entry }
            if types.include? StellerJ::LLVMEmitter::FType
                StellerJ::LLVMEmitter::JFTensor
            else
                StellerJ::LLVMEmitter::JITensor
            end
        elsif data.include? "."
            StellerJ::LLVMEmitter::FType
        else
            StellerJ::LLVMEmitter::IType
        end
    end
    
    def value_for_operand(operand)
        case operand.speech
        when :noun
            if operand.leaf?
                raw, type = operand.value
                case type
                when :data
                    dtype = type_for_data raw
                    [ raw, dtype ]
                when :word
                    variable = @variables[raw]
                    temp = @emitter.load variable.name, variable.dtype
                    [ temp, variable.dtype ]
                else
                    raise "unimplemented: value for noun #{type}"
                end
            else
                reg, dtype = compile_value operand, nil
            end
        else
            raise "unimplemented: value for #{operand.speech}"
        end
    end
    
    def handle_native_primitive(verb, lhs, rhs)
        lhs_raw, lhs_type = lhs
        rhs_raw, rhs_type = rhs
        types = [ lhs_type, rhs_type ].compact
        case types
        when StellerJ::LLVMEmitter::ITypePair
            # TODO: int, int -> float for division?
            mono_type = types[0]
            prim_name = {
                "+" => "add",
                "-" => "sub",
                "*" => "mul",
                "%" => "sdiv",
            }[verb]
        when StellerJ::LLVMEmitter::FTypePair
            mono_type = types[0]
            prim_name = {
                "+" => "fadd",
                "-" => "fsub",
                "*" => "fmul",
                "%" => "fdiv",
            }[verb]
        # TODO: mixed conversion?
        # TODO: unary operations
        else
            raise "Unsupported operands for verb #{verb}: #{types}"
        end
        reg = @emitter.primitive prim_name, mono_type, [ lhs_raw, rhs_raw ]
        [ reg, mono_type ]
    end
    
    def compile_verb(verb, params)
        lhs, rhs = params
        
        puts "LHS: #{lhs.inspect}"
        puts "RHS: #{rhs.inspect}"
        
        case verb
        when "$"
            raise "TODO: $"
        when "+", "-", "*", "%"
            handle_native_primitive verb, lhs, rhs
        end
    end
    
    def tensor_store_values(name, values, dim, dtype, first_assign)
        if first_assign
            # initialize JFTensor
            @emitter.init_tensor name, dtype, dim
            @variables[name].dim = dim
            
            values.each.with_index { |value, idx|
                @emitter.comment "storing #{value} at #{idx}"
                @emitter.tensor_store name, dim, idx, value, dtype
            }
        else
            # copy into JFTensor
            raise "TODO: copy values into a JFTensor"
        end
    end
    
    # TODO: integer format static check
    def store(name, value, dtype, first_assign)
        @last_assigned = name
        case dtype
        when StellerJ::LLVMEmitter::IType, StellerJ::LLVMEmitter::FType
            @emitter.store name, value, dtype
        when StellerJ::LLVMEmitter::JITensor
            values = value.split
            dim = [ values.size ]
            tensor_store_values name, values, dim, dtype, first_assign
        when StellerJ::LLVMEmitter::JFTensor
            values = value.split.map { |value|
                # make sure floats are properly floating point
                value.include?(".") ? value : "#{value}.0"
            }
            dim = [ values.size ]
            tensor_store_values name, values, dim, dtype, first_assign
        else
            raise "Unhandled store operation: #{dtype}"
        end
    end
    
    def compile_value(node, dest)
        case node.value
        when StellerJ::Parser::TreeNode
            head = node.value
            raw, type = head.value
            case type
            when :verb
                p node.left, node.right
                # we need temporaries for each side
                lhs = value_for_operand node.left
                rhs = value_for_operand node.right
                
                result_reg, dtype = compile_verb raw, [ lhs, rhs ]
                
                if dest.nil?
                    # intermediate value stored in register
                    [ result_reg, dtype ]
                else
                    first_assign = dest.dtype.nil?
                    if first_assign
                        dest.dtype = dtype
                    end
                    raise "Incompatible type: store #{dtype} into #{dest.dtype}" if dest.dtype != dtype
                    # store doesn't update active register count, so we return a nil register
                    store dest.name, result_reg, dtype, first_assign
                    [ nil, dtype ]
                end
            end
        
        # single value initialization 
        when Array
            raw, type = node.value
            case type
            when :data
                assign_type = type_for_data raw
                first_assign = dest.dtype.nil?
                if first_assign
                    dest.dtype = assign_type
                end
                raise "Incompatible type: store #{assign_type} into #{dest.dtype}" if dest.dtype != assign_type
                reg = store dest.name, raw, dest.dtype, first_assign
                [ reg, dest.dtype ]
            else
                raise "unhandled noun type #{type}"
            end
        end
    end
    
    def compile_node(node)
        puts "Compiling: "
        p node.value
        raw, type = node.value
        case type
        when :copula
            # assume assignment
            # TODO: distinction between local and global assignment
            lhs = node.left
            name = lhs.value[0]
            
            # first time compilation
            if @variables[name].nil?
                variable = Variable.new name, nil
                @variables[name] = variable
                
                @emitter.alloca variable.name, :backfill
                # TODO: initialization code for tensors
            else
                variable = @variables[name]
            end
            
            # get value
            rhs = node.right
            if rhs.speech == :noun
                compile_value rhs, variable
                @emitter.notify_type variable.name, variable.dtype
            else
                #TODO:
                raise "TODO: non-noun copula assignment"
            end
        else
            raise "TODO: handle non-copula at top level"
        end
        
        puts
    end
    
    def compile
        @trees.each { |tree|
            compile_node tree
        }
        # implicitly print last value
        to_print = @variables[@last_assigned]
        p @last_assigned, to_print
        case to_print.dtype
        when StellerJ::LLVMEmitter::IType
            reg = @emitter.load to_print.name, to_print.dtype
            @emitter.call "putn", [ reg ]
        when StellerJ::LLVMEmitter::FType
            reg = @emitter.load to_print.name, to_print.dtype
            @emitter.call "putd", [ reg ]
        when StellerJ::LLVMEmitter::JITensor
            @emitter.call "JITensor_dump", [ "%#{to_print.name}" ]
        when StellerJ::LLVMEmitter::JFTensor
            @emitter.call "JFTensor_dump", [ "%#{to_print.name}" ]
        else
            raise "Cannot print datatype #{to_print.dtype}"
        end
        @emitter.compile
    end
    
    # TODO: more than one function
    
    def self.compile(parsed)
        compiler = self.new parsed
        compiler.compile
    end
end
