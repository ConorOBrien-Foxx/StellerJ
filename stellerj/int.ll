; included in a compiled file
%JITensor = type {
    i64*,       ; data
    i64*,       ; dimensions
    i64,        ; dimension_count
    i64         ; total data count
}

; write a single integer
@.putn_fmt = internal constant [5 x i8] c"%lld\00", align 1
define dso_local void @putn(i64 %number) #0 {
    %spec = getelementptr [5 x i8], [5 x i8]* @.putn_fmt, i32 0, i32 0
    call i32 (i8*, ...) @printf(i8* %spec, i64 %number)
    ret void
}

; add two integers
define dso_local i64 @I64_add(i64 noundef %0, i64 noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = add nsw i64 %5, %6
  ret i64 %7
}

; subtracts two integers
define dso_local i64 @I64_sub(i64 noundef %0, i64 noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = sub nsw i64 %5, %6
  ret i64 %7
}

; multiplies two integers
define dso_local i64 @I64_mul(i64 noundef %0, i64 noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = mul nsw i64 %5, %6
  ret i64 %7
}

; divides two integers
define dso_local i64 @I64_div(i64 noundef %0, i64 noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = sdiv i64 %5, %6
  ret i64 %7
}

; performs inner product with two input tensors, (tensor -> i64), (i64,i64 -> i64), and output tensor
define dso_local void @JITensor_inner_product(%JITensor* noundef %0, %JITensor* noundef %1, i64 (%JITensor*)* noundef %2, i64 (i64, i64)* noundef %3, %JITensor* noundef %4) #0 {
  %6 = alloca %JITensor*, align 8
  %7 = alloca %JITensor*, align 8
  %8 = alloca i64 (%JITensor*)*, align 8
  %9 = alloca i64 (i64, i64)*, align 8
  %10 = alloca %JITensor*, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca %JITensor, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  store %JITensor* %0, %JITensor** %6, align 8
  store %JITensor* %1, %JITensor** %7, align 8
  store i64 (%JITensor*)* %2, i64 (%JITensor*)** %8, align 8
  store i64 (i64, i64)* %3, i64 (i64, i64)** %9, align 8
  store %JITensor* %4, %JITensor** %10, align 8
  %18 = load %JITensor*, %JITensor** %6, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 2
  %20 = load i64, i64* %19, align 8
  %21 = icmp ne i64 %20, 2
  br i1 %21, label %27, label %22

22:
  %23 = load %JITensor*, %JITensor** %7, align 8
  %24 = getelementptr inbounds %JITensor, %JITensor* %23, i32 0, i32 2
  %25 = load i64, i64* %24, align 8
  %26 = icmp ne i64 %25, 2
  br i1 %26, label %27, label %28

27:
  br label %170

28:
  %29 = load %JITensor*, %JITensor** %6, align 8
  %30 = getelementptr inbounds %JITensor, %JITensor* %29, i32 0, i32 1
  %31 = load i64*, i64** %30, align 8
  %32 = getelementptr inbounds i64, i64* %31, i64 0
  %33 = load i64, i64* %32, align 8
  store i64 %33, i64* %11, align 8
  %34 = load %JITensor*, %JITensor** %6, align 8
  %35 = getelementptr inbounds %JITensor, %JITensor* %34, i32 0, i32 1
  %36 = load i64*, i64** %35, align 8
  %37 = getelementptr inbounds i64, i64* %36, i64 1
  %38 = load i64, i64* %37, align 8
  store i64 %38, i64* %12, align 8
  %39 = load i64, i64* %12, align 8
  %40 = load %JITensor*, %JITensor** %7, align 8
  %41 = getelementptr inbounds %JITensor, %JITensor* %40, i32 0, i32 1
  %42 = load i64*, i64** %41, align 8
  %43 = getelementptr inbounds i64, i64* %42, i64 0
  %44 = load i64, i64* %43, align 8
  %45 = icmp ne i64 %39, %44
  br i1 %45, label %46, label %47

46:
  br label %170

47:
  %48 = load %JITensor*, %JITensor** %7, align 8
  %49 = getelementptr inbounds %JITensor, %JITensor* %48, i32 0, i32 1
  %50 = load i64*, i64** %49, align 8
  %51 = getelementptr inbounds i64, i64* %50, i64 1
  %52 = load i64, i64* %51, align 8
  store i64 %52, i64* %13, align 8
  %53 = load %JITensor*, %JITensor** %10, align 8
  %54 = getelementptr inbounds %JITensor, %JITensor* %53, i32 0, i32 0
  %55 = load i64*, i64** %54, align 8
  %56 = icmp ne i64* %55, null
  br i1 %56, label %91, label %57

