#include <iostream>
#include <cstdlib>
#include <ctime>
#include <immintrin.h> /* for SIMD intrinsics */
#include "portable-attributes.hpp"
#include "timing.hpp"

#ifndef DIM_I
#define DIM_I (70)
#endif

#ifndef DIM_J
#define DIM_J (40)
#endif

#ifndef DIM_K
#define DIM_K (30)
#endif

#ifndef DIM_L
#define DIM_L (64)
#endif

#ifndef NTRIALS
#define NTRIALS (3)
#endif

#ifndef SEED
// #define SEED (time(0))
#define SEED (0)
#endif

const size_t I = DIM_I, J = DIM_J, K = DIM_K, L = DIM_L;

const size_t SIMD_SIZE = sizeof(__m256i) / sizeof(int64_t);
template <typename T>
NOINLINE void do_vectorized_product(T A, T B, T C) {
    for(size_t i = 0; i < I; i++) {
        for(size_t j = 0; j < J; j++) {
            for(size_t k = 0; k < K; k++) {
                size_t l;
                for(l = 0; l < L; l += SIMD_SIZE) {
                    __m256i a = _mm256_loadu_si256((__m256i*)(&A[i][j][k][l]));
                    __m256i b = _mm256_loadu_si256((__m256i*)(&B[i][j][k][l]));
                    __m256i c = _mm256_mullo_epi32(a, b);
                    _mm256_storeu_si256((__m256i*)(&C[i][j][k][l]), c);
                }
                for(; l < L; l++) {
                    C[i][j][k][l] = A[i][j][k][l] * B[i][j][k][l];
                }
            }
        }
    }
}

int main() {
    srand(SEED);
    
    int64_t* A[I][J][K];
    int64_t* B[I][J][K];
    int64_t* C[I][J][K];
    for(size_t i = 0; i < I; i++) {
        for(size_t j = 0; j < J; j++) {
            for(size_t k = 0; k < K; k++) {
                A[i][j][k] = new int64_t[L];
                B[i][j][k] = new int64_t[L];
                C[i][j][k] = new int64_t[L];
                for(size_t l = 0; l < L; l++) {
                    A[i][j][k][l] = rand() % 100;
                    B[i][j][k][l] = rand() % 100;
                }
            }
        }
    }
    
    srand(SEED); // Seed the random number generator
    for(size_t n = 0; n < NTRIALS; n++) {
        // progress information
        std::cerr << (n + 1) << '/' << NTRIALS << '\r' << std::flush;
        // Initialize matrices A and B with random values
        for(size_t i = 0; i < I; i++) {
            for(size_t j = 0; j < J; j++) {
                for(size_t k = 0; k < K; k++) {
                    for(size_t l = 0; l < L; l++) {
                        A[i][j][k][l] = rand() % 100;
                        B[i][j][k][l] = rand() % 100;
                    }
                }
            }
        }
        
        uint64_t start_time = ns_time();
        // Compute elementwise product C = A * B
        do_vectorized_product(A, B, C);
        uint64_t end_time = ns_time();
        double ms_time = (end_time - start_time) / 1e9;
        std::cout << ms_time << '\n';
    }
    // padding flush
    std::cerr << std::endl;
    return 0;
}
