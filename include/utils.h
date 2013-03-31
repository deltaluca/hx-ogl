#pragma once
#ifndef UTILS_H
#define UTILS_H
#include <hx/CFFI.h>
#include <GL/glew.h>
#include <GL/gl.h>



typedef const char* string;



// Parameterised allocs
template <typename T>
static value alloc(T x) { neko_error(); }
template <>
inline value alloc(int x) { return alloc_int(x); }
template <>
inline value alloc(float x) { return alloc_float(x); }
template <>
inline value alloc(double x) { return alloc_float(x); }
template <>
inline value alloc(bool x) { return alloc_bool(x); }
template <>
inline value alloc(string x) { return alloc_string(x); }

inline value alloc_double(float  x) { return alloc(x); }
inline value alloc_double(double x) { return alloc(x); }



// Parameterised val_gets
template <typename T>
T val_get(value x) { neko_error(); }
template <>
inline int val_get(value x) {
    if (val_is_int  (x)) return val_int(x);
    if (val_is_float(x)) return (int)val_float(x);
    if (val_is_bool (x)) return (int)val_bool(x);
    neko_error();
    return -1;
}
template <>
inline double val_get(value x) {
    if (val_is_int  (x)) return (double)val_int(x);
    if (val_is_float(x)) return val_float(x);
    if (val_is_bool (x)) return (double)val_bool(x);
    neko_error();
    return -1;
}
template <>
inline float val_get(value x) {
    double r = val_get<double>(x);
    return r;
}
template <>
inline string val_get(value x) { return val_get_string(x); }
template <>
inline bool val_get(value x) { return val_get_bool(x); }

inline string safe_val_string(value x) {
    return val_is_null(x) ? NULL : val_get<string>(x);
}

// Typical finalisation
template <typename T>
void finaliser(value v) {
    T* ptr = (T*)val_data(v);
    delete ptr;
}


// Defining GL_# integer consts.
#define CONST(N) \
    value hx_gl_##N() { return alloc_int(GL_##N); } \
    DEFINE_PRIM(hx_gl_##N, 0)


#define PGETPROP(P, N, M, I) \
    value hx_##P##_##N##_get_##M(value v) { \
        val_check_kind(v, k_##N); \
        P::N* ptr = (P::N*)val_data(v); \
        return alloc<I>(ptr->M); \
    } \
    DEFINE_PRIM(hx_##P##_##N##_get_##M, 1)
#define PSETPROP(P, N, M, I) \
    value hx_##P##_##N##_set_##M(value v, value M) { \
        val_check_kind(v, k_##N); \
        P::N* ptr = (P::N*)val_data(v); \
        return alloc<I>(ptr->M = val_get<I>(M)); \
    } \
    DEFINE_PRIM(hx_##P##_##N##_set_##M, 2)
#define PPROP(P, N, M, I) \
    PGETPROP(P, N, M, I); \
    PSETPROP(P, N, M, I)

#endif