57:
  %58 = load %JITensor*, %JITensor** %10, align 8
  %59 = getelementptr inbounds %JITensor, %JITensor* %58, i32 0, i32 2
  store i64 2, i64* %59, align 8
  %60 = load %JITensor*, %JITensor** %10, align 8
  %61 = getelementptr inbounds %JITensor, %JITensor* %60, i32 0, i32 2
  %62 = load i64, i64* %61, align 8
  %63 = mul i64 8, %62
  %64 = call noalias i8* @malloc(i64 noundef %63) #5
  %65 = bitcast i8* %64 to i64*
  %66 = load %JITensor*, %JITensor** %10, align 8
  %67 = getelementptr inbounds %JITensor, %JITensor* %66, i32 0, i32 1
  store i64* %65, i64** %67, align 8
  %68 = load i64, i64* %11, align 8
  %69 = load %JITensor*, %JITensor** %10, align 8
  %70 = getelementptr inbounds %JITensor, %JITensor* %69, i32 0, i32 1
  %71 = load i64*, i64** %70, align 8
  %72 = getelementptr inbounds i64, i64* %71, i64 0
  store i64 %68, i64* %72, align 8
  %73 = load i64, i64* %13, align 8
  %74 = load %JITensor*, %JITensor** %10, align 8
  %75 = getelementptr inbounds %JITensor, %JITensor* %74, i32 0, i32 1
  %76 = load i64*, i64** %75, align 8
  %77 = getelementptr inbounds i64, i64* %76, i64 1
  store i64 %73, i64* %77, align 8
  %78 = load i64, i64* %11, align 8
  %79 = load i64, i64* %13, align 8
  %80 = mul i64 %78, %79
  %81 = load %JITensor*, %JITensor** %10, align 8
  %82 = getelementptr inbounds %JITensor, %JITensor* %81, i32 0, i32 3
  store i64 %80, i64* %82, align 8
  %83 = load %JITensor*, %JITensor** %10, align 8
  %84 = getelementptr inbounds %JITensor, %JITensor* %83, i32 0, i32 3
  %85 = load i64, i64* %84, align 8
  %86 = mul i64 8, %85
  %87 = call noalias i8* @malloc(i64 noundef %86) #5
  %88 = bitcast i8* %87 to i64*
  %89 = load %JITensor*, %JITensor** %10, align 8
  %90 = getelementptr inbounds %JITensor, %JITensor* %89, i32 0, i32 0
  store i64* %88, i64** %90, align 8
  br label %91

91:
  %92 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 2
  store i64 1, i64* %92, align 8
  %93 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 2
  %94 = load i64, i64* %93, align 8
  %95 = mul i64 8, %94
  %96 = call noalias i8* @malloc(i64 noundef %95) #5
  %97 = bitcast i8* %96 to i64*
  %98 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 1
  store i64* %97, i64** %98, align 8
  %99 = load i64, i64* %12, align 8
  %100 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 3
  store i64 %99, i64* %100, align 8
  %101 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 3
  %102 = load i64, i64* %101, align 8
  %103 = mul i64 8, %102
  %104 = call noalias i8* @malloc(i64 noundef %103) #5
  %105 = bitcast i8* %104 to i64*
  %106 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 0
  store i64* %105, i64** %106, align 8
  store i64 0, i64* %15, align 8
  br label %107

107:
  %108 = load i64, i64* %15, align 8
  %109 = load i64, i64* %11, align 8
  %110 = icmp ult i64 %108, %109
  br i1 %110, label %111, label %170

111:
  store i64 0, i64* %16, align 8
  br label %112

112:
  %113 = load i64, i64* %16, align 8
  %114 = load i64, i64* %13, align 8
  %115 = icmp ult i64 %113, %114
  br i1 %115, label %116, label %166

116:
  store i64 0, i64* %17, align 8
  br label %117

117:
  %118 = load i64, i64* %17, align 8
  %119 = load i64, i64* %12, align 8
  %120 = icmp ult i64 %118, %119
  br i1 %120, label %121, label %151

121:
  %122 = load i64 (i64, i64)*, i64 (i64, i64)** %9, align 8
  %123 = load %JITensor*, %JITensor** %6, align 8
  %124 = getelementptr inbounds %JITensor, %JITensor* %123, i32 0, i32 0
  %125 = load i64*, i64** %124, align 8
  %126 = load i64, i64* %15, align 8
  %127 = load i64, i64* %11, align 8
  %128 = mul i64 %126, %127
  %129 = load i64, i64* %17, align 8
  %130 = add i64 %128, %129
  %131 = getelementptr inbounds i64, i64* %125, i64 %130
  %132 = load i64, i64* %131, align 8
  %133 = load %JITensor*, %JITensor** %7, align 8
  %134 = getelementptr inbounds %JITensor, %JITensor* %133, i32 0, i32 0
  %135 = load i64*, i64** %134, align 8
  %136 = load i64, i64* %17, align 8
  %137 = load i64, i64* %13, align 8
  %138 = mul i64 %136, %137
  %139 = load i64, i64* %16, align 8
  %140 = add i64 %138, %139
  %141 = getelementptr inbounds i64, i64* %135, i64 %140
  %142 = load i64, i64* %141, align 8
  %143 = call i64 %122(i64 noundef %132, i64 noundef %142)
  %144 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 0
  %145 = load i64*, i64** %144, align 8
  %146 = load i64, i64* %17, align 8
  %147 = getelementptr inbounds i64, i64* %145, i64 %146
  store i64 %143, i64* %147, align 8
  br label %148

