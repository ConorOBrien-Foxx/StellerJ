@.putn_fmt = internal constant [5 x i8] c"%lld ", align 1
define dso_local void @putn(i64 %number) #0 {
    %spec = getelementptr [5 x i8], [5 x i8]* @.putn_fmt, i32 0, i32 0
    call i32 (i8*, ...) @printf(i8* %spec, i64 %number)
    ret void
}
@.putd_fmt = internal constant [3 x i8] c"%g ", align 1
define dso_local void @putd(double %number) #0 {
    %spec = getelementptr [3 x i8], [3 x i8]* @.putd_fmt, i32 0, i32 0
    call i32 (i8*, ...) @printf(i8* %spec, double %number)
    ret void
}
define dso_local i32 @main() #0 {
    %x = alloca double, align 8
    store double 10.4, double* %x, align 8
    %y = alloca double, align 8
    store double 12.9, double* %y, align 8
    %z = alloca double, align 8
    %1 = load double, double* %x, align 8
    %2 = load double, double* %x, align 8
    %3 = fmul double %1, %2
    %4 = load double, double* %y, align 8
    %5 = fadd double %3, %4
    store double %5, double* %z, align 8
    %6 = load double, double* %z, align 8
    call void @putd(double %6)
    ret i32 0
}
declare dso_local i32 @printf(i8*, ...) #1
declare dso_local i32 @putchar(i32) #1