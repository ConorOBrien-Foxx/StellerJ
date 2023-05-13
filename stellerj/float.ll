; included in a compiled file
%JFTensor = type {
    double*,    ; data
    i64*,       ; dimensions
    i64,        ; dimension_count
    i64         ; total data count
}

; write a single double
@.putd_fmt = internal constant [3 x i8] c"%g\00", align 1
define dso_local void @putd(double %number) #0 {
    %spec = getelementptr [3 x i8], [3 x i8]* @.putd_fmt, i32 0, i32 0
    call i32 (i8*, ...) @printf(i8* %spec, double %number)
    ret void
}

; dump a float tensor (modified from clang C++ code)
define dso_local void @JFTensor_dump(%JFTensor* noundef %0) #0 {
  %2 = alloca %JFTensor*, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  store %JFTensor* %0, %JFTensor** %2, align 8
  %7 = load %JFTensor*, %JFTensor** %2, align 8
  %8 = getelementptr inbounds %JFTensor, %JFTensor* %7, i32 0, i32 2
  %9 = load i64, i64* %8, align 8
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %11, label %12

11:
  br label %64

12:
  store i64 0, i64* %6, align 8
  br label %13

13:
  %14 = load i64, i64* %6, align 8
  %15 = load %JFTensor*, %JFTensor** %2, align 8
  %16 = getelementptr inbounds %JFTensor, %JFTensor* %15, i32 0, i32 3
  %17 = load i64, i64* %16, align 8
  %18 = icmp ult i64 %14, %17
  br i1 %18, label %19, label %64

19:
  %20 = load %JFTensor*, %JFTensor** %2, align 8
  %21 = getelementptr inbounds %JFTensor, %JFTensor* %20, i32 0, i32 0
  %22 = load double*, double** %21, align 8
  %23 = load i64, i64* %6, align 8
  %24 = getelementptr inbounds double, double* %22, i64 %23
  %25 = load double, double* %24, align 8
  %26 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.putd_fmt, i64 0, i64 0), double noundef %25)
  store i64 1, i64* %3, align 8
  store i32 1, i32* %5, align 4
  %27 = load %JFTensor*, %JFTensor** %2, align 8
  %28 = getelementptr inbounds %JFTensor, %JFTensor* %27, i32 0, i32 2
  %29 = load i64, i64* %28, align 8
  %30 = sub i64 %29, 1
  store i64 %30, i64* %4, align 8
  br label %31

31:
  %32 = load i64, i64* %4, align 8
  %33 = icmp uge i64 %32, 1
  br i1 %33, label %34, label %55

34:
  %35 = load %JFTensor*, %JFTensor** %2, align 8
  %36 = getelementptr inbounds %JFTensor, %JFTensor* %35, i32 0, i32 1
  %37 = load i64*, i64** %36, align 8
  %38 = load i64, i64* %4, align 8
  %39 = getelementptr inbounds i64, i64* %37, i64 %38
  %40 = load i64, i64* %39, align 8
  %41 = load i64, i64* %3, align 8
  %42 = mul i64 %41, %40
  store i64 %42, i64* %3, align 8
  %43 = load i64, i64* %6, align 8
  %44 = load i64, i64* %3, align 8
  %45 = urem i64 %43, %44
  %46 = load i64, i64* %3, align 8
  %47 = sub i64 %46, 1
  %48 = icmp eq i64 %45, %47
  br i1 %48, label %49, label %51

49:
  store i32 0, i32* %5, align 4
  %50 = call i32 @putchar(i32 noundef 10)
  br label %51

51:
  br label %52

52:
  %53 = load i64, i64* %4, align 8
  %54 = add i64 %53, -1
  store i64 %54, i64* %4, align 8
  br label %31

55:
  %56 = load i32, i32* %5, align 4
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %58, label %60

58:
  %59 = call i32 @putchar(i32 noundef 32)
  br label %60

60:
  br label %61

61:
  %62 = load i64, i64* %6, align 8
  %63 = add i64 %62, 1
  store i64 %63, i64* %6, align 8
  br label %13

64:
  ret void
}