148:
  %149 = load i64, i64* %17, align 8
  %150 = add i64 %149, 1
  store i64 %150, i64* %17, align 8
  br label %117

151:
  %152 = load i64 (%JITensor*)*, i64 (%JITensor*)** %8, align 8
  %153 = call i64 %152(%JITensor* noundef %14)
  %154 = load %JITensor*, %JITensor** %10, align 8
  %155 = getelementptr inbounds %JITensor, %JITensor* %154, i32 0, i32 0
  %156 = load i64*, i64** %155, align 8
  %157 = load i64, i64* %15, align 8
  %158 = load i64, i64* %11, align 8
  %159 = mul i64 %157, %158
  %160 = load i64, i64* %16, align 8
  %161 = add i64 %159, %160
  %162 = getelementptr inbounds i64, i64* %156, i64 %161
  store i64 %153, i64* %162, align 8
  br label %163

163:
  %164 = load i64, i64* %16, align 8
  %165 = add i64 %164, 1
  store i64 %165, i64* %16, align 8
  br label %112

166:
  br label %167

167:
  %168 = load i64, i64* %15, align 8
  %169 = add i64 %168, 1
  store i64 %169, i64* %15, align 8
  br label %107

170:
  ret void
}

; fold a function with a given pointer
define dso_local i64 @JITensor_fold(%JITensor* noundef %0, i64 (i64, i64)* noundef %1, i64 noundef %2) #0 {
  %4 = alloca i64, align 8
  %5 = alloca %JITensor*, align 8
  %6 = alloca i64 (i64, i64)*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  store %JITensor* %0, %JITensor** %5, align 8
  store i64 (i64, i64)* %1, i64 (i64, i64)** %6, align 8
  store i64 %2, i64* %7, align 8
  %10 = load %JITensor*, %JITensor** %5, align 8
  %11 = getelementptr inbounds %JITensor, %JITensor* %10, i32 0, i32 3
  %12 = load i64, i64* %11, align 8
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %14, label %16

14:
  %15 = load i64, i64* %7, align 8
  store i64 %15, i64* %4, align 8
  br label %50

16:
  %17 = load %JITensor*, %JITensor** %5, align 8
  %18 = getelementptr inbounds %JITensor, %JITensor* %17, i32 0, i32 3
  %19 = load i64, i64* %18, align 8
  %20 = sub i64 %19, 1
  store i64 %20, i64* %8, align 8
  %21 = load %JITensor*, %JITensor** %5, align 8
  %22 = getelementptr inbounds %JITensor, %JITensor* %21, i32 0, i32 0
  %23 = load i64*, i64** %22, align 8
  %24 = load i64, i64* %8, align 8
  %25 = getelementptr inbounds i64, i64* %23, i64 %24
  %26 = load i64, i64* %25, align 8
  store i64 %26, i64* %9, align 8
  %27 = load i64, i64* %8, align 8
  %28 = add i64 %27, -1
  store i64 %28, i64* %8, align 8
  br label %29

29:
  %30 = load i64, i64* %8, align 8
  %31 = load %JITensor*, %JITensor** %5, align 8
  %32 = getelementptr inbounds %JITensor, %JITensor* %31, i32 0, i32 3
  %33 = load i64, i64* %32, align 8
  %34 = icmp ult i64 %30, %33
  br i1 %34, label %35, label %48

35:
  %36 = load i64 (i64, i64)*, i64 (i64, i64)** %6, align 8
  %37 = load i64, i64* %9, align 8
  %38 = load %JITensor*, %JITensor** %5, align 8
  %39 = getelementptr inbounds %JITensor, %JITensor* %38, i32 0, i32 0
  %40 = load i64*, i64** %39, align 8
  %41 = load i64, i64* %8, align 8
  %42 = getelementptr inbounds i64, i64* %40, i64 %41
  %43 = load i64, i64* %42, align 8
  %44 = call i64 %36(i64 noundef %37, i64 noundef %43)
  store i64 %44, i64* %9, align 8
  br label %45

45:
  %46 = load i64, i64* %8, align 8
  %47 = add i64 %46, -1
  store i64 %47, i64* %8, align 8
  br label %29

