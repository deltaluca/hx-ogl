#define IMPLEMENT_API
#include <hx/CFFI.h>

#include "gl.h"

extern "C" void hx_ogl_entry() {
    gl_allocateKinds();
}
DEFINE_ENTRY_POINT(hx_ogl_entry);

