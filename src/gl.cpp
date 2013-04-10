#include <hx/CFFI.h>
#include "utils.h"
#define CONST(N) PCONST(gl, GL, N)


void hx_gl_glewInit() {
    glewExperimental = GL_TRUE;
    glewInit();
}
DEFINE_PRIM(hx_gl_glewInit, 0);


// Convert Array<Int>, Array<Float> and
// Array<Int|Float|Vec#> into T* array based
// on GL type
int byte_kind(int T) {
    int t = (T == GL_UNSIGNED_BYTE || T == GL_BYTE) ? 0 :
            (T == GL_UNSIGNED_SHORT || T == GL_SHORT) ? 1 :
            (T == GL_UNSIGNED_INT || T == GL_INT) ? 2 :
            (T == GL_FLOAT) ? 3 : -1;
    return t;
}
int byte_size(int T) {
    int t = byte_kind(t);
    return t == 0 ? 1 : t == 1 ? 2 : 4;
}
int byte_array(value arr, int T, void** dat) {
    int size = val_array_size(arr);
    int t = byte_kind(T);
    if (t == -1) {
        printf("OGL Type not supported for void* data\n");
        neko_error();
    }

    int retval;
    void* ret;
    int* ai = val_array_int(arr);
    if (ai != NULL) {
        ret = *dat = malloc(retval = (size * byte_size(T)));
        for (int i = 0; i < size; i++) {
            if     (t == 0) ((char *)(ret))[i] = ai[i];
            else if(t == 1) ((short*)(ret))[i] = ai[i];
            else if(t == 2) ((int  *)(ret))[i] = ai[i];
            else            ((float*)(ret))[i] = ai[i];
        }
        return retval;
    }

    double* ad = val_array_double(arr);
    if (ad != NULL) {
        ret = *dat = malloc(retval = (size * byte_size(T)));
        for (int i = 0; i < size; i++) {
            if     (t == 0) ((char *)(ret))[i] = ad[i];
            else if(t == 1) ((short*)(ret))[i] = ad[i];
            else if(t == 2) ((int  *)(ret))[i] = ad[i];
            else            ((float*)(ret))[i] = ad[i];
        }
        return retval;
    }

    // Neither Array<Int> or Array<Float>
    // Must be mixed type! slower route.
    int j = 0;
    for (int i = 0; i < size; i++) {
        value d = val_array_i(arr, i);
        if (val_is_int(d) || val_is_float(d) || val_is_bool(d)) {
            j++;
        }
        else {
            j += val_array_size(d);
        }
    }
    ret = *dat = malloc(retval = j * byte_size(T));

    j = 0;
    for (int i = 0; i < size; i++) {
        value d = val_array_i(arr, i);
        if (val_is_int(d) || val_is_float(d) || val_is_bool(d)) {
            if     (t == 0) ((char *)(ret))[j++] = val_get<int>   (d);
            else if(t == 1) ((short*)(ret))[j++] = val_get<int>   (d);
            else if(t == 2) ((int  *)(ret))[j++] = val_get<int>   (d);
            else            ((float*)(ret))[j++] = val_get<double>(d);
        }
        else {
            int size2 = val_array_size(d);
            for (int k = 0; k < size2; k++) {
                value e = val_array_i(d, k);
                if (val_is_int(e) || val_is_float(e) || val_is_bool(e)) {
                    if     (t == 0) ((char *)(ret))[j++] = val_get<int>   (e);
                    else if(t == 1) ((short*)(ret))[j++] = val_get<int>   (e);
                    else if(t == 2) ((int  *)(ret))[j++] = val_get<int>   (e);
                    else            ((float*)(ret))[j++] = val_get<double>(e);
                }
                else {
                    printf("arr had dim > 2\n");
                    neko_error();
                }
            }
        }
    }

    return retval;
}

DECLARE_KIND(k_Buffer);
DEFINE_KIND(k_Buffer);
struct Buffer {
    void* data;
    int size;
    int count;
    int type;
};
void finalise_Buffer(value v) {
    Buffer* ptr = (Buffer*)val_data(v);
    free(ptr->data);
    delete ptr;
}
void finalise_Buffer_nogc(value v) {
    Buffer* ptr = (Buffer*)val_data(v);
    delete ptr;
}
value hx_gl_allocBuffer(value _type, value _count) {
    int type = val_get<int>(_type);
    int count = val_get<int>(_count);

    Buffer* ret = new Buffer;
    int t = byte_kind(type);
    ret->data = malloc(ret->size = (count * byte_size(type)));
    ret->type = type;
    ret->count = count;
    value v = alloc_abstract(k_Buffer, ret);
    val_gc(v, finalise_Buffer);
    return v;
}
value hx_gl_createBuffer(value arr, value type) {
    void* dat;
    int size = byte_array(arr, val_get<int>(type), &dat);
    Buffer* ret = new Buffer;
    ret->data = dat;
    ret->size = size;
    ret->type = val_get<int>(type);
    ret->count = ret->size / byte_size(ret->type);
    value v = alloc_abstract(k_Buffer, ret);
    val_gc(v, finalise_Buffer);
    return v;
}
value hx_gl_createBufferRaw(value raw, value size, value type, value nogc) {
    Buffer* ret = new Buffer;
    ret->data = val_data(raw);
    ret->size = val_get<int>(size);
    ret->type = val_get<int>(type);
    int t = byte_kind(ret->type);
    ret->count = ret->size / byte_size(ret->type);
    value v = alloc_abstract(k_Buffer, ret);
    if (val_get<bool>(nogc)) val_gc(v, finalise_Buffer_nogc);
    else val_gc(v, finalise_Buffer);
    return v;
}
void hx_gl_Buffer_resize(value v, value newCount) {
    val_check_kind(v, k_Buffer);
    Buffer* ptr = (Buffer*)val_data(v);
    ptr->data = realloc(ptr->data, val_get<int>(newCount) * byte_size(ptr->type));
    ptr->count = val_get<int>(newCount);
    ptr->size = ptr->count * byte_size(ptr->type);
}
DEFINE_PRIM(hx_gl_allocBuffer,     2);
DEFINE_PRIM(hx_gl_createBuffer,    2);
DEFINE_PRIM(hx_gl_createBufferRaw, 4);
DEFINE_PRIM(hx_gl_Buffer_resize,   2);

value hx_gl_Buffer_get_type(value v) {
    val_check_kind(v, k_Buffer);
    Buffer* ptr = (Buffer*)val_data(v);
    return alloc<int>(ptr->type);
}
value hx_gl_Buffer_get_count(value v) {
    val_check_kind(v, k_Buffer);
    Buffer* ptr = (Buffer*)val_data(v);
    return alloc<int>(ptr->count);
}
value hx_gl_Buffer_get_size(value v) {
    val_check_kind(v, k_Buffer);
    Buffer* ptr = (Buffer*)val_data(v);
    return alloc<int>(ptr->size);
}
value hx_gl_Buffer_get_raw(value v) {
    val_check_kind(v, k_Buffer);
    Buffer* ptr = (Buffer*)val_data(v);
    return (value)(ptr->data);
}
DEFINE_PRIM(hx_gl_Buffer_get_type,  1);
DEFINE_PRIM(hx_gl_Buffer_get_size,  1);
DEFINE_PRIM(hx_gl_Buffer_get_count, 1);
DEFINE_PRIM(hx_gl_Buffer_get_raw,   1);

value hx_gl_Buffer_get_T(value v, value iv) {
    val_check_kind(v, k_Buffer);
    Buffer* ptr = (Buffer*)val_data(v);
    int i = val_get<int>(iv);
    int t = ptr->type;
    if      (t == GL_BYTE)           return alloc<int>   (((char*)          ptr->data)[i]);
    else if (t == GL_SHORT)          return alloc<int>   (((short*)         ptr->data)[i]);
    else if (t == GL_INT)            return alloc<int>   (((int*)           ptr->data)[i]);
    else if (t == GL_UNSIGNED_BYTE)  return alloc<int>   (((unsigned char*) ptr->data)[i]);
    else if (t == GL_UNSIGNED_SHORT) return alloc<int>   (((unsigned short*)ptr->data)[i]);
    else if (t == GL_UNSIGNED_INT)   return alloc<int>   (((unsigned int*)  ptr->data)[i]);
    else if (t == GL_FLOAT)          return alloc<double>(((float*)         ptr->data)[i]);
    else { neko_error(); return val_null; }
}
value hx_gl_Buffer_set_T(value v, value iv, value x) {
    val_check_kind(v, k_Buffer);
    Buffer* ptr = (Buffer*)val_data(v);
    int i = val_get<int>(iv);
    int t = ptr->type;
    if      (t == GL_BYTE)           return alloc<int>   (((char*)          ptr->data)[i] = val_get<int>   (x));
    else if (t == GL_SHORT)          return alloc<int>   (((short*)         ptr->data)[i] = val_get<int>   (x));
    else if (t == GL_INT)            return alloc<int>   (((int*)           ptr->data)[i] = val_get<int>   (x));
    else if (t == GL_UNSIGNED_BYTE)  return alloc<int>   (((unsigned char*) ptr->data)[i] = val_get<int>   (x));
    else if (t == GL_UNSIGNED_SHORT) return alloc<int>   (((unsigned short*)ptr->data)[i] = val_get<int>   (x));
    else if (t == GL_UNSIGNED_INT)   return alloc<int>   (((unsigned int*)  ptr->data)[i] = val_get<int>   (x));
    else if (t == GL_FLOAT)          return alloc<double>(((float*)         ptr->data)[i] = val_get<double>(x));
    else { neko_error(); return val_null; }
}
DEFINE_PRIM(hx_gl_Buffer_get_T, 2);
DEFINE_PRIM(hx_gl_Buffer_set_T, 3);

// ================================================================================================
// A
// ================================================================================================
void hx_gl_attachShader(value program, value shader) {
    glAttachShader(val_get<int>(program), val_get<int>(shader));
}
DEFINE_PRIM(hx_gl_attachShader, 2);

// ================================================================================================
// B
// ================================================================================================
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
CONST(TEXTURE_1D);
CONST(TEXTURE_2D);
CONST(TEXTURE_3D);
CONST(TEXTURE_1D_ARRAY);
CONST(TEXTURE_2D_ARRAY);
CONST(TEXTURE_RECTANGLE);
CONST(TEXTURE_CUBE_MAP);
CONST(TEXTURE_2D_MULTISAMPLE);
CONST(TEXTURE_2D_MULTISAMPLE_ARRAY);
void hx_gl_bindTexture(value target, value texture) {
    glBindTexture(val_get<int>(target), val_get<int>(texture));
}
void hx_gl_bindVertexArray(value arr) {
    glBindVertexArray(val_get<int>(arr));
}
CONST(SRC_COLOR);
CONST(ONE_MINUS_SRC_COLOR);
CONST(DST_COLOR);
CONST(ONE_MINUS_DST_COLOR);
CONST(SRC_ALPHA);
CONST(ONE_MINUS_SRC_ALPHA);
CONST(DST_ALPHA);
CONST(ONE_MINUS_DST_ALPHA);
CONST(CONSTANT_COLOR);
CONST(ONE_MINUS_CONSTANT_COLOR);
CONST(CONSTANT_ALPHA);
CONST(ONE_MINUS_CONSTANT_ALPHA);
CONST(SRC_ALPHA_SATURATE);
CONST(SRC1_COLOR);
CONST(ONE_MINUS_SRC1_COLOR);
CONST(SRC1_ALPHA);
CONST(ONE_MINUS_SRC1_ALPHA);
void hx_gl_blendFunc(value sfactor, value dfactor) {
    glBlendFunc(val_get<int>(sfactor), val_get<int>(dfactor));
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
void hx_gl_bufferData(value target, value data, value usage, value count) {
    val_check_kind(data, k_Buffer);
    Buffer* ptr = (Buffer*)val_data(data);
    glBufferData(val_get<int>(target), byte_size(ptr->type)*val_get<int>(count), ptr->data, val_get<int>(usage));
}
void hx_gl_bufferSubData(value target, value offset, value data, value count) {
    val_check_kind(data, k_Buffer);
    Buffer* ptr = (Buffer*)val_data(data);
    glBufferSubData(val_get<int>(target), val_get<int>(offset)*byte_size(ptr->type), val_get<int>(count)*byte_size(ptr->type), ptr->data);
}
DEFINE_PRIM(hx_gl_bindBuffer,       2);
DEFINE_PRIM(hx_gl_bindTexture,      2);
DEFINE_PRIM(hx_gl_bindVertexArray,  1);
DEFINE_PRIM(hx_gl_blendFunc,        2);
DEFINE_PRIM(hx_gl_bufferData,       4);
DEFINE_PRIM(hx_gl_bufferSubData,    4);

// ================================================================================================
// C
// ================================================================================================
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

// ================================================================================================
// D
// ================================================================================================
void hx_gl_deleteShader(value shader) {
    glDeleteShader(val_get<int>(shader));
}
void hx_gl_depthFunc(value func) {
    glDepthFunc(val_get<int>(func));
}
void hx_gl_disable(value flag) {
    glDisable(val_get<int>(flag));
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
DEFINE_PRIM(hx_gl_depthFunc,                1);
DEFINE_PRIM(hx_gl_disable,                  1);
DEFINE_PRIM(hx_gl_disableVertexAttribArray, 1);
DEFINE_PRIM(hx_gl_drawArrays,               3);

// ================================================================================================
// E
// ================================================================================================
CONST(BLEND);
CONST(COLOR_LOGIC_OP);
CONST(CULL_FACE);
CONST(DEPTH_CLAMP);
CONST(DEPTH_TEST);
CONST(DITHER);
CONST(FRAMEBUFFER_SRGB);
CONST(LINE_SMOOTH);
CONST(MULTISAMPLE);
CONST(POLYGON_OFFSET_FILL);
CONST(POLYGON_OFFSET_LINE);
CONST(POLYGON_OFFSET_POINT);
CONST(POLYGON_SMOOTH);
CONST(PRIMITIVE_RESTART);
CONST(SAMPLE_ALPHA_TO_COVERAGE);
CONST(SAMPLE_ALPHA_TO_ONE);
CONST(SAMPLE_COVERAGE);
CONST(SCISSOR_TEST);
CONST(STENCIL_TEST);
CONST(TEXTURE_CUBE_MAP_SEAMLESS);
CONST(PROGRAM_POINT_SIZE);
void hx_gl_enable(value flag) {
    glEnable(val_get<int>(flag));
}
void hx_gl_enableVertexAttribArray(value index) {
    glEnableVertexAttribArray(val_get<int>(index));
}
DEFINE_PRIM(hx_gl_enable,                  1);
DEFINE_PRIM(hx_gl_enableVertexAttribArray, 1);

// ================================================================================================
// F
// ================================================================================================

// ================================================================================================
// G
// ================================================================================================
void hx_gl_genBuffers(value n, value buffers) {
    val_array_set_size(buffers, val_get<int>(n));
    glGenBuffers(val_get<int>(n), (GLuint*)val_array_int(buffers));
}
void hx_gl_genTextures(value n, value arrays) {
    val_array_set_size(arrays, val_get<int>(n));
    glGenTextures(val_get<int>(n), (GLuint*)val_array_int(arrays));
}
void hx_gl_genVertexArrays(value n, value arrays) {
    val_array_set_size(arrays, val_get<int>(n));
    glGenVertexArrays(val_get<int>(n), (GLuint*)val_array_int(arrays));
}
value hx_gl_getUniformLocation(value program, value name) {
    return alloc<int>(glGetUniformLocation(val_get<int>(program), val_get<string>(name)));
}
DEFINE_PRIM(hx_gl_genBuffers,         2);
DEFINE_PRIM(hx_gl_genTextures,        2);
DEFINE_PRIM(hx_gl_genVertexArrays,    2);
DEFINE_PRIM(hx_gl_getUniformLocation, 2);

// ================================================================================================
// H
// ================================================================================================

// ================================================================================================
// I
// ================================================================================================

// ================================================================================================
// J
// ================================================================================================

// ================================================================================================
// K
// ================================================================================================

// ================================================================================================
// L
// ================================================================================================
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

// ================================================================================================
// M
// ================================================================================================

// ================================================================================================
// N
// ================================================================================================

// ================================================================================================
// O
// ================================================================================================

// ================================================================================================
// P
// ================================================================================================

// ================================================================================================
// Q
// ================================================================================================

// ================================================================================================
// R
// ================================================================================================

// ================================================================================================
// S
// ================================================================================================
void hx_gl_shaderSource(value shader, value strings) {
    string* _strings = new string[val_array_size(strings)];
    for (int i = 0; i < val_array_size(strings); i++)
        _strings[i] = val_get<string>(val_array_i(strings, i));
    glShaderSource(val_get<int>(shader), val_array_size(strings), _strings, NULL);
    delete[] _strings;
}
DEFINE_PRIM(hx_gl_shaderSource, 2);

// ================================================================================================
// T
// ================================================================================================
CONST(PROXY_TEXTURE_2D);
CONST(PROXY_TEXTURE_1D_ARRAY);
CONST(PROXY_TEXTURE_RECTANGLE);
CONST(TEXTURE_CUBE_MAP_POSITIVE_X);
CONST(TEXTURE_CUBE_MAP_POSITIVE_Y);
CONST(TEXTURE_CUBE_MAP_POSITIVE_Z);
CONST(TEXTURE_CUBE_MAP_NEGATIVE_X);
CONST(TEXTURE_CUBE_MAP_NEGATIVE_Y);
CONST(TEXTURE_CUBE_MAP_NEGATIVE_Z);
CONST(PROXY_TEXTURE_CUBE_MAP);
CONST(RED);
CONST(RG);
CONST(RGB);
CONST(LUMINANCE);
CONST(BGR);
CONST(RGBA);
CONST(BGRA);
void hx_gl_texImage2D(value* args, int narg) {
    val_check_kind(args[8], k_Buffer);
    Buffer* ptr = (Buffer*)val_data(args[8]);
    glTexImage2D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]), ptr->data);
}
void hx_gl_texSubImage2D(value* args, int narg) {
    val_check_kind(args[8], k_Buffer);
    Buffer* ptr = (Buffer*)val_data(args[8]);
    glTexSubImage2D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]), ptr->data);
}
CONST(TEXTURE_BASE_LEVEL);
CONST(TEXTURE_COMPARE_FUNC);
CONST(TEXTURE_COMPARE_MODE);
CONST(TEXTURE_LOD_BIAS);
CONST(TEXTURE_MIN_FILTER);
CONST(TEXTURE_MAG_FILTER);
CONST(TEXTURE_MIN_LOD);
CONST(TEXTURE_MAX_LOD);
CONST(TEXTURE_MAX_LEVEL);
CONST(TEXTURE_SWIZZLE_R);
CONST(TEXTURE_SWIZZLE_G);
CONST(TEXTURE_SWIZZLE_B);
CONST(TEXTURE_SWIZZLE_A);
CONST(TEXTURE_WRAP_S);
CONST(TEXTURE_WRAP_T);
CONST(TEXTURE_WRAP_R);
CONST(COMPARE_REF_TO_TEXTURE);
CONST(LEQUAL);
CONST(GEQUAL);
CONST(LESS);
CONST(GREATER);
CONST(EQUAL);
CONST(NOTEQUAL);
CONST(ALWAYS);
CONST(NEVER);
CONST(NEAREST);
CONST(LINEAR);
CONST(NEAREST_MIPMAP_NEAREST);
CONST(LINEAR_MIPMAP_NEAREST);
CONST(NEAREST_MIPMAP_LINEAR);
CONST(LINEAR_MIPMAP_LINEAR);
CONST(ZERO);
CONST(ALPHA);
CONST(ONE);
CONST(BLUE);
CONST(GREEN);
CONST(CLAMP_TO_EDGE);
CONST(CLAMP_TO_BORDER);
CONST(MIRRORED_REPEAT);
CONST(REPEAT);
void hx_gl_texParameteri(value target, value pname, value param) {
    glTexParameteri(val_get<int>(target), val_get<int>(pname), val_get<int>(param));
}
void hx_gl_texParameterf(value target, value pname, value param) {
    glTexParameterf(val_get<int>(target), val_get<int>(pname), val_get<float>(param));
}
DEFINE_PRIM_MULT(hx_gl_texImage2D);
DEFINE_PRIM_MULT(hx_gl_texSubImage2D);
DEFINE_PRIM(hx_gl_texParameteri, 3);
DEFINE_PRIM(hx_gl_texParameterf, 3);

// ================================================================================================
// U
// ================================================================================================
void hx_gl_useProgram(value program) {
    glUseProgram(val_get<int>(program));
}
void hx_gl_uniformMatrix2x3fv(value location, value count, value transpose, value data) {
    int size = val_array_size(data);
    float* _data = new float[size];
    for (int i = 0; i < size; i++) _data[i] = val_get<float>(val_array_i(data, i));
    glUniformMatrix2x3fv(val_get<int>(location), val_get<int>(count), val_get<bool>(transpose), _data);
    delete[] _data;
}
void hx_gl_uniformMatrix4fv(value location, value count, value transpose, value data) {
    int size = val_array_size(data);
    float* _data = new float[size];
    for (int i = 0; i < size; i++) _data[i] = val_get<float>(val_array_i(data, i));
    glUniformMatrix4fv(val_get<int>(location), val_get<int>(count), val_get<bool>(transpose), _data);
    delete[] _data;
}
DEFINE_PRIM(hx_gl_useProgram,         1);
DEFINE_PRIM(hx_gl_uniformMatrix2x3fv, 4);
DEFINE_PRIM(hx_gl_uniformMatrix4fv,   4);

// ================================================================================================
// V
// ================================================================================================
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
void hx_gl_viewport(value x, value y, value width, value height) {
    glViewport(val_get<int>(x), val_get<int>(y), val_get<int>(width), val_get<int>(height));
}
DEFINE_PRIM_MULT(hx_gl_vertexAttribPointer);
DEFINE_PRIM(hx_gl_viewport, 4);

// ================================================================================================
// W
// ================================================================================================

// ================================================================================================
// X
// ================================================================================================

// ================================================================================================
// Y
// ================================================================================================

// ================================================================================================
// Z
// ================================================================================================




// ================================================================================================

extern "C" void gl_allocateKinds() {
    k_Buffer = alloc_kind();
}