48:
  %49 = load i64, i64* %9, align 8
  store i64 %49, i64* %4, align 8
  br label %50

50:
  %51 = load i64, i64* %4, align 8
  ret i64 %51
}

; dump an integer tensor (modified from clang C++ code)
define dso_local void @JITensor_dump(%JITensor* noundef %0) #0 {
  %2 = alloca %JITensor*, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  store %JITensor* %0, %JITensor** %2, align 8
  %7 = load %JITensor*, %JITensor** %2, align 8
  %8 = getelementptr inbounds %JITensor, %JITensor* %7, i32 0, i32 2
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
  %15 = load %JITensor*, %JITensor** %2, align 8
  %16 = getelementptr inbounds %JITensor, %JITensor* %15, i32 0, i32 3
  %17 = load i64, i64* %16, align 8
  %18 = icmp ult i64 %14, %17
  br i1 %18, label %19, label %64

19:
  %20 = load %JITensor*, %JITensor** %2, align 8
  %21 = getelementptr inbounds %JITensor, %JITensor* %20, i32 0, i32 0
  %22 = load i64*, i64** %21, align 8
  %23 = load i64, i64* %6, align 8
  %24 = getelementptr inbounds i64, i64* %22, i64 %23
  %25 = load i64, i64* %24, align 8
  %26 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([5 x i8], [5 x i8]* @.putn_fmt, i64 0, i64 0), i64 noundef %25)
  store i64 1, i64* %3, align 8
  store i32 1, i32* %5, align 4
  %27 = load %JITensor*, %JITensor** %2, align 8
  %28 = getelementptr inbounds %JITensor, %JITensor* %27, i32 0, i32 2
  %29 = load i64, i64* %28, align 8
  %30 = sub i64 %29, 1
  store i64 %30, i64* %4, align 8
  br label %31

31:
  %32 = load i64, i64* %4, align 8
  %33 = icmp uge i64 %32, 1
  br i1 %33, label %34, label %55

34:
  %35 = load %JITensor*, %JITensor** %2, align 8
  %36 = getelementptr inbounds %JITensor, %JITensor* %35, i32 0, i32 1
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

; check if two tensors have the same dimensions
; returns 1 if true and 0 if false
define dso_local i32 @JITensor_same_dim(%JITensor* noundef %0, %JITensor* noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %JITensor*, align 8
  %5 = alloca %JITensor*, align 8
  %6 = alloca i64, align 8
  store %JITensor* %0, %JITensor** %4, align 8
  store %JITensor* %1, %JITensor** %5, align 8
  %7 = load %JITensor*, %JITensor** %4, align 8
  %8 = getelementptr inbounds %JITensor, %JITensor* %7, i32 0, i32 2
  %9 = load i64, i64* %8, align 8
  %10 = load %JITensor*, %JITensor** %5, align 8
  %11 = getelementptr inbounds %JITensor, %JITensor* %10, i32 0, i32 2
  %12 = load i64, i64* %11, align 8
  %13 = icmp ne i64 %9, %12
  br i1 %13, label %14, label %15

14:
  store i32 0, i32* %3, align 4
  br label %42

15:
  store i64 0, i64* %6, align 8
  br label %16

16:
  %17 = load i64, i64* %6, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 2
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %41

22:
  %23 = load %JITensor*, %JITensor** %4, align 8
  %24 = getelementptr inbounds %JITensor, %JITensor* %23, i32 0, i32 1
  %25 = load i64*, i64** %24, align 8
  %26 = load i64, i64* %6, align 8
  %27 = getelementptr inbounds i64, i64* %25, i64 %26
  %28 = load i64, i64* %27, align 8
  %29 = load %JITensor*, %JITensor** %5, align 8
  %30 = getelementptr inbounds %JITensor, %JITensor* %29, i32 0, i32 1
  %31 = load i64*, i64** %30, align 8
  %32 = load i64, i64* %6, align 8
  %33 = getelementptr inbounds i64, i64* %31, i64 %32
  %34 = load i64, i64* %33, align 8
  %35 = icmp ne i64 %28, %34
  br i1 %35, label %36, label %37

36:
  store i32 0, i32* %3, align 4
  br label %42

37:
  br label %38

38:
  %39 = load i64, i64* %6, align 8
  %40 = add i64 %39, 1
  store i64 %40, i64* %6, align 8
  br label %16

41:
  store i32 1, i32* %3, align 4
  br label %42

42:
  %43 = load i32, i32* %3, align 4
  ret i32 %43
}

; prepares an output tensor by allocating memory
define dso_local void @JITensor_copy_shape(%JITensor* noundef %0, %JITensor* noundef %1) #0 {
  %3 = alloca %JITensor*, align 8
  %4 = alloca %JITensor*, align 8
  store %JITensor* %0, %JITensor** %3, align 8
  store %JITensor* %1, %JITensor** %4, align 8
  %5 = load %JITensor*, %JITensor** %3, align 8
  %6 = load %JITensor*, %JITensor** %4, align 8
  %7 = call i32 @JITensor_same_dim(%JITensor* noundef %5, %JITensor* noundef %6)
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %68, label %9

