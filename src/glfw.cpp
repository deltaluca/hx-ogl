#include <hx/CFFI.h>
#include "utils.h"
#define CONST(N) PCONST(glfw, GLFW, N)

DECLARE_KIND(k_Monitor);
DECLARE_KIND(k_Window);
DEFINE_KIND(k_Monitor);
DEFINE_KIND(k_Window);

//
// glfwSetErrorCallback
//
AutoGCRoot* hx_setErrorCallback = NULL;
void bound_setErrorCallback(int error, const char* description) {
    val_call2(hx_setErrorCallback->get(), alloc<int>(error), alloc<string>(description));
}
GLFWCALLBACK(setErrorCallback, SetErrorCallback, 2);

//
// glfwInit
// glfwTerminate
//
value hx_glfw_init() {
    return alloc<int>(glfwInit());
}
void hx_glfw_terminate() {
    glfwTerminate();
}
DEFINE_PRIM(hx_glfw_init,      0);
DEFINE_PRIM(hx_glfw_terminate, 0);


//
// glfwGetMonitors
// glfwGetPrimaryMonitor
//
void hx_glfw_getMonitors(value out) {
    int count;
    GLFWmonitor** monitors = glfwGetMonitors(&count);
    val_array_set_size(out, count);
    for (int i = 0; i < count; i++) {
        value v = alloc_abstract(k_Monitor, monitors[i]);
        val_array_set_i(out, i, v);
    }
}
value hx_glfw_getPrimaryMonitor() {
    GLFWmonitor* ptr = glfwGetPrimaryMonitor();
    value v = alloc_abstract(k_Monitor, ptr);
    return v;
}
DEFINE_PRIM(hx_glfw_getMonitors,       1);
DEFINE_PRIM(hx_glfw_getPrimaryMonitor, 0);


//
// glfwMakeContextCurrent
// glfwGetCurrentContext
// glfwSwapBuffers
// glfwSwapInterval
//
void hx_glfw_makeContextCurrent(value v) {
    glfwMakeContextCurrent((GLFWwindow*)val_data(v));
}
value hx_glfw_getCurrentContext() {
    GLFWwindow* ptr = glfwGetCurrentContext();
    return ptr == NULL ? val_null : alloc_abstract(k_Window, ptr);
}
void hx_glfw_swapBuffers(value v) {
    glfwSwapBuffers((GLFWwindow*)val_data(v));
}
void hx_glfw_swapInterval(value interval) {
    glfwSwapInterval(val_get<int>(interval));
}
DEFINE_PRIM(hx_glfw_makeContextCurrent, 1);
DEFINE_PRIM(hx_glfw_getCurrentContext,  0);
DEFINE_PRIM(hx_glfw_swapBuffers,        1);
DEFINE_PRIM(hx_glfw_swapInterval,       1);


//
// glfwCreateWindow
// glfwDestroyWindow
//
value hx_glfw_createWindow(value width, value height, value title, value monitor, value share) {
    GLFWwindow* ptr = glfwCreateWindow(val_get<int>(width), val_get<int>(height), val_get<string>(title), (GLFWmonitor*)val_data(monitor), (GLFWwindow*)val_data(share));
    value v = alloc_abstract(k_Window, ptr);
    return v;
}
void hx_glfw_destroyWindow(value v) {
    GLFWwindow* ptr = (GLFWwindow*)val_data(v);
    glfwDestroyWindow(ptr);
}
DEFINE_PRIM(hx_glfw_createWindow,  5);
DEFINE_PRIM(hx_glfw_destroyWindow, 1);


//
// glfwDefaultWindowHints
// glfwWindowHint
//
CONST(STEREO);
CONST(RED_BITS);
CONST(GREEN_BITS);
CONST(BLUE_BITS);
CONST(ALPHA_BITS);
CONST(DEPTH_BITS);
CONST(STENCIL_BITS);
CONST(ACCUM_RED_BITS);
CONST(ACCUM_GREEN_BITS);
CONST(ACCUM_BLUE_BITS);
CONST(ACCUM_ALPHA_BITS);
CONST(AUX_BUFFERS);
CONST(SAMPLES);
CONST(SRGB_CAPABLE);
CONST(OPENGL_API);
CONST(OPENGL_ES_API);

