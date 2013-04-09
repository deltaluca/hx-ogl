#define IMPLEMENT_API
#include <hx/CFFI.h>

#include "gl.h"
#include "glfw.h"

extern "C" void hx_ogl_entry() {
    gl_allocateKinds();
    glfw_allocateKinds();
}
DEFINE_ENTRY_POINT(hx_ogl_entry);