9:
  %10 = load %JITensor*, %JITensor** %4, align 8
  %11 = getelementptr inbounds %JITensor, %JITensor* %10, i32 0, i32 0
  %12 = load i64*, i64** %11, align 8
  %13 = icmp ne i64* %12, null
  br i1 %13, label %14, label %19

14:
  %15 = load %JITensor*, %JITensor** %4, align 8
  %16 = getelementptr inbounds %JITensor, %JITensor* %15, i32 0, i32 0
  %17 = load i64*, i64** %16, align 8
  %18 = bitcast i64* %17 to i8*
  call void @free(i8* noundef %18) #5
  br label %19

19:
  %20 = load %JITensor*, %JITensor** %3, align 8
  %21 = getelementptr inbounds %JITensor, %JITensor* %20, i32 0, i32 3
  %22 = load i64, i64* %21, align 8
  %23 = mul i64 8, %22
  %24 = call noalias i8* @malloc(i64 noundef %23) #5
  %25 = bitcast i8* %24 to i64*
  %26 = load %JITensor*, %JITensor** %4, align 8
  %27 = getelementptr inbounds %JITensor, %JITensor* %26, i32 0, i32 0
  store i64* %25, i64** %27, align 8
  %28 = load %JITensor*, %JITensor** %4, align 8
  %29 = getelementptr inbounds %JITensor, %JITensor* %28, i32 0, i32 1
  %30 = load i64*, i64** %29, align 8
  %31 = icmp ne i64* %30, null
  br i1 %31, label %32, label %37

32:
  %33 = load %JITensor*, %JITensor** %4, align 8
  %34 = getelementptr inbounds %JITensor, %JITensor* %33, i32 0, i32 1
  %35 = load i64*, i64** %34, align 8
  %36 = bitcast i64* %35 to i8*
  call void @free(i8* noundef %36) #5
  br label %37

37:
  %38 = load %JITensor*, %JITensor** %3, align 8
  %39 = getelementptr inbounds %JITensor, %JITensor* %38, i32 0, i32 2
  %40 = load i64, i64* %39, align 8
  %41 = mul i64 8, %40
  %42 = call noalias i8* @malloc(i64 noundef %41) #5
  %43 = bitcast i8* %42 to i64*
  %44 = load %JITensor*, %JITensor** %4, align 8
  %45 = getelementptr inbounds %JITensor, %JITensor* %44, i32 0, i32 1
  store i64* %43, i64** %45, align 8
  %46 = load %JITensor*, %JITensor** %4, align 8
  %47 = getelementptr inbounds %JITensor, %JITensor* %46, i32 0, i32 1
  %48 = load i64*, i64** %47, align 8
  %49 = bitcast i64* %48 to i8*
  %50 = load %JITensor*, %JITensor** %3, align 8
  %51 = getelementptr inbounds %JITensor, %JITensor* %50, i32 0, i32 1
  %52 = load i64*, i64** %51, align 8
  %53 = bitcast i64* %52 to i8*
  %54 = load %JITensor*, %JITensor** %3, align 8
  %55 = getelementptr inbounds %JITensor, %JITensor* %54, i32 0, i32 2
  %56 = load i64, i64* %55, align 8
  %57 = mul i64 %56, 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %49, i8* align 8 %53, i64 %57, i1 false)
  %58 = load %JITensor*, %JITensor** %3, align 8
  %59 = getelementptr inbounds %JITensor, %JITensor* %58, i32 0, i32 3
  %60 = load i64, i64* %59, align 8
  %61 = load %JITensor*, %JITensor** %4, align 8
  %62 = getelementptr inbounds %JITensor, %JITensor* %61, i32 0, i32 3
  store i64 %60, i64* %62, align 8
  %63 = load %JITensor*, %JITensor** %3, align 8
  %64 = getelementptr inbounds %JITensor, %JITensor* %63, i32 0, i32 2
  %65 = load i64, i64* %64, align 8
  %66 = load %JITensor*, %JITensor** %4, align 8
  %67 = getelementptr inbounds %JITensor, %JITensor* %66, i32 0, i32 2
  store i64 %65, i64* %67, align 8
  br label %68

68:
  ret void
}

