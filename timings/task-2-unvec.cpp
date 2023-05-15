#include <iostream>
#include <cstdlib>
#include <ctime>
#include "portable-attributes.hpp"
#include "timing.hpp"

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

const size_t rows = ROWS;
const size_t cols = COLS;

NOINLINE void do_matrix_product(int64_t** A, int64_t** B, int64_t** C) {
    for(size_t i = 0; i < rows; ++i) {
        for(size_t j = 0; j < rows; ++j) {
            C[i][j] = 0;
            for(size_t k = 0; k < cols; ++k) {
                C[i][j] += A[i][k] * B[k][j];
            }
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
        for(size_t i = 0; i < cols; ++i) {
            for(size_t j = 0; j < rows; ++j) {
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
