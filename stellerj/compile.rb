# converts parsed trees to LLVM IR

require_relative './llvm-emit'

# TODO: use ! for methods

class StellerJ::Compiler
    Variable = Struct.new(:name, :dtype) {
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
        if data.include? "."
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
    
    def compile_verb(verb, params)
        lhs, rhs = params
        lhs_raw, lhs_type = lhs
        rhs_raw, rhs_type = rhs
        
        puts "LHS: #{lhs.inspect}"
        puts "RHS: #{rhs.inspect}"
        
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
    
    def store(name, value, dtype)
        @last_assigned = name
        @emitter.store name, value, dtype
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
                    if dest.dtype.nil?
                        dest.dtype = dtype
                    end
                    raise "Incompatible type: store #{dtype} into #{dest.dtype}" if dest.dtype != dtype
                    # store doesn't update active register count, so we return a nil register
                    store dest.name, result_reg, dtype
                    [ nil, dtype ]
                end
            end
        
        # single value initialization 
        when Array
            raw, type = node.value
            case type
            when :data
                assign_type = type_for_data raw
                if dest.dtype.nil?
                    dest.dtype = assign_type
                end
                raise "Incompatible type: store #{assign_type} into #{dest.dtype}" if dest.dtype != assign_type
                reg = store dest.name, raw, dest.dtype
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
        else
            raise "Cannot print #{to_print.dtype} dtype"
        end
        @emitter.compile
    end
    
    # TODO: more than one function
    
    def self.compile(parsed)
        compiler = self.new parsed
        compiler.compile
    end
end
