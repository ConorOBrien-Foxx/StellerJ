# converts parsed trees to LLVM IR

require_relative './llvm-emit'

# TODO: use ! for methods

class StellerJ::Compiler
    Variable = Struct.new(:name, :dtype, :static_value, :dim, :initialized) {
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
            # if types.include? StellerJ::LLVMEmitter::FType
                # StellerJ::LLVMEmitter::JFTensor
            # else
                StellerJ::LLVMEmitter::JITensor
            # end
        # elsif data.include? "."
            # StellerJ::LLVMEmitter::FType
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
                    # temp = @emitter.load variable.name, variable.dtype
                    [ variable.name, variable.dtype ]
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
    
    def to_temporary(name, type)
        if name[0] == '%'
            name
        else
            @emitter.load name, type
        end
    end
    
    def handle_native_primitive(verb, lhs, rhs, dest)
        lhs_raw, lhs_type = lhs
        rhs_raw, rhs_type = rhs
        types = [ lhs_type, rhs_type ].compact
        case types
        when [ StellerJ::LLVMEmitter::IType, StellerJ::LLVMEmitter::IType ]
            # TODO: int, int -> float for division?
            p ["loading", lhs, rhs]
            lhs_reg = to_temporary lhs_raw, lhs_type
            rhs_reg = to_temporary rhs_raw, rhs_type
            prim_name = {
                "+" => "add",
                "-" => "sub",
                "*" => "mul",
                "%" => "sdiv",
            }[verb]
            reg = @emitter.primitive prim_name, lhs_type, [ lhs_reg, rhs_reg ]
            [ reg, lhs_type ]
        # when [ StellerJ::LLVMEmitter::FType, StellerJ::LLVMEmitter::FType ]
        #     p ["loading", lhs, rhs]
        #     lhs_reg = to_temporary lhs_raw, lhs_type
        #     rhs_reg = to_temporary rhs_raw, rhs_type
        #     prim_name = {
        #         "+" => "fadd",
        #         "-" => "fsub",
        #         "*" => "fmul",
        #         "%" => "fdiv",
        #     }[verb]
        #     reg = @emitter.primitive prim_name, lhs_type, [ lhs_reg, rhs_reg ]
        #     [ reg, lhs_type ]
        # TODO: mixed conversion?
        # TODO: unary operations
        when [ StellerJ::LLVMEmitter::JITensor, StellerJ::LLVMEmitter::JITensor ]
            if dest.nil?
                raise "TODO: anonymous operation"
            else
                method_name = {
                    "+" => "JITensor_add_vec_vec",
                }[verb]
                raise "Unimplemented: #{verb} #{types}" if method_name.nil?
                # reg = @emitter.primitive prim_name, lhs_type, [ lhs_raw, rhs_raw ]
                # p ["HECK UWU", lhs, rhs, dest]
                
                dest.initialized = true
                dest.dtype = lhs_type
                @emitter.clear_tensor dest.name, lhs_type
                @emitter.call method_name, [ "%#{lhs_raw}", "%#{rhs_raw}", "%#{dest.name}" ]
                # TODO: there might be something fucky about this
                # raise
                [ nil, lhs_type ]
            end
        else
            raise "Unsupported operands for verb #{verb}: #{types}"
        end
    end
    
    def handle_shape(lhs, rhs, dest)
        # TODO: constant value propagation
        lhs_raw, lhs_type = lhs
        rhs_raw, rhs_type = rhs
        # raise "TODO: $"
        # @emitter.comment "this is where shape handle goes"
        # handle_native_primitive "+", ["1", "i64"], ["1", "i64"]
        
        # TODO: scalar dimension case e.g. 3 $ 1
        
        # static case
        # raise "cannot have non-integral dimensions" if lhs_type == StellerJ::LLVMEmitter::JFTensor
        if !dest.nil? && /[0-9_]/ === lhs_raw[0] && /[0-9_]/ === rhs_raw[0]
            dim = lhs_raw.split.map &:to_i
            total_elements = dim.inject(:*)
            values = rhs_raw.split
            if values.size < total_elements
                values *= (total_elements.to_f / values.size).ceil
            end
            if values.size > total_elements
                values = values[0...total_elements]
            end
            # @emitter.alloca dest.name, rhs_type
            tensor_store_values dest.name, values, dim, rhs_type
            # p [dim, values, reg]
            # exit
            [ nil, rhs_type ]
        else
            raise "TODO: dynamic shape $"
        end
    end
    
    def compile_verb(verb, params, dest)
        lhs, rhs = params
        
        puts "LHS: #{lhs.inspect}"
        puts "RHS: #{rhs.inspect}"
        
        case verb
        when "$"
            handle_shape lhs, rhs, dest
        when "+", "-", "*", "%"
            handle_native_primitive verb, lhs, rhs, dest
        end
    end
    
    def tensor_store_values(name, values, dim, dtype)
        if @variables[name] && !@variables[name].initialized
            # initialize J*Tensor
            @variables[name].initialized = true
            @variables[name].dtype = dtype
            @variables[name].dim = dim unless @variables[name].nil?
            @emitter.init_tensor name, dtype, dim
        else
            # copy into J*Tensor
            p [name, values, dim, dtype]
            raise "TODO: copy values into a J*Tensor"
        end
        
        # p ["GIVEN VALUES", values]
        # if dtype == StellerJ::LLVMEmitter::JFTensor
        #     values.map! { |value|
        #         # make sure floats are properly floating point
        #         value.include?(".") ? value : "#{value}.0"
        #     }
        # end
        
        values.each.with_index { |value, idx|
            @emitter.comment "storing value in tensor, #{value} at #{idx}"
            @emitter.tensor_store name, dim, idx, value, dtype
        }
        
        name
    end
    
    # TODO: integer format static check
    # returns a register type?
    def store(name, value, dtype)
        @last_assigned = name
        raise "Trying to store nil value into #{name} (#{dtype})" if value.nil?
        case dtype
        when StellerJ::LLVMEmitter::IType#, StellerJ::LLVMEmitter::FType
            @emitter.store name, value, dtype
            @variables[name].initialized = true
        when StellerJ::LLVMEmitter::JITensor
            values = value.split
            dim = [ values.size ]
            tensor_store_values name, values, dim, dtype
        # when StellerJ::LLVMEmitter::JFTensor
        #     values = value.split
        #     dim = [ values.size ]
        #     tensor_store_values name, values, dim, dtype
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
                p ["left",node.left, "right",node.right]
                # we need temporaries for each side
                # exit
                lhs = value_for_operand node.left
                rhs = value_for_operand node.right
                
                result_reg, dtype = compile_verb raw, [ lhs, rhs ], dest
                
                if dest.nil?
                    # intermediate value stored in register
                    [ result_reg, dtype ]
                else
                    p dest
                    if !dest.initialized
                        dest.dtype = dtype
                    end
                    raise "No dtype for #{dest}" if dest.dtype.nil?
                    raise "Incompatible type: store #{dtype} into #{dest.dtype}" if dest.dtype != dtype
                    # store doesn't update active register count, so we return a nil register
                    # p ["store", dest.name, result_reg, dtype]
                    unless dest.initialized
                        store dest.name, result_reg, dtype
                        raise "variable was not initialized by store call" unless dest.initialized
                        [ nil, dtype ]
                    else
                        puts "Hey, already initialized"
                        @last_assigned = dest.name
                        # [ dest.name, dtype ]
                        [ nil, dtype ]
                    end
                end
            end
        
        # single value initialization 
        when Array
            raw, type = node.value
            case type
            when :data
                # TODO: merge with above?
                assign_type = type_for_data raw
                if !dest.initialized
                    dest.dtype = dtype || assign_type
                end
                p ["UWU", assign_type, dest, dtype, raw]
                raise "No dtype for #{dest}" if dest.dtype.nil?
                raise "Incompatible type: store #{assign_type} into #{dest.dtype}" if dest.dtype != assign_type
                reg = store dest.name, raw, dest.dtype
                [ reg, dest.dtype ]
            else
                raise "unhandled noun type #{type}"
            end
        
        else
            raise "unknown head type #{node.value}"
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
        # when StellerJ::LLVMEmitter::FType
        #     reg = @emitter.load to_print.name, to_print.dtype
        #     @emitter.call "putd", [ reg ]
        when StellerJ::LLVMEmitter::JITensor
            @emitter.call "JITensor_dump", [ "%#{to_print.name}" ]
        # when StellerJ::LLVMEmitter::JFTensor
        #     @emitter.call "JFTensor_dump", [ "%#{to_print.name}" ]
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
