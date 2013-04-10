#pragma once
#ifndef UTILS_H
#define UTILS_H
#include <hx/CFFI.h>
#include <GL/glew.h>
#include <GL/glfw3.h>



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
#define PCONST(P, R, N) \
    value hx_##P##_##N() { return alloc_int(R##_##N); } \
    DEFINE_PRIM(hx_##P##_##N, 0)


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


// GLFW single version callbacks
#define GLFWCALLBACK(N, G, P) \
    void hx_glfw_##N(value cbfun) { \
        if (hx_##N != NULL) { \
            delete hx_##N; \
            hx_##N = NULL; \
        } \
        if (val_is_null(cbfun)) \
            glfw##G(NULL); \
        else { \
            val_check_function(cbfun, P); \
            hx_##N = new AutoGCRoot(cbfun); \
            glfw##G(bound_##N); \
        } \
    } \
    DEFINE_PRIM(hx_glfw_##N, 1)

#include <map>

// GLFW multiple version callbacks
#define GLFWMULTIDECLARE(N) \
    std::map<GLFWwindow*, AutoGCRoot*> hx_##N##_cbs
#define GLFWMULTIFUNC(N, w) \
    hx_##N##_cbs[w]->get()
#define GLFWMULTIDEFINE(N, G) \
    void hx_glfw_##N(value v, value cbfun) { \
        GLFWwindow* w = (GLFWwindow*)val_data(v); \
        if (hx_##N##_cbs.find(w) != hx_##N##_cbs.end()) { \
            delete hx_##N##_cbs[w]; \
            hx_##N##_cbs[w] = NULL; \
        } \
        if (val_is_null(cbfun)) { \
            glfw##G(w, NULL); \
        } \
        else { \
            hx_##N##_cbs[w] = new AutoGCRoot(cbfun); \
            glfw##G(w, bound_##N); \
        } \
    } \
    DEFINE_PRIM(hx_glfw_##N, 2)

#endif
