// this file is the basis for int.ll
// initial LLVM code obtained from clang -S -emit-llvm int.c -o temp.ll
// it is then copied and modified manually to int.ll
// a similar process would take place for float.c/float.ll for future work

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

struct JITensor {
    int64_t* data;
    uint64_t* dims;
    uint64_t dimcount;
    uint64_t total;
};

typedef int64_t (*Dyad)(int64_t lhs, int64_t rhs);
typedef int64_t (*Monad)(int64_t arg);
typedef int64_t (*TensorMonad)(struct JITensor* arg);

int64_t I64_add(int64_t lhs, int64_t rhs) {
    return lhs + rhs;
}

int64_t I64_sub(int64_t lhs, int64_t rhs) {
    return lhs - rhs;
}

int64_t I64_mul(int64_t lhs, int64_t rhs) {
    return lhs * rhs;
}

int64_t I64_div(int64_t lhs, int64_t rhs) {
    return lhs / rhs;
}

int64_t JITensor_fold(struct JITensor* ptr, Dyad fn, int64_t seed) {
    // TODO: perform across columns?
    if(ptr->total == 0) {
        return seed;
    }
    size_t idx = ptr->total - 1;
    int64_t basis = ptr->data[idx];
    for(--idx; idx < ptr->total; --idx) {
        basis = fn(basis, ptr->data[idx]);
    }
    return basis;
}

int64_t JITensor_sum(struct JITensor* ptr) {
    return JITensor_fold(ptr, &I64_add, 0);
}

void JITensor_inner_product(
    struct JITensor* a, struct JITensor* b,
    TensorMonad f, Dyad g,
    struct JITensor* out) {
    // assume just matrices for now
    if(a->dimcount != 2 || b->dimcount != 2) return;
    // printf("n=%d k=%d\n", a->dims[0], a->dims[1]);
    // printf("k=%d m=%d\n", b->dims[0], b->dims[1]);
    size_t n = a->dims[0];
    size_t k = a->dims[1];
    // cannot do product
    if(k != b->dims[0]) return;
    size_t m = b->dims[1];
    // initialize out
    if(!out->data) {
        out->dimcount = 2;
        out->dims = malloc(sizeof(*out->dims) * out->dimcount);
        out->dims[0] = n;
        out->dims[1] = m;
        out->total = n * m;
        out->data = malloc(sizeof(*out->data) * out->total);
    }
    struct JITensor slice;
    slice.dimcount = 1;
    slice.dims = malloc(sizeof(*slice.dims) * slice.dimcount);
    slice.total = k;
    slice.data = malloc(sizeof(*slice.data) * slice.total);
    for(size_t i = 0; i < n; i++) {
        for(size_t j = 0; j < m; j++) {
            for(size_t x = 0; x < k; x++) {
                slice.data[x] = g(a->data[i * n + x], b->data[x * m + j]);
            }
            out->data[i * n + j] = f(&slice);
        }
    }
}

void JITensor_dump(struct JITensor* ptr) {
    if(ptr->dimcount == 0) return;
    size_t total, j;
    int empty;
    for(size_t idx = 0; idx < ptr->total; idx++) {
        printf("%lld", ptr->data[idx]);
        total = 1;
        empty = 1;
        for(j = ptr->dimcount - 1; j >= 1; --j) {
            total *= ptr->dims[j];
            if(idx % total == total - 1) { empty = 0; putchar('\n'); }
        }
        if(empty) putchar(' ');
    }
}

int JITensor_same_dim(struct JITensor* lhs, struct JITensor* rhs) {
    if(lhs->dimcount != rhs->dimcount) return 0;
    for(size_t i = 0; i < lhs->dimcount; i++) {
        if(lhs->dims[i] != rhs->dims[i]) return 0;
    }
    return 1;
}

void JITensor_copy_shape(struct JITensor* basis, struct JITensor* out) {
    if(!JITensor_same_dim(basis, out)) {
        // TODO: use realloc?
        if(out->data) free(out->data);
        out->data = malloc(sizeof(*basis->data) * basis->total);
        if(out->dims) free(out->dims);
        out->dims = malloc(sizeof(*basis->dims) * basis->dimcount);
        memcpy(out->dims, basis->dims, basis->dimcount * sizeof(*out->dims));
        out->total = basis->total;
        out->dimcount = basis->dimcount;
    }
}