void hx_glfw_defaultWindowHints() {
    glfwDefaultWindowHints();
}
void hx_glfw_windowHint(value target, value hint) {
    glfwWindowHint(val_get<int>(target), val_get<int>(hint));
}
DEFINE_PRIM(hx_glfw_defaultWindowHints, 0);
DEFINE_PRIM(hx_glfw_windowHint,         2);


//
// glfwGetWindowParam
//
CONST(FOCUSED);
CONST(ICONIFIED);
CONST(VISIBLE);
CONST(RESIZABLE);
CONST(DECORATED);
CONST(CLIENT_API);
CONST(CONTEXT_VERSION_MAJOR);
CONST(CONTEXT_VERSION_MINOR);
CONST(CONTEXT_REVISION);
CONST(OPENGL_FORWARD_COMPAT);
CONST(OPENGL_DEBUG_CONTEXT);
CONST(OPENGL_PROFILE);
CONST(CONTEXT_ROBUSTNESS);

CONST(OPENGL_CORE_PROFILE);
CONST(OPENGL_COMPAT_PROFILE);
CONST(OPENGL_NO_PROFILE);

CONST(LOSE_CONTEXT_ON_RESET);
CONST(NO_RESET_NOTIFICATION);
CONST(NO_ROBUSTNESS);

value hx_glfw_getWindowParam(value v, value param) {
    return alloc<int>(glfwGetWindowParam((GLFWwindow*)val_data(v), val_get<int>(param)));
}
DEFINE_PRIM(hx_glfw_getWindowParam, 2);

//
//glfwGetWindowPos
//glfwGetWindowSize
//glfwSetWindowPos
//glfwSetWindowSize
//glfwSetWindowTitle
//
void hx_glfw_getWindowPos(value v, value size) {
    int* vals = val_array_int(size);
    glfwGetWindowPos((GLFWwindow*)val_data(v), vals, vals+1);
}
void hx_glfw_getWindowSize(value v, value size) {
    int* vals = val_array_int(size);
    glfwGetWindowSize((GLFWwindow*)val_data(v), vals, vals+1);
}
void hx_glfw_setWindowPos(value v, value x, value y) {
    glfwSetWindowPos((GLFWwindow*)val_data(v), val_get<int>(x), val_get<int>(y));
}
void hx_glfw_setWindowSize(value v, value width, value height) {
    glfwSetWindowSize((GLFWwindow*)val_data(v), val_get<int>(width), val_get<int>(height));
}
void hx_glfw_setWindowTitle(value v, value title) {
    glfwSetWindowTitle((GLFWwindow*)val_data(v), val_get<string>(title));
}
DEFINE_PRIM(hx_glfw_getWindowPos,   2);
DEFINE_PRIM(hx_glfw_getWindowSize,  2);
DEFINE_PRIM(hx_glfw_setWindowPos,   3);
DEFINE_PRIM(hx_glfw_setWindowSize,  3);
DEFINE_PRIM(hx_glfw_setWindowTitle, 2);

//
// glfwHideWindow
// glfwShowWindow
// glfwIconifyWindow
// glfwRestoreWindow
//
void hx_glfw_hideWindow(value v) {
    glfwHideWindow((GLFWwindow*)val_data(v));
}
void hx_glfw_showWindow(value v) {
    glfwShowWindow((GLFWwindow*)val_data(v));
}
void hx_glfw_iconifyWindow(value v) {
    glfwIconifyWindow((GLFWwindow*)val_data(v));
}
void hx_glfw_restoreWindow(value v) {
    glfwRestoreWindow((GLFWwindow*)val_data(v));
}
DEFINE_PRIM(hx_glfw_hideWindow,    1);
DEFINE_PRIM(hx_glfw_showWindow,    1);
DEFINE_PRIM(hx_glfw_iconifyWindow, 1);
DEFINE_PRIM(hx_glfw_restoreWindow, 1);

