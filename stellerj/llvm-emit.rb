# API to emit llvm

class StellerJ::LLVMEmitter
    IType = "i64"
    FType = "double"
    Void = "void"
    TypeSize = {
        IType => 4,
        FType => 8,
    }
    
    ITypePair = [ IType, IType ]
    FTypePair = [ FType, FType ]
    
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
        @function_data["putd"] = {
            return: Void,
            args: [FType],
        }
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
        if type == :backfill
            dest_index = @functions[where].size
            @type_backfill[name] = dest_index
            add_line where, [ "%#{name} = alloca ", 0, ", align ", 1 ]
        else
            size = TypeSize[type]
            add_line where, "%#{name} = alloca #{type}, align #{size}"
        end
    end
    
    def backfill(idx, args, where=@focus)
        @functions[where][idx] = @functions[where][idx].map { |item|
            Numeric === item ? args[item] : item
        }.join
    end
    
    def notify_type(name, type, where=@focus)
        size = TypeSize[type]
        backfill @type_backfill[name], [ type, size ]
        @type_backfill.delete name
    end
    
    def store(name, value, type, where=@focus)
        size = TypeSize[type]
        add_line where, "store #{type} #{value}, #{type}* %#{name}, align #{size}"
    end
    
    def load(name, type, where=@focus)
        reg = next_register!
        size = TypeSize[type]
        add_line where, "#{reg} = load #{type}, #{type}* %#{name}, align #{size}"
        reg
    end
    
    def primitive(prim_name, dtype, params, where=@focus)
        reg = next_register!
        add_line where, "#{reg} = #{prim_name} #{dtype} #{params * ", "}"
        reg
    end
    
    def call(name, args, where=@focus)
        data = @function_data[name]
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
            <<~EOF.lines.map(&:chomp),
            @.putn_fmt = internal constant [5 x i8] c"%lld\00", align 1
            define dso_local void @putn(i64 %number) #0 {
                %spec = getelementptr [5 x i8], [5 x i8]* @.putn_fmt, i32 0, i32 0
                call i32 (i8*, ...) @printf(i8* %spec, i64 %number)
                ret void
            }
            @.putd_fmt = internal constant [3 x i8] c"%g\00", align 1
            define dso_local void @putd(double %number) #0 {
                %spec = getelementptr [3 x i8], [3 x i8]* @.putd_fmt, i32 0, i32 0
                call i32 (i8*, ...) @printf(i8* %spec, double %number)
                ret void
            }
            EOF
            "define dso_local i32 @main() #0 {",
            *@functions["main"].map { |line| "    #{line}" },
            "    ret i32 0",
            "}",
            "declare dso_local i32 @printf(i8*, ...) #1",
            "declare dso_local i32 @putchar(i32) #1"
        ]
        lines.join "\n"
    end
end
