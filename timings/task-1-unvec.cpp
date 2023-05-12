#include <iostream>
#include <vector>
#include "portable-attributes.h"
#include "timing.h"

// make options: -O3 -g -Wall -Wno-unused-but-set-variable

#ifndef MAX
#define MAX (320000000)
#endif

#ifndef NTRIALS
#define NTRIALS (3)
#endif

typedef long long Atom;

NOINLINE Atom do_sum(std::vector<Atom> array, size_t max) {
  Atom result = 0;
  for(size_t i = 0; i < max; i++) {
    result += array[i];
  }
  return result;
}

int main() {
  size_t max = MAX;
  std::vector<Atom> array;
  // generate step
  array.reserve(max);
  NOUNROLL for(size_t i = 0; i < max; i++) {
    array.push_back(i);
  }
  // timing step
  for(size_t n = 0; n < NTRIALS; n++) {
    // progress information
    std::cerr << (n + 1) << '/' << NTRIALS << '\r' << std::flush;
    // summation step
    Atom sum = 0;
    uint64_t start_time = ns_time();
    sum = do_sum(array, max);
    uint64_t end_time = ns_time();
    // output step
    double ms_time = (end_time - start_time) / 1e9;
    std::cout << ms_time << '\n';
  }
  // padding flush
  std::cerr << std::endl;

  return 0;
}