//
// glfwWindowShouldClose
// glfwSetWindowShouldClose
//
value hx_glfw_windowShouldClose(value v) {
    return alloc<bool>(glfwWindowShouldClose((GLFWwindow*)val_data(v)));
}
void hx_glfw_setWindowShouldClose(value v, value val) {
    glfwSetWindowShouldClose((GLFWwindow*)val_data(v), val_get<bool>(val));
}
DEFINE_PRIM(hx_glfw_windowShouldClose,    1);
DEFINE_PRIM(hx_glfw_setWindowShouldClose, 2);

//
// glfwPollEvents
// glfwWaitEvents
//
void hx_glfw_pollEvents() {
    glfwPollEvents();
}
void hx_glfw_waitEvents() {
    glfwWaitEvents();
}
DEFINE_PRIM(hx_glfw_pollEvents, 0);
DEFINE_PRIM(hx_glfw_waitEvents, 0);


//
// glfwSetWindowPosCallback
// glfwSetWindowSizeCallback
// glfwSetWindowRefreshCallback
// glfwSetWindowCloseCallback
// glfwSetWindowFocusCallback
// glfwSetWindowIconifyCallback
//
GLFWMULTIDECLARE(setWindowPosCallback);
GLFWMULTIDECLARE(setWindowSizeCallback);
GLFWMULTIDECLARE(setWindowRefreshCallback);
GLFWMULTIDECLARE(setWindowCloseCallback);
GLFWMULTIDECLARE(setWindowFocusCallback);
GLFWMULTIDECLARE(setWindowIconifyCallback);
void bound_setWindowPosCallback(GLFWwindow* v, int x, int y) {
    value cb = GLFWMULTIFUNC(setWindowPosCallback, v);
    val_call2(cb, alloc<int>(x), alloc<int>(y));
}
void bound_setWindowSizeCallback(GLFWwindow* v, int width, int height) {
    value cb = GLFWMULTIFUNC(setWindowSizeCallback, v);
    val_call2(cb, alloc<int>(width), alloc<int>(height));
}
void bound_setWindowRefreshCallback(GLFWwindow* v) {
    value cb = GLFWMULTIFUNC(setWindowRefreshCallback, v);
    val_call0(cb);
}
void bound_setWindowCloseCallback(GLFWwindow* v) {
    value cb = GLFWMULTIFUNC(setWindowCloseCallback, v);
    val_call0(cb);
}
void bound_setWindowFocusCallback(GLFWwindow* v, int focused) {
    value cb = GLFWMULTIFUNC(setWindowFocusCallback, v);
    val_call1(cb, alloc<bool>(focused));
}
void bound_setWindowIconifyCallback(GLFWwindow* v, int iconified) {
    value cb = GLFWMULTIFUNC(setWindowIconifyCallback, v);
    val_call1(cb, alloc<bool>(iconified));
}
GLFWMULTIDEFINE(setWindowPosCallback,     SetWindowPosCallback);
GLFWMULTIDEFINE(setWindowSizeCallback,    SetWindowSizeCallback);
GLFWMULTIDEFINE(setWindowRefreshCallback, SetWindowRefreshCallback);
GLFWMULTIDEFINE(setWindowCloseCallback,   SetWindowCloseCallback);
GLFWMULTIDEFINE(setWindowFocusCallback,   SetWindowFocusCallback);
GLFWMULTIDEFINE(setWindowIconifyCallback, SetWindowIconifyCallback);


//
// glfwGetKey
// glfwGetMouseButton
// glfwGetCursorPos
// glfwSetCursorPos
//
value hx_glfw_getKey(value v, value key) {
    return alloc<bool>(GLFW_PRESS == glfwGetKey((GLFWwindow*)val_data(v), val_get<int>(key)));
}
value hx_glfw_getMouseButton(value v, value button) {
    return alloc<bool>(GLFW_PRESS == glfwGetMouseButton((GLFWwindow*)val_data(v), val_get<int>(button)));
}
void hx_glfw_getCursorPos(value v, value pos) {
    double* vals = val_array_double(pos);
    glfwGetCursorPos((GLFWwindow*)val_data(v), vals, vals+1);
}
void hx_glfw_setCursorPos(value v, value x, value y) {
    glfwSetCursorPos((GLFWwindow*)val_data(v), val_get<double>(x), val_get<double>(y));
}
DEFINE_PRIM(hx_glfw_getKey,         2);
DEFINE_PRIM(hx_glfw_getMouseButton, 2);
DEFINE_PRIM(hx_glfw_getCursorPos,   2);
DEFINE_PRIM(hx_glfw_setCursorPos,   3);

