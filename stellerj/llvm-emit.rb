# API to emit llvm

class StellerJ::LLVMEmitter
    TENSOR_SIZE = 32 # 4 fields x 8 bytes
    IType = "i64"
    # FType = "double"
    Void = "void"
    JITensor = "%JITensor"
    # JFTensor = "%JFTensor"
    TypeSize = {
        IType => 4,
        # FType => 8,
        Void => 0,
        # JFTensor => 8,
        JITensor => 8,
        # JITensor => :dont_specify,
        # JFTensor => :dont_specify,
    }
    
    def get_size(type)
        # all pointers are of size 8
        return 8 if type[-1] == "*"
        result = TypeSize[type]
        raise "could not get type size of #{type}" if result.nil?
        result
    end
    
    def ITypeN(n)
        "[#{n} x #{IType}]"
    end
    # def FTypeN(n)
        # "[#{n} x #{FType}]"
    # end
    
    def initialize
        @functions = {}
        @functions["main"] = []
        @function_data = {}
        @function_data["main"] = {
            return: "i32",
            args: []
        }
        @function_data["putn"] = {
            return: Void,
            args: [IType],
        }
        @function_data["JITensor_dump"] = {
            return: Void,
            args: ["#{JITensor}*"],
        }
        @function_data["JITensor_add_vec_vec"] = {
            return: Void,
            args: ["#{JITensor}*", "#{JITensor}*", "#{JITensor}*"],
        }
        # @function_data["putd"] = {
        #     return: Void,
        #     args: [FType],
        # }
        # @function_data["JFTensor_dump"] = {
        #     return: Void,
        #     args: ["#{JFTensor}*"],
        # }
        @registers = {
            "main" => 1
        }
        # "type inference"
        @type_backfill = {}
        @focus = "main"
    end
    
    attr_accessor :focus
    
    def next_register!(where=@focus)
        value = "%#{@registers[where]}"
        @registers[where] += 1
        value
    end
    
    def add_line(function, line)
        @functions[function] << line
    end
    
    def alloca(name, type, where=@focus)
        raise "must specify dtype for alloca, got nil" if type.nil?
        name = prefix_percent name
        if type == :backfill
            dest_index = @functions[where].size
            @type_backfill[name] = dest_index
            add_line where, [ "#{name} = alloca ", 0, ", align ", 1 ]
        else
            size = get_size(type)
            if size == :dont_specify
                add_line where, "#{name} = alloca #{type}"
            else
                add_line where, "#{name} = alloca #{type}, align #{size}"
            end
        end
    end
    
    def clear_tensor(name, type, where=@focus)
        name = prefix_percent name
        downcast = next_register!
        add_line where, "#{downcast} = bitcast #{type}* #{name} to i8*"
        add_line where, "call void @llvm.memset.p0i8.i64(i8* align 8 #{downcast}, i8 0, i64 #{TENSOR_SIZE}, i1 false)"
    end
    
    def backfill(idx, args, where=@focus)
        @functions[where][idx] = @functions[where][idx].map { |item|
            Numeric === item ? args[item] : item
        }.join
    end
    
    def notify_type(name, type, where=@focus)
        size = get_size(type)
        name = prefix_percent name
        idx = @type_backfill[name]
        if size == :dont_specify
            @functions[where][idx] = "#{@functions[where][idx].first}#{type}"
        else
            backfill idx, [ type, size ]
        end
        @type_backfill.delete name
    end
    
    def comment(message, where=@focus)
        add_line where, "; #{message}"
    end
    
    def prefix_percent(name)
        raise "no given name (nil)" if name.nil?
        name[0] == '%' ? name : "%#{name}"
    end
    
    def tensor_atom_type(type)
        case type
        # when JFTensor
        #     FType
        when JITensor
            IType
        else
            raise "unknown tensor type #{type}"
        end
    end
    
    def init_tensor(name, type, dim, where=@focus)
        name = prefix_percent name
        
        atom_type = tensor_atom_type(type)
        # this errors for (say) IType because atom_size would be 4
        # is this the correct approach? is the wrong pointer kind being stored?
        # TODO: XXX: this might be a source of errors
        atom_size = get_size("#{atom_type}*")
        total_item_count = dim.inject(:*)
        
        ### allocate first field (atom_type*) ###
        # the amount of memory we want: Product(dim) * byte_size
        data_size = total_item_count * atom_size
        comment "allocating tensor data #{total_item_count} * #{atom_size} = #{data_size}"
        # reference to the field (i32 0 dereferences, i32 0 gets first field)
        data_ptr = next_register! where
        add_line where, "#{data_ptr} = getelementptr inbounds #{type}, #{type}* #{name}, i32 0, i32 0"
        # call malloc with appropriate size
        ptr_malloc = next_register! where
        add_line where, "#{ptr_malloc} = call noalias i8* @malloc(i64 noundef #{data_size})"
        # cast to correct type
        ptr_malloc_typed = next_register! where
        add_line where, "#{ptr_malloc_typed} = bitcast i8* #{ptr_malloc} to #{atom_type}*"
        # store in instance
        store data_ptr, ptr_malloc_typed, "#{atom_type}*"
        
        ### allocate second field: dimensions (i64*) ###
        comment "allocating tensor dimensions"
        # the amount of memory we want: length(dim) * byte_size
        dim_size = dim.size * get_size(IType)
        # reference to the field (i32 0 dereferences, i32 1 gets second field)
        dim_ptr = next_register! where
        add_line where, "#{dim_ptr} = getelementptr inbounds #{type}, #{type}* #{name}, i32 0, i32 1"
        # call malloc with appropriate size
        ptr_malloc = next_register! where
        add_line where, "#{ptr_malloc} = call noalias i8* @malloc(i64 noundef #{dim_size})"
        # cast to correct type
        ptr_malloc_typed = next_register! where
        add_line where, "#{ptr_malloc_typed} = bitcast i8* #{ptr_malloc} to #{IType}*"
        # store in instance
        store dim_ptr, ptr_malloc_typed, "#{IType}*", where
        
        ### populate second field: dimension (i64*) ###
        dim.each.with_index { |dimension, i|
            comment "storing tensor dimension #{i} = #{dimension}"
            tensor_storedim name, dim, i, dimension, type, where
        }
        
        ### populate third field: dimension count (i64) ###
        comment "storing tensor dimension count = #{dim.size}"
        dimcount_ptr = getelementptr_inbounds name, type, ["i32 0", "i32 2"], where
        store dimcount_ptr, dim.size, IType, where
        
        ### populate fourth field: total data count (i64) ###
        comment "storing tensor data count = #{total_item_count}"
        dimcount_ptr = getelementptr_inbounds name, type, ["i32 0", "i32 3"], where
        store dimcount_ptr, total_item_count, IType, where
        
    end
    
    def getelementptr_inbounds(name, type, path, where=@focus)
        ptr = next_register!
        path = path.join ", "
        add_line where, "#{ptr} = getelementptr inbounds #{type}, #{type}* #{name}, #{path}"
        ptr
    end
    
    # path should begin with a 0 for dereferencing purpose, followed by the field index you want
    def store_at_index(name, dim, path, idx, value, type, subtype, where=@focus)
        #TODO:assert idx is static??? maybe not
        name = prefix_percent name
        path = path.map { |p| "i32 #{p}" }
        
        tensor_ptr = getelementptr_inbounds name, type, path, where
        # tensor_ptr = next_register!
        # add_line where, "#{tensor_ptr} = getelementptr inbounds #{type}, #{type}* #{name}, #{path}"
        
        memory_ptr = load tensor_ptr, "#{subtype}*", where
        
        memory_cell = getelementptr_inbounds memory_ptr, subtype, [ "i64 #{idx}" ], where
        # memory_cell = next_register!
        # add_line where, "#{memory_cell} = getelementptr inbounds #{subtype}, #{subtype}* #{memory_ptr}, i64 #{idx}"
        
        store memory_cell, value, subtype, where
    end
    
    def tensor_store(name, dim, idx, value, type, where=@focus)
        atom_type = tensor_atom_type type
        store_at_index name, dim, [0, 0], idx, value, type, atom_type, where
    end
    
    def tensor_storedim(name, dim, idx, value, type, where=@focus)
        store_at_index name, dim, [0, 1], idx, value, type, IType, where
    end
    
    def store(name, value, type, where=@focus)
        name = prefix_percent name
        size = get_size(type)
        add_line where, "store #{type} #{value}, #{type}* #{name}, align #{size}"
    end
    
    def load(name, type, where=@focus)
        name = prefix_percent name
        reg = next_register! where
        size = get_size(type)
        add_line where, "#{reg} = load #{type}, #{type}* #{name}, align #{size}"
        reg
    end
    
    def primitive(prim_name, dtype, params, where=@focus)
        reg = next_register! where
        add_line where, "#{reg} = #{prim_name} #{dtype} #{params * ", "}"
        reg
    end
    
    def get_function_data(name)
        data = @function_data[name]
        raise "unknown function #{name}" if data.nil?
        data
    end
    
    def call(name, args, where=@focus)
        data = get_function_data name
        raise "cannot handle non-void yet" if data[:return] != Void
        rtype = data[:return]
        argtypes = data[:args]
        params = argtypes.zip(args).map { |type, param| "#{type} #{param}" } .join ", "
        add_line where, "call #{rtype} @#{name}(#{params})"
        nil
        # TODO: handle non-void and return a register
    end
    
    def compile
        lines = [
            *File.read("int.ll").lines.map(&:chomp),
            *File.read("float.ll").lines.map(&:chomp),
            *File.read("header.ll").lines.map(&:chomp),
            "define dso_local i32 @main() #0 {",
            *@functions["main"].map { |line| "    #{line}" },
            "    ret i32 0",
            "}",
        ]
        lines.join "\n"
    end
end
