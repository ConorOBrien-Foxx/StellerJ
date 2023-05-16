; included in a compiled file

; generates a matrix
define dso_local void @task2(i64 noundef %0, i64 noundef %1, %JITensor* noundef %2) #0 {
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
  %15 = call noalias i8* @malloc(i64 noundef %14) #4
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
  %38 = call noalias i8* @malloc(i64 noundef %37) #4
  %39 = bitcast i8* %38 to i64*
  %40 = load %JITensor*, %JITensor** %6, align 8
  %41 = getelementptr inbounds %JITensor, %JITensor* %40, i32 0, i32 0
  store i64* %39, i64** %41, align 8
  store i64 0, i64* %7, align 8
  br label %42

42:
  %43 = load i64, i64* %7, align 8
  %44 = load i64, i64* %4, align 8
  %45 = icmp ult i64 %43, %44
  br i1 %45, label %46, label %71

46:
  store i64 0, i64* %8, align 8
  br label %47

47:
  %48 = load i64, i64* %8, align 8
  %49 = load i64, i64* %5, align 8
  %50 = icmp ult i64 %48, %49
  br i1 %50, label %51, label %67

51:
  %52 = call i32 @rand() #4
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

64:
  %65 = load i64, i64* %8, align 8
  %66 = add i64 %65, 1
  store i64 %66, i64* %8, align 8
  br label %47

67:
  br label %68

68:
  %69 = load i64, i64* %7, align 8
  %70 = add i64 %69, 1
  store i64 %70, i64* %7, align 8
  br label %42

71:
  ret void
}

define dso_local void @task3(i64 noundef %0, i64 noundef %1, i64 noundef %2, i64 noundef %3, %JITensor* noundef %4) #0 {
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
  %18 = call noalias i8* @malloc(i64 noundef %17) #4
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
  %55 = call noalias i8* @malloc(i64 noundef %54) #4
  %56 = bitcast i8* %55 to i64*
  %57 = load %JITensor*, %JITensor** %10, align 8
  %58 = getelementptr inbounds %JITensor, %JITensor* %57, i32 0, i32 0
  store i64* %56, i64** %58, align 8
  store i64 0, i64* %11, align 8
  br label %59

59:
  %60 = load i64, i64* %11, align 8
  %61 = load %JITensor*, %JITensor** %10, align 8
  %62 = getelementptr inbounds %JITensor, %JITensor* %61, i32 0, i32 3
  %63 = load i64, i64* %62, align 8
  %64 = icmp ult i64 %60, %63
  br i1 %64, label %65, label %77

65:
  %66 = call i32 @rand() #4
  %67 = srem i32 %66, 100
  %68 = sext i32 %67 to i64
  %69 = load %JITensor*, %JITensor** %10, align 8
  %70 = getelementptr inbounds %JITensor, %JITensor* %69, i32 0, i32 0
  %71 = load i64*, i64** %70, align 8
  %72 = load i64, i64* %11, align 8
  %73 = getelementptr inbounds i64, i64* %71, i64 %72
  store i64 %68, i64* %73, align 8
  br label %74

74:
  %75 = load i64, i64* %11, align 8
  %76 = add i64 %75, 1
  store i64 %76, i64* %11, align 8
  br label %59

77:
  ret void
}

; timing functions
%struct.timespec = type { i64, i64 }
define internal i64 @ns_time() #0 {
  %1 = alloca %struct.timespec, align 8
  %2 = call i32 @clock_gettime(i32 noundef 0, %struct.timespec* noundef %1) #3
  %3 = getelementptr inbounds %struct.timespec, %struct.timespec* %1, i32 0, i32 0
  %4 = load i64, i64* %3, align 8
  %5 = mul nsw i64 %4, 1000000000
  %6 = getelementptr inbounds %struct.timespec, %struct.timespec* %1, i32 0, i32 1
  %7 = load i64, i64* %6, align 8
  %8 = add nsw i64 %5, %7
  ret i64 %8
}

@.outfmt = private unnamed_addr constant [4 x i8] c"%g\0A\00", align 1

declare i32 @rand() #1
declare i32 @clock_gettime(i32 noundef, %struct.timespec* noundef) #2
declare noalias i8* @malloc(i64 noundef)
declare void @free(i8* noundef)
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg)
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg)
declare i32 @printf(i8*, ...)
declare i32 @putchar(i32)

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