//
// glfwSetKeyCallback
// glfwSetCharCallback
// glfwSetMouseButtonCallback
// glfwSetScrollCallback
// glfwSetCursorPosCallback
// glfwSetCursorEnterCallback
//
GLFWMULTIDECLARE(setKeyCallback);
GLFWMULTIDECLARE(setCharCallback);
GLFWMULTIDECLARE(setMouseButtonCallback);
GLFWMULTIDECLARE(setScrollCallback);
GLFWMULTIDECLARE(setCursorPosCallback);
GLFWMULTIDECLARE(setCursorEnterCallback);
void bound_setKeyCallback(GLFWwindow* v, int key, int action) {
    value cb = GLFWMULTIFUNC(setKeyCallback, v);
    val_call2(cb, alloc<int>(key), alloc<int>(action));
}
void bound_setCharCallback(GLFWwindow* v, unsigned int character) {
    value cb = GLFWMULTIFUNC(setCharCallback, v);
    val_call1(cb, alloc<int>(character));
}
void bound_setMouseButtonCallback(GLFWwindow* v, int button, int pressed) {
    value cb = GLFWMULTIFUNC(setMouseButtonCallback, v);
    val_call2(cb, alloc<int>(button), alloc<bool>(pressed == GLFW_PRESS));
}
void bound_setScrollCallback(GLFWwindow* v, double x, double y) {
    value cb = GLFWMULTIFUNC(setScrollCallback, v);
    val_call2(cb, alloc<double>(x), alloc<double>(y));
}
void bound_setCursorPosCallback(GLFWwindow* v, double x, double y) {
    value cb = GLFWMULTIFUNC(setCursorPosCallback, v);
    val_call2(cb, alloc<double>(x), alloc<double>(y));
}
void bound_setCursorEnterCallback(GLFWwindow* v, int enter) {
    value cb = GLFWMULTIFUNC(setCursorEnterCallback, v);
    val_call1(cb, alloc<bool>(enter));
}
GLFWMULTIDEFINE(setKeyCallback, SetKeyCallback);
GLFWMULTIDEFINE(setCharCallback, SetCharCallback);
GLFWMULTIDEFINE(setMouseButtonCallback, SetMouseButtonCallback);
GLFWMULTIDEFINE(setScrollCallback, SetScrollCallback);
GLFWMULTIDEFINE(setCursorPosCallback, SetCursorPosCallback);
GLFWMULTIDEFINE(setCursorEnterCallback, SetCursorEnterCallback);


//
// glfwGetTime
// glfwSetTime
//
value hx_glfw_getTime() {
    return alloc<double>(glfwGetTime());
}
void hx_glfw_setTime(value time) {
    glfwSetTime(val_get<double>(time));
}
DEFINE_PRIM(hx_glfw_getTime, 0);
DEFINE_PRIM(hx_glfw_setTime, 1);


CONST(RELEASE);
CONST(PRESS);
CONST(REPEAT);