define dso_local void @JITensor_copy_value(%JITensor* noundef %0, %JITensor* noundef %1) #0 {
  %3 = alloca %JITensor*, align 8
  %4 = alloca %JITensor*, align 8
  store %JITensor* %0, %JITensor** %3, align 8
  store %JITensor* %1, %JITensor** %4, align 8
  %5 = load %JITensor*, %JITensor** %3, align 8
  %6 = load %JITensor*, %JITensor** %4, align 8
  call void @JITensor_copy_shape(%JITensor* noundef %5, %JITensor* noundef %6)
  %7 = load %JITensor*, %JITensor** %4, align 8
  %8 = getelementptr inbounds %JITensor, %JITensor* %7, i32 0, i32 0
  %9 = load i64*, i64** %8, align 8
  %10 = bitcast i64* %9 to i8*
  %11 = load %JITensor*, %JITensor** %3, align 8
  %12 = getelementptr inbounds %JITensor, %JITensor* %11, i32 0, i32 0
  %13 = load i64*, i64** %12, align 8
  %14 = bitcast i64* %13 to i8*
  %15 = load %JITensor*, %JITensor** %3, align 8
  %16 = getelementptr inbounds %JITensor, %JITensor* %15, i32 0, i32 3
  %17 = load i64, i64* %16, align 8
  %18 = mul i64 %17, 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %10, i8* align 8 %14, i64 %18, i1 false)
  ret void
}

; adds two vectors and stores output in an output vector
define dso_local void @JITensor_add_vec_vec(%JITensor* noundef %0, %JITensor* noundef %1, %JITensor* noundef %2) #0 {
  %4 = alloca %JITensor*, align 8
  %5 = alloca %JITensor*, align 8
  %6 = alloca %JITensor*, align 8
  %7 = alloca i64, align 8
  store %JITensor* %0, %JITensor** %4, align 8
  store %JITensor* %1, %JITensor** %5, align 8
  store %JITensor* %2, %JITensor** %6, align 8
  %8 = load %JITensor*, %JITensor** %4, align 8
  %9 = load %JITensor*, %JITensor** %5, align 8
  %10 = call i32 @JITensor_same_dim(%JITensor* noundef %8, %JITensor* noundef %9)
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %13, label %12

12:
  br label %44

13:
  %14 = load %JITensor*, %JITensor** %4, align 8
  %15 = load %JITensor*, %JITensor** %6, align 8
  call void @JITensor_copy_shape(%JITensor* noundef %14, %JITensor* noundef %15)
  store i64 0, i64* %7, align 8
  br label %16

16:
  %17 = load i64, i64* %7, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 3
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %44

22:
  %23 = load %JITensor*, %JITensor** %4, align 8
  %24 = getelementptr inbounds %JITensor, %JITensor* %23, i32 0, i32 0
  %25 = load i64*, i64** %24, align 8
  %26 = load i64, i64* %7, align 8
  %27 = getelementptr inbounds i64, i64* %25, i64 %26
  %28 = load i64, i64* %27, align 8
  %29 = load %JITensor*, %JITensor** %5, align 8
  %30 = getelementptr inbounds %JITensor, %JITensor* %29, i32 0, i32 0
  %31 = load i64*, i64** %30, align 8
  %32 = load i64, i64* %7, align 8
  %33 = getelementptr inbounds i64, i64* %31, i64 %32
  %34 = load i64, i64* %33, align 8
  %35 = add nsw i64 %28, %34
  %36 = load %JITensor*, %JITensor** %6, align 8
  %37 = getelementptr inbounds %JITensor, %JITensor* %36, i32 0, i32 0
  %38 = load i64*, i64** %37, align 8
  %39 = load i64, i64* %7, align 8
  %40 = getelementptr inbounds i64, i64* %38, i64 %39
  store i64 %35, i64* %40, align 8
  br label %41

41:
  %42 = load i64, i64* %7, align 8
  %43 = add i64 %42, 1
  store i64 %43, i64* %7, align 8
  br label %16

44:
  ret void
}

; subtracts two vectors
define dso_local void @JITensor_sub_vec_vec(%JITensor* noundef %0, %JITensor* noundef %1, %JITensor* noundef %2) #0 {
  %4 = alloca %JITensor*, align 8
  %5 = alloca %JITensor*, align 8
  %6 = alloca %JITensor*, align 8
  %7 = alloca i64, align 8
  store %JITensor* %0, %JITensor** %4, align 8
  store %JITensor* %1, %JITensor** %5, align 8
  store %JITensor* %2, %JITensor** %6, align 8
  %8 = load %JITensor*, %JITensor** %4, align 8
  %9 = load %JITensor*, %JITensor** %5, align 8
  %10 = call i32 @JITensor_same_dim(%JITensor* noundef %8, %JITensor* noundef %9)
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %13, label %12

12:
  br label %44

13:
  %14 = load %JITensor*, %JITensor** %4, align 8
  %15 = load %JITensor*, %JITensor** %6, align 8
  call void @JITensor_copy_shape(%JITensor* noundef %14, %JITensor* noundef %15)
  store i64 0, i64* %7, align 8
  br label %16

