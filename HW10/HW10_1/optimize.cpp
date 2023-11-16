// optimize.cpp

/*After completing my test,
I requested suggestions from ChatGPT
for improving the code.*/

#include "optimize.h"

data_t *get_vec_start(vec *v) {
    return v->data;
}

// optimize1
void optimize1(vec *v, data_t *dest) {
    size_t len = v->len;
    data_t *data = get_vec_start(v);
    data_t result = IDENT;

    // Loop through the data array and perform the reduction operation
    for (size_t i = 0; i < len; i++) {
        result = result OP data[i];
    }
    *dest = result;
}

// optimize2
void optimize2(vec *v, data_t *dest) {
    size_t len = v->len;
    data_t *data = get_vec_start(v);
    data_t result = IDENT;

    // Loop through the data array with loop unrolling and perform the reduction operation
    size_t i;
    for (i = 0; i < len-1; i+=2) {
        result = (result OP data[i]) OP data[i+1];
    }
    for (; i < len; i++) {
        result = result OP data[i];
    }
    *dest = result;
}

// optimize3
void optimize3(vec *v, data_t *dest) {
    size_t len = v->len;
    data_t *data = get_vec_start(v);
    data_t result = IDENT;

    // Loop through the data array with loop unrolling and perform the reduction operation
    size_t i;
    for (i = 0; i < len-1; i+=2) {
        result = (result OP (data[i] OP data[i+1]));
    }
    for (; i < len; i++) {
        result = result OP data[i];
    }
    *dest = result;
}

// optimize4
void optimize4(vec *v, data_t *dest) {
    size_t len = v->len;
    data_t *data = get_vec_start(v);
    data_t result = IDENT;

    // Loop through the data array with loop unrolling and perform the reduction operation
    size_t i;
    for (i = 0; i < len-1; i+=2) {
        data_t inter_result = data[i] OP data[i+1];
        result = result OP inter_result;
    }
    for (; i < len; i++) {
        result = result OP data[i];
    }
    *dest = result;
}

// optimize5: Similar to reduce4, but with K = 3 and L = 3
void optimize5(vec *v, data_t *dest) {
    size_t len = v->len;
    data_t *data = get_vec_start(v);
    data_t result = IDENT;

    // Loop through the data array with loop unrolling and perform the reduction operation
    size_t i;
    for (i = 0; i < len-3; i+=3) {
        data_t inter_result = (data[i] OP data[i+1]) OP data[i+2];
        result = result OP inter_result;
    }
    for (; i < len; i++) {
        result = result OP data[i];
    }
    *dest = result;
}





