#ifndef TIMING_INCLUDE
#define TIMING_INCLUDE

#include <cstdint> /* for uint64_t */
#include <time.h> /* for timespec, clock_gettime, etc */

static inline uint64_t ns_time() {
  struct timespec t;
  clock_gettime(CLOCK_REALTIME, &t);
  return (uint64_t)(t.tv_sec*1000000000ll + t.tv_nsec);
}


#endif
