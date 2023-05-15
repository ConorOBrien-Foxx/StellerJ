#include <iostream>
#include <vector>
#include <immintrin.h> /* for SIMD intrinsics */
#include "portable-attributes.hpp"
#include "timing.hpp"

// make options: -O3 -g -Wall -Wno-unused-but-set-variable -march=native

#ifndef MAX
#define MAX (320000000)
#endif

#ifndef NTRIALS
#define NTRIALS (3)
#endif

const size_t SIMD_SIZE = sizeof(__m256i) / sizeof(int64_t);
NOINLINE int64_t do_sum(std::vector<int64_t> array, size_t size) {
    // performs the sum by creating (SIMD_SIZE) pools to sum into
    // and summing every SIMD_SIZE-th element
    int64_t result = 0;
    __m256i simd_sum = _mm256_setzero_si256();
    // add elements N at a time corresponding to the given stride
    // this creates stride_size sums we must sum at the end
    size_t i;
    for (i = 0; i < size; i += SIMD_SIZE) {
        __m256i simd_array = _mm256_loadu_si256((__m256i*)&array[i]);
        simd_sum = _mm256_add_epi64(simd_sum, simd_array);
    }
    // retrieve and sum the final results
    int64_t simd_sum_array[SIMD_SIZE];
    _mm256_storeu_si256((__m256i*)&simd_sum_array[0], simd_sum);
    for (size_t j = 0; j < SIMD_SIZE; j++) {
        result += simd_sum_array[j];
    }
    // add remaining elements not handled by vectorization
    for (; i < size; i++) {
        result += array[i];
    }
    return result;
}

int main() {
    size_t max = MAX;
    std::vector<int64_t> array;
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
        int64_t sum = 0;
        uint64_t start_time = ns_time();
        sum = do_sum(array, max);
        uint64_t end_time = ns_time();
        // output step
        // std::cout << sum << '\n';
        double ms_time = (end_time - start_time) / 1e9;
        std::cout << ms_time << '\n';
    }
    // padding flush
    std::cerr << std::endl;

    return 0;
}
