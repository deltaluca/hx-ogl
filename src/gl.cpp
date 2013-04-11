#include <hx/CFFI.h>
#include "utils.h"
#define CONST(N) PCONST(gl, GL, N)



void hx_gl_glewInit() {
    glewExperimental = GL_TRUE;
    glewInit();
}
DEFINE_PRIM(hx_gl_glewInit, 0);


// Convert Array<Int>, Array<Float> and
// Array<Int|Float|Vec#> into hxcpp buffer
// based on GL type
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

buffer buffer_array(value arr, int T) {
    int size = val_array_size(arr);
    int t = byte_kind(T);
    if (t == -1) {
        printf("OGL Type not supported for void* data\n");
        neko_error();
    }

    buffer ret;
    int* ai = val_array_int(arr);
    if (ai != NULL) {
        ret = alloc_buffer_len(size * byte_size(T));
        void* dat = (void*)buffer_data(ret);
        for (int i = 0; i < size; i++) {
            if     (t == 0) ((char *)(dat))[i] = ai[i];
            else if(t == 1) ((short*)(dat))[i] = ai[i];
            else if(t == 2) ((int  *)(dat))[i] = ai[i];
            else            ((float*)(dat))[i] = ai[i];
        }
        return ret;
    }

    double* ad = val_array_double(arr);
    if (ad != NULL) {
        ret = alloc_buffer_len(size * byte_size(T));
        void* dat = (void*)buffer_data(ret);
        for (int i = 0; i < size; i++) {
            if     (t == 0) ((char *)(dat))[i] = ad[i];
            else if(t == 1) ((short*)(dat))[i] = ad[i];
            else if(t == 2) ((int  *)(dat))[i] = ad[i];
            else            ((float*)(dat))[i] = ad[i];
        }
        return ret;
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
    ret = alloc_buffer_len(j * byte_size(T));
    void* dat = (void*)buffer_data(ret);

    j = 0;
    for (int i = 0; i < size; i++) {
        value d = val_array_i(arr, i);
        if (val_is_int(d) || val_is_float(d) || val_is_bool(d)) {
            if     (t == 0) ((char *)(dat))[j++] = val_get<int>   (d);
            else if(t == 1) ((short*)(dat))[j++] = val_get<int>   (d);
            else if(t == 2) ((int  *)(dat))[j++] = val_get<int>   (d);
            else            ((float*)(dat))[j++] = val_get<double>(d);
        }
        else {
            int size2 = val_array_size(d);
            for (int k = 0; k < size2; k++) {
                value e = val_array_i(d, k);
                if (val_is_int(e) || val_is_float(e) || val_is_bool(e)) {
                    if     (t == 0) ((char *)(dat))[j++] = val_get<int>   (e);
                    else if(t == 1) ((short*)(dat))[j++] = val_get<int>   (e);
                    else if(t == 2) ((int  *)(dat))[j++] = val_get<int>   (e);
                    else            ((float*)(dat))[j++] = val_get<double>(e);
                }
                else {
                    printf("arr had dim > 2\n");
                    neko_error();
                }
            }
        }
    }
    return ret;
}

value hx_gl_allocBuffer(value type, value count) {
    return buffer_val(alloc_buffer_len(val_get<int>(count) * byte_size(val_get<int>(type))));
}
value hx_gl_createBuffer(value arr, value type) {
    return buffer_val(buffer_array(arr, val_get<int>(type)));
}
value hx_gl_arrbuffer_resize(value buf, value size) {
    buffer b = val_to_buffer(buf);
    buffer_set_size(b, val_get<int>(size));
}
DEFINE_PRIM(hx_gl_allocBuffer, 2);
DEFINE_PRIM(hx_gl_createBuffer, 2);
DEFINE_PRIM(hx_gl_arrbuffer_resize, 2);


DECLARE_KIND(k_Sync);
DEFINE_KIND(k_Sync);


// ================================================================================================
// A
// ================================================================================================
void hx_gl_activeTexture(value texture) {
    glActiveTexture(val_get<int>(texture));
}
void hx_gl_attachShader(value program, value shader) {
    glAttachShader(val_get<int>(program), val_get<int>(shader));
}
DEFINE_PRIM(hx_gl_activeTexture, 1);
DEFINE_PRIM(hx_gl_attachShader,  2);

// ================================================================================================
// B
// ================================================================================================
void hx_gl_beginConditionalRender(value id, value mode) {
    glBeginConditionalRender(val_get<int>(id), val_get<int>(mode));
}
void hx_gl_beginQuery(value target, value id) {
    glBeginQuery(val_get<int>(target), val_get<int>(id));
}
void hx_gl_beginTransformFeedback(value primitiveMode) {
    glBeginTransformFeedback(val_get<int>(primitiveMode));
}
void hx_gl_bindAttribLocation(value program, value index, value name) {
    glBindAttribLocation(val_get<int>(program), val_get<int>(index), val_get<string>(name));
}
void hx_gl_bindBuffer(value target, value _buffer) {
    glBindBuffer(val_get<int>(target), val_get<int>(_buffer));
}
void hx_gl_bindBufferBase(value target, value index, value _buffer) {
    glBindBufferBase(val_get<int>(target), val_get<int>(index), val_get<int>(_buffer));
}
void hx_gl_bindBufferRange(value target, value index, value _buffer, value offset, value size) {
    glBindBufferRange(val_get<int>(target), val_get<int>(index), val_get<int>(_buffer), val_get<int>(offset), val_get<int>(size));
}
void hx_gl_bindFragDataLocation(value program, value colorNumber, value name) {
    glBindFragDataLocation(val_get<int>(program), val_get<int>(colorNumber), val_get<string>(name));
}
void hx_gl_bindFragDataLocationIndexed(value program, value colorNumber, value index, value name) {
    glBindFragDataLocationIndexed(val_get<int>(program), val_get<int>(colorNumber), val_get<int>(index), val_get<string>(name));
}
void hx_gl_bindFramebuffer(value target, value framebuffer) {
    glBindFramebuffer(val_get<int>(target), val_get<int>(framebuffer));
}
void hx_gl_bindRenderbuffer(value target, value renderbuffer) {
    glBindRenderbuffer(val_get<int>(target), val_get<int>(renderbuffer));
}
void hx_gl_bindSampler(value target, value sampler) {
    glBindSampler(val_get<int>(target), val_get<int>(sampler));
}
void hx_gl_bindTexture(value target, value texture) {
    glBindTexture(val_get<int>(target), val_get<int>(texture));
}
void hx_gl_bindVertexArray(value arr) {
    glBindVertexArray(val_get<int>(arr));
}
void hx_gl_blendColor(value r, value g, value b, value a) {
    glBlendColor(val_get<double>(r), val_get<double>(g), val_get<double>(b), val_get<double>(a));
}
void hx_gl_blendEquation(value mode) {
    glBlendEquation(val_get<int>(mode));
}
void hx_gl_blendEquationSeparate(value modeRGB, value modeAlpha) {
    glBlendEquationSeparate(val_get<int>(modeRGB), val_get<int>(modeAlpha));
}
void hx_gl_blendFunc(value sfactor, value dfactor) {
    glBlendFunc(val_get<int>(sfactor), val_get<int>(dfactor));
}
void hx_gl_blendFuncSeparate(value srcrgb, value dstrgb, value srca, value dsta) {
    glBlendFuncSeparate(val_get<int>(srcrgb), val_get<int>(dstrgb), val_get<int>(srca), val_get<int>(dsta));
}
void hx_gl_blitFramebuffer(value* args, int nargs) {
    glBlitFramebuffer(
        val_get<int>(args[0]),
        val_get<int>(args[1]),
        val_get<int>(args[2]),
        val_get<int>(args[3]),
        val_get<int>(args[4]),
        val_get<int>(args[5]),
        val_get<int>(args[6]),
        val_get<int>(args[7]),
        val_get<int>(args[8]),
        val_get<int>(args[9])
    );
}
void hx_gl_bufferData(value target, value data, value size, value usage, value count) {
    glBufferData(val_get<int>(target), val_get<int>(size)*val_get<int>(count), buffer_data(val_to_buffer(data)), val_get<int>(usage));
}
void hx_gl_bufferSubData(value target, value offset, value data, value size, value count) {
    glBufferSubData(val_get<int>(target), val_get<int>(offset)*val_get<int>(size), val_get<int>(count)*val_get<int>(size), buffer_data(val_to_buffer(data)));
}
DEFINE_PRIM(hx_gl_beginConditionalRender, 2);
DEFINE_PRIM(hx_gl_beginQuery,             2);
DEFINE_PRIM(hx_gl_beginTransformFeedback, 1);
DEFINE_PRIM(hx_gl_bindAttribLocation,     3);
DEFINE_PRIM(hx_gl_bindBuffer,             2);
DEFINE_PRIM(hx_gl_bindBufferBase,         3);
DEFINE_PRIM(hx_gl_bindBufferRange,        5);
DEFINE_PRIM(hx_gl_bindFragDataLocation,   3);
DEFINE_PRIM(hx_gl_bindFragDataLocationIndexed,4);
DEFINE_PRIM(hx_gl_bindFramebuffer,        2);
DEFINE_PRIM(hx_gl_bindRenderbuffer,       2);
DEFINE_PRIM(hx_gl_bindSampler,            2);
DEFINE_PRIM(hx_gl_bindTexture,            2);
DEFINE_PRIM(hx_gl_bindVertexArray,        1);
DEFINE_PRIM(hx_gl_blendColor,             4);
DEFINE_PRIM(hx_gl_blendEquation,          1);
DEFINE_PRIM(hx_gl_blendEquationSeparate,  2);
DEFINE_PRIM(hx_gl_blendFunc,              2);
DEFINE_PRIM(hx_gl_blendFuncSeparate,      4);
DEFINE_PRIM_MULT(hx_gl_blitFramebuffer);
DEFINE_PRIM(hx_gl_bufferData,             5);
DEFINE_PRIM(hx_gl_bufferSubData,          5);

// ================================================================================================
// C
// ================================================================================================
value hx_gl_checkFramebufferStatus(value target) {
    return alloc<int>(glCheckFramebufferStatus(val_get<int>(target)));
}
void hx_gl_clampColor(value target, value clamp) {
    glClampColor(val_get<int>(target), val_get<int>(clamp));
}
void hx_gl_clear(value mask) {
    glClear(val_get<int>(mask));
}
void hx_gl_clearBufferiv(value _buffer, value drawBuffer, value _value) {
    glClearBufferiv(val_get<int>(_buffer), val_get<int>(drawBuffer), (const GLint*)buffer_data(val_to_buffer(_value)));
}
void hx_gl_clearBufferuiv(value _buffer, value drawBuffer, value _value) {
    glClearBufferuiv(val_get<int>(_buffer), val_get<int>(drawBuffer), (const GLuint*)buffer_data(val_to_buffer(_value)));
}
void hx_gl_clearBufferfv(value _buffer, value drawBuffer, value _value) {
    glClearBufferfv(val_get<int>(_buffer), val_get<int>(drawBuffer), (const GLfloat*)buffer_data(val_to_buffer(_value)));
}
void hx_gl_clearBufferfi(value _buffer, value drawBuffer, value depth, value stencil) {
    glClearBufferfi(val_get<int>(_buffer), val_get<int>(drawBuffer), val_get<double>(depth), val_get<int>(stencil));
}
void hx_gl_clearColor(value r, value g, value b, value a) {
    glClearColor(val_get<float>(r), val_get<float>(g), val_get<float>(b), val_get<float>(a));
}
void hx_gl_clearDepth(value depth) {
    glClearDepth(val_get<double>(depth));
}
void hx_gl_clearStencil(value stencil) {
    glClearStencil(val_get<int>(stencil));
}
value hx_gl_clientWaitSync(value sync, value flags, value timeLow, value timeHigh) {
    val_check_kind(sync, k_Sync);
    GLsync syncVal = (GLsync)val_data(sync);
    GLuint64 val;
    ((int*)&val)[0] = val_get<int>(timeLow);
    ((int*)&val)[1] = val_get<int>(timeHigh);
    return alloc<int>(glClientWaitSync(syncVal, val_get<int>(flags), val));
}
void hx_gl_colorMask(value r, value g, value b, value a) {
    glColorMask(val_get<bool>(r), val_get<bool>(g), val_get<bool>(b), val_get<bool>(a));
}
void hx_gl_colorMaski(value buf, value r, value g, value b, value a) {
    glColorMaski(val_get<int>(buf), val_get<bool>(r), val_get<bool>(g), val_get<bool>(b), val_get<bool>(a));
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
void hx_gl_compressedTexImage1D(value* args, int nargs) {
    glCompressedTexImage1D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), buffer_data(val_to_buffer(args[6])));
}
void hx_gl_compressedTexImage2D(value* args, int nargs) {
    glCompressedTexImage2D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), buffer_data(val_to_buffer(args[7])));
}
void hx_gl_compressedTexImage3D(value* args, int nargs) {
    glCompressedTexImage3D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]), buffer_data(val_to_buffer(args[8])));
}
void hx_gl_compressedTexSubImage1D(value* args, int nargs) {
    glCompressedTexSubImage1D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), buffer_data(val_to_buffer(args[6])));
}
void hx_gl_compressedTexSubImage2D(value* args, int nargs) {
    glCompressedTexSubImage2D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]), buffer_data(val_to_buffer(args[8])));
}
void hx_gl_compressedTexSubImage3D(value* args, int nargs) {
    glCompressedTexSubImage3D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]), val_get<int>(args[8]), val_get<int>(args[9]), buffer_data(val_to_buffer(args[10])));
}
void hx_gl_copyBufferSubData(value readt, value writet, value reado, value writeo, value size) {
    glCopyBufferSubData(val_get<int>(readt), val_get<int>(writet), val_get<int>(reado), val_get<int>(writeo), val_get<int>(size));
}
void hx_gl_copyTexImage1D(value* args, int nargs) {
    glCopyTexImage1D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]));
}
void hx_gl_copyTexImage2D(value* args, int nargs) {
    glCopyTexImage2D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]));
}
void hx_gl_copyTexSubImage1D(value* args, int nargs) {
    glCopyTexSubImage1D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]));
}
void hx_gl_copyTexSubImage2D(value* args, int nargs) {
    glCopyTexSubImage2D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]));
}
void hx_gl_copyTexSubImage3D(value* args, int nargs) {
    glCopyTexSubImage3D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]), val_get<int>(args[8]));
}
value hx_gl_createShader(value type) {
    return alloc<int>(glCreateShader(val_get<int>(type)));
}
value hx_gl_createProgram() {
    return alloc<int>(glCreateProgram());
}
void hx_gl_cullFace(value mode) {
    glCullFace(val_get<int>(mode));
}
DEFINE_PRIM(hx_gl_checkFramebufferStatus, 1);
DEFINE_PRIM(hx_gl_clampColor,             2);
DEFINE_PRIM(hx_gl_clear,                  1);
DEFINE_PRIM(hx_gl_clearBufferiv,          3);
DEFINE_PRIM(hx_gl_clearBufferuiv,         3);
DEFINE_PRIM(hx_gl_clearBufferfv,          3);
DEFINE_PRIM(hx_gl_clearBufferfi,          4);
DEFINE_PRIM(hx_gl_clearColor,             4);
DEFINE_PRIM(hx_gl_clearDepth,             1);
DEFINE_PRIM(hx_gl_clearStencil,           1);
DEFINE_PRIM(hx_gl_clientWaitSync,         4);
DEFINE_PRIM(hx_gl_colorMask,              4);
DEFINE_PRIM(hx_gl_colorMaski,             5);
DEFINE_PRIM(hx_gl_compileShader,          1);
DEFINE_PRIM_MULT(hx_gl_compressedTexImage1D);
DEFINE_PRIM_MULT(hx_gl_compressedTexImage2D);
DEFINE_PRIM_MULT(hx_gl_compressedTexImage3D);
DEFINE_PRIM_MULT(hx_gl_compressedTexSubImage1D);
DEFINE_PRIM_MULT(hx_gl_compressedTexSubImage2D);
DEFINE_PRIM_MULT(hx_gl_compressedTexSubImage3D);
DEFINE_PRIM(hx_gl_copyBufferSubData,      5);
DEFINE_PRIM_MULT(hx_gl_copyTexImage1D);
DEFINE_PRIM_MULT(hx_gl_copyTexImage2D);
DEFINE_PRIM_MULT(hx_gl_copyTexSubImage1D);
DEFINE_PRIM_MULT(hx_gl_copyTexSubImage2D);
DEFINE_PRIM_MULT(hx_gl_copyTexSubImage3D);
DEFINE_PRIM(hx_gl_createShader,           1);
DEFINE_PRIM(hx_gl_createProgram,          0);
DEFINE_PRIM(hx_gl_cullFace,               1);

