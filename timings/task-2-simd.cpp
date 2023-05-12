#include <iostream>
#include <cstdlib>
#include <ctime>
#include <immintrin.h> /* for SIMD intrinsics */
#include "portable-attributes.h"
#include "timing.h"

// make options: -O3 -g -Wall

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

NOINLINE void do_matrix_product(float** A, float** B, float** C) {
    for(int i = 0; i < rows; ++i) {
        for(int j = 0; j < rows; j += 8) {
            __m256 sum = _mm256_setzero_ps();

            for(int k = 0; k < cols; ++k) {
                __m256 a = _mm256_broadcast_ss(&A[i][k]);
                __m256 b = _mm256_loadu_ps(&B[k][j]);
                sum = _mm256_add_ps(sum, _mm256_mul_ps(a, b));
            }

            _mm256_storeu_ps(&C[i][j], sum);
        }
    }
}

int main() {
    // Allocate memory for matrices A, B, and C
    float** A = new float*[rows];
    float** B = new float*[cols];
    float** C = new float*[rows];
    for(int i = 0; i < rows; ++i) {
        A[i] = new float[cols];
        C[i] = new float[rows];
    }
    for(int i = 0; i < cols; ++i) {
        B[i] = new float[rows];
    }

    srand(SEED); // Seed the random number generator
    for(size_t n = 0; n < NTRIALS; n++) {
        // progress information
        std::cerr << (n + 1) << '/' << NTRIALS << '\r' << std::flush;
        // Initialize matrices A and B with random values
        for(int i = 0; i < rows; ++i) {
            for(int j = 0; j < cols; ++j) {
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
