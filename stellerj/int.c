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

int main() {
    struct JITensor numbers;
    numbers.total = 12;
    numbers.dimcount = 1;
    numbers.dims = malloc(sizeof(*numbers.dims) * numbers.dimcount);
    numbers.data = malloc(sizeof(*numbers.data) * numbers.total);
    for(size_t i = 0; i < numbers.total; i++) {
        numbers.data[i] = 30 ^ i;
    }
    JITensor_dump(&numbers);
    int64_t sum = JITensor_fold(&numbers, &I64_add, 0);
    printf("\nsum = %lld\n", sum);
    /*
    struct JITensor a = { malloc(sizeof(uint64_t)*9), malloc(sizeof(uint64_t) * 2), 2 };
    for(int i = 0; i < 9; i++) a.data[i] = i + 1;
    a.dims[0] = 3; a.dims[1] = 3; a.dimcount = 2;
    a.total = a.dims[0] * a.dims[1];
    JITensor_dump(&a);
    puts("- plus -");
    
    struct JITensor b = { malloc(sizeof(uint64_t)*9), malloc(sizeof(uint64_t) * 2), 2 };
    for(int i = 0; i < 9; i++) b.data[i] = i ^ 43 + 3;
    b.dims[0] = 3; b.dims[1] = 3; b.dimcount = 2;
    b.total = b.dims[0] * b.dims[1];
    JITensor_dump(&b);
    puts("- is -");
    
    struct JITensor out = { 0, 0, 0, 0 };
    struct JITensor tmp = { 0, 0, 0, 0 };

    JITensor_add_vec_vec(&a, &b, &out);
    JITensor_copy_value(&out, &tmp);
    
    JITensor_dump(&tmp);
    */
}
