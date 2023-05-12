#include <iostream>
#include <vector>
#include <immintrin.h> /* for SIMD intrinsics */
#include "portable-attributes.h"
#include "timing.h"

// make options: -O3 -g -Wall -Wno-unused-but-set-variable -march=native

#ifndef MAX
#define MAX (320000000)
#endif

#ifndef NTRIALS
#define NTRIALS (3)
#endif

typedef long long Atom;

NOINLINE Atom do_sum(std::vector<Atom> array, size_t max) {
  Atom result = 0;
  const size_t n = array.size();
  const size_t simd_size = sizeof(__m256i) / sizeof(Atom);
  const size_t num_simd_iters = n / simd_size;
  __m256i simd_sum = _mm256_setzero_si256();
  // add elements N at a time corresponding to the given stride
  // this creates stride_size sums we must sum at the end
  for (size_t i = 0; i < num_simd_iters * simd_size; i += simd_size) {
    __m256i simd_array = _mm256_loadu_si256((__m256i*)&array[i]);
    simd_sum = _mm256_add_epi64(simd_sum, simd_array);
  }
  // retrieve and sum the final results
  Atom simd_sum_array[simd_size];
  _mm256_storeu_si256((__m256i*)&simd_sum_array[0], simd_sum);
  for (size_t i = 0; i < simd_size; i++) {
    result += simd_sum_array[i];
  }
  // add remaining elements not handled by vectorization
  for (size_t i = num_simd_iters * simd_size; i < n; i++) {
    result += array[i];
  }
  return result;
}

int main() {
  size_t max = MAX;
  std::vector<Atom> array;
  // generate step
  array.reserve(max);
  for(size_t i = 0; i < max; i++) {
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