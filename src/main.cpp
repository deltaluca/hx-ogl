#define IMPLEMENT_API
#include <hx/CFFI.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include "utils.h"

// A
void hx_gl_attachShader(value program, value shader) {
    glAttachShader(val_get<int>(program), val_get<int>(shader));
}
DEFINE_PRIM(hx_gl_attachShader, 2);
// B
CONST(ARRAY_BUFFER);
CONST(COPY_READ_BUFFER);
CONST(COPY_WRITE_BUFFER);
CONST(ELEMENT_ARRAY_BUFFER);
CONST(PIXEL_PACK_BUFFER);
CONST(PIXEL_UNPACK_BUFFER);
CONST(TEXTURE_BUFFER);
CONST(TRANSFORM_FEEDBACK_BUFFER);
CONST(UNIFORM_BUFFER);
void hx_gl_bindBuffer(value target, value buffer) {
    glBindBuffer(val_get<int>(target), val_get<int>(buffer));
}
void hx_gl_bindVertexArray(value arr) {
    glBindVertexArray(val_get<int>(arr));
}
CONST(STREAM_DRAW);
CONST(STREAM_READ);
CONST(STREAM_COPY);
CONST(STATIC_DRAW);
CONST(STATIC_READ);
CONST(STATIC_COPY);
CONST(DYNAMIC_DRAW);
CONST(DYNAMIC_READ);
CONST(DYNAMIC_COPY);
void hx_gl_bufferData_float(value target, value data, value usage) {
    double* dat = val_array_double(data);
    float* dat2 = new float[val_array_size(data)];
    for (int i =0 ; i < val_array_size(data); i++)
        dat2[i] = dat[i];
    glBufferData(val_get<int>(target), val_array_size(data)*sizeof(float), (GLvoid*)dat2, val_get<int>(usage));
    delete[] dat2;
}
DEFINE_PRIM(hx_gl_bindBuffer,       2);
DEFINE_PRIM(hx_gl_bindVertexArray,  1);
DEFINE_PRIM(hx_gl_bufferData_float, 3);
// C
CONST(COLOR_BUFFER_BIT);
CONST(DEPTH_BUFFER_BIT);
CONST(STENCIL_BUFFER_BIT);
void hx_gl_clear(value mask) {
    glClear(val_get<int>(mask));
}
void hx_gl_clearColor(value r, value g, value b, value a) {
    glClearColor(val_get<float>(r), val_get<float>(g), val_get<float>(b), val_get<float>(a));
}
value hx_gl_compileShader(value shader) {
    glCompileShader(val_get<int>(shader));

    int result;
    glGetShaderiv(val_get<int>(shader), GL_COMPILE_STATUS, &result);
    if (!result) {
        int length;
        glGetShaderiv(val_get<int>(shader), GL_INFO_LOG_LENGTH, &length);
        char* err = new char[length];
        glGetShaderInfoLog(val_get<int>(shader), length, NULL, err);
        return alloc<string>(err);
    }
    else {
        return val_null;
    }
}
CONST(VERTEX_SHADER);
CONST(GEOMETRY_SHADER);
CONST(FRAGMENT_SHADER);
value hx_gl_createShader(value type) {
    return alloc<int>(glCreateShader(val_get<int>(type)));
}
value hx_gl_createProgram() {
    return alloc<int>(glCreateProgram());
}
DEFINE_PRIM(hx_gl_clear,         1);
DEFINE_PRIM(hx_gl_clearColor,    4);
DEFINE_PRIM(hx_gl_compileShader, 1);
DEFINE_PRIM(hx_gl_createShader,  1);
DEFINE_PRIM(hx_gl_createProgram, 0);
// D
void hx_gl_deleteShader(value shader) {
    glDeleteShader(val_get<int>(shader));
}
void hx_gl_disableVertexAttribArray(value index) {
    glDisableVertexAttribArray(val_get<int>(index));
}
CONST(POINTS);
CONST(LINE_STRIP);
CONST(LINE_LOOP);
CONST(LINES);
CONST(LINE_STRIP_ADJACENCY);
CONST(LINES_ADJACENCY);
CONST(TRIANGLE_STRIP);
CONST(TRIANGLE_FAN);
CONST(TRIANGLES);
CONST(TRIANGLE_STRIP_ADJACENCY);
CONST(TRIANGLES_ADJACENCY);
void hx_gl_drawArrays(value mode, value first, value count) {
    glDrawArrays(val_get<int>(mode), val_get<int>(first), val_get<int>(count));
}
DEFINE_PRIM(hx_gl_deleteShader,             1);
DEFINE_PRIM(hx_gl_disableVertexAttribArray, 1);
DEFINE_PRIM(hx_gl_drawArrays,               3);
// E
void hx_gl_enableVertexAttribArray(value index) {
    glEnableVertexAttribArray(val_get<int>(index));
}
DEFINE_PRIM(hx_gl_enableVertexAttribArray, 1);
// F
// G
void hx_gl_genBuffers(value n, value buffers) {
    val_array_set_size(buffers, val_get<int>(n));
    glGenBuffers(val_get<int>(n), (GLuint*)val_array_int(buffers));
}
void hx_gl_genVertexArrays(value n, value arrays) {
    val_array_set_size(arrays, val_get<int>(n));
    glGenVertexArrays(val_get<int>(n), (GLuint*)val_array_int(arrays));
}
DEFINE_PRIM(hx_gl_genBuffers,      2);
DEFINE_PRIM(hx_gl_genVertexArrays, 2);
// H
// I
// J
// K
// L
value hx_gl_linkProgram(value program) {
    glLinkProgram(val_get<int>(program));

    int result;
    glGetProgramiv(val_get<int>(program), GL_LINK_STATUS, &result);
    if (!result) {
        int length;
        glGetProgramiv(val_get<int>(program), GL_INFO_LOG_LENGTH, &length);
        char* err = new char[length];
        glGetProgramInfoLog(val_get<int>(program), length, NULL, err);
        return alloc<string>(err);
    }
    else {
        return val_null;
    }
}
DEFINE_PRIM(hx_gl_linkProgram, 1);
// M
// N
// O
// P
// Q
// R
// S
void hx_gl_shaderSource(value shader, value strings) {
    string* _strings = new string[val_array_size(strings)];
    for (int i = 0; i < val_array_size(strings); i++)
        _strings[i] = val_get<string>(val_array_i(strings, i));
    glShaderSource(val_get<int>(shader), val_array_size(strings), _strings, NULL);
    delete[] _strings;
}
DEFINE_PRIM(hx_gl_shaderSource, 2);
// T
// U
void hx_gl_useProgram(value program) {
    glUseProgram(val_get<int>(program));
}
DEFINE_PRIM(hx_gl_useProgram, 1);
// V
CONST(BGRA);
CONST(BYTE);
CONST(UNSIGNED_BYTE);
CONST(SHORT);
CONST(UNSIGNED_SHORT);
CONST(INT);
CONST(UNSIGNED_INT);
CONST(HALF_FLOAT);
CONST(FLOAT);
CONST(DOUBLE);
CONST(INT_2_10_10_10_REV);
CONST(UNSIGNED_INT_2_10_10_10_REV);
void hx_gl_vertexAttribPointer(value* args, int narg) {
    glVertexAttribPointer(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<bool>(args[3]), val_get<int>(args[4]), (GLvoid*)val_get<int>(args[5]));
}
DEFINE_PRIM_MULT(hx_gl_vertexAttribPointer);
// W
// X
// Y
// Z

extern "C" void hx_ogl_entry() {
    glewExperimental = GL_TRUE;
    glewInit();
}
DEFINE_ENTRY_POINT(hx_ogl_entry);

