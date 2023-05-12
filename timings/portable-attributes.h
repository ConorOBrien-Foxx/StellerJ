#ifndef PORTABLE_ATTRIBUTES_INCLUDE
#define PORTABLE_ATTRIBUTES_INCLUDE

#define NOINLINE __attribute__((noinline))
#if __clang__
  #define NOUNROLL _Pragma("clang loop unroll(disable)")
  #define NOVECTORIZE _Pragma("clang loop vectorize(disable)")
#elif __GNUC__
  #define EXACTLY_GCC 1
  #define NOUNROLL _Pragma("GCC unroll 1")
  #define NOVECTORIZE
#else
  #define NOUNROLL
  #define NOVECTORIZE
#endif
#define PLAINLOOP NOUNROLL NOVECTORIZE

#endif
