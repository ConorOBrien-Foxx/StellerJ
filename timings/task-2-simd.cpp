#include <iostream>
#include <cstdlib>
#include <ctime>
#include <immintrin.h> /* for SIMD intrinsics */
#include "portable-attributes.hpp"
#include "timing.hpp"

// make options: -O3 -g -Wall -march=native

#ifndef ROWS
#define ROWS (1024)
#endif

#ifndef COLS
#define COLS (512)
#endif

#ifndef NTRIALS
#define NTRIALS (3)
#endif

#ifndef SEED
// #define SEED (time(0))
#define SEED (0)
#endif

const int rows = ROWS;
const int cols = COLS;

const size_t SIMD_SIZE = sizeof(__m256i) / sizeof(int64_t);
NOINLINE void do_matrix_product(int64_t** A, int64_t** B, int64_t** C) {
    for(int i = 0; i < rows; ++i) {
        for(int j = 0; j < rows; j += SIMD_SIZE) {
            __m256i sum = _mm256_setzero_si256();

            for(int k = 0; k < cols; ++k) {
                __m256i a = _mm256_set1_epi64x(A[i][k]);
                __m256i b = _mm256_loadu_si256((__m256i*) &B[k][j]);
                // multiply_256i_pairwise(a, b, b); // store product in the b temporary
                sum = _mm256_add_epi64(sum, _mm256_mul_epi32(a, b));
            }

            _mm256_storeu_si256((__m256i*) &C[i][j], sum);
        }
    }
}

int main() {
    // Allocate memory for matrices A, B, and C
    int64_t** A = new int64_t*[rows];
    int64_t** B = new int64_t*[cols];
    int64_t** C = new int64_t*[rows];
    for(size_t i = 0; i < rows; ++i) {
        A[i] = new int64_t[cols];
        C[i] = new int64_t[rows];
    }
    for(size_t i = 0; i < cols; ++i) {
        B[i] = new int64_t[rows];
    }

    srand(SEED); // Seed the random number generator
    for(size_t n = 0; n < NTRIALS; n++) {
        // progress information
        std::cerr << (n + 1) << '/' << NTRIALS << '\r' << std::flush;
        // Initialize matrices A and B with random values
        for(size_t i = 0; i < rows; ++i) {
            for(size_t j = 0; j < cols; ++j) {
                A[i][j] = rand() % 10; // Generate a random number between 0 and 9
            }
        }
        for(int i = 0; i < cols; ++i) {
            for(int j = 0; j < rows; ++j) {
                B[i][j] = rand() % 10;
            }
        }
        
        uint64_t start_time = ns_time();
        // Compute matrix product C = A * B
        do_matrix_product(A, B, C);
        uint64_t end_time = ns_time();
        double ms_time = (end_time - start_time) / 1e9;
        std::cout << ms_time << '\n';
    }
    // padding flush
    std::cerr << std::endl;
    
    return 0;
}
