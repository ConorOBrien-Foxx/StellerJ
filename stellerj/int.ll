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
