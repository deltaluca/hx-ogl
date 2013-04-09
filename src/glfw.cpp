#include <hx/CFFI.h>
#include "utils.h"
#define CONST(N) PCONST(glfw, GLFW, N)

value hx_glfw_init() {
    return alloc<int>(glfwInit());
}
void hx_glfw_terminate() {
    glfwTerminate();
}
DEFINE_PRIM(hx_glfw_init,      0);
DEFINE_PRIM(hx_glfw_terminate, 0);



CONST(WINDOW);
CONST(FULLSCREEN);

CONST(OPENED);
CONST(ACTIVE);
CONST(ICONIFIED);
CONST(ACCELERATED);
CONST(RED_BITS);
CONST(GREEN_BITS);
CONST(BLUE_BITS);
CONST(ALPHA_BITS);
CONST(DEPTH_BITS);
CONST(STENCIL_BITS);

CONST(REFRESH_RATE);
CONST(ACCUM_RED_BITS);
CONST(ACCUM_GREEN_BITS);
CONST(ACCUM_BLUE_BITS);
CONST(ACCUM_ALPHA_BITS);
CONST(AUX_BUFFERS);
CONST(STEREO);
CONST(WINDOW_NO_RESIZE);
CONST(FSAA_SAMPLES);
CONST(OPENGL_VERSION_MAJOR);
CONST(OPENGL_VERSION_MINOR);
CONST(OPENGL_FORWARD_COMPAT);
CONST(OPENGL_DEBUG_CONTEXT);
CONST(OPENGL_PROFILE);

value hx_glfw_openWindow(value* args, int nargs) {
    return alloc<int>(
        glfwOpenWindow(val_get<int>(args[0]),
                       val_get<int>(args[1]),
                       val_get<int>(args[2]),
                       val_get<int>(args[3]),
                       val_get<int>(args[4]),
                       val_get<int>(args[5]),
                       val_get<int>(args[6]),
                       val_get<int>(args[7]),
                       val_get<int>(args[8])
                      )
    );
}
value hx_glfw_openWindowHint(value target, value hint) {
    glfwOpenWindowHint(val_get<int>(target), val_get<int>(hint));
}
void hx_glfw_closeWindow() {
    glfwCloseWindow();
}
value hx_glfw_getWindowParam(value param) {
    return alloc<int>(glfwGetWindowParam(val_get<int>(param)));
}
void hx_glfw_setWindowTitle(value title) {
    glfwSetWindowTitle(val_get<string>(title));
}
void hx_glfw_setWindowSize(value width, value height) {
    glfwSetWindowSize(val_get<int>(width), val_get<int>(height));
}
void hx_glfw_setWindowPos(value x, value y) {
    glfwSetWindowPos(val_get<int>(x), val_get<int>(y));
}
void hx_glfw_getWindowSize(value size) {
    int* vals = val_array_int(size);
    glfwGetWindowSize(vals, vals+1);
}
void hx_glfw_iconifyWindow() {
    glfwIconifyWindow();
}
void hx_glfw_restoreWindow() {
    glfwRestoreWindow();
}
void hx_glfw_swapInterval(value interval) {
    glfwSwapInterval(val_get<int>(interval));
}
DEFINE_PRIM_MULT(hx_glfw_openWindow);
DEFINE_PRIM(hx_glfw_openWindowHint, 2);
DEFINE_PRIM(hx_glfw_closeWindow,    0);
DEFINE_PRIM(hx_glfw_getWindowParam, 1);
DEFINE_PRIM(hx_glfw_setWindowTitle, 1);
DEFINE_PRIM(hx_glfw_setWindowSize,  2);
DEFINE_PRIM(hx_glfw_setWindowPos,   2);
DEFINE_PRIM(hx_glfw_getWindowSize,  1);
DEFINE_PRIM(hx_glfw_iconifyWindow,  0);
DEFINE_PRIM(hx_glfw_restoreWindow,  0);
DEFINE_PRIM(hx_glfw_swapInterval,   1);

AutoGCRoot* hx_setWindowCloseCallback = NULL;
int GLFWCALL bound_setWindowCloseCallback() {
    return val_get<bool>(val_call0(hx_setWindowCloseCallback->get()));
}
GLFWCALLBACK(setWindowCloseCallback, SetWindowCloseCallback, 0);

AutoGCRoot* hx_setWindowSizeCallback = NULL;
void GLFWCALL bound_setWindowSizeCallback(int width, int height) {
    val_call2(hx_setWindowSizeCallback->get(), alloc<int>(width), alloc<int>(height));
}
GLFWCALLBACK(setWindowSizeCallback, SetWindowSizeCallback, 2);

AutoGCRoot* hx_setWindowRefreshCallback = NULL;
void GLFWCALL bound_setWindowRefreshCallback() {
    val_call0(hx_setWindowRefreshCallback->get());
}
GLFWCALLBACK(setWindowRefreshCallback, SetWindowRefreshCallback, 0);