void JITensor_copy_value(struct JITensor* basis, struct JITensor* out) {
    JITensor_copy_shape(basis, out);
    memcpy(out->data, basis->data, basis->total * sizeof(*out->data));
}

void JITensor_add_vec_vec(struct JITensor* lhs, struct JITensor* rhs, struct JITensor* out) {
    // todo: learn how to error
    if(!JITensor_same_dim(lhs, rhs)) return;
    JITensor_copy_shape(lhs, out);
    // naive
    for(size_t idx = 0; idx < lhs->total; idx++) {
        out->data[idx] = lhs->data[idx] + rhs->data[idx];
    }
}

void JITensor_sub_vec_vec(struct JITensor* lhs, struct JITensor* rhs, struct JITensor* out) {
    // todo: learn how to error
    if(!JITensor_same_dim(lhs, rhs)) return;
    JITensor_copy_shape(lhs, out);
    // naive
    for(size_t idx = 0; idx < lhs->total; idx++) {
        out->data[idx] = lhs->data[idx] - rhs->data[idx];
    }
}

void JITensor_mul_vec_vec(struct JITensor* lhs, struct JITensor* rhs, struct JITensor* out) {
    // todo: learn how to error
    if(!JITensor_same_dim(lhs, rhs)) return;
    JITensor_copy_shape(lhs, out);
    // naive
    for(size_t idx = 0; idx < lhs->total; idx++) {
        out->data[idx] = lhs->data[idx] * rhs->data[idx];
    }
}

void JITensor_div_vec_vec(struct JITensor* lhs, struct JITensor* rhs, struct JITensor* out) {
    // todo: learn how to error
    if(!JITensor_same_dim(lhs, rhs)) return;
    JITensor_copy_shape(lhs, out);
    // naive
    for(size_t idx = 0; idx < lhs->total; idx++) {
        out->data[idx] = lhs->data[idx] / rhs->data[idx];
    }
}

#include <time.h> /* for timespec, clock_gettime, etc */
#ifndef SEED
#define SEED (0)
#endif
#ifndef NTRIALS
#define NTRIALS (3)
#endif

/*
struct JITensor {
    int64_t* data;
    uint64_t* dims;
    uint64_t dimcount;
    uint64_t total;
};*/
void task2(int64_t rows, int64_t cols, struct JITensor* out) {
    out->dimcount = 2;
    out->dims = malloc(sizeof(*out->dims) * out->dimcount);
    out->dims[0] = rows;
    out->dims[1] = cols;
    out->total = rows * cols;
    out->data = malloc(sizeof(*out->data) * out->total);
    for(size_t i = 0; i < rows; ++i) {
        for(size_t j = 0; j < cols; ++j) {
            out->data[i * cols + j] = rand() % 10;
        }
    }
}
void task3(int64_t i, int64_t j, int64_t k, int64_t l, struct JITensor* out) {
    out->dimcount = 4;
    out->dims = malloc(sizeof(*out->dims) * out->dimcount);
    out->dims[0] = i;
    out->dims[1] = j;
    out->dims[2] = k;
    out->dims[3] = l;
    out->total = i * j * k * l;
    out->data = malloc(sizeof(*out->data) * out->total);
    for(size_t i = 0; i < out->total; ++i) {
        out->data[i] = rand() % 100;
    }
}

static inline uint64_t ns_time() {
    struct timespec t;
    clock_gettime(CLOCK_REALTIME, &t);
    return (uint64_t)(t.tv_sec*1000000000ll + t.tv_nsec);
}

void idot(int64_t max, struct JITensor* out) {
    out->dimcount = 1;
    out->dims = malloc(sizeof(*out->dims) * out->dimcount);
    out->dims[0] = max;
    out->total = max;
    out->data = malloc(sizeof(*out->data) * out->total);
    for(int64_t i = 0; i < max; ++i) {
        out->data[i] = i;
    }
}
int main() {
    struct JITensor out;
    task2(1024, 512, &out);
}