// ================================================================================================
// D
// ================================================================================================
void hx_gl_deleteBuffers(value buffers) {
    glDeleteBuffers(val_array_size(buffers), (const GLuint*)val_array_int(buffers));
}
void hx_gl_deleteFramebuffers(value buffers) {
    glDeleteFramebuffers(val_array_size(buffers), (const GLuint*)val_array_int(buffers));
}
void hx_gl_deleteProgram(value program) {
    glDeleteProgram(val_get<int>(program));
}
void hx_gl_deleteQueries(value queries) {
    glDeleteQueries(val_array_size(queries), (const GLuint*)val_array_int(queries));
}
void hx_gl_deleteRenderbuffers(value buffers) {
    glDeleteRenderbuffers(val_array_size(buffers), (const GLuint*)val_array_int(buffers));
}
void hx_gl_deleteSamplers(value samplers) {
    glDeleteSamplers(val_array_size(samplers), (const GLuint*)val_array_int(samplers));
}
void hx_gl_deleteShader(value shader) {
    glDeleteShader(val_get<int>(shader));
}
void hx_gl_deleteSync(value sync) {
    val_check_kind(sync, k_Sync);
    glDeleteSync((GLsync)val_data(sync));
}
void hx_gl_deleteTextures(value textures) {
    glDeleteTextures(val_array_size(textures), (const GLuint*)val_array_int(textures));
}
void hx_gl_deleteVertexArrays(value vertexArrays) {
    glDeleteVertexArrays(val_array_size(vertexArrays), (const GLuint*)val_array_int(vertexArrays));
}
void hx_gl_depthFunc(value func) {
    glDepthFunc(val_get<int>(func));
}
void hx_gl_depthMask(value flag) {
    glDepthMask(val_get<bool>(flag));
}
void hx_gl_depthRange(value near, value far) {
    glDepthRange(val_get<double>(near), val_get<double>(far));
}
void hx_gl_detachShader(value program, value shader) {
    glDetachShader(val_get<int>(program), val_get<int>(shader));
}
void hx_gl_disable(value flag) {
    glDisable(val_get<int>(flag));
}
void hx_gl_disableVertexAttribArray(value index) {
    glDisableVertexAttribArray(val_get<int>(index));
}
void hx_gl_disablei(value cap, value index) {
    glDisablei(val_get<int>(cap), val_get<int>(index));
}
void hx_gl_drawArrays(value mode, value first, value count) {
    glDrawArrays(val_get<int>(mode), val_get<int>(first), val_get<int>(count));
}
void hx_gl_drawArraysInstanced(value mode, value first, value count, value primcount) {
    glDrawArraysInstanced(val_get<int>(mode), val_get<int>(first), val_get<int>(count), val_get<int>(primcount));
}
void hx_gl_drawBuffer(value mode) {
    glDrawBuffer(val_get<int>(mode));
}
void hx_gl_drawBuffers(value bufs) {
    glDrawBuffers(val_array_size(bufs), (const GLenum*)val_array_int(bufs));
}
void hx_gl_drawElements(value mode, value count, value type, value indices) {
    glDrawElements(val_get<int>(mode), val_get<int>(count), val_get<int>(type), buffer_data(val_to_buffer(indices)));
}
void hx_gl_drawElementsBaseVertex(value mode, value count, value type, value indices, value basevertex) {
    glDrawElementsBaseVertex(val_get<int>(mode), val_get<int>(count), val_get<int>(type), buffer_data(val_to_buffer(indices)), val_get<int>(basevertex));
}
void hx_gl_drawElementsInstanced(value mode, value count, value type, value indices, value primcount) {
    glDrawElementsInstanced(val_get<int>(mode), val_get<int>(count), val_get<int>(type), buffer_data(val_to_buffer(indices)), val_get<int>(primcount));
}
void hx_gl_drawElementsInstancedBaseVertex(value* args, int nargs) {
    glDrawElementsInstancedBaseVertex(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), buffer_data(val_to_buffer(args[3])), val_get<int>(args[4]), val_get<int>(args[5]));
}
void hx_gl_drawRangeElements(value* args, int nargs) {
    glDrawRangeElements(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), buffer_data(val_to_buffer(args[5])));
}
void hx_gl_drawRangeElementsBaseVertex(value* args, int nargs) {
    glDrawRangeElementsBaseVertex(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), buffer_data(val_to_buffer(args[5])), val_get<int>(args[6]));
}
DEFINE_PRIM(hx_gl_deleteBuffers,            1);
DEFINE_PRIM(hx_gl_deleteFramebuffers,       1);
DEFINE_PRIM(hx_gl_deleteProgram,            1);
DEFINE_PRIM(hx_gl_deleteQueries,            1);
DEFINE_PRIM(hx_gl_deleteRenderbuffers,      1);
DEFINE_PRIM(hx_gl_deleteSamplers,           1);
DEFINE_PRIM(hx_gl_deleteShader,             1);
DEFINE_PRIM(hx_gl_deleteSync,               1);
DEFINE_PRIM(hx_gl_deleteTextures,           1);
DEFINE_PRIM(hx_gl_deleteVertexArrays,       1);
DEFINE_PRIM(hx_gl_depthFunc,                1);
DEFINE_PRIM(hx_gl_depthMask,                1);
DEFINE_PRIM(hx_gl_depthRange,               2);
DEFINE_PRIM(hx_gl_detachShader,             2);
DEFINE_PRIM(hx_gl_disable,                  1);
DEFINE_PRIM(hx_gl_disablei,                 2);
DEFINE_PRIM(hx_gl_disableVertexAttribArray, 1);
DEFINE_PRIM(hx_gl_drawArrays,               3);
DEFINE_PRIM(hx_gl_drawArraysInstanced,      4);
DEFINE_PRIM(hx_gl_drawBuffer,               1);
DEFINE_PRIM(hx_gl_drawBuffers,              1);
DEFINE_PRIM(hx_gl_drawElements,             4);
DEFINE_PRIM(hx_gl_drawElementsBaseVertex,   5);
DEFINE_PRIM(hx_gl_drawElementsInstanced,    5);
DEFINE_PRIM_MULT(hx_gl_drawElementsInstancedBaseVertex);
DEFINE_PRIM_MULT(hx_gl_drawRangeElements);
DEFINE_PRIM_MULT(hx_gl_drawRangeElementsBaseVertex);