16:
  %17 = load i64, i64* %7, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 3
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %44

22:
  %23 = load %JITensor*, %JITensor** %4, align 8
  %24 = getelementptr inbounds %JITensor, %JITensor* %23, i32 0, i32 0
  %25 = load i64*, i64** %24, align 8
  %26 = load i64, i64* %7, align 8
  %27 = getelementptr inbounds i64, i64* %25, i64 %26
  %28 = load i64, i64* %27, align 8
  %29 = load %JITensor*, %JITensor** %5, align 8
  %30 = getelementptr inbounds %JITensor, %JITensor* %29, i32 0, i32 0
  %31 = load i64*, i64** %30, align 8
  %32 = load i64, i64* %7, align 8
  %33 = getelementptr inbounds i64, i64* %31, i64 %32
  %34 = load i64, i64* %33, align 8
  %35 = sub nsw i64 %28, %34
  %36 = load %JITensor*, %JITensor** %6, align 8
  %37 = getelementptr inbounds %JITensor, %JITensor* %36, i32 0, i32 0
  %38 = load i64*, i64** %37, align 8
  %39 = load i64, i64* %7, align 8
  %40 = getelementptr inbounds i64, i64* %38, i64 %39
  store i64 %35, i64* %40, align 8
  br label %41

41:
  %42 = load i64, i64* %7, align 8
  %43 = add i64 %42, 1
  store i64 %43, i64* %7, align 8
  br label %16

44:
  ret void
}

; multiplies two vectors
define dso_local void @JITensor_mul_vec_vec(%JITensor* noundef %0, %JITensor* noundef %1, %JITensor* noundef %2) #0 {
  %4 = alloca %JITensor*, align 8
  %5 = alloca %JITensor*, align 8
  %6 = alloca %JITensor*, align 8
  %7 = alloca i64, align 8
  store %JITensor* %0, %JITensor** %4, align 8
  store %JITensor* %1, %JITensor** %5, align 8
  store %JITensor* %2, %JITensor** %6, align 8
  %8 = load %JITensor*, %JITensor** %4, align 8
  %9 = load %JITensor*, %JITensor** %5, align 8
  %10 = call i32 @JITensor_same_dim(%JITensor* noundef %8, %JITensor* noundef %9)
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %13, label %12

12:
  br label %44

13:
  %14 = load %JITensor*, %JITensor** %4, align 8
  %15 = load %JITensor*, %JITensor** %6, align 8
  call void @JITensor_copy_shape(%JITensor* noundef %14, %JITensor* noundef %15)
  store i64 0, i64* %7, align 8
  br label %16

16:
  %17 = load i64, i64* %7, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 3
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %44

22:
  %23 = load %JITensor*, %JITensor** %4, align 8
  %24 = getelementptr inbounds %JITensor, %JITensor* %23, i32 0, i32 0
  %25 = load i64*, i64** %24, align 8
  %26 = load i64, i64* %7, align 8
  %27 = getelementptr inbounds i64, i64* %25, i64 %26
  %28 = load i64, i64* %27, align 8
  %29 = load %JITensor*, %JITensor** %5, align 8
  %30 = getelementptr inbounds %JITensor, %JITensor* %29, i32 0, i32 0
  %31 = load i64*, i64** %30, align 8
  %32 = load i64, i64* %7, align 8
  %33 = getelementptr inbounds i64, i64* %31, i64 %32
  %34 = load i64, i64* %33, align 8
  %35 = mul nsw i64 %28, %34
  %36 = load %JITensor*, %JITensor** %6, align 8
  %37 = getelementptr inbounds %JITensor, %JITensor* %36, i32 0, i32 0
  %38 = load i64*, i64** %37, align 8
  %39 = load i64, i64* %7, align 8
  %40 = getelementptr inbounds i64, i64* %38, i64 %39
  store i64 %35, i64* %40, align 8
  br label %41

41:
  %42 = load i64, i64* %7, align 8
  %43 = add i64 %42, 1
  store i64 %43, i64* %7, align 8
  br label %16

44:
  ret void
}

; divides two vectors
define dso_local void @JITensor_div_vec_vec(%JITensor* noundef %0, %JITensor* noundef %1, %JITensor* noundef %2) #0 {
  %4 = alloca %JITensor*, align 8
  %5 = alloca %JITensor*, align 8
  %6 = alloca %JITensor*, align 8
  %7 = alloca i64, align 8
  store %JITensor* %0, %JITensor** %4, align 8
  store %JITensor* %1, %JITensor** %5, align 8
  store %JITensor* %2, %JITensor** %6, align 8
  %8 = load %JITensor*, %JITensor** %4, align 8
  %9 = load %JITensor*, %JITensor** %5, align 8
  %10 = call i32 @JITensor_same_dim(%JITensor* noundef %8, %JITensor* noundef %9)
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %13, label %12

