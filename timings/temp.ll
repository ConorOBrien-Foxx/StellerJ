; ModuleID = 'temp.ll'
source_filename = "temp.ll"

%JITensor = type { i64*, i64*, i64, i64 }
%struct.timespec = type { i64, i64 }

@.putn_fmt = internal constant [5 x i8] c"%lld\00", align 1
@.outfmt = private unnamed_addr constant [4 x i8] c"%g\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @putn(i64 %number) local_unnamed_addr #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.putn_fmt, i32 0, i32 0), i64 %number)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @I64_add(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = add nsw i64 %5, %6
  ret i64 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @I64_sub(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = sub nsw i64 %5, %6
  ret i64 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @I64_mul(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = mul nsw i64 %5, %6
  ret i64 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @I64_div(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = sdiv i64 %5, %6
  ret i64 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @JITensor_inner_product(%JITensor* noundef %0, %JITensor* noundef %1, i64 (%JITensor*)* noundef %2, i64 (i64, i64)* noundef %3, %JITensor* noundef %4) local_unnamed_addr #0 {
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

22:                                               ; preds = %5
  %23 = load %JITensor*, %JITensor** %7, align 8
  %24 = getelementptr inbounds %JITensor, %JITensor* %23, i32 0, i32 2
  %25 = load i64, i64* %24, align 8
  %26 = icmp ne i64 %25, 2
  br i1 %26, label %27, label %28

27:                                               ; preds = %22, %5
  br label %170

28:                                               ; preds = %22
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

46:                                               ; preds = %28
  br label %170

47:                                               ; preds = %28
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

57:                                               ; preds = %47
  %58 = load %JITensor*, %JITensor** %10, align 8
  %59 = getelementptr inbounds %JITensor, %JITensor* %58, i32 0, i32 2
  store i64 2, i64* %59, align 8
  %60 = load %JITensor*, %JITensor** %10, align 8
  %61 = getelementptr inbounds %JITensor, %JITensor* %60, i32 0, i32 2
  %62 = load i64, i64* %61, align 8
  %63 = mul i64 8, %62
  %64 = call noalias i8* @malloc(i64 noundef %63)
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
  %87 = call noalias i8* @malloc(i64 noundef %86)
  %88 = bitcast i8* %87 to i64*
  %89 = load %JITensor*, %JITensor** %10, align 8
  %90 = getelementptr inbounds %JITensor, %JITensor* %89, i32 0, i32 0
  store i64* %88, i64** %90, align 8
  br label %91

91:                                               ; preds = %57, %47
  %92 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 2
  store i64 1, i64* %92, align 8
  %93 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 2
  %94 = load i64, i64* %93, align 8
  %95 = mul i64 8, %94
  %96 = call noalias i8* @malloc(i64 noundef %95)
  %97 = bitcast i8* %96 to i64*
  %98 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 1
  store i64* %97, i64** %98, align 8
  %99 = load i64, i64* %12, align 8
  %100 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 3
  store i64 %99, i64* %100, align 8
  %101 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 3
  %102 = load i64, i64* %101, align 8
  %103 = mul i64 8, %102
  %104 = call noalias i8* @malloc(i64 noundef %103)
  %105 = bitcast i8* %104 to i64*
  %106 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 0
  store i64* %105, i64** %106, align 8
  store i64 0, i64* %15, align 8
  br label %107

107:                                              ; preds = %167, %91
  %108 = load i64, i64* %15, align 8
  %109 = load i64, i64* %11, align 8
  %110 = icmp ult i64 %108, %109
  br i1 %110, label %111, label %170

111:                                              ; preds = %107
  store i64 0, i64* %16, align 8
  br label %112

112:                                              ; preds = %163, %111
  %113 = load i64, i64* %16, align 8
  %114 = load i64, i64* %13, align 8
  %115 = icmp ult i64 %113, %114
  br i1 %115, label %116, label %166

116:                                              ; preds = %112
  store i64 0, i64* %17, align 8
  br label %117

117:                                              ; preds = %148, %116
  %118 = load i64, i64* %17, align 8
  %119 = load i64, i64* %12, align 8
  %120 = icmp ult i64 %118, %119
  br i1 %120, label %121, label %151

121:                                              ; preds = %117
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

148:                                              ; preds = %121
  %149 = load i64, i64* %17, align 8
  %150 = add i64 %149, 1
  store i64 %150, i64* %17, align 8
  br label %117

151:                                              ; preds = %117
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

163:                                              ; preds = %151
  %164 = load i64, i64* %16, align 8
  %165 = add i64 %164, 1
  store i64 %165, i64* %16, align 8
  br label %112

166:                                              ; preds = %112
  br label %167

167:                                              ; preds = %166
  %168 = load i64, i64* %15, align 8
  %169 = add i64 %168, 1
  store i64 %169, i64* %15, align 8
  br label %107

170:                                              ; preds = %107, %46, %27
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @JITensor_fold(%JITensor* noundef %0, i64 (i64, i64)* noundef %1, i64 noundef %2) local_unnamed_addr #0 {
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

14:                                               ; preds = %3
  %15 = load i64, i64* %7, align 8
  store i64 %15, i64* %4, align 8
  br label %50

16:                                               ; preds = %3
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

29:                                               ; preds = %45, %16
  %30 = load i64, i64* %8, align 8
  %31 = load %JITensor*, %JITensor** %5, align 8
  %32 = getelementptr inbounds %JITensor, %JITensor* %31, i32 0, i32 3
  %33 = load i64, i64* %32, align 8
  %34 = icmp ult i64 %30, %33
  br i1 %34, label %35, label %48

35:                                               ; preds = %29
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

45:                                               ; preds = %35
  %46 = load i64, i64* %8, align 8
  %47 = add i64 %46, -1
  store i64 %47, i64* %8, align 8
  br label %29

48:                                               ; preds = %29
  %49 = load i64, i64* %9, align 8
  store i64 %49, i64* %4, align 8
  br label %50

50:                                               ; preds = %48, %14
  %51 = load i64, i64* %4, align 8
  ret i64 %51
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @JITensor_dump(%JITensor* noundef %0) local_unnamed_addr #0 {
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

11:                                               ; preds = %1
  br label %64

12:                                               ; preds = %1
  store i64 0, i64* %6, align 8
  br label %13

13:                                               ; preds = %61, %12
  %14 = load i64, i64* %6, align 8
  %15 = load %JITensor*, %JITensor** %2, align 8
  %16 = getelementptr inbounds %JITensor, %JITensor* %15, i32 0, i32 3
  %17 = load i64, i64* %16, align 8
  %18 = icmp ult i64 %14, %17
  br i1 %18, label %19, label %64

19:                                               ; preds = %13
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

31:                                               ; preds = %52, %19
  %32 = load i64, i64* %4, align 8
  %33 = icmp uge i64 %32, 1
  br i1 %33, label %34, label %55

34:                                               ; preds = %31
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

49:                                               ; preds = %34
  store i32 0, i32* %5, align 4
  %50 = call i32 @putchar(i32 noundef 10)
  br label %51

51:                                               ; preds = %49, %34
  br label %52

52:                                               ; preds = %51
  %53 = load i64, i64* %4, align 8
  %54 = add i64 %53, -1
  store i64 %54, i64* %4, align 8
  br label %31

55:                                               ; preds = %31
  %56 = load i32, i32* %5, align 4
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %58, label %60

58:                                               ; preds = %55
  %59 = call i32 @putchar(i32 noundef 32)
  br label %60

60:                                               ; preds = %58, %55
  br label %61

61:                                               ; preds = %60
  %62 = load i64, i64* %6, align 8
  %63 = add i64 %62, 1
  store i64 %63, i64* %6, align 8
  br label %13

64:                                               ; preds = %13, %11
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @JITensor_same_dim(%JITensor* noundef %0, %JITensor* noundef %1) local_unnamed_addr #0 {
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

14:                                               ; preds = %2
  store i32 0, i32* %3, align 4
  br label %42

15:                                               ; preds = %2
  store i64 0, i64* %6, align 8
  br label %16

16:                                               ; preds = %38, %15
  %17 = load i64, i64* %6, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 2
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %41

22:                                               ; preds = %16
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

36:                                               ; preds = %22
  store i32 0, i32* %3, align 4
  br label %42

37:                                               ; preds = %22
  br label %38

38:                                               ; preds = %37
  %39 = load i64, i64* %6, align 8
  %40 = add i64 %39, 1
  store i64 %40, i64* %6, align 8
  br label %16

41:                                               ; preds = %16
  store i32 1, i32* %3, align 4
  br label %42

42:                                               ; preds = %41, %36, %14
  %43 = load i32, i32* %3, align 4
  ret i32 %43
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @JITensor_copy_shape(%JITensor* noundef %0, %JITensor* noundef %1) local_unnamed_addr #0 {
  %3 = alloca %JITensor*, align 8
  %4 = alloca %JITensor*, align 8
  store %JITensor* %0, %JITensor** %3, align 8
  store %JITensor* %1, %JITensor** %4, align 8
  %5 = load %JITensor*, %JITensor** %3, align 8
  %6 = load %JITensor*, %JITensor** %4, align 8
  %7 = call i32 @JITensor_same_dim(%JITensor* noundef %5, %JITensor* noundef %6)
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %68, label %9

9:                                                ; preds = %2
  %10 = load %JITensor*, %JITensor** %4, align 8
  %11 = getelementptr inbounds %JITensor, %JITensor* %10, i32 0, i32 0
  %12 = load i64*, i64** %11, align 8
  %13 = icmp ne i64* %12, null
  br i1 %13, label %14, label %19

14:                                               ; preds = %9
  %15 = load %JITensor*, %JITensor** %4, align 8
  %16 = getelementptr inbounds %JITensor, %JITensor* %15, i32 0, i32 0
  %17 = load i64*, i64** %16, align 8
  %18 = bitcast i64* %17 to i8*
  call void @free(i8* noundef %18)
  br label %19

19:                                               ; preds = %14, %9
  %20 = load %JITensor*, %JITensor** %3, align 8
  %21 = getelementptr inbounds %JITensor, %JITensor* %20, i32 0, i32 3
  %22 = load i64, i64* %21, align 8
  %23 = mul i64 8, %22
  %24 = call noalias i8* @malloc(i64 noundef %23)
  %25 = bitcast i8* %24 to i64*
  %26 = load %JITensor*, %JITensor** %4, align 8
  %27 = getelementptr inbounds %JITensor, %JITensor* %26, i32 0, i32 0
  store i64* %25, i64** %27, align 8
  %28 = load %JITensor*, %JITensor** %4, align 8
  %29 = getelementptr inbounds %JITensor, %JITensor* %28, i32 0, i32 1
  %30 = load i64*, i64** %29, align 8
  %31 = icmp ne i64* %30, null
  br i1 %31, label %32, label %37

32:                                               ; preds = %19
  %33 = load %JITensor*, %JITensor** %4, align 8
  %34 = getelementptr inbounds %JITensor, %JITensor* %33, i32 0, i32 1
  %35 = load i64*, i64** %34, align 8
  %36 = bitcast i64* %35 to i8*
  call void @free(i8* noundef %36)
  br label %37

37:                                               ; preds = %32, %19
  %38 = load %JITensor*, %JITensor** %3, align 8
  %39 = getelementptr inbounds %JITensor, %JITensor* %38, i32 0, i32 2
  %40 = load i64, i64* %39, align 8
  %41 = mul i64 8, %40
  %42 = call noalias i8* @malloc(i64 noundef %41)
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

68:                                               ; preds = %37, %2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @JITensor_copy_value(%JITensor* noundef %0, %JITensor* noundef %1) local_unnamed_addr #0 {
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

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @JITensor_add_vec_vec(%JITensor* noundef %0, %JITensor* noundef %1, %JITensor* noundef %2) local_unnamed_addr #0 {
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

12:                                               ; preds = %3
  br label %44

13:                                               ; preds = %3
  %14 = load %JITensor*, %JITensor** %4, align 8
  %15 = load %JITensor*, %JITensor** %6, align 8
  call void @JITensor_copy_shape(%JITensor* noundef %14, %JITensor* noundef %15)
  store i64 0, i64* %7, align 8
  br label %16

16:                                               ; preds = %41, %13
  %17 = load i64, i64* %7, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 3
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %44

22:                                               ; preds = %16
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

41:                                               ; preds = %22
  %42 = load i64, i64* %7, align 8
  %43 = add i64 %42, 1
  store i64 %43, i64* %7, align 8
  br label %16

44:                                               ; preds = %16, %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @JITensor_sub_vec_vec(%JITensor* noundef %0, %JITensor* noundef %1, %JITensor* noundef %2) local_unnamed_addr #0 {
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

12:                                               ; preds = %3
  br label %44

13:                                               ; preds = %3
  %14 = load %JITensor*, %JITensor** %4, align 8
  %15 = load %JITensor*, %JITensor** %6, align 8
  call void @JITensor_copy_shape(%JITensor* noundef %14, %JITensor* noundef %15)
  store i64 0, i64* %7, align 8
  br label %16

16:                                               ; preds = %41, %13
  %17 = load i64, i64* %7, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 3
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %44

22:                                               ; preds = %16
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

41:                                               ; preds = %22
  %42 = load i64, i64* %7, align 8
  %43 = add i64 %42, 1
  store i64 %43, i64* %7, align 8
  br label %16

44:                                               ; preds = %16, %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @JITensor_mul_vec_vec(%JITensor* noundef %0, %JITensor* noundef %1, %JITensor* noundef %2) local_unnamed_addr #0 {
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

12:                                               ; preds = %3
  br label %44

13:                                               ; preds = %3
  %14 = load %JITensor*, %JITensor** %4, align 8
  %15 = load %JITensor*, %JITensor** %6, align 8
  call void @JITensor_copy_shape(%JITensor* noundef %14, %JITensor* noundef %15)
  store i64 0, i64* %7, align 8
  br label %16

16:                                               ; preds = %41, %13
  %17 = load i64, i64* %7, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 3
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %44

22:                                               ; preds = %16
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

41:                                               ; preds = %22
  %42 = load i64, i64* %7, align 8
  %43 = add i64 %42, 1
  store i64 %43, i64* %7, align 8
  br label %16

44:                                               ; preds = %16, %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @JITensor_div_vec_vec(%JITensor* noundef %0, %JITensor* noundef %1, %JITensor* noundef %2) local_unnamed_addr #0 {
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

12:                                               ; preds = %3
  br label %44

13:                                               ; preds = %3
  %14 = load %JITensor*, %JITensor** %4, align 8
  %15 = load %JITensor*, %JITensor** %6, align 8
  call void @JITensor_copy_shape(%JITensor* noundef %14, %JITensor* noundef %15)
  store i64 0, i64* %7, align 8
  br label %16

16:                                               ; preds = %41, %13
  %17 = load i64, i64* %7, align 8
  %18 = load %JITensor*, %JITensor** %4, align 8
  %19 = getelementptr inbounds %JITensor, %JITensor* %18, i32 0, i32 3
  %20 = load i64, i64* %19, align 8
  %21 = icmp ult i64 %17, %20
  br i1 %21, label %22, label %44

22:                                               ; preds = %16
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

41:                                               ; preds = %22
  %42 = load i64, i64* %7, align 8
  %43 = add i64 %42, 1
  store i64 %43, i64* %7, align 8
  br label %16

44:                                               ; preds = %16, %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @idot(i64 noundef %0, %JITensor* noundef %1) local_unnamed_addr #0 {
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
  %12 = call noalias i8* @malloc(i64 noundef %11)
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
  %28 = call noalias i8* @malloc(i64 noundef %27)
  %29 = bitcast i8* %28 to i64*
  %30 = load %JITensor*, %JITensor** %4, align 8
  %31 = getelementptr inbounds %JITensor, %JITensor* %30, i32 0, i32 0
  store i64* %29, i64** %31, align 8
  store i64 0, i64* %5, align 8
  br label %32

32:                                               ; preds = %43, %2
  %33 = load i64, i64* %5, align 8
  %34 = load i64, i64* %3, align 8
  %35 = icmp slt i64 %33, %34
  br i1 %35, label %36, label %46

36:                                               ; preds = %32
  %37 = load i64, i64* %5, align 8
  %38 = load %JITensor*, %JITensor** %4, align 8
  %39 = getelementptr inbounds %JITensor, %JITensor* %38, i32 0, i32 0
  %40 = load i64*, i64** %39, align 8
  %41 = load i64, i64* %5, align 8
  %42 = getelementptr inbounds i64, i64* %40, i64 %41
  store i64 %37, i64* %42, align 8
  br label %43

43:                                               ; preds = %36
  %44 = load i64, i64* %5, align 8
  %45 = add nsw i64 %44, 1
  store i64 %45, i64* %5, align 8
  br label %32

46:                                               ; preds = %32
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @task2(i64 noundef %0, i64 noundef %1, %JITensor* noundef %2) local_unnamed_addr #0 {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca %JITensor*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  store i64 %0, i64* %4, align 8
  store i64 %1, i64* %5, align 8
  store %JITensor* %2, %JITensor** %6, align 8
  %9 = load %JITensor*, %JITensor** %6, align 8
  %10 = getelementptr inbounds %JITensor, %JITensor* %9, i32 0, i32 2
  store i64 2, i64* %10, align 8
  %11 = load %JITensor*, %JITensor** %6, align 8
  %12 = getelementptr inbounds %JITensor, %JITensor* %11, i32 0, i32 2
  %13 = load i64, i64* %12, align 8
  %14 = mul i64 8, %13
  %15 = call noalias i8* @malloc(i64 noundef %14)
  %16 = bitcast i8* %15 to i64*
  %17 = load %JITensor*, %JITensor** %6, align 8
  %18 = getelementptr inbounds %JITensor, %JITensor* %17, i32 0, i32 1
  store i64* %16, i64** %18, align 8
  %19 = load i64, i64* %4, align 8
  %20 = load %JITensor*, %JITensor** %6, align 8
  %21 = getelementptr inbounds %JITensor, %JITensor* %20, i32 0, i32 1
  %22 = load i64*, i64** %21, align 8
  %23 = getelementptr inbounds i64, i64* %22, i64 0
  store i64 %19, i64* %23, align 8
  %24 = load i64, i64* %5, align 8
  %25 = load %JITensor*, %JITensor** %6, align 8
  %26 = getelementptr inbounds %JITensor, %JITensor* %25, i32 0, i32 1
  %27 = load i64*, i64** %26, align 8
  %28 = getelementptr inbounds i64, i64* %27, i64 1
  store i64 %24, i64* %28, align 8
  %29 = load i64, i64* %4, align 8
  %30 = load i64, i64* %5, align 8
  %31 = mul nsw i64 %29, %30
  %32 = load %JITensor*, %JITensor** %6, align 8
  %33 = getelementptr inbounds %JITensor, %JITensor* %32, i32 0, i32 3
  store i64 %31, i64* %33, align 8
  %34 = load %JITensor*, %JITensor** %6, align 8
  %35 = getelementptr inbounds %JITensor, %JITensor* %34, i32 0, i32 3
  %36 = load i64, i64* %35, align 8
  %37 = mul i64 8, %36
  %38 = call noalias i8* @malloc(i64 noundef %37)
  %39 = bitcast i8* %38 to i64*
  %40 = load %JITensor*, %JITensor** %6, align 8
  %41 = getelementptr inbounds %JITensor, %JITensor* %40, i32 0, i32 0
  store i64* %39, i64** %41, align 8
  store i64 0, i64* %7, align 8
  br label %42

42:                                               ; preds = %68, %3
  %43 = load i64, i64* %7, align 8
  %44 = load i64, i64* %4, align 8
  %45 = icmp ult i64 %43, %44
  br i1 %45, label %46, label %71

46:                                               ; preds = %42
  store i64 0, i64* %8, align 8
  br label %47

47:                                               ; preds = %64, %46
  %48 = load i64, i64* %8, align 8
  %49 = load i64, i64* %5, align 8
  %50 = icmp ult i64 %48, %49
  br i1 %50, label %51, label %67

51:                                               ; preds = %47
  %52 = call i32 @rand()
  %53 = srem i32 %52, 10
  %54 = sext i32 %53 to i64
  %55 = load %JITensor*, %JITensor** %6, align 8
  %56 = getelementptr inbounds %JITensor, %JITensor* %55, i32 0, i32 0
  %57 = load i64*, i64** %56, align 8
  %58 = load i64, i64* %7, align 8
  %59 = load i64, i64* %5, align 8
  %60 = mul i64 %58, %59
  %61 = load i64, i64* %8, align 8
  %62 = add i64 %60, %61
  %63 = getelementptr inbounds i64, i64* %57, i64 %62
  store i64 %54, i64* %63, align 8
  br label %64

64:                                               ; preds = %51
  %65 = load i64, i64* %8, align 8
  %66 = add i64 %65, 1
  store i64 %66, i64* %8, align 8
  br label %47

67:                                               ; preds = %47
  br label %68

68:                                               ; preds = %67
  %69 = load i64, i64* %7, align 8
  %70 = add i64 %69, 1
  store i64 %70, i64* %7, align 8
  br label %42

71:                                               ; preds = %42
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @task3(i64 noundef %0, i64 noundef %1, i64 noundef %2, i64 noundef %3, %JITensor* noundef %4) local_unnamed_addr #0 {
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca %JITensor*, align 8
  %11 = alloca i64, align 8
  store i64 %0, i64* %6, align 8
  store i64 %1, i64* %7, align 8
  store i64 %2, i64* %8, align 8
  store i64 %3, i64* %9, align 8
  store %JITensor* %4, %JITensor** %10, align 8
  %12 = load %JITensor*, %JITensor** %10, align 8
  %13 = getelementptr inbounds %JITensor, %JITensor* %12, i32 0, i32 2
  store i64 4, i64* %13, align 8
  %14 = load %JITensor*, %JITensor** %10, align 8
  %15 = getelementptr inbounds %JITensor, %JITensor* %14, i32 0, i32 2
  %16 = load i64, i64* %15, align 8
  %17 = mul i64 8, %16
  %18 = call noalias i8* @malloc(i64 noundef %17)
  %19 = bitcast i8* %18 to i64*
  %20 = load %JITensor*, %JITensor** %10, align 8
  %21 = getelementptr inbounds %JITensor, %JITensor* %20, i32 0, i32 1
  store i64* %19, i64** %21, align 8
  %22 = load i64, i64* %6, align 8
  %23 = load %JITensor*, %JITensor** %10, align 8
  %24 = getelementptr inbounds %JITensor, %JITensor* %23, i32 0, i32 1
  %25 = load i64*, i64** %24, align 8
  %26 = getelementptr inbounds i64, i64* %25, i64 0
  store i64 %22, i64* %26, align 8
  %27 = load i64, i64* %7, align 8
  %28 = load %JITensor*, %JITensor** %10, align 8
  %29 = getelementptr inbounds %JITensor, %JITensor* %28, i32 0, i32 1
  %30 = load i64*, i64** %29, align 8
  %31 = getelementptr inbounds i64, i64* %30, i64 1
  store i64 %27, i64* %31, align 8
  %32 = load i64, i64* %8, align 8
  %33 = load %JITensor*, %JITensor** %10, align 8
  %34 = getelementptr inbounds %JITensor, %JITensor* %33, i32 0, i32 1
  %35 = load i64*, i64** %34, align 8
  %36 = getelementptr inbounds i64, i64* %35, i64 2
  store i64 %32, i64* %36, align 8
  %37 = load i64, i64* %9, align 8
  %38 = load %JITensor*, %JITensor** %10, align 8
  %39 = getelementptr inbounds %JITensor, %JITensor* %38, i32 0, i32 1
  %40 = load i64*, i64** %39, align 8
  %41 = getelementptr inbounds i64, i64* %40, i64 3
  store i64 %37, i64* %41, align 8
  %42 = load i64, i64* %6, align 8
  %43 = load i64, i64* %7, align 8
  %44 = mul nsw i64 %42, %43
  %45 = load i64, i64* %8, align 8
  %46 = mul nsw i64 %44, %45
  %47 = load i64, i64* %9, align 8
  %48 = mul nsw i64 %46, %47
  %49 = load %JITensor*, %JITensor** %10, align 8
  %50 = getelementptr inbounds %JITensor, %JITensor* %49, i32 0, i32 3
  store i64 %48, i64* %50, align 8
  %51 = load %JITensor*, %JITensor** %10, align 8
  %52 = getelementptr inbounds %JITensor, %JITensor* %51, i32 0, i32 3
  %53 = load i64, i64* %52, align 8
  %54 = mul i64 8, %53
  %55 = call noalias i8* @malloc(i64 noundef %54)
  %56 = bitcast i8* %55 to i64*
  %57 = load %JITensor*, %JITensor** %10, align 8
  %58 = getelementptr inbounds %JITensor, %JITensor* %57, i32 0, i32 0
  store i64* %56, i64** %58, align 8
  store i64 0, i64* %11, align 8
  br label %59

59:                                               ; preds = %74, %5
  %60 = load i64, i64* %11, align 8
  %61 = load %JITensor*, %JITensor** %10, align 8
  %62 = getelementptr inbounds %JITensor, %JITensor* %61, i32 0, i32 3
  %63 = load i64, i64* %62, align 8
  %64 = icmp ult i64 %60, %63
  br i1 %64, label %65, label %77

65:                                               ; preds = %59
  %66 = call i32 @rand()
  %67 = srem i32 %66, 100
  %68 = sext i32 %67 to i64
  %69 = load %JITensor*, %JITensor** %10, align 8
  %70 = getelementptr inbounds %JITensor, %JITensor* %69, i32 0, i32 0
  %71 = load i64*, i64** %70, align 8
  %72 = load i64, i64* %11, align 8
  %73 = getelementptr inbounds i64, i64* %71, i64 %72
  store i64 %68, i64* %73, align 8
  br label %74

74:                                               ; preds = %65
  %75 = load i64, i64* %11, align 8
  %76 = add i64 %75, 1
  store i64 %76, i64* %11, align 8
  br label %59

77:                                               ; preds = %59
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal fastcc i64 @ns_time() unnamed_addr #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = call i32 @clock_gettime(i32 noundef 0, %struct.timespec* noundef %1)
  %3 = getelementptr inbounds %struct.timespec, %struct.timespec* %1, i32 0, i32 0
  %4 = load i64, i64* %3, align 8
  %5 = mul nsw i64 %4, 1000000000
  %6 = getelementptr inbounds %struct.timespec, %struct.timespec* %1, i32 0, i32 1
  %7 = load i64, i64* %6, align 8
  %8 = add nsw i64 %5, %7
  ret i64 %8
}

declare i32 @rand() local_unnamed_addr

declare i32 @clock_gettime(i32 noundef, %struct.timespec* noundef) local_unnamed_addr

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind willreturn
declare noalias noundef i8* @malloc(i64 noundef) local_unnamed_addr #1

; Function Attrs: inaccessiblemem_or_argmemonly mustprogress nounwind willreturn
declare void @free(i8* nocapture noundef) local_unnamed_addr #2

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: nofree nounwind
declare noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  %A = alloca %JITensor, align 8
  %1 = bitcast %JITensor* %A to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %1, i8 0, i64 32, i1 false)
  %2 = alloca %JITensor, align 8
  %3 = bitcast %JITensor* %2 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %3, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %2)
  call void @JITensor_copy_value(%JITensor* %2, %JITensor* %A)
  %B = alloca %JITensor, align 8
  %4 = bitcast %JITensor* %B to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %4, i8 0, i64 32, i1 false)
  %5 = alloca %JITensor, align 8
  %6 = bitcast %JITensor* %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %6, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %5)
  call void @JITensor_copy_value(%JITensor* %5, %JITensor* %B)
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca double, align 8
  %10 = call fastcc i64 @ns_time()
  store i64 %10, i64* %7, align 8
  %11 = alloca %JITensor, align 8
  %12 = bitcast %JITensor* %11 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %12, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %A, %JITensor* %11)
  %13 = alloca %JITensor, align 8
  %14 = bitcast %JITensor* %13 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %14, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %B, %JITensor* %13)
  %15 = alloca %JITensor, align 8
  %16 = bitcast %JITensor* %15 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %16, i8 0, i64 32, i1 false)
  call void @JITensor_mul_vec_vec(%JITensor* %11, %JITensor* %13, %JITensor* %15)
  %17 = call fastcc i64 @ns_time()
  store i64 %17, i64* %8, align 8
  %18 = load i64, i64* %8, align 8
  %19 = load i64, i64* %7, align 8
  %20 = sub i64 %18, %19
  %21 = uitofp i64 %20 to double
  %22 = fdiv double %21, 1.000000e+09
  store double %22, double* %9, align 8
  %23 = load double, double* %9, align 8
  %24 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.outfmt, i64 0, i64 0), double noundef %23)
  %25 = alloca %JITensor, align 8
  %26 = bitcast %JITensor* %25 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %26, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %25)
  call void @JITensor_copy_value(%JITensor* %25, %JITensor* %A)
  %27 = alloca %JITensor, align 8
  %28 = bitcast %JITensor* %27 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %28, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %27)
  call void @JITensor_copy_value(%JITensor* %27, %JITensor* %B)
  %29 = alloca i64, align 8
  %30 = alloca i64, align 8
  %31 = alloca double, align 8
  %32 = call fastcc i64 @ns_time()
  store i64 %32, i64* %29, align 8
  %33 = alloca %JITensor, align 8
  %34 = bitcast %JITensor* %33 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %34, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %A, %JITensor* %33)
  %35 = alloca %JITensor, align 8
  %36 = bitcast %JITensor* %35 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %36, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %B, %JITensor* %35)
  %37 = alloca %JITensor, align 8
  %38 = bitcast %JITensor* %37 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %38, i8 0, i64 32, i1 false)
  call void @JITensor_mul_vec_vec(%JITensor* %33, %JITensor* %35, %JITensor* %37)
  %39 = call fastcc i64 @ns_time()
  store i64 %39, i64* %30, align 8
  %40 = load i64, i64* %30, align 8
  %41 = load i64, i64* %29, align 8
  %42 = sub i64 %40, %41
  %43 = uitofp i64 %42 to double
  %44 = fdiv double %43, 1.000000e+09
  store double %44, double* %31, align 8
  %45 = load double, double* %31, align 8
  %46 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.outfmt, i64 0, i64 0), double noundef %45)
  %47 = alloca %JITensor, align 8
  %48 = bitcast %JITensor* %47 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %48, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %47)
  call void @JITensor_copy_value(%JITensor* %47, %JITensor* %A)
  %49 = alloca %JITensor, align 8
  %50 = bitcast %JITensor* %49 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %50, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %49)
  call void @JITensor_copy_value(%JITensor* %49, %JITensor* %B)
  %51 = alloca i64, align 8
  %52 = alloca i64, align 8
  %53 = alloca double, align 8
  %54 = call fastcc i64 @ns_time()
  store i64 %54, i64* %51, align 8
  %55 = alloca %JITensor, align 8
  %56 = bitcast %JITensor* %55 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %56, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %A, %JITensor* %55)
  %57 = alloca %JITensor, align 8
  %58 = bitcast %JITensor* %57 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %58, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %B, %JITensor* %57)
  %59 = alloca %JITensor, align 8
  %60 = bitcast %JITensor* %59 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %60, i8 0, i64 32, i1 false)
  call void @JITensor_mul_vec_vec(%JITensor* %55, %JITensor* %57, %JITensor* %59)
  %61 = call fastcc i64 @ns_time()
  store i64 %61, i64* %52, align 8
  %62 = load i64, i64* %52, align 8
  %63 = load i64, i64* %51, align 8
  %64 = sub i64 %62, %63
  %65 = uitofp i64 %64 to double
  %66 = fdiv double %65, 1.000000e+09
  store double %66, double* %53, align 8
  %67 = load double, double* %53, align 8
  %68 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.outfmt, i64 0, i64 0), double noundef %67)
  %69 = alloca %JITensor, align 8
  %70 = bitcast %JITensor* %69 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %70, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %69)
  call void @JITensor_copy_value(%JITensor* %69, %JITensor* %A)
  %71 = alloca %JITensor, align 8
  %72 = bitcast %JITensor* %71 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %72, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %71)
  call void @JITensor_copy_value(%JITensor* %71, %JITensor* %B)
  %73 = alloca i64, align 8
  %74 = alloca i64, align 8
  %75 = alloca double, align 8
  %76 = call fastcc i64 @ns_time()
  store i64 %76, i64* %73, align 8
  %77 = alloca %JITensor, align 8
  %78 = bitcast %JITensor* %77 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %78, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %A, %JITensor* %77)
  %79 = alloca %JITensor, align 8
  %80 = bitcast %JITensor* %79 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %80, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %B, %JITensor* %79)
  %81 = alloca %JITensor, align 8
  %82 = bitcast %JITensor* %81 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %82, i8 0, i64 32, i1 false)
  call void @JITensor_mul_vec_vec(%JITensor* %77, %JITensor* %79, %JITensor* %81)
  %83 = call fastcc i64 @ns_time()
  store i64 %83, i64* %74, align 8
  %84 = load i64, i64* %74, align 8
  %85 = load i64, i64* %73, align 8
  %86 = sub i64 %84, %85
  %87 = uitofp i64 %86 to double
  %88 = fdiv double %87, 1.000000e+09
  store double %88, double* %75, align 8
  %89 = load double, double* %75, align 8
  %90 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.outfmt, i64 0, i64 0), double noundef %89)
  %91 = alloca %JITensor, align 8
  %92 = bitcast %JITensor* %91 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %92, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %91)
  call void @JITensor_copy_value(%JITensor* %91, %JITensor* %A)
  %93 = alloca %JITensor, align 8
  %94 = bitcast %JITensor* %93 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %94, i8 0, i64 32, i1 false)
  call void @task3(i64 70, i64 40, i64 30, i64 64, %JITensor* %93)
  call void @JITensor_copy_value(%JITensor* %93, %JITensor* %B)
  %95 = alloca i64, align 8
  %96 = alloca i64, align 8
  %97 = alloca double, align 8
  %98 = call fastcc i64 @ns_time()
  store i64 %98, i64* %95, align 8
  %99 = alloca %JITensor, align 8
  %100 = bitcast %JITensor* %99 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %100, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %A, %JITensor* %99)
  %101 = alloca %JITensor, align 8
  %102 = bitcast %JITensor* %101 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %102, i8 0, i64 32, i1 false)
  call void @JITensor_copy_value(%JITensor* %B, %JITensor* %101)
  %103 = alloca %JITensor, align 8
  %104 = bitcast %JITensor* %103 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %104, i8 0, i64 32, i1 false)
  call void @JITensor_mul_vec_vec(%JITensor* %99, %JITensor* %101, %JITensor* %103)
  %105 = call fastcc i64 @ns_time()
  store i64 %105, i64* %96, align 8
  %106 = load i64, i64* %96, align 8
  %107 = load i64, i64* %95, align 8
  %108 = sub i64 %106, %107
  %109 = uitofp i64 %108 to double
  %110 = fdiv double %109, 1.000000e+09
  store double %110, double* %97, align 8
  %111 = load double, double* %97, align 8
  %112 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.outfmt, i64 0, i64 0), double noundef %111)
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { inaccessiblememonly mustprogress nofree nounwind willreturn }
attributes #2 = { inaccessiblemem_or_argmemonly mustprogress nounwind willreturn }
attributes #3 = { argmemonly mustprogress nofree nounwind willreturn writeonly }
attributes #4 = { argmemonly mustprogress nofree nounwind willreturn }
attributes #5 = { nofree nounwind }