// ================================================================================================
// E
// ================================================================================================
void hx_gl_enable(value cap) {
    glEnable(val_get<int>(cap));
}
void hx_gl_enableVertexAttribArray(value index) {
    glEnableVertexAttribArray(val_get<int>(index));
}
void hx_gl_enablei(value cap, value index) {
    glEnablei(val_get<int>(cap), val_get<int>(index));
}
void hx_gl_endConditionalRender() {
    glEndConditionalRender();
}
void hx_gl_endQuery(value target) {
    glEndQuery(val_get<int>(target));
}
void hx_gl_endTransformFeedback() {
    glEndTransformFeedback();
}
DEFINE_PRIM(hx_gl_enable,                  1);
DEFINE_PRIM(hx_gl_enableVertexAttribArray, 1);
DEFINE_PRIM(hx_gl_enablei,                 2);
DEFINE_PRIM(hx_gl_endConditionalRender,    0);
DEFINE_PRIM(hx_gl_endQuery,                1);
DEFINE_PRIM(hx_gl_endTransformFeedback,    0);

// ================================================================================================
// F
// ================================================================================================
void hx_gl_fenceSync(value condition, value flags) {
    glFenceSync(val_get<int>(condition), val_get<int>(flags));
}
void hx_gl_finish() {
    glFinish();
}
void hx_gl_flush() {
    glFlush();
}
void hx_gl_flushMappedBufferRange(value target, value offset, value length) {
    glFlushMappedBufferRange(val_get<int>(target), val_get<int>(offset), val_get<int>(length));
}
void hx_gl_framebufferRenderbuffer(value target, value att, value rtarget, value rbuffer) {
    glFramebufferRenderbuffer(val_get<int>(target), val_get<int>(att), val_get<int>(rtarget), val_get<int>(rbuffer));
}
void hx_gl_framebufferTexture(value target, value att, value tex, value level) {
    glFramebufferTexture(val_get<int>(target), val_get<int>(att), val_get<int>(tex), val_get<int>(level));
}
void hx_gl_framebufferTexture1D(value target, value att, value textarg, value tex, value level) {
    glFramebufferTexture1D(val_get<int>(target), val_get<int>(att), val_get<int>(textarg), val_get<int>(tex), val_get<int>(level));
}
void hx_gl_framebufferTexture2D(value target, value att, value textarg, value tex, value level) {
    glFramebufferTexture2D(val_get<int>(target), val_get<int>(att), val_get<int>(textarg), val_get<int>(tex), val_get<int>(level));
}
void hx_gl_framebufferTexture3D(value* args, int nargs) {
    glFramebufferTexture3D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]));
}
void hx_gl_framebufferTextureLayer(value target, value att, value texture, value level, value layer) {
    glFramebufferTextureLayer(val_get<int>(target), val_get<int>(att), val_get<int>(texture), val_get<int>(level), val_get<int>(layer));
}
void hx_gl_frontFace(value mode) {
    glFrontFace(val_get<int>(mode));
}
DEFINE_PRIM(hx_gl_fenceSync,               2);
DEFINE_PRIM(hx_gl_finish,                  0);
DEFINE_PRIM(hx_gl_flush,                   0);
DEFINE_PRIM(hx_gl_flushMappedBufferRange,  3);
DEFINE_PRIM(hx_gl_framebufferRenderbuffer, 4);
DEFINE_PRIM(hx_gl_framebufferTexture,      4);
DEFINE_PRIM(hx_gl_framebufferTexture1D,    5);
DEFINE_PRIM(hx_gl_framebufferTexture2D,    5);
DEFINE_PRIM_MULT(hx_gl_framebufferTexture3D);
DEFINE_PRIM(hx_gl_framebufferTextureLayer, 5);
DEFINE_PRIM(hx_gl_frontFace,               1);

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
void hx_gl_texImage2D(value* args, int narg) {
    glTexImage2D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]), buffer_data(val_to_buffer(args[8])));
}
void hx_gl_texSubImage2D(value* args, int narg) {
    glTexSubImage2D(val_get<int>(args[0]), val_get<int>(args[1]), val_get<int>(args[2]), val_get<int>(args[3]), val_get<int>(args[4]), val_get<int>(args[5]), val_get<int>(args[6]), val_get<int>(args[7]), buffer_data(val_to_buffer(args[8])));
}
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
void hx_gl_waitSync(value sync, value flags, value timeLow, value timeHigh) {
    val_check_kind(sync, k_Sync);
    GLsync syncVal = (GLsync)val_data(sync);
    GLuint64 val;
    ((int*)&val)[0] = val_get<int>(timeLow);
    ((int*)&val)[1] = val_get<int>(timeHigh);
    glWaitSync(syncVal, val_get<int>(flags), val);
}
DEFINE_PRIM(hx_gl_waitSync, 4);

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
// GL_VERSION_1_1 CONSTS
CONST(ZERO);
CONST(FALSE);
CONST(LOGIC_OP);
CONST(NONE);
CONST(TEXTURE_COMPONENTS);
CONST(NO_ERROR);
CONST(POINTS);
CONST(CURRENT_BIT);
CONST(TRUE);
CONST(ONE);
CONST(CLIENT_PIXEL_STORE_BIT);
CONST(LINES);
CONST(LINE_LOOP);
CONST(POINT_BIT);
CONST(CLIENT_VERTEX_ARRAY_BIT);
CONST(LINE_STRIP);
CONST(LINE_BIT);
CONST(TRIANGLES);
CONST(TRIANGLE_STRIP);
CONST(TRIANGLE_FAN);
CONST(QUADS);
CONST(QUAD_STRIP);
CONST(POLYGON_BIT);
CONST(POLYGON);
CONST(POLYGON_STIPPLE_BIT);
CONST(PIXEL_MODE_BIT);
CONST(LIGHTING_BIT);
CONST(FOG_BIT);
CONST(DEPTH_BUFFER_BIT);
CONST(ACCUM);
CONST(LOAD);
CONST(RETURN);
CONST(MULT);
CONST(ADD);
CONST(NEVER);
CONST(ACCUM_BUFFER_BIT);
CONST(LESS);
CONST(EQUAL);
CONST(LEQUAL);
CONST(GREATER);
CONST(NOTEQUAL);
CONST(GEQUAL);
CONST(ALWAYS);
CONST(SRC_COLOR);
CONST(ONE_MINUS_SRC_COLOR);
CONST(SRC_ALPHA);
CONST(ONE_MINUS_SRC_ALPHA);
CONST(DST_ALPHA);
CONST(ONE_MINUS_DST_ALPHA);
CONST(DST_COLOR);
CONST(ONE_MINUS_DST_COLOR);
CONST(SRC_ALPHA_SATURATE);
CONST(STENCIL_BUFFER_BIT);
CONST(FRONT_LEFT);
CONST(FRONT_RIGHT);
CONST(BACK_LEFT);
CONST(BACK_RIGHT);
CONST(FRONT);
CONST(BACK);
CONST(LEFT);
CONST(RIGHT);
CONST(FRONT_AND_BACK);
CONST(AUX0);
CONST(AUX1);
CONST(AUX2);
CONST(AUX3);
CONST(INVALID_ENUM);
CONST(INVALID_VALUE);
CONST(INVALID_OPERATION);
CONST(STACK_OVERFLOW);
CONST(STACK_UNDERFLOW);
CONST(OUT_OF_MEMORY);
CONST(2D);
CONST(3D);
CONST(3D_COLOR);
CONST(3D_COLOR_TEXTURE);
CONST(4D_COLOR_TEXTURE);
CONST(PASS_THROUGH_TOKEN);
CONST(POINT_TOKEN);
CONST(LINE_TOKEN);
CONST(POLYGON_TOKEN);
CONST(BITMAP_TOKEN);
CONST(DRAW_PIXEL_TOKEN);
CONST(COPY_PIXEL_TOKEN);
CONST(LINE_RESET_TOKEN);
CONST(EXP);
CONST(VIEWPORT_BIT);
CONST(EXP2);
CONST(CW);
CONST(CCW);
CONST(COEFF);
CONST(ORDER);
CONST(DOMAIN);
CONST(CURRENT_COLOR);
CONST(CURRENT_INDEX);
CONST(CURRENT_NORMAL);
CONST(CURRENT_TEXTURE_COORDS);
CONST(CURRENT_RASTER_COLOR);
CONST(CURRENT_RASTER_INDEX);
CONST(CURRENT_RASTER_TEXTURE_COORDS);
CONST(CURRENT_RASTER_POSITION);
CONST(CURRENT_RASTER_POSITION_VALID);
CONST(CURRENT_RASTER_DISTANCE);
CONST(POINT_SMOOTH);
CONST(POINT_SIZE);
CONST(POINT_SIZE_RANGE);
CONST(POINT_SIZE_GRANULARITY);
CONST(LINE_SMOOTH);
CONST(LINE_WIDTH);
CONST(LINE_WIDTH_RANGE);
CONST(LINE_WIDTH_GRANULARITY);
CONST(LINE_STIPPLE);
CONST(LINE_STIPPLE_PATTERN);
CONST(LINE_STIPPLE_REPEAT);
CONST(LIST_MODE);
CONST(MAX_LIST_NESTING);
CONST(LIST_BASE);
CONST(LIST_INDEX);
CONST(POLYGON_MODE);
CONST(POLYGON_SMOOTH);
CONST(POLYGON_STIPPLE);
CONST(EDGE_FLAG);
CONST(CULL_FACE);
CONST(CULL_FACE_MODE);
CONST(FRONT_FACE);
CONST(LIGHTING);
CONST(LIGHT_MODEL_LOCAL_VIEWER);
CONST(LIGHT_MODEL_TWO_SIDE);
CONST(LIGHT_MODEL_AMBIENT);
CONST(SHADE_MODEL);
CONST(COLOR_MATERIAL_FACE);
CONST(COLOR_MATERIAL_PARAMETER);
CONST(COLOR_MATERIAL);
CONST(FOG);
CONST(FOG_INDEX);
CONST(FOG_DENSITY);
CONST(FOG_START);
CONST(FOG_END);
CONST(FOG_MODE);
CONST(FOG_COLOR);
CONST(DEPTH_RANGE);
CONST(DEPTH_TEST);
CONST(DEPTH_WRITEMASK);
CONST(DEPTH_CLEAR_VALUE);
CONST(DEPTH_FUNC);
CONST(ACCUM_CLEAR_VALUE);
CONST(STENCIL_TEST);
CONST(STENCIL_CLEAR_VALUE);
CONST(STENCIL_FUNC);
CONST(STENCIL_VALUE_MASK);
CONST(STENCIL_FAIL);
CONST(STENCIL_PASS_DEPTH_FAIL);
CONST(STENCIL_PASS_DEPTH_PASS);
CONST(STENCIL_REF);
CONST(STENCIL_WRITEMASK);
CONST(MATRIX_MODE);
CONST(NORMALIZE);
CONST(VIEWPORT);
CONST(MODELVIEW_STACK_DEPTH);
CONST(PROJECTION_STACK_DEPTH);
CONST(TEXTURE_STACK_DEPTH);
CONST(MODELVIEW_MATRIX);
CONST(PROJECTION_MATRIX);
CONST(TEXTURE_MATRIX);
CONST(ATTRIB_STACK_DEPTH);
CONST(CLIENT_ATTRIB_STACK_DEPTH);
CONST(ALPHA_TEST);
CONST(ALPHA_TEST_FUNC);
CONST(ALPHA_TEST_REF);
CONST(DITHER);
CONST(BLEND_DST);
CONST(BLEND_SRC);
CONST(BLEND);
CONST(LOGIC_OP_MODE);
CONST(INDEX_LOGIC_OP);
CONST(COLOR_LOGIC_OP);
CONST(AUX_BUFFERS);
CONST(DRAW_BUFFER);
CONST(READ_BUFFER);
CONST(SCISSOR_BOX);
CONST(SCISSOR_TEST);
CONST(INDEX_CLEAR_VALUE);
CONST(INDEX_WRITEMASK);
CONST(COLOR_CLEAR_VALUE);
CONST(COLOR_WRITEMASK);
CONST(INDEX_MODE);
CONST(RGBA_MODE);
CONST(DOUBLEBUFFER);
CONST(STEREO);
CONST(RENDER_MODE);
CONST(PERSPECTIVE_CORRECTION_HINT);
CONST(POINT_SMOOTH_HINT);
CONST(LINE_SMOOTH_HINT);
CONST(POLYGON_SMOOTH_HINT);
CONST(FOG_HINT);
CONST(TEXTURE_GEN_S);
CONST(TEXTURE_GEN_T);
CONST(TEXTURE_GEN_R);
CONST(TEXTURE_GEN_Q);
CONST(PIXEL_MAP_I_TO_I);
CONST(PIXEL_MAP_S_TO_S);
CONST(PIXEL_MAP_I_TO_R);
CONST(PIXEL_MAP_I_TO_G);
CONST(PIXEL_MAP_I_TO_B);
CONST(PIXEL_MAP_I_TO_A);
CONST(PIXEL_MAP_R_TO_R);
CONST(PIXEL_MAP_G_TO_G);
CONST(PIXEL_MAP_B_TO_B);
CONST(PIXEL_MAP_A_TO_A);
CONST(PIXEL_MAP_I_TO_I_SIZE);
CONST(PIXEL_MAP_S_TO_S_SIZE);
CONST(PIXEL_MAP_I_TO_R_SIZE);
CONST(PIXEL_MAP_I_TO_G_SIZE);
CONST(PIXEL_MAP_I_TO_B_SIZE);
CONST(PIXEL_MAP_I_TO_A_SIZE);
CONST(PIXEL_MAP_R_TO_R_SIZE);
CONST(PIXEL_MAP_G_TO_G_SIZE);
CONST(PIXEL_MAP_B_TO_B_SIZE);
CONST(PIXEL_MAP_A_TO_A_SIZE);
CONST(UNPACK_SWAP_BYTES);
CONST(UNPACK_LSB_FIRST);
CONST(UNPACK_ROW_LENGTH);
CONST(UNPACK_SKIP_ROWS);
CONST(UNPACK_SKIP_PIXELS);
CONST(UNPACK_ALIGNMENT);
CONST(PACK_SWAP_BYTES);
CONST(PACK_LSB_FIRST);
CONST(PACK_ROW_LENGTH);
CONST(PACK_SKIP_ROWS);
CONST(PACK_SKIP_PIXELS);
CONST(PACK_ALIGNMENT);
CONST(MAP_COLOR);
CONST(MAP_STENCIL);
CONST(INDEX_SHIFT);
CONST(INDEX_OFFSET);
CONST(RED_SCALE);
CONST(RED_BIAS);
CONST(ZOOM_X);
CONST(ZOOM_Y);
CONST(GREEN_SCALE);
CONST(GREEN_BIAS);
CONST(BLUE_SCALE);
CONST(BLUE_BIAS);
CONST(ALPHA_SCALE);
CONST(ALPHA_BIAS);
CONST(DEPTH_SCALE);
CONST(DEPTH_BIAS);
CONST(MAX_EVAL_ORDER);
CONST(MAX_LIGHTS);
CONST(MAX_CLIP_PLANES);
CONST(MAX_TEXTURE_SIZE);
CONST(MAX_PIXEL_MAP_TABLE);
CONST(MAX_ATTRIB_STACK_DEPTH);
CONST(MAX_MODELVIEW_STACK_DEPTH);
CONST(MAX_NAME_STACK_DEPTH);
CONST(MAX_PROJECTION_STACK_DEPTH);
CONST(MAX_TEXTURE_STACK_DEPTH);
CONST(MAX_VIEWPORT_DIMS);
CONST(MAX_CLIENT_ATTRIB_STACK_DEPTH);
CONST(SUBPIXEL_BITS);
CONST(INDEX_BITS);
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
CONST(NAME_STACK_DEPTH);
CONST(AUTO_NORMAL);
CONST(MAP1_COLOR_4);
CONST(MAP1_INDEX);
CONST(MAP1_NORMAL);
CONST(MAP1_TEXTURE_COORD_1);
CONST(MAP1_TEXTURE_COORD_2);
CONST(MAP1_TEXTURE_COORD_3);
CONST(MAP1_TEXTURE_COORD_4);
CONST(MAP1_VERTEX_3);
CONST(MAP1_VERTEX_4);
CONST(MAP2_COLOR_4);
CONST(MAP2_INDEX);
CONST(MAP2_NORMAL);
CONST(MAP2_TEXTURE_COORD_1);
CONST(MAP2_TEXTURE_COORD_2);
CONST(MAP2_TEXTURE_COORD_3);
CONST(MAP2_TEXTURE_COORD_4);
CONST(MAP2_VERTEX_3);
CONST(MAP2_VERTEX_4);
CONST(MAP1_GRID_DOMAIN);
CONST(MAP1_GRID_SEGMENTS);
CONST(MAP2_GRID_DOMAIN);
CONST(MAP2_GRID_SEGMENTS);
CONST(TEXTURE_1D);
CONST(TEXTURE_2D);
CONST(FEEDBACK_BUFFER_POINTER);
CONST(FEEDBACK_BUFFER_SIZE);
CONST(FEEDBACK_BUFFER_TYPE);
CONST(SELECTION_BUFFER_POINTER);
CONST(SELECTION_BUFFER_SIZE);
CONST(TEXTURE_WIDTH);
CONST(TRANSFORM_BIT);
CONST(TEXTURE_HEIGHT);
CONST(TEXTURE_INTERNAL_FORMAT);
CONST(TEXTURE_BORDER_COLOR);
CONST(TEXTURE_BORDER);
CONST(DONT_CARE);
CONST(FASTEST);
CONST(NICEST);
CONST(AMBIENT);
CONST(DIFFUSE);
CONST(SPECULAR);
CONST(POSITION);
CONST(SPOT_DIRECTION);
CONST(SPOT_EXPONENT);
CONST(SPOT_CUTOFF);
CONST(CONSTANT_ATTENUATION);
CONST(LINEAR_ATTENUATION);
CONST(QUADRATIC_ATTENUATION);
CONST(COMPILE);
CONST(COMPILE_AND_EXECUTE);
CONST(BYTE);
CONST(UNSIGNED_BYTE);
CONST(SHORT);
CONST(UNSIGNED_SHORT);
CONST(INT);
CONST(UNSIGNED_INT);
CONST(FLOAT);
CONST(2_BYTES);
CONST(3_BYTES);
CONST(4_BYTES);
CONST(DOUBLE);
CONST(CLEAR);
CONST(AND);
CONST(AND_REVERSE);
CONST(COPY);
CONST(AND_INVERTED);
CONST(NOOP);
CONST(XOR);
CONST(OR);
CONST(NOR);
CONST(EQUIV);
CONST(INVERT);
CONST(OR_REVERSE);
CONST(COPY_INVERTED);
CONST(OR_INVERTED);
CONST(NAND);
CONST(SET);
CONST(EMISSION);
CONST(SHININESS);
CONST(AMBIENT_AND_DIFFUSE);
CONST(COLOR_INDEXES);
CONST(MODELVIEW);
CONST(PROJECTION);
CONST(TEXTURE);
CONST(COLOR);
CONST(DEPTH);
CONST(STENCIL);
CONST(COLOR_INDEX);
CONST(STENCIL_INDEX);
CONST(DEPTH_COMPONENT);
CONST(RED);
CONST(GREEN);
CONST(BLUE);
CONST(ALPHA);
CONST(RGB);
CONST(RGBA);
CONST(LUMINANCE);
CONST(LUMINANCE_ALPHA);
CONST(BITMAP);
CONST(POINT);
CONST(LINE);
CONST(FILL);
CONST(RENDER);
CONST(FEEDBACK);
CONST(SELECT);
CONST(FLAT);
CONST(SMOOTH);
CONST(KEEP);
CONST(REPLACE);
CONST(INCR);
CONST(DECR);
CONST(VENDOR);
CONST(RENDERER);
CONST(VERSION);
CONST(EXTENSIONS);
CONST(S);
CONST(ENABLE_BIT);
CONST(T);
CONST(R);
CONST(Q);
CONST(MODULATE);
CONST(DECAL);
CONST(TEXTURE_ENV_MODE);
CONST(TEXTURE_ENV_COLOR);
CONST(TEXTURE_ENV);
CONST(EYE_LINEAR);
CONST(OBJECT_LINEAR);
CONST(SPHERE_MAP);
CONST(TEXTURE_GEN_MODE);
CONST(OBJECT_PLANE);
CONST(EYE_PLANE);
CONST(NEAREST);
CONST(LINEAR);
CONST(NEAREST_MIPMAP_NEAREST);
CONST(LINEAR_MIPMAP_NEAREST);
CONST(NEAREST_MIPMAP_LINEAR);
CONST(LINEAR_MIPMAP_LINEAR);
CONST(TEXTURE_MAG_FILTER);
CONST(TEXTURE_MIN_FILTER);
CONST(TEXTURE_WRAP_S);
CONST(TEXTURE_WRAP_T);
CONST(CLAMP);
CONST(REPEAT);
CONST(POLYGON_OFFSET_UNITS);
CONST(POLYGON_OFFSET_POINT);
CONST(POLYGON_OFFSET_LINE);
CONST(R3_G3_B2);
CONST(V2F);
CONST(V3F);
CONST(C4UB_V2F);
CONST(C4UB_V3F);
CONST(C3F_V3F);
CONST(N3F_V3F);
CONST(C4F_N3F_V3F);
CONST(T2F_V3F);
CONST(T4F_V4F);
CONST(T2F_C4UB_V3F);
CONST(T2F_C3F_V3F);
CONST(T2F_N3F_V3F);
CONST(T2F_C4F_N3F_V3F);
CONST(T4F_C4F_N3F_V4F);
CONST(CLIP_PLANE0);
CONST(CLIP_PLANE1);
CONST(CLIP_PLANE2);
CONST(CLIP_PLANE3);
CONST(CLIP_PLANE4);
CONST(CLIP_PLANE5);
CONST(LIGHT0);
CONST(COLOR_BUFFER_BIT);
CONST(LIGHT1);
CONST(LIGHT2);
CONST(LIGHT3);
CONST(LIGHT4);
CONST(LIGHT5);
CONST(LIGHT6);
CONST(LIGHT7);
CONST(HINT_BIT);
CONST(POLYGON_OFFSET_FILL);
CONST(POLYGON_OFFSET_FACTOR);
CONST(ALPHA4);
CONST(ALPHA8);
CONST(ALPHA12);
CONST(ALPHA16);
CONST(LUMINANCE4);
CONST(LUMINANCE8);
CONST(LUMINANCE12);
CONST(LUMINANCE16);
CONST(LUMINANCE4_ALPHA4);
CONST(LUMINANCE6_ALPHA2);
CONST(LUMINANCE8_ALPHA8);
CONST(LUMINANCE12_ALPHA4);
CONST(LUMINANCE12_ALPHA12);
CONST(LUMINANCE16_ALPHA16);
CONST(INTENSITY);
CONST(INTENSITY4);
CONST(INTENSITY8);
CONST(INTENSITY12);
CONST(INTENSITY16);
CONST(RGB4);
CONST(RGB5);
CONST(RGB8);
CONST(RGB10);
CONST(RGB12);
CONST(RGB16);
CONST(RGBA2);
CONST(RGBA4);
CONST(RGB5_A1);
CONST(RGBA8);
CONST(RGB10_A2);
CONST(RGBA12);
CONST(RGBA16);
CONST(TEXTURE_RED_SIZE);
CONST(TEXTURE_GREEN_SIZE);
CONST(TEXTURE_BLUE_SIZE);
CONST(TEXTURE_ALPHA_SIZE);
CONST(TEXTURE_LUMINANCE_SIZE);
CONST(TEXTURE_INTENSITY_SIZE);
CONST(PROXY_TEXTURE_1D);
CONST(PROXY_TEXTURE_2D);
CONST(TEXTURE_PRIORITY);
CONST(TEXTURE_RESIDENT);
CONST(TEXTURE_BINDING_1D);
CONST(TEXTURE_BINDING_2D);
CONST(VERTEX_ARRAY);
CONST(NORMAL_ARRAY);
CONST(COLOR_ARRAY);
CONST(INDEX_ARRAY);
CONST(TEXTURE_COORD_ARRAY);
CONST(EDGE_FLAG_ARRAY);
CONST(VERTEX_ARRAY_SIZE);
CONST(VERTEX_ARRAY_TYPE);
CONST(VERTEX_ARRAY_STRIDE);
CONST(NORMAL_ARRAY_TYPE);
CONST(NORMAL_ARRAY_STRIDE);
CONST(COLOR_ARRAY_SIZE);
CONST(COLOR_ARRAY_TYPE);
CONST(COLOR_ARRAY_STRIDE);
CONST(INDEX_ARRAY_TYPE);
CONST(INDEX_ARRAY_STRIDE);
CONST(TEXTURE_COORD_ARRAY_SIZE);
CONST(TEXTURE_COORD_ARRAY_TYPE);
CONST(TEXTURE_COORD_ARRAY_STRIDE);
CONST(EDGE_FLAG_ARRAY_STRIDE);
CONST(VERTEX_ARRAY_POINTER);
CONST(NORMAL_ARRAY_POINTER);
CONST(COLOR_ARRAY_POINTER);
CONST(INDEX_ARRAY_POINTER);
CONST(TEXTURE_COORD_ARRAY_POINTER);
CONST(EDGE_FLAG_ARRAY_POINTER);
CONST(COLOR_INDEX1_EXT);
CONST(COLOR_INDEX2_EXT);
CONST(COLOR_INDEX4_EXT);
CONST(COLOR_INDEX8_EXT);
CONST(COLOR_INDEX12_EXT);
CONST(COLOR_INDEX16_EXT);
CONST(EVAL_BIT);
CONST(LIST_BIT);
CONST(TEXTURE_BIT);
CONST(SCISSOR_BIT);
CONST(ALL_ATTRIB_BITS);
CONST(CLIENT_ALL_ATTRIB_BITS);
// GL_VERSION_1_2 CONSTS
CONST(SMOOTH_POINT_SIZE_RANGE);
CONST(SMOOTH_POINT_SIZE_GRANULARITY);
CONST(SMOOTH_LINE_WIDTH_RANGE);
CONST(SMOOTH_LINE_WIDTH_GRANULARITY);
CONST(UNSIGNED_BYTE_3_3_2);
CONST(UNSIGNED_SHORT_4_4_4_4);
CONST(UNSIGNED_SHORT_5_5_5_1);
CONST(UNSIGNED_INT_8_8_8_8);
CONST(UNSIGNED_INT_10_10_10_2);
CONST(RESCALE_NORMAL);
CONST(TEXTURE_BINDING_3D);
CONST(PACK_SKIP_IMAGES);
CONST(PACK_IMAGE_HEIGHT);
CONST(UNPACK_SKIP_IMAGES);
CONST(UNPACK_IMAGE_HEIGHT);
CONST(TEXTURE_3D);
CONST(PROXY_TEXTURE_3D);
CONST(TEXTURE_DEPTH);
CONST(TEXTURE_WRAP_R);
CONST(MAX_3D_TEXTURE_SIZE);
CONST(BGR);
CONST(BGRA);
CONST(MAX_ELEMENTS_VERTICES);
CONST(MAX_ELEMENTS_INDICES);
CONST(CLAMP_TO_EDGE);
CONST(TEXTURE_MIN_LOD);
CONST(TEXTURE_MAX_LOD);
CONST(TEXTURE_BASE_LEVEL);
CONST(TEXTURE_MAX_LEVEL);
CONST(LIGHT_MODEL_COLOR_CONTROL);
CONST(SINGLE_COLOR);
CONST(SEPARATE_SPECULAR_COLOR);
CONST(UNSIGNED_BYTE_2_3_3_REV);
CONST(UNSIGNED_SHORT_5_6_5);
CONST(UNSIGNED_SHORT_5_6_5_REV);
CONST(UNSIGNED_SHORT_4_4_4_4_REV);
CONST(UNSIGNED_SHORT_1_5_5_5_REV);
CONST(UNSIGNED_INT_8_8_8_8_REV);
CONST(UNSIGNED_INT_2_10_10_10_REV);
CONST(ALIASED_POINT_SIZE_RANGE);
CONST(ALIASED_LINE_WIDTH_RANGE);
// GL_VERSION_1_3 CONSTS
CONST(MULTISAMPLE);
CONST(SAMPLE_ALPHA_TO_COVERAGE);
CONST(SAMPLE_ALPHA_TO_ONE);
CONST(SAMPLE_COVERAGE);
CONST(SAMPLE_BUFFERS);
CONST(SAMPLES);
CONST(SAMPLE_COVERAGE_VALUE);
CONST(SAMPLE_COVERAGE_INVERT);
CONST(CLAMP_TO_BORDER);
CONST(TEXTURE0);
CONST(TEXTURE1);
CONST(TEXTURE2);
CONST(TEXTURE3);
CONST(TEXTURE4);
CONST(TEXTURE5);
CONST(TEXTURE6);
CONST(TEXTURE7);
CONST(TEXTURE8);
CONST(TEXTURE9);
CONST(TEXTURE10);
CONST(TEXTURE11);
CONST(TEXTURE12);
CONST(TEXTURE13);
CONST(TEXTURE14);
CONST(TEXTURE15);
CONST(TEXTURE16);
CONST(TEXTURE17);
CONST(TEXTURE18);
CONST(TEXTURE19);
CONST(TEXTURE20);
CONST(TEXTURE21);
CONST(TEXTURE22);
CONST(TEXTURE23);
CONST(TEXTURE24);
CONST(TEXTURE25);
CONST(TEXTURE26);
CONST(TEXTURE27);
CONST(TEXTURE28);
CONST(TEXTURE29);
CONST(TEXTURE30);
CONST(TEXTURE31);
CONST(ACTIVE_TEXTURE);
CONST(CLIENT_ACTIVE_TEXTURE);
CONST(MAX_TEXTURE_UNITS);
CONST(TRANSPOSE_MODELVIEW_MATRIX);
CONST(TRANSPOSE_PROJECTION_MATRIX);
CONST(TRANSPOSE_TEXTURE_MATRIX);
CONST(TRANSPOSE_COLOR_MATRIX);
CONST(SUBTRACT);
CONST(COMPRESSED_ALPHA);
CONST(COMPRESSED_LUMINANCE);
CONST(COMPRESSED_LUMINANCE_ALPHA);
CONST(COMPRESSED_INTENSITY);
CONST(COMPRESSED_RGB);
CONST(COMPRESSED_RGBA);
CONST(TEXTURE_COMPRESSION_HINT);
CONST(NORMAL_MAP);
CONST(REFLECTION_MAP);
CONST(TEXTURE_CUBE_MAP);
CONST(TEXTURE_BINDING_CUBE_MAP);
CONST(TEXTURE_CUBE_MAP_POSITIVE_X);
CONST(TEXTURE_CUBE_MAP_NEGATIVE_X);
CONST(TEXTURE_CUBE_MAP_POSITIVE_Y);
CONST(TEXTURE_CUBE_MAP_NEGATIVE_Y);
CONST(TEXTURE_CUBE_MAP_POSITIVE_Z);
CONST(TEXTURE_CUBE_MAP_NEGATIVE_Z);
CONST(PROXY_TEXTURE_CUBE_MAP);
CONST(MAX_CUBE_MAP_TEXTURE_SIZE);
CONST(COMBINE);
CONST(COMBINE_RGB);
CONST(COMBINE_ALPHA);
CONST(RGB_SCALE);
CONST(ADD_SIGNED);
CONST(INTERPOLATE);
CONST(CONSTANT);
CONST(PRIMARY_COLOR);
CONST(PREVIOUS);
CONST(SOURCE0_RGB);
CONST(SOURCE1_RGB);
CONST(SOURCE2_RGB);
CONST(SOURCE0_ALPHA);
CONST(SOURCE1_ALPHA);
CONST(SOURCE2_ALPHA);
CONST(OPERAND0_RGB);
CONST(OPERAND1_RGB);
CONST(OPERAND2_RGB);
CONST(OPERAND0_ALPHA);
CONST(OPERAND1_ALPHA);
CONST(OPERAND2_ALPHA);
CONST(TEXTURE_COMPRESSED_IMAGE_SIZE);
CONST(TEXTURE_COMPRESSED);
CONST(NUM_COMPRESSED_TEXTURE_FORMATS);
CONST(COMPRESSED_TEXTURE_FORMATS);
CONST(DOT3_RGB);
CONST(DOT3_RGBA);
CONST(MULTISAMPLE_BIT);
// GL_VERSION_1_4 CONSTS
CONST(BLEND_DST_RGB);
CONST(BLEND_SRC_RGB);
CONST(BLEND_DST_ALPHA);
CONST(BLEND_SRC_ALPHA);
CONST(POINT_SIZE_MIN);
CONST(POINT_SIZE_MAX);
CONST(POINT_FADE_THRESHOLD_SIZE);
CONST(POINT_DISTANCE_ATTENUATION);
CONST(GENERATE_MIPMAP);
CONST(GENERATE_MIPMAP_HINT);
CONST(DEPTH_COMPONENT16);
CONST(DEPTH_COMPONENT24);
CONST(DEPTH_COMPONENT32);
CONST(MIRRORED_REPEAT);
CONST(FOG_COORDINATE_SOURCE);
CONST(FOG_COORDINATE);
CONST(FRAGMENT_DEPTH);
CONST(CURRENT_FOG_COORDINATE);
CONST(FOG_COORDINATE_ARRAY_TYPE);
CONST(FOG_COORDINATE_ARRAY_STRIDE);
CONST(FOG_COORDINATE_ARRAY_POINTER);
CONST(FOG_COORDINATE_ARRAY);
CONST(COLOR_SUM);
CONST(CURRENT_SECONDARY_COLOR);
CONST(SECONDARY_COLOR_ARRAY_SIZE);
CONST(SECONDARY_COLOR_ARRAY_TYPE);
CONST(SECONDARY_COLOR_ARRAY_STRIDE);
CONST(SECONDARY_COLOR_ARRAY_POINTER);
CONST(SECONDARY_COLOR_ARRAY);
CONST(MAX_TEXTURE_LOD_BIAS);
CONST(TEXTURE_FILTER_CONTROL);
CONST(TEXTURE_LOD_BIAS);
CONST(INCR_WRAP);
CONST(DECR_WRAP);
CONST(TEXTURE_DEPTH_SIZE);
CONST(DEPTH_TEXTURE_MODE);
CONST(TEXTURE_COMPARE_MODE);
CONST(TEXTURE_COMPARE_FUNC);
CONST(COMPARE_R_TO_TEXTURE);
// GL_VERSION_1_5 CONSTS
CONST(FOG_COORD_SRC);
CONST(FOG_COORD);
CONST(FOG_COORD_ARRAY);
CONST(SRC0_RGB);
CONST(FOG_COORD_ARRAY_POINTER);
CONST(FOG_COORD_ARRAY_TYPE);
CONST(SRC1_ALPHA);
CONST(CURRENT_FOG_COORD);
CONST(FOG_COORD_ARRAY_STRIDE);
CONST(SRC0_ALPHA);
CONST(SRC1_RGB);
CONST(FOG_COORD_ARRAY_BUFFER_BINDING);
CONST(SRC2_ALPHA);
CONST(SRC2_RGB);
CONST(BUFFER_SIZE);
CONST(BUFFER_USAGE);
CONST(QUERY_COUNTER_BITS);
CONST(CURRENT_QUERY);
CONST(QUERY_RESULT);
CONST(QUERY_RESULT_AVAILABLE);
CONST(ARRAY_BUFFER);
CONST(ELEMENT_ARRAY_BUFFER);
CONST(ARRAY_BUFFER_BINDING);
CONST(ELEMENT_ARRAY_BUFFER_BINDING);
CONST(VERTEX_ARRAY_BUFFER_BINDING);
CONST(NORMAL_ARRAY_BUFFER_BINDING);
CONST(COLOR_ARRAY_BUFFER_BINDING);
CONST(INDEX_ARRAY_BUFFER_BINDING);
CONST(TEXTURE_COORD_ARRAY_BUFFER_BINDING);
CONST(EDGE_FLAG_ARRAY_BUFFER_BINDING);
CONST(SECONDARY_COLOR_ARRAY_BUFFER_BINDING);
CONST(FOG_COORDINATE_ARRAY_BUFFER_BINDING);
CONST(WEIGHT_ARRAY_BUFFER_BINDING);
CONST(VERTEX_ATTRIB_ARRAY_BUFFER_BINDING);
CONST(READ_ONLY);
CONST(WRITE_ONLY);
CONST(READ_WRITE);
CONST(BUFFER_ACCESS);
CONST(BUFFER_MAPPED);
CONST(BUFFER_MAP_POINTER);
CONST(STREAM_DRAW);
CONST(STREAM_READ);
CONST(STREAM_COPY);
CONST(STATIC_DRAW);
CONST(STATIC_READ);
CONST(STATIC_COPY);
CONST(DYNAMIC_DRAW);
CONST(DYNAMIC_READ);
CONST(DYNAMIC_COPY);
CONST(SAMPLES_PASSED);
// GL_VERSION_2_0
CONST(BLEND_EQUATION_RGB);
CONST(VERTEX_ATTRIB_ARRAY_ENABLED);
CONST(VERTEX_ATTRIB_ARRAY_SIZE);
CONST(VERTEX_ATTRIB_ARRAY_STRIDE);
CONST(VERTEX_ATTRIB_ARRAY_TYPE);
CONST(CURRENT_VERTEX_ATTRIB);
CONST(VERTEX_PROGRAM_POINT_SIZE);
CONST(VERTEX_PROGRAM_TWO_SIDE);
CONST(VERTEX_ATTRIB_ARRAY_POINTER);
CONST(STENCIL_BACK_FUNC);
CONST(STENCIL_BACK_FAIL);
CONST(STENCIL_BACK_PASS_DEPTH_FAIL);
CONST(STENCIL_BACK_PASS_DEPTH_PASS);
CONST(MAX_DRAW_BUFFERS);
CONST(DRAW_BUFFER0);
CONST(DRAW_BUFFER1);
CONST(DRAW_BUFFER2);
CONST(DRAW_BUFFER3);
CONST(DRAW_BUFFER4);
CONST(DRAW_BUFFER5);
CONST(DRAW_BUFFER6);
CONST(DRAW_BUFFER7);
CONST(DRAW_BUFFER8);
CONST(DRAW_BUFFER9);
CONST(DRAW_BUFFER10);
CONST(DRAW_BUFFER11);
CONST(DRAW_BUFFER12);
CONST(DRAW_BUFFER13);
CONST(DRAW_BUFFER14);
CONST(DRAW_BUFFER15);
CONST(BLEND_EQUATION_ALPHA);
CONST(POINT_SPRITE);
CONST(COORD_REPLACE);
CONST(MAX_VERTEX_ATTRIBS);
CONST(VERTEX_ATTRIB_ARRAY_NORMALIZED);
CONST(MAX_TEXTURE_COORDS);
CONST(MAX_TEXTURE_IMAGE_UNITS);
CONST(FRAGMENT_SHADER);
CONST(VERTEX_SHADER);
CONST(MAX_FRAGMENT_UNIFORM_COMPONENTS);
CONST(MAX_VERTEX_UNIFORM_COMPONENTS);
CONST(MAX_VARYING_FLOATS);
CONST(MAX_VERTEX_TEXTURE_IMAGE_UNITS);
CONST(MAX_COMBINED_TEXTURE_IMAGE_UNITS);
CONST(SHADER_TYPE);
CONST(FLOAT_VEC2);
CONST(FLOAT_VEC3);
CONST(FLOAT_VEC4);
CONST(INT_VEC2);
CONST(INT_VEC3);
CONST(INT_VEC4);
CONST(BOOL);
CONST(BOOL_VEC2);
CONST(BOOL_VEC3);
CONST(BOOL_VEC4);
CONST(FLOAT_MAT2);
CONST(FLOAT_MAT3);
CONST(FLOAT_MAT4);
CONST(SAMPLER_1D);
CONST(SAMPLER_2D);
CONST(SAMPLER_3D);
CONST(SAMPLER_CUBE);
CONST(SAMPLER_1D_SHADOW);
CONST(SAMPLER_2D_SHADOW);
CONST(DELETE_STATUS);
CONST(COMPILE_STATUS);
CONST(LINK_STATUS);
CONST(VALIDATE_STATUS);
CONST(INFO_LOG_LENGTH);
CONST(ATTACHED_SHADERS);
CONST(ACTIVE_UNIFORMS);
CONST(ACTIVE_UNIFORM_MAX_LENGTH);
CONST(SHADER_SOURCE_LENGTH);
CONST(ACTIVE_ATTRIBUTES);
CONST(ACTIVE_ATTRIBUTE_MAX_LENGTH);
CONST(FRAGMENT_SHADER_DERIVATIVE_HINT);
CONST(SHADING_LANGUAGE_VERSION);
CONST(CURRENT_PROGRAM);
CONST(POINT_SPRITE_COORD_ORIGIN);
CONST(LOWER_LEFT);
CONST(UPPER_LEFT);
CONST(STENCIL_BACK_REF);
CONST(STENCIL_BACK_VALUE_MASK);
CONST(STENCIL_BACK_WRITEMASK);
// GL_VERSION_2_1 CONSTS
CONST(CURRENT_RASTER_SECONDARY_COLOR);
CONST(PIXEL_PACK_BUFFER);
CONST(PIXEL_UNPACK_BUFFER);
CONST(PIXEL_PACK_BUFFER_BINDING);
CONST(PIXEL_UNPACK_BUFFER_BINDING);
CONST(FLOAT_MAT2x3);
CONST(FLOAT_MAT2x4);
CONST(FLOAT_MAT3x2);
CONST(FLOAT_MAT3x4);
CONST(FLOAT_MAT4x2);
CONST(FLOAT_MAT4x3);
CONST(SRGB);
CONST(SRGB8);
CONST(SRGB_ALPHA);
CONST(SRGB8_ALPHA8);
CONST(SLUMINANCE_ALPHA);
CONST(SLUMINANCE8_ALPHA8);
CONST(SLUMINANCE);
CONST(SLUMINANCE8);
CONST(COMPRESSED_SRGB);
CONST(COMPRESSED_SRGB_ALPHA);
CONST(COMPRESSED_SLUMINANCE);
CONST(COMPRESSED_SLUMINANCE_ALPHA);
// GL_VERSION_3_0 CONSTS
CONST(MAX_CLIP_DISTANCES);
CONST(CLIP_DISTANCE5);
CONST(CLIP_DISTANCE1);
CONST(CLIP_DISTANCE3);
CONST(COMPARE_REF_TO_TEXTURE);
CONST(CLIP_DISTANCE0);
CONST(CLIP_DISTANCE4);
CONST(CLIP_DISTANCE2);
CONST(MAX_VARYING_COMPONENTS);
CONST(CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT);
CONST(MAJOR_VERSION);
CONST(MINOR_VERSION);
CONST(NUM_EXTENSIONS);
CONST(CONTEXT_FLAGS);
CONST(DEPTH_BUFFER);
CONST(STENCIL_BUFFER);
CONST(COMPRESSED_RED);
CONST(COMPRESSED_RG);
CONST(RGBA32F);
CONST(RGB32F);
CONST(RGBA16F);
CONST(RGB16F);
CONST(VERTEX_ATTRIB_ARRAY_INTEGER);
CONST(MAX_ARRAY_TEXTURE_LAYERS);
CONST(MIN_PROGRAM_TEXEL_OFFSET);
CONST(MAX_PROGRAM_TEXEL_OFFSET);
CONST(CLAMP_VERTEX_COLOR);
CONST(CLAMP_FRAGMENT_COLOR);
CONST(CLAMP_READ_COLOR);
CONST(FIXED_ONLY);
CONST(TEXTURE_RED_TYPE);
CONST(TEXTURE_GREEN_TYPE);
CONST(TEXTURE_BLUE_TYPE);
CONST(TEXTURE_ALPHA_TYPE);
CONST(TEXTURE_LUMINANCE_TYPE);
CONST(TEXTURE_INTENSITY_TYPE);
CONST(TEXTURE_DEPTH_TYPE);
CONST(UNSIGNED_NORMALIZED);
CONST(TEXTURE_1D_ARRAY);
CONST(PROXY_TEXTURE_1D_ARRAY);
CONST(TEXTURE_2D_ARRAY);
CONST(PROXY_TEXTURE_2D_ARRAY);
CONST(TEXTURE_BINDING_1D_ARRAY);
CONST(TEXTURE_BINDING_2D_ARRAY);
CONST(R11F_G11F_B10F);
CONST(UNSIGNED_INT_10F_11F_11F_REV);
CONST(RGB9_E5);
CONST(UNSIGNED_INT_5_9_9_9_REV);
CONST(TEXTURE_SHARED_SIZE);
CONST(TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH);
CONST(TRANSFORM_FEEDBACK_BUFFER_MODE);
CONST(MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS);
CONST(TRANSFORM_FEEDBACK_VARYINGS);
CONST(TRANSFORM_FEEDBACK_BUFFER_START);
CONST(TRANSFORM_FEEDBACK_BUFFER_SIZE);
CONST(PRIMITIVES_GENERATED);
CONST(TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
CONST(RASTERIZER_DISCARD);
CONST(MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS);
CONST(MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS);
CONST(INTERLEAVED_ATTRIBS);
CONST(SEPARATE_ATTRIBS);
CONST(TRANSFORM_FEEDBACK_BUFFER);
CONST(TRANSFORM_FEEDBACK_BUFFER_BINDING);
CONST(RGBA32UI);
CONST(RGB32UI);
CONST(RGBA16UI);
CONST(RGB16UI);
CONST(RGBA8UI);
CONST(RGB8UI);
CONST(RGBA32I);
CONST(RGB32I);
CONST(RGBA16I);
CONST(RGB16I);
CONST(RGBA8I);
CONST(RGB8I);
CONST(RED_INTEGER);
CONST(GREEN_INTEGER);
CONST(BLUE_INTEGER);
CONST(ALPHA_INTEGER);
CONST(RGB_INTEGER);
CONST(RGBA_INTEGER);
CONST(BGR_INTEGER);
CONST(BGRA_INTEGER);
CONST(SAMPLER_1D_ARRAY);
CONST(SAMPLER_2D_ARRAY);
CONST(SAMPLER_1D_ARRAY_SHADOW);
CONST(SAMPLER_2D_ARRAY_SHADOW);
CONST(SAMPLER_CUBE_SHADOW);
CONST(UNSIGNED_INT_VEC2);
CONST(UNSIGNED_INT_VEC3);
CONST(UNSIGNED_INT_VEC4);
CONST(INT_SAMPLER_1D);
CONST(INT_SAMPLER_2D);
CONST(INT_SAMPLER_3D);
CONST(INT_SAMPLER_CUBE);
CONST(INT_SAMPLER_1D_ARRAY);
CONST(INT_SAMPLER_2D_ARRAY);
CONST(UNSIGNED_INT_SAMPLER_1D);
CONST(UNSIGNED_INT_SAMPLER_2D);
CONST(UNSIGNED_INT_SAMPLER_3D);
CONST(UNSIGNED_INT_SAMPLER_CUBE);
CONST(UNSIGNED_INT_SAMPLER_1D_ARRAY);
CONST(UNSIGNED_INT_SAMPLER_2D_ARRAY);
CONST(QUERY_WAIT);
CONST(QUERY_NO_WAIT);
CONST(QUERY_BY_REGION_WAIT);
CONST(QUERY_BY_REGION_NO_WAIT);
// GL_VERSION_3_1 CONSTS
CONST(TEXTURE_RECTANGLE);
CONST(TEXTURE_BINDING_RECTANGLE);
CONST(PROXY_TEXTURE_RECTANGLE);
CONST(MAX_RECTANGLE_TEXTURE_SIZE);
CONST(SAMPLER_2D_RECT);
CONST(SAMPLER_2D_RECT_SHADOW);
CONST(TEXTURE_BUFFER);
CONST(MAX_TEXTURE_BUFFER_SIZE);
CONST(TEXTURE_BINDING_BUFFER);
CONST(TEXTURE_BUFFER_DATA_STORE_BINDING);
CONST(TEXTURE_BUFFER_FORMAT);
CONST(SAMPLER_BUFFER);
CONST(INT_SAMPLER_2D_RECT);
CONST(INT_SAMPLER_BUFFER);
CONST(UNSIGNED_INT_SAMPLER_2D_RECT);
CONST(UNSIGNED_INT_SAMPLER_BUFFER);
CONST(RED_SNORM);
CONST(RG_SNORM);
CONST(RGB_SNORM);
CONST(RGBA_SNORM);
CONST(R8_SNORM);
CONST(RG8_SNORM);
CONST(RGB8_SNORM);
CONST(RGBA8_SNORM);
CONST(R16_SNORM);
CONST(RG16_SNORM);
CONST(RGB16_SNORM);
CONST(RGBA16_SNORM);
CONST(SIGNED_NORMALIZED);
CONST(PRIMITIVE_RESTART);
CONST(PRIMITIVE_RESTART_INDEX);
CONST(BUFFER_ACCESS_FLAGS);
CONST(BUFFER_MAP_LENGTH);
CONST(BUFFER_MAP_OFFSET);
// GL_VERSION_3_2 CONSTS
CONST(CONTEXT_CORE_PROFILE_BIT);
CONST(CONTEXT_COMPATIBILITY_PROFILE_BIT);
CONST(LINES_ADJACENCY);
CONST(LINE_STRIP_ADJACENCY);
CONST(TRIANGLES_ADJACENCY);
CONST(TRIANGLE_STRIP_ADJACENCY);
CONST(PROGRAM_POINT_SIZE);
CONST(GEOMETRY_VERTICES_OUT);
CONST(GEOMETRY_INPUT_TYPE);
CONST(GEOMETRY_OUTPUT_TYPE);
CONST(MAX_GEOMETRY_TEXTURE_IMAGE_UNITS);
CONST(FRAMEBUFFER_ATTACHMENT_LAYERED);
CONST(FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS);
CONST(GEOMETRY_SHADER);
CONST(MAX_GEOMETRY_UNIFORM_COMPONENTS);
CONST(MAX_GEOMETRY_OUTPUT_VERTICES);
CONST(MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS);
CONST(MAX_VERTEX_OUTPUT_COMPONENTS);
CONST(MAX_GEOMETRY_INPUT_COMPONENTS);
CONST(MAX_GEOMETRY_OUTPUT_COMPONENTS);
CONST(MAX_FRAGMENT_INPUT_COMPONENTS);
CONST(CONTEXT_PROFILE_MASK);
// GL_VERSION_3_3 CONSTS
CONST(VERTEX_ATTRIB_ARRAY_DIVISOR);
CONST(ANY_SAMPLES_PASSED);
CONST(TEXTURE_SWIZZLE_R);
CONST(TEXTURE_SWIZZLE_G);
CONST(TEXTURE_SWIZZLE_B);
CONST(TEXTURE_SWIZZLE_A);
CONST(TEXTURE_SWIZZLE_RGBA);
CONST(RGB10_A2UI);
// GL_VERSION_4_0 CONSTS
CONST(GEOMETRY_SHADER_INVOCATIONS);
CONST(SAMPLE_SHADING);
CONST(MIN_SAMPLE_SHADING_VALUE);
CONST(MAX_GEOMETRY_SHADER_INVOCATIONS);
CONST(MIN_FRAGMENT_INTERPOLATION_OFFSET);
CONST(MAX_FRAGMENT_INTERPOLATION_OFFSET);
CONST(FRAGMENT_INTERPOLATION_OFFSET_BITS);
CONST(MIN_PROGRAM_TEXTURE_GATHER_OFFSET);
CONST(MAX_PROGRAM_TEXTURE_GATHER_OFFSET);
CONST(MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS);
CONST(TEXTURE_CUBE_MAP_ARRAY);
CONST(TEXTURE_BINDING_CUBE_MAP_ARRAY);
CONST(PROXY_TEXTURE_CUBE_MAP_ARRAY);
CONST(SAMPLER_CUBE_MAP_ARRAY);
CONST(SAMPLER_CUBE_MAP_ARRAY_SHADOW);
CONST(INT_SAMPLER_CUBE_MAP_ARRAY);
CONST(UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY);
// ================================================================================================


// ================================================================================================

extern "C" void gl_allocateKinds() {
    k_Sync = alloc_kind();
}