12:
  br label %44

13:
  %14 = load %JITensor*, %JITensor** %4, align 8
  %15 = load %JITensor*, %JITensor** %6, align 8
  call void @JITensor_copy_shape(%JITensor* noundef %14, %JITensor* noundef %15)
  store i64 0, i64* %7, align 8
  br label %16

16:
  %17 = load i64, i64* %7, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 3
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %44

22:
  %23 = load %JITensor*, %JITensor** %4, align 8
  %24 = getelementptr inbounds %JITensor, %JITensor* %23, i32 0, i32 0
  %25 = load i64*, i64** %24, align 8
  %26 = load i64, i64* %7, align 8
  %27 = getelementptr inbounds i64, i64* %25, i64 %26
  %28 = load i64, i64* %27, align 8
  %29 = load %JITensor*, %JITensor** %5, align 8
  %30 = getelementptr inbounds %JITensor, %JITensor* %29, i32 0, i32 0
  %31 = load i64*, i64** %30, align 8
  %32 = load i64, i64* %7, align 8
  %33 = getelementptr inbounds i64, i64* %31, i64 %32
  %34 = load i64, i64* %33, align 8
  %35 = sdiv i64 %28, %34
  %36 = load %JITensor*, %JITensor** %6, align 8
  %37 = getelementptr inbounds %JITensor, %JITensor* %36, i32 0, i32 0
  %38 = load i64*, i64** %37, align 8
  %39 = load i64, i64* %7, align 8
  %40 = getelementptr inbounds i64, i64* %38, i64 %39
  store i64 %35, i64* %40, align 8
  br label %41

41:
  %42 = load i64, i64* %7, align 8
  %43 = add i64 %42, 1
  store i64 %43, i64* %7, align 8
  br label %16

44:
  ret void
}

; i.
define dso_local void @idot(i64 noundef %0, %JITensor* noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca %JITensor*, align 8
  %5 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store %JITensor* %1, %JITensor** %4, align 8
  %6 = load %JITensor*, %JITensor** %4, align 8
  %7 = getelementptr inbounds %JITensor, %JITensor* %6, i32 0, i32 2
  store i64 1, i64* %7, align 8
  %8 = load %JITensor*, %JITensor** %4, align 8
  %9 = getelementptr inbounds %JITensor, %JITensor* %8, i32 0, i32 2
  %10 = load i64, i64* %9, align 8
  %11 = mul i64 8, %10
  %12 = call noalias i8* @malloc(i64 noundef %11) #4
  %13 = bitcast i8* %12 to i64*
  %14 = load %JITensor*, %JITensor** %4, align 8
  %15 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 1
  store i64* %13, i64** %15, align 8
  %16 = load i64, i64* %3, align 8
  %17 = load %JITensor*, %JITensor** %4, align 8
  %18 = getelementptr inbounds %JITensor, %JITensor* %17, i32 0, i32 1
  %19 = load i64*, i64** %18, align 8
  %20 = getelementptr inbounds i64, i64* %19, i64 0
  store i64 %16, i64* %20, align 8
  %21 = load i64, i64* %3, align 8
  %22 = load %JITensor*, %JITensor** %4, align 8
  %23 = getelementptr inbounds %JITensor, %JITensor* %22, i32 0, i32 3
  store i64 %21, i64* %23, align 8
  %24 = load %JITensor*, %JITensor** %4, align 8
  %25 = getelementptr inbounds %JITensor, %JITensor* %24, i32 0, i32 3
  %26 = load i64, i64* %25, align 8
  %27 = mul i64 8, %26
  %28 = call noalias i8* @malloc(i64 noundef %27) #4
  %29 = bitcast i8* %28 to i64*
  %30 = load %JITensor*, %JITensor** %4, align 8
  %31 = getelementptr inbounds %JITensor, %JITensor* %30, i32 0, i32 0
  store i64* %29, i64** %31, align 8
  store i64 0, i64* %5, align 8
  br label %32

32:    
  %33 = load i64, i64* %5, align 8
  %34 = load i64, i64* %3, align 8
  %35 = icmp slt i64 %33, %34
  br i1 %35, label %36, label %46

36:    
  %37 = load i64, i64* %5, align 8
  %38 = load %JITensor*, %JITensor** %4, align 8
  %39 = getelementptr inbounds %JITensor, %JITensor* %38, i32 0, i32 0
  %40 = load i64*, i64** %39, align 8
  %41 = load i64, i64* %5, align 8
  %42 = getelementptr inbounds i64, i64* %40, i64 %41
  store i64 %37, i64* %42, align 8
  br label %43

43:    
  %44 = load i64, i64* %5, align 8
  %45 = add nsw i64 %44, 1
  store i64 %45, i64* %5, align 8
  br label %32    

46:    
  ret void
}