void hx_glfw_swapBuffers() {
    glfwSwapBuffers();
}
void hx_glfw_pollEvents() {
    glfwPollEvents();
}
DEFINE_PRIM(hx_glfw_swapBuffers, 0);
DEFINE_PRIM(hx_glfw_pollEvents,  0);



CONST(KEY_UNKNOWN);
CONST(KEY_SPACE);
CONST(KEY_SPECIAL);
CONST(KEY_ESC);
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
CONST(KEY_UP);
CONST(KEY_DOWN);
CONST(KEY_LEFT);
CONST(KEY_RIGHT);
CONST(KEY_LSHIFT);
CONST(KEY_RSHIFT);
CONST(KEY_LCTRL);
CONST(KEY_RCTRL);
CONST(KEY_LALT);
CONST(KEY_RALT);
CONST(KEY_TAB);
CONST(KEY_ENTER);
CONST(KEY_BACKSPACE);
CONST(KEY_INSERT);
CONST(KEY_DEL);
CONST(KEY_PAGEUP);
CONST(KEY_PAGEDOWN);
CONST(KEY_HOME);
CONST(KEY_END);
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
CONST(KEY_KP_DIVIDE);
CONST(KEY_KP_MULTIPLY);
CONST(KEY_KP_SUBTRACT);
CONST(KEY_KP_ADD);
CONST(KEY_KP_DECIMAL);
CONST(KEY_KP_EQUAL);
CONST(KEY_KP_ENTER);
CONST(KEY_KP_NUM_LOCK);
CONST(KEY_CAPS_LOCK);
CONST(KEY_SCROLL_LOCK);
CONST(KEY_PAUSE);
CONST(KEY_LSUPER);
CONST(KEY_RSUPER);
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

value hx_glfw_getKey(value key) {
    return alloc<int>(glfwGetKey(val_get<int>(key)));
}
value hx_glfw_getMouseButton(value button) {
    return alloc<int>(glfwGetMouseButton(val_get<int>(button)));
}
void hx_glfw_getMousePos(value size) {
    int* vals = val_array_int(size);
    glfwGetMousePos(vals, vals+1);
}
void hx_glfw_setMousePos(value x, value y) {
    glfwSetMousePos(val_get<int>(x), val_get<int>(y));
}
value hx_glfw_getMouseWheel() {
    return alloc<int>(glfwGetMouseWheel());
}
void hx_glfw_setMouseWheel(value pos) {
    glfwSetMouseWheel(val_get<int>(pos));
}
DEFINE_PRIM(hx_glfw_getKey,         1);
DEFINE_PRIM(hx_glfw_getMouseButton, 1);
DEFINE_PRIM(hx_glfw_getMousePos,    1);
DEFINE_PRIM(hx_glfw_setMousePos,    2);
DEFINE_PRIM(hx_glfw_getMouseWheel,  0);
DEFINE_PRIM(hx_glfw_setMouseWheel,  1);

AutoGCRoot* hx_setKeyCallback = NULL;
void GLFWCALL bound_setKeyCallback(int key, int action) {
    val_call2(hx_setKeyCallback->get(), alloc<int>(key), alloc<bool>(action));
}
GLFWCALLBACK(setKeyCallback, SetKeyCallback, 2);

AutoGCRoot* hx_setCharCallback = NULL;
void GLFWCALL bound_setCharCallback(int key, int action) {
    val_call2(hx_setCharCallback->get(), alloc<int>(key), alloc<bool>(action));
}
GLFWCALLBACK(setCharCallback, SetCharCallback, 2);

AutoGCRoot* hx_setMouseButtonCallback = NULL;
void GLFWCALL bound_setMouseButtonCallback(int key, int action) {
    val_call2(hx_setMouseButtonCallback->get(), alloc<int>(key), alloc<bool>(action));
}
GLFWCALLBACK(setMouseButtonCallback, SetMouseButtonCallback, 2);

AutoGCRoot* hx_setMousePosCallback = NULL;
void GLFWCALL bound_setMousePosCallback(int x, int y) {
    val_call2(hx_setMousePosCallback->get(), alloc<int>(x), alloc<int>(y));
}
GLFWCALLBACK(setMousePosCallback, SetMousePosCallback, 2);

AutoGCRoot* hx_setMouseWheelCallback = NULL;
void GLFWCALL bound_setMouseWheelCallback(int pos) {
    val_call1(hx_setMouseWheelCallback->get(), alloc<int>(pos));
}
GLFWCALLBACK(setMouseWheelCallback, SetMouseWheelCallback, 1);


value hx_glfw_getTime() {
    return alloc<double>(glfwGetTime());
}
void hx_glfw_setTime(value time) {
    glfwSetTime(val_get<double>(time));
}
void hx_glfw_sleep(value time) {
    glfwSleep(val_get<double>(time));
}
DEFINE_PRIM(hx_glfw_getTime, 0);
DEFINE_PRIM(hx_glfw_setTime, 1);
DEFINE_PRIM(hx_glfw_sleep,   1);


extern "C" void glfw_allocateKinds() {
}