CONST(KEY_SPACE);
CONST(KEY_APOSTROPHE);
CONST(KEY_COMMA);
CONST(KEY_MINUS);
CONST(KEY_PERIOD);
CONST(KEY_SLASH);
CONST(KEY_0);
CONST(KEY_1);
CONST(KEY_2);
CONST(KEY_3);
CONST(KEY_4);
CONST(KEY_5);
CONST(KEY_6);
CONST(KEY_7);
CONST(KEY_8);
CONST(KEY_9);
CONST(KEY_SEMICOLON);
CONST(KEY_EQUAL);
CONST(KEY_A);
CONST(KEY_B);
CONST(KEY_C);
CONST(KEY_D);
CONST(KEY_E);
CONST(KEY_F);
CONST(KEY_G);
CONST(KEY_H);
CONST(KEY_I);
CONST(KEY_J);
CONST(KEY_K);
CONST(KEY_L);
CONST(KEY_M);
CONST(KEY_N);
CONST(KEY_O);
CONST(KEY_P);
CONST(KEY_Q);
CONST(KEY_R);
CONST(KEY_S);
CONST(KEY_T);
CONST(KEY_U);
CONST(KEY_V);
CONST(KEY_W);
CONST(KEY_X);
CONST(KEY_Y);
CONST(KEY_Z);
CONST(KEY_LEFT_BRACKET);
CONST(KEY_BACKSLASH);
CONST(KEY_RIGHT_BRACKET);
CONST(KEY_GRAVE_ACCENT);
CONST(KEY_WORLD_1);
CONST(KEY_WORLD_2);
CONST(KEY_ESCAPE);
CONST(KEY_ENTER);
CONST(KEY_TAB);
CONST(KEY_BACKSPACE);
CONST(KEY_INSERT);
CONST(KEY_DELETE);
CONST(KEY_RIGHT);
CONST(KEY_LEFT);
CONST(KEY_DOWN);
CONST(KEY_UP);
CONST(KEY_PAGE_UP);
CONST(KEY_PAGE_DOWN);
CONST(KEY_HOME);
CONST(KEY_END);
CONST(KEY_CAPS_LOCK);
CONST(KEY_SCROLL_LOCK);
CONST(KEY_NUM_LOCK);
CONST(KEY_PRINT_SCREEN);
CONST(KEY_PAUSE);
CONST(KEY_F1);
CONST(KEY_F2);
CONST(KEY_F3);
CONST(KEY_F4);
CONST(KEY_F5);
CONST(KEY_F6);
CONST(KEY_F7);
CONST(KEY_F8);
CONST(KEY_F9);
CONST(KEY_F10);
CONST(KEY_F11);
CONST(KEY_F12);
CONST(KEY_F13);
CONST(KEY_F14);
CONST(KEY_F15);
CONST(KEY_F16);
CONST(KEY_F17);
CONST(KEY_F18);
CONST(KEY_F19);
CONST(KEY_F20);
CONST(KEY_F21);
CONST(KEY_F22);
CONST(KEY_F23);
CONST(KEY_F24);
CONST(KEY_F25);
CONST(KEY_KP_0);
CONST(KEY_KP_1);
CONST(KEY_KP_2);
CONST(KEY_KP_3);
CONST(KEY_KP_4);
CONST(KEY_KP_5);
CONST(KEY_KP_6);
CONST(KEY_KP_7);
CONST(KEY_KP_8);
CONST(KEY_KP_9);
CONST(KEY_KP_DECIMAL);
CONST(KEY_KP_DIVIDE);
CONST(KEY_KP_MULTIPLY);
CONST(KEY_KP_SUBTRACT);
CONST(KEY_KP_ADD);
CONST(KEY_KP_ENTER);
CONST(KEY_KP_EQUAL);
CONST(KEY_LEFT_SHIFT);
CONST(KEY_LEFT_CONTROL);
CONST(KEY_LEFT_ALT);
CONST(KEY_LEFT_SUPER);
CONST(KEY_RIGHT_SHIFT);
CONST(KEY_RIGHT_CONTROL);
CONST(KEY_RIGHT_ALT);
CONST(KEY_RIGHT_SUPER);
CONST(KEY_MENU);
CONST(KEY_LAST);

CONST(MOUSE_BUTTON_1);
CONST(MOUSE_BUTTON_2);
CONST(MOUSE_BUTTON_3);
CONST(MOUSE_BUTTON_4);
CONST(MOUSE_BUTTON_5);
CONST(MOUSE_BUTTON_6);
CONST(MOUSE_BUTTON_7);
CONST(MOUSE_BUTTON_8);
CONST(MOUSE_BUTTON_LAST);
CONST(MOUSE_BUTTON_LEFT);
CONST(MOUSE_BUTTON_RIGHT);
CONST(MOUSE_BUTTON_MIDDLE);

extern "C" void glfw_allocateKinds() {
    k_Window = alloc_kind();
    k_Monitor = alloc_kind();
}
