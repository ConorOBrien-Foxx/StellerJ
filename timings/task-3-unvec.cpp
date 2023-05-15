#include <iostream>
#include <cstdlib>
#include <ctime>
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

const int I = DIM_I, J = DIM_J, K = DIM_K, L = DIM_L;

template <typename T>
NOINLINE void do_vectorized_product(T A, T B, T C) {
    for(int i = 0; i < I; i++) {
        for(int j = 0; j < J; j++) {
            for(int k = 0; k < K; k++) {
                for(int l = 0; l < L; l++) {
                    C[i][j][k][l] = A[i][j][k][l] * B[i][j][k][l];
                }
            }
        }
    }
}

int main() {
    srand(SEED);
    
    int* A[I][J][K];
    int* B[I][J][K];
    int* C[I][J][K];
    for(int i = 0; i < I; i++) {
        for(int j = 0; j < J; j++) {
            for(int k = 0; k < K; k++) {
                A[i][j][k] = new int[L];
                B[i][j][k] = new int[L];
                C[i][j][k] = new int[L];
            }
        }
    }
    
    srand(SEED); // Seed the random number generator
    for(size_t n = 0; n < NTRIALS; n++) {
        // progress information
        std::cerr << (n + 1) << '/' << NTRIALS << '\r' << std::flush;
        // Initialize matrices A and B with random values
        for(int i = 0; i < I; i++) {
            for(int j = 0; j < J; j++) {
                for(int k = 0; k < K; k++) {
                    for(int l = 0; l < L; l++) {
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
