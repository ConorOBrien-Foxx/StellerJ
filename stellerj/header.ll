; included in a compiled file
declare noalias i8* @malloc(i64 noundef)
declare void @free(i8* noundef)
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg)
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg)
declare i32 @printf(i8*, ...)
declare i32 @putchar(i32)