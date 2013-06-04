package ogl;

import #if cpp cpp #else neko #end.Lib;
import ogl.Macros;
import ogl.GLArray;

import haxe.io.BytesData;

typedef GLbyte     = Int;
typedef GLubyte    = Int;
typedef GLshort    = Int;
typedef GLushort   = Int;
typedef GLint      = Int;
typedef GLuint     = Int;
typedef GLfloat    = Float;
typedef GLdouble   = Float;
typedef GLenum     = Int;
typedef GLbitfield = Int;
typedef GLint64    = haxe.Int64;
typedef GLuint64   = haxe.Int64;
typedef GLsizeiptr = Int;
typedef GLsizei    = Int;
typedef GLintptr   = Int;
typedef GLclampf   = Float;
typedef GLclampd   = Float;
typedef GLboolean  = Bool;

class GLsync extends NativeBinding {
    @:allow(ogl)
    function new(x:Dynamic) super(x);

    @:allow(ogl)
    inline static function cvt(x:Dynamic) return if (x == null) null else new GLsync(x);
}

class GL implements GLConsts implements GLProcs {
    @:allow(ogl)
    static inline function load(n:String, p:Int):Dynamic
        return Lib.load("ogl","hx_gl_"+n, p);


    @:GLProc(glewInit) function init():Void;


    // Haxe specific interfaces.
    @:GLProc function allocBuffer(type:GLenum, count:Int):BytesData {
        return load("allocBuffer", 2)(type, count);
    }
    // TODO: Haxe issue 1667 prevents this working nicely without Dynamic
    @:GLProc function buffer(data:Array<Dynamic>, type:GLenum):BytesData {
        return load("createBuffer", 2)(data, type);
    }

    // ================================================================================================
    // A
    // ================================================================================================
    @:GLProc function activeTexture(texture:GLenum):Void;
    @:GLProc function attachShader(program:GLuint, shader:GLuint):Void;

    // ================================================================================================
    // B
    // ================================================================================================
    @:GLProc function beginConditionalRender(id:GLuint, mode:GLenum):Void;
    @:GLProc function beginQuery(target:GLenum, id:GLuint):Void;
    @:GLProc function beginTransformFeedback(primitiveMode:GLenum):Void;
    @:GLProc function bindAttribLocation(program:GLuint, index:GLuint, name:String):Void;
    @:GLProc function bindBuffer(target:GLenum, buffer:GLuint):Void;
    @:GLProc function bindBufferBase(target:GLenum, index:GLuint, buffer:GLuint):Void;
    @:GLProc function bindBufferRange(target:GLenum, index:GLuint, buffer:GLuint, offset:GLintptr, size:GLsizeiptr):Void;
    @:GLProc function bindFragDataLocation(program:GLuint, colorNumber:GLuint, name:String):Void;
    @:GLProc function bindFragDataLocationIndexed(program:GLuint, colorNumber:GLuint, index:GLuint, name:String):Void;
    @:GLProc function bindFramebuffer(target:GLenum, framebuffer:GLuint):Void;
    @:GLProc function bindRenderbuffer(target:GLenum, renderbuffer:GLuint):Void;
    @:GLProc function bindSampler(target:GLuint, sampler:GLuint):Void;
    @:GLProc function bindTexture(target:GLenum, texture:GLuint):Void;
    @:GLProc function bindVertexArray(array:GLuint):Void;
    @:GLProc function blendColor(red:GLclampf, green:GLclampf, blue:GLclampf, alpha:GLclampf):Void;
    @:GLProc function blendEquation(mode:GLenum):Void;
    @:GLProc function blendEquationSeparate(modeRGB:GLenum, modeAlpha:GLenum):Void;
    @:GLProc function blendFunc(sfactor:GLenum, dfactor:GLenum):Void;
    @:GLProc function blendFuncSeparate(srcRGB:GLenum, dstRGB:GLenum, srcAlpha:GLenum, dstAlpha:GLenum):Void;
    @:GLProc function blitFrameBuffer(srcx0:GLint, srcy0:GLint, srcx1:GLint, srcy1:GLint, dstx0:GLint, dsty0:GLint, dstx1:GLint, dsty1:GLint, mask:GLbitfield, filter:GLenum):Void;
    @:GLProc function bufferData(target:GLenum, data:GLArray, usage:GLenum) {
        load("bufferData", 5)(target, data.size*data.count, data.buffer, data.byteOffset, usage);
    }
    @:GLProc function bufferSubData(target:GLenum, countOffset:Int, data:GLArray) {
        load("bufferSubData", 5)(target, countOffset*data.size, data.count*data.size, data.buffer, data.byteOffset);
    }

    // ================================================================================================
    // C
    // ================================================================================================
    @:GLProc function checkFramebufferStatus(target:GLenum):Void;
    @:GLProc function clampColor(target:GLenum, clamp:GLenum):Void;
    @:GLProc function clear(mask:GLbitfield):Void;
    @:GLProc function clearBufferiv(buffer:GLenum, drawBuffer:GLint, value:Array<GLint>):Void
        load("clearBufferiv", 3)(buffer, drawBuffer, value);
    @:GLProc function clearBufferuiv(buffer:GLenum, drawBuffer:GLint, value:Array<GLuint>):Void
        load("clearBufferuiv", 3)(buffer, drawBuffer, value);
    @:GLProc function clearBufferfv(buffer:GLenum, drawBuffer:GLint, value:GLfloatArray):Void {
        var vals:GLArray = value;
        load("clearBufferfv", 4)(buffer, drawBuffer, value.raw, vals.byteOffset);
    }
    @:GLProc function clearBufferfi(buffer:GLenum, drawBuffer:GLint, depth:GLfloat, stencil:GLint):Void;
    @:GLProc function clearColor(red:GLclampf, green:GLclampf, blue:GLclampf, alpha:GLclampf):Void;
    @:GLProc function clearDepth(depth:GLclampd):Void;
    @:GLProc function clearStencil(stencil:GLint):Void;
    @:GLProc function clientWaitSync(sync:GLsync, flags:GLbitfield, timeout:GLuint64):GLenum
        return load("clientWaitSync", 4)(NativeBinding.native(sync), flags, haxe.Int64.getLow(timeout), haxe.Int64.getHigh(timeout));
    @:GLProc function colorMask(red:GLboolean, green:GLboolean, blue:GLboolean, alpha:GLboolean):Void;
    @:GLProc function colorMaski(buf:GLuint, red:GLboolean, green:GLboolean, blue:GLboolean, alpha:GLboolean):Void;
    @:GLProc function compileShader(shader:GLuint):Void {
        var err:Null<String> = load("compileShader", 1)(shader);
        if (err != null) throw err;
    }
    @:GLProc function compressedTexImage1D(target:GLenum, level:GLint, width:GLsizei, border:GLint, data:GLArray):Void
        load("compressedTexImage1D", 8)(target, level, data.type, width, border, data.buffer.length, data.buffer, data.byteOffset);
    @:GLProc function compressedTexImage2D(target:GLenum, level:GLint, width:GLsizei, height:GLsizei, border:GLint, data:GLArray):Void
        load("compressedTexImage2D", 9)(target, level, data.type, width, height, border, data.buffer.length, data.buffer, data.byteOffset);
    @:GLProc function compressedTexImage3D(target:GLenum, level:GLint, width:GLsizei, height:GLsizei, depth:GLsizei, border:GLint, data:GLArray):Void
        load("compressedTexImage3D", 10)(target, level, data.type, width, height, depth, border, data.buffer.length, data.buffer, data.byteOffset);
    @:GLProc function compressedTexSubImage1D(target:GLenum, level:GLint, xOffset:GLint, width:GLsizei, data:GLArray):Void
        load("compressedTexSubImage1D", 8)(target, level, xOffset, width, data.type, data.buffer.length, data.buffer, data.byteOffset);
    @:GLProc function compressedTexSubImage2D(target:GLenum, level:GLint, xOffset:GLint, yOffset:GLint, width:GLsizei, height:GLsizei, data:GLArray):Void
        load("compressedTexSubImage2D", 10)(target, level, xOffset, yOffset, width, height, data.type, data.buffer.length, data.buffer, data.byteOffset);
    @:GLProc function compressedTexSubImage3D(target:GLenum, level:GLint, xOffset:GLint, yOffset:GLint, zOffset:GLint, width:GLsizei, height:GLsizei, depth:GLsizei, data:GLArray):Void
        load("compressedTexSubImage3D", 12)(target, level, xOffset, yOffset, zOffset, width, height, depth, data.type, data.buffer.length, data.buffer, data.byteOffset);
    @:GLProc function copyBufferSubData(readTarget:GLenum, writeTarget:GLenum, readOffset:GLintptr, writeOffset:GLintptr, size:GLsizeiptr):Void;
    @:GLProc function copyTexImage1D(target:GLenum, level:GLint, internalFormat:GLenum, x:GLint, y:GLint, width:GLsizei, border:GLint):Void;
    @:GLProc function copyTexImage2D(target:GLenum, level:GLint, internalFormat:GLenum, x:GLint, y:GLint, width:GLsizei, height:GLsizei, border:GLint):Void;
    @:GLProc function copyTexSubImage1D(target:GLenum, level:GLint, xOffset:GLint, x:GLint, y:GLint, width:GLsizei):Void;
    @:GLProc function copyTexSubImage2D(target:GLenum, level:GLint, xOffset:GLint, yOffset:GLint, x:GLint, y:GLint, width:GLsizei, height:GLsizei):Void;
    @:GLProc function copyTexSubImage3D(target:GLenum, level:GLint, xOffset:GLint, yOffset:GLint, zOffset:GLint, x:GLint, y:GLint, width:GLsizei, height:GLsizei):Void;
    @:GLProc function createProgram():GLuint;
    @:GLProc function createShader(shaderType:GLenum):GLuint;
    @:GLProc function cullFace(mode:GLenum):Void;

    // ================================================================================================
    // D
    // ================================================================================================
    @:GLProc function deleteBuffers(buffers:Array<GLuint>):Void;
    @:GLProc function deleteFramebuffers(framebuffers:Array<GLuint>):Void;
    @:GLProc function deleteProgram(program:GLuint):Void;
    @:GLProc function deleteQueries(queries:Array<GLuint>):Void;
    @:GLProc function deleteRenderbuffers(renderbuffers:Array<GLuint>):Void;
    @:GLProc function deleteSamplers(samplers:Array<GLuint>):Void;
    @:GLProc function deleteShader(shader:GLuint):Void;
    @:GLProc function deleteSync(sync:GLsync):Void;
    @:GLProc function deleteTextures(textures:Array<GLuint>):Void;
    @:GLProc function deleteVertexArrays(vertexArrays:Array<GLuint>):Void;
    @:GLProc function depthFunc(func:GLenum):Void;
    @:GLProc function depthMask(flag:GLboolean):Void;
    @:GLProc function depthRange(nearVal:GLclampd, farVal:GLclampd):Void;
    @:GLProc function detatchShader(program:GLuint, shader:GLuint):Void;
    @:GLProc function disable(cap:GLenum):Void;
    @:GLProc function disableVertexAttribArray(index:GLuint):Void;
    @:GLProc function disablei(cap:GLenum, index:GLuint):Void;
    @:GLProc function drawArrays(mode:GLenum, first:GLint, count:GLsizei):Void;
    @:GLProc function drawArraysInstanced(mode:GLenum, first:GLint, count:GLsizei, primCount:GLsizei):Void;
    @:GLProc function drawBuffer(mode:GLenum):Void;
    @:GLProc function drawBuffers(bufs:Array<GLenum>):Void;
    @:GLProc function drawElements(mode:GLenum, count:GLsizei, indices:GLArray):Void
        load("drawElements", 5)(mode, count, indices.type, indices.buffer, indices.byteOffset);
    @:GLProc function drawElementsBaseVertex(mode:GLenum, count:GLsizei, indices:GLArray, baseVertex:GLint):Void
        load("drawElementsBaseVertex", 6)(mode, count, indices.type, indices.buffer, indices.byteOffset, baseVertex);
    @:GLProc function drawElementsInstanced(mode:GLenum, count:GLsizei, indices:GLArray, primCount:GLsizei):Void
        load("drawElementsInstanced", 6)(mode, count, indices.type, indices.buffer, indices.byteOffset, primCount);
    @:GLProc function drawElementsInstancedBaseVertex(mode:GLenum, count:GLsizei, indices:GLArray, primCount:GLsizei, baseVertex:GLint):Void
        load("drawElementsInstancedBaseVertex", 7)(mode, count, indices.type, indices.buffer, indices.byteOffset, primCount, baseVertex);
    @:GLProc function drawRangeElements(mode:GLenum, start:GLuint, end:GLuint, count:GLsizei, indices:GLArray):Void
        load("drawRangeElements", 7)(mode, start, end, count, indices.type, indices.buffer, indices.byteOffset);
    @:GLProc function drawRangeElementsBaseVertex(mode:GLenum, start:GLuint, end:GLuint, count:GLsizei, indices:GLArray, baseVertex:GLint):Void
        load("drawRangeElementsBaseVertex", 8)(mode, start, end, count, indices.type, indices.buffer, indices.byteOffset, baseVertex);

    // ================================================================================================
    // E
    // ================================================================================================
    @:GLProc function enable(cap:GLenum):Void;
    @:GLProc function enableVertexAttribArray(index:GLuint):Void;
    @:GLProc function enablei(cap:GLenum, index:GLuint):Void;
    @:GLProc function endConditionalRender():Void;
    @:GLProc function endQuery(target:GLenum):Void;
    @:GLProc function endTransformFeedback():Void;

    // ================================================================================================
    // F
    // ================================================================================================
    @:GLProc function fenceSync(condition:GLenum, flags:GLbitfield):Void;
    @:GLProc function finish():Void;
    @:GLProc function flush():Void;
    @:GLProc function flushMappedBufferRange(target:GLenum, offset:GLintptr, length:GLsizeiptr):Void;
    @:GLProc function framebufferRenderbuffer(target:GLenum, attachment:GLenum, renderbuffertarget:GLenum, renderbuffer:GLuint):Void;
    @:GLProc function framebufferTexture(target:GLenum, attachment:GLenum, texture:GLuint, level:GLint):Void;
    @:GLProc function framebufferTexture1D(target:GLenum, attachment:GLenum, textarget:GLenum, texture:GLuint, level:GLint):Void;
    @:GLProc function framebufferTexture2D(target:GLenum, attachment:GLenum, textarget:GLenum, texture:GLuint, level:GLint):Void;
    @:GLProc function framebufferTexture3D(target:GLenum, attachment:GLenum, textarget:GLenum, texture:GLuint, level:GLint, layer:GLint):Void;
    @:GLProc function framebufferTextureLayer(target:GLenum, attachment:GLenum, texture:GLuint, level:GLint, layer:GLint):Void;
    @:GLProc function frontFace(mode:GLenum):Void;

    // ================================================================================================
    // G
    // ================================================================================================
    @:GLProc function genBuffers(n:GLsizei):Array<GLuint> {
        var buffers:Array<GLuint> = [];
        load("genBuffers", 2)(n, buffers);
        return buffers;
    }
    @:GLProc function genFramebuffers(n:GLsizei):Array<GLuint> {
        var buffers:Array<GLuint> = [];
        load("genFramebuffers", 2)(n, buffers);
        return buffers;
    }
    @:GLProc function genQueries(n:GLsizei):Array<GLuint> {
        var queries:Array<GLuint> = [];
        load("genQueries", 2)(n, queries);
        return queries;
    }
    @:GLProc function genRenderbuffers(n:GLsizei):Array<GLuint> {
        var buffers:Array<GLuint> = [];
        load("genRenderbuffers", 2)(n, buffers);
        return buffers;
    }
    @:GLProc function genSamplers(n:GLsizei):Array<GLuint> {
        var samplers:Array<GLuint> = [];
        load("genSamplers", 2)(n, samplers);
        return samplers;
    }
    @:GLProc function genTextures(n:GLsizei):Array<GLuint> {
        var textures:Array<GLuint> = [];
        load("genTextures", 2)(n, textures);
        return textures;
    }
    @:GLProc function genVertexArrays(n:GLsizei):Array<GLuint> {
        var arrays:Array<GLuint> = [];
        load("genVertexArrays", 2)(n, arrays);
        return arrays;
    }
    @:GLProc function generateMipmap(target:GLenum):Void;
    @:GLProc function getBooleanv(pname:GLenum):Array<GLboolean> {
        var ret:Array<GLboolean> = [];
        load("getBooleanv", 2)(pname, ret);
        return ret;
    }
    @:GLProc function getDoublev(pname:GLenum):Array<GLdouble> {
        var ret:Array<GLdouble> = [];
        load("getDoublev", 2)(pname, ret);
        return ret;
    }
    @:GLProc function getFloatv(pname:GLenum):Array<GLfloat> {
        var ret:Array<GLfloat> = [];
        load("getFloatv", 2)(pname, ret);
        return ret;
    }
    @:GLProc function getIntegerv(pname:GLenum):Array<GLint> {
        var ret:Array<GLint> = [];
        load("getIntegerv", 2)(pname, ret);
        return ret;
    }
    @:GLProc function getInteger64v(pname:GLenum):Array<GLint64> {
        var ret:Array<GLint64> = [];
        var vals:Array<GLint> = [];
        load("getInteger64v", 2)(pname, vals);
        for (i in 0...(vals.length>>1)) ret[i] = GLint64.make(vals[i*2+1], vals[i*2]);
        return ret;
    }
    @:GLProc function getBooleani_v(pname:GLenum, index:GLuint):Array<GLboolean> {
        var ret:Array<GLboolean> = [];
        load("getBooleani_v", 3)(pname, index, ret);
        return ret;
    }
    @:GLProc function getIntegeri_v(pname:GLenum, index:GLuint):Array<GLint> {
        var ret:Array<GLint> = [];
        load("getIntegeri_v", 3)(pname, index, ret);
        return ret;
    }
    @:GLProc function getInteger64i_v(pname:GLenum, index:GLuint):Array<GLint64> {
        var ret:Array<GLint64> = [];
        var vals:Array<GLint> = [];
        load("getInteger64i_v", 3)(pname, index, vals);
        for (i in 0...(vals.length>>1)) ret[i] = GLint64.make(vals[i*2+1], vals[i*2]);
        return ret;
    }
    @:GLProc function getActiveAttrib(program:GLuint, index:GLuint):{name:String, size:GLint, type:GLenum}
        return load("getActiveAttrib", 2)(program, index);
    @:GLProc function getActiveUniform(program:GLuint, index:GLuint):{name:String, size:GLint, type:GLenum}
        return load("getActiveUniform", 2)(program, index);
    @:GLProc function getActiveUniformBlockiv(program:GLuint, uniformBlockIndex:GLuint, pname:GLenum):GLint;
    @:GLProc function getActiveUniformBlockName(program:GLuint, uniformBlockIndex:GLuint):String;
    @:GLProc function getActiveUniformName(program:GLuint, uniformIndex:GLuint):String;
    @:GLProc function getActiveUniformsiv(program:GLuint, uniformIndices:Array<GLuint>, pname:GLenum):Array<GLint> {
        var ret:Array<GLint> = [];
        load("getActiveUniformsiv", 4)(program, uniformIndices, pname, ret);
        return ret;
    }
    @:GLProc function getAttachedShaders(program:GLuint):Array<GLuint> {
        var ret:Array<GLuint> = [];
        load("getAttachedShaders", 2)(program, ret);
        return ret;
    }
    @:GLProc function getBufferParameteriv(target:GLenum, value:GLenum):GLint;
    @:GLProc function getBufferSubData(target:GLenum, offset:GLintptr, size:GLsizeiptr, data:GLArray):Void
        load("getBufferSubData", 5)(target, offset, size, data.buffer, data.byteOffset);
    @:GLProc function getCompressedTexImage(target:GLenum, lod:GLint, img:GLArray):Void
        load("getCompressedTexImage", 4)(target, lod, img.buffer, img.byteOffset);
    @:GLProc function getError():GLenum;
    @:GLProc function getFragDataIndex(program:GLuint, name:String):GLint;
    @:GLProc function getFragDataLocation(program:GLuint, name:String):GLint;
    @:GLProc function getFramebufferAttachmentParameteriv(target:GLenum, attachment:GLenum, pname:GLenum):GLint;
    @:GLProc function getMultisamplefv(pname:GLenum, index:GLuint):{x:GLfloat, y:GLfloat}
        return load("getMultisamplefv", 2)(pname, index);
    @:GLProc function getProgramiv(program:GLuint, pname:GLenum):GLint;
    @:GLProc function getQueryObjectiv(program:GLuint, pname:GLenum):GLint;
    @:GLProc function getQueryObjectuiv(program:GLuint, pname:GLenum):GLuint;
    @:GLProc function getQueryObjecti64v(program:GLuint, pname:GLenum):GLint64 {
        var ret:Array<Int> = [0,0];
        load("getQueryObjecti64v", 3)(program, pname, ret);
        return GLint64.make(ret[1], ret[0]);
    }
    @:GLProc function getQueryObjectui64v(program:GLuint, pname:GLenum):GLuint64 {
        var ret:Array<Int> = [0,0];
        load("getQueryObjectui64v", 3)(program, pname, ret);
        return GLuint64.make(ret[1], ret[0]);
    }
    @:GLProc function getQueryiv(program:GLuint, pname:GLenum):GLint;
    @:GLProc function getRenderbufferParameteriv(target:GLenum, pname:GLenum):GLint;
    @:GLProc function getSamplerParameterfv(sampler:GLuint, pname:GLenum):Array<GLfloat>
        return load("getSamplerParameterfv", 3)(sampler, pname, []);
    @:GLProc function getSamplerParameteriv(sampler:GLuint, pname:GLenum):Array<GLint>
        return load("getSamplerParameteriv", 3)(sampler, pname, []);
    @:GLProc function getSamplerParameterIiv(sampler:GLuint, pname:GLenum):Array<GLint>
        return load("getSamplerParameterIiv", 3)(sampler, pname, []);
    @:GLProc function getSamplerParameterIuiv(sampler:GLuint, pname:GLenum):Array<GLuint>
        return load("getSamplerParameterIuiv", 3)(sampler, pname, []);
    @:GLProc function getShaderiv(shader:GLuint, pname:GLenum):GLint;
    @:GLProc function getShaderSource(shader:GLuint):String;
    @:GLProc function getString(name:GLenum):String;
    @:GLProc function getStringi(name:GLenum, index:GLuint):String;
    @:GLProc function getSynciv(sync:GLsync, pname:GLenum):GLint;
    @:GLProc function getTexImage(target:GLenum, level:GLint, format:GLenum, img:GLArray):Void
        load("getTexImage", 6)(target, level, format, img.type, img.buffer, img.byteOffset);
    @:GLProc function getTexLevelParameterfv(target:GLenum, level:GLint, pname:GLenum):GLfloat;
    @:GLProc function getTexLevelParameteriv(target:GLenum, level:GLint, pname:GLenum):GLint;
    @:GLProc function getTexParameterfv(target:GLenum, pname:GLenum):Array<GLfloat>
        return load("getTexParameterfv", 3)(target, pname, []);
    @:GLProc function getTexParameteriv(target:GLenum, pname:GLenum):Array<GLint>
        return load("getTexParameteriv", 3)(target, pname, []);
    @:GLProc function getTexParameterIiv(target:GLenum, pname:GLenum):Array<GLint>
        return load("getTexParameterIiv", 3)(target, pname, []);
    @:GLProc function getTexParameterIuiv(target:GLenum, pname:GLenum):Array<GLuint>
        return load("getTexParameterIuiv", 3)(target, pname, []);
    @:GLProc function getTransformFeedbackVarying(program:GLuint, index:GLuint):{name:String, size:GLsizei, type:GLenum}
        return load("getTransformFeedbackVarying", 2)(program, index);
    @:GLProc function getUniformParameterfv(program:GLuint, location:GLint):Array<GLfloat> {
        var vals = []; for (i in 0...16) vals[i] = Math.NaN;
        load("getUniformParameterfv", 3)(program, location, vals);
        while (Math.isNaN(vals[vals.length-1])) vals.pop();
        return vals;
    }
    @:GLProc function getUniformParameteriv(program:GLuint, location:GLint):Array<GLint> {
        var vals = []; for (i in 0...16) vals[i] = 0xfedcba98;
        load("getUniformParameteriv", 3)(program, location, vals);
        while (vals[vals.length-1] == 0xfedcba98) vals.pop();
        return vals;
    }
    @:GLProc function getUniformParameteruiv(program:GLuint, location:GLint):Array<GLuint> {
        var vals = []; for (i in 0...16) vals[i] = 0xfedcba98;
        load("getUniformParameteruiv", 3)(program, location, vals);
        while (vals[vals.length-1] == 0xfedcba98) vals.pop();
        return vals;
    }
    @:GLProc function getUniformBlockIndex(program:GLuint, uniformBlockName:String):GLuint;
    @:GLProc function getUniformIndices(program:GLuint, uniformNames:Array<String>):Array<GLuint>
        return load("getUniformIndices", 3)(program, uniformNames, []);
    @:GLProc function getUniformLocation(program:GLuint, name:String):GLint;
    @:GLProc function getVertexAttribfv(index:GLuint, pname:GLenum):Array<GLfloat>
        return load("getVertexAttribfv", 3)(index, pname, []);
    @:GLProc function getVertexAttribdv(index:GLuint, pname:GLenum):Array<GLdouble>
        return load("getVertexAttribdv", 3)(index, pname, []);
    @:GLProc function getVertexAttribiv(index:GLuint, pname:GLenum):Array<GLint>
        return load("getVertexAttribiv", 3)(index, pname, []);
    @:GLProc function getVertexAttribIiv(index:GLuint, pname:GLenum):Array<GLint>
        return load("getVertexAttribIiv", 3)(index, pname, []);
    @:GLProc function getVertexAttribIuiv(index:GLuint, pname:GLenum):Array<GLuint>
        return load("getVertexAttribIuiv", 3)(index, pname, []);

    // ================================================================================================
    // H
    // ================================================================================================
    @:GLProc function hint(target:GLenum, mode:GLenum):Void;

    // ================================================================================================
    // I
    // ================================================================================================
    @:GLProc function isBuffer(buffer:GLuint):GLboolean;
    @:GLProc function isEnabled(cap:GLenum):GLboolean;
    @:GLProc function isEnabledi(cap:GLenum, index:GLuint):GLboolean;
    @:GLProc function isFramebuffer(framebuffer:GLuint):GLboolean;
    @:GLProc function isProgram(program:GLuint):GLboolean;
    @:GLProc function isQuery(id:GLuint):GLboolean;
    @:GLProc function isRenderbuffer(renderbuffer:GLuint):GLboolean;
    @:GLProc function isSampler(id:GLuint):GLboolean;
    @:GLProc function isShader(shader:GLuint):GLboolean;
    @:GLProc function isSync(sync:GLsync):GLboolean;
    @:GLProc function isTexture(texture:GLuint):GLboolean;
    @:GLProc function isVertexArray(array:GLuint):GLboolean;

    // ================================================================================================
    // L
    // ================================================================================================
    @:GLProc function lineWidth(width:Float):Void;
    @:GLProc function linkProgram(program:Int):Void {
        var err:Null<String> = load("linkProgram", 1)(program);
        if (err != null) throw err;
    }
    @:GLProc function logicOp(opcode:GLenum):Void;

    // ================================================================================================
    // M
    // ================================================================================================
    @:GLProc function multiDrawArrays(mode:GLenum, first:Array<GLint>, count:Array<GLsizei>):Void {
        @:GLCheck if (first.length == 0) throw "Cannot draw 0 arrays";
        @:GLCheck if (first.length != count.length) throw "First and Count should have equal sizes";
        load("multiDrawArrays", 3)(mode, first, count);
    }
    @:GLProc function multiDrawElements(mode:GLenum, count:Array<GLsizei>, indices:Array<GLArray>):Void {
        @:GLCheck if (count.length == 0) throw "Cannot draw 0 elements";
        @:GLCheck if (count.length != indices.length) throw "Count and Indices should have equal sizes";
        @:GLCheck if (!({
            var same = true;
            var type = indices[0].type;
            for (i in 1...indices.length) {
                if (indices[i].type != type) {
                    same = false;
                    break;
                }
            }
            same;
        })) throw "Indices arrays must all be of the same GL type";
        var cindices = [];
        var coffsets = [];
        for (i in indices) {
            cindices.push(i.buffer);
            coffsets.push(i.byteOffset);
        }
        load("multiDrawElements", 5)(mode, count, indices[0].type, cindices, coffsets);
    }
    @:GLProc function multiDrawElementsBaseVertex(mode:GLenum, count:Array<GLsizei>, indices:Array<GLArray>, baseVertex:Array<GLint>):Void {
        @:GLCheck if (count.length == 0) throw "Cannot draw 0 elements";
        @:GLCheck if (count.length != indices.length || count.length != baseVertex.length) throw "Count, Indices and BaseVertex should have equal sizes";
        @:GLCheck if (!({
            var same = true;
            var type = indices[0].type;
            for (i in 1...indices.length) {
                if (indices[i].type != type) {
                    same = false;
                    break;
                }
            }
            same;
        })) throw "Indices arrays must all be of the same GL type";
        var cindices = [];
        var coffsets = [];
        for (i in indices) {
            cindices.push(i.buffer);
            coffsets.push(i.byteOffset);
        }
        load("multiDrawElementsBaseVertex", 6)(mode, count, indices[0].type, cindices, coffsets, baseVertex);
    }

    // ================================================================================================
    // P
    // ================================================================================================
    @:GLProc function pixelStoref(pname:GLenum, param:GLfloat):Void;
    @:GLProc function pixelStorei(pname:GLenum, param:GLint):Void;
    @:GLProc function pointParameterf(pname:GLenum, param:GLfloat):Void;
    @:GLProc function pointParameteri(pname:GLenum, param:GLint):Void;
    @:GLProc function pointSize(size:GLfloat):Void;
    @:GLProc function polygonMode(face:GLenum, mode:GLenum):Void;
    @:GLProc function polygonOffset(factor:GLfloat, units:GLfloat):Void;
    @:GLProc function primitiveRestartIndex(index:GLuint):Void;
    @:GLProc function provokingVertex(provokeMode:GLenum):Void;

    // ================================================================================================
    // Q
    // ================================================================================================
    @:GLProc function queryCounter(id:GLuint, target:GLenum):Void;

    // ================================================================================================
    // R
    // ================================================================================================
    @:GLProc function readBuffer(mode:GLenum):Void;
    @:GLProc function readPixels(x:GLint, y:GLint, width:GLsizei, height:GLsizei, format:GLenum, data:GLArray):Void
        load("readPixels", 8)(x, y, width, height, format, data.type, data.buffer, data.byteOffset);
    @:GLProc function renderbufferStorage(target:GLenum, internalFormat:GLenum, width:GLsizei, height:GLsizei):Void;
    @:GLProc function renderbufferStorageMultisample(target:GLenum, samples:GLsizei, internalFormat:GLenum, width:GLsizei, height:GLsizei):Void;

    // ================================================================================================
    // S
    // ================================================================================================
    @:GLProc function sampleCoverage(value:GLclampf, invert:GLboolean):Void;
    @:GLProc function sampleMaski(maskNumber:GLuint, mask:GLbitfield):Void;
    @:GLProc function samplerParameterf(sampler:GLuint, pname:GLenum, param:GLfloat):Void;
    @:GLProc function samplerParameteri(sampler:GLuint, pname:GLenum, param:GLint):Void;
    @:GLProc function scissor(x:GLint, y:GLint, width:GLsizei, height:GLsizei):Void;
    @:GLProc function stencilFunc(func:GLenum, ref:GLint, mask:GLuint):Void;
    @:GLProc function stencilFuncSeparate(face:GLenum, func:GLenum, ref:GLint, mask:GLuint):Void;
    @:GLProc function stencilMask(mask:GLuint):Void;
    @:GLProc function stencilMaskSeparate(face:GLenum, mask:GLuint):Void;
    @:GLProc function stencilOp(sfail:GLenum, dpfail:GLenum, dppass:GLenum):Void;
    @:GLProc function stencilOpSeparate(face:GLenum, sfail:GLenum, dpfail:GLenum, dppass:GLenum):Void;
    @:GLProc function shaderSource(shader:GLuint, source:String):Void {
        load("shaderSource", 2)(shader, [source]);
    }

    // ================================================================================================
    // T
    // ================================================================================================
    @:GLProc function texBuffer(target:GLenum, internalFormat:GLenum, buffer:GLuint):Void;
    @:GLProc function texImage1D(target:GLenum, level:GLint, internalFormat:GLint, width:GLsizei, border:GLint, format:GLint, data:Null<GLArray>):Void
        load("texImage1D", 9)(target, level, internalFormat, width, border, format, data==null?GL.INT:data.type, data==null?null:data.buffer, data==null?-1:data.byteOffset);
    @:GLProc function texImage2D(target:GLenum, level:GLint, internalFormat:GLint, width:GLsizei, height:GLsizei, border:GLint, format:GLint, data:Null<GLArray>):Void
        load("texImage2D", 10)(target, level, internalFormat, width, height, border, format, data==null?GL.INT:data.type, data==null?null:data.buffer, data==null?-1:data.byteOffset);
    @:GLProc function texImage2DMultisample(target:GLenum, samples:GLsizei, internalFormat:GLint, width:GLsizei, height:GLsizei, fixedsamplelocations:GLboolean):Void;
    @:GLProc function texImage3D(target:GLenum, level:GLint, internalFormat:GLint, width:GLsizei, height:GLsizei, depth:GLsizei, border:GLint, format:GLint, data:Null<GLArray>):Void
        load("texImage3D", 11)(target, level, internalFormat, width, height, depth, border, format, data==null?GL.INT:data.type, data==null?null:data.buffer, data==null?-1:data.byteOffset);
    @:GLProc function texImage3DMultisample(target:GLenum, samples:GLsizei, internalFormat:GLint, width:GLsizei, height:GLsizei, depth:GLsizei, fixedsamplelocations:GLboolean):Void;
    @:GLProc function texParameterf(target:GLenum, pname:GLenum, param:GLfloat):Void;
    @:GLProc function texParameteri(target:GLenum, pname:GLenum, param:GLint):Void;
    @:GLProc function texSubImage1D(target:GLenum, level:GLint, xOffset:GLint, width:GLsizei, format:GLenum, data:GLArray):Void
        load("texSubImage1D", 8)(target, level, xOffset, width, format, data.type, data.buffer, data.byteOffset);
    @:GLProc function texSubImage2D(target:GLenum, level:GLint, xOffset:GLint, yOffset:GLint, width:GLsizei, height:GLsizei, format:GLenum, data:GLArray):Void
        load("texSubImage2D", 10)(target, level, xOffset, yOffset, width, height, format, data.type, data.buffer, data.byteOffset);
    @:GLProc function texSubImage3D(target:GLenum, level:GLint, xOffset:GLint, yOffset:GLint, zOffset:GLint, width:GLsizei, height:GLsizei, depth:GLsizei, format:GLenum, data:GLArray):Void
        load("texSubImage3D", 12)(target, level, xOffset, yOffset, zOffset, width, height, depth, format, data.type, data.buffer, data.byteOffset);
    @:GLProc function transformFeedbackVaryings(program:GLuint, varyings:Array<String>, bufferMode:GLenum):Void;

    // ================================================================================================
    // U
    // ================================================================================================
    @:GLProc function uniform1f (location:GLint, v0:GLfloat):Void;
    @:GLProc function uniform1i (location:GLint, v0:GLint  ):Void;
    @:GLProc function uniform1ui(location:GLint, v0:GLuint ):Void;
    @:GLProc function uniform2f (location:GLint, v0:GLfloat, v1:GLfloat):Void;
    @:GLProc function uniform2i (location:GLint, v0:GLint  , v1:GLint  ):Void;
    @:GLProc function uniform2ui(location:GLint, v0:GLuint , v1:GLuint ):Void;
    @:GLProc function uniform3f (location:GLint, v0:GLfloat, v1:GLfloat, v2:GLfloat):Void;
    @:GLProc function uniform3i (location:GLint, v0:GLint  , v1:GLint  , v2:GLint  ):Void;
    @:GLProc function uniform3ui(location:GLint, v0:GLuint , v1:GLuint , v2:GLuint ):Void;
    @:GLProc function uniform4f (location:GLint, v0:GLfloat, v1:GLfloat, v2:GLfloat, v3:GLfloat):Void;
    @:GLProc function uniform4i (location:GLint, v0:GLint  , v1:GLint  , v2:GLint  , v3:GLint  ):Void;
    @:GLProc function uniform4ui(location:GLint, v0:GLuint , v1:GLuint , v2:GLuint , v3:GLuint ):Void;

    @:GLProc function uniform1fv(location:GLint, data:GLfloatArray):Void {
        var dat:GLArray = data;
        load("uniform1fv", 4)(location, data.count, data.raw, dat.byteOffset);
    }
    @:GLProc function uniform2fv(location:GLint, data:GLfloatArray):Void {
        @:GLCheck if (data.count%2 != 0) throw "Data should have length as multiple of 2";
        var dat:GLArray = data;
        load("uniform2fv", 4)(location, data.count, data.raw, dat.byteOffset);
    }
    @:GLProc function uniform3fv(location:GLint, data:GLfloatArray):Void {
        @:GLCheck if (data.count%3 != 0) throw "Data should have length as multiple of 3";
        var dat:GLArray = data;
        load("uniform3fv", 4)(location, data.count, data.raw, dat.byteOffset);
    }
    @:GLProc function uniform4fv(location:GLint, data:GLfloatArray):Void {
        @:GLCheck if (data.count%4 != 0) throw "Data should have length as multiple of 4";
        var dat:GLArray = data;
        load("uniform4fv", 4)(location, data.count, data.raw, dat.byteOffset);
    }

    @:GLProc function uniform1iv(location:GLint, data:Array<GLint>):Void;
    @:GLProc function uniform2iv(location:GLint, data:Array<GLint>):Void {
        @:GLCheck if (data.length%2 != 0) throw "Data should have length as multiple of 2";
        load("uniform2iv", 2)(location, data);
    }
    @:GLProc function uniform3iv(location:GLint, data:Array<GLint>):Void {
        @:GLCheck if (data.length%3 != 0) throw "Data should have length as multiple of 3";
        load("uniform3iv", 3)(location, data);
    }
    @:GLProc function uniform4iv(location:GLint, data:Array<GLint>):Void {
        @:GLCheck if (data.length%4 != 0) throw "Data should have length as multiple of 4";
        load("uniform4iv", 4)(location, data);
    }

    @:GLProc function uniform1uiv(location:GLint, data:Array<GLuint>):Void;
    @:GLProc function uniform2uiv(location:GLint, data:Array<GLint>):Void {
        @:GLCheck if (data.length%2 != 0) throw "Data should have length as multiple of 2";
        load("uniform2uiv", 2)(location, data);
    }
    @:GLProc function uniform3uiv(location:GLint, data:Array<GLint>):Void {
        @:GLCheck if (data.length%3 != 0) throw "Data should have length as multiple of 3";
        load("uniform3uiv", 3)(location, data);
    }
    @:GLProc function uniform4uiv(location:GLint, data:Array<GLint>):Void {
        @:GLCheck if (data.length%4 != 0) throw "Data should have length as multiple of 4";
        load("uniform4uiv", 4)(location, data);
    }

    @:GLProc function uniformMatrix2fv(location:GLint, transpose:GLboolean, data:GLfloatArray):Void {
        @:GLCheck if (data.count%4 != 0) throw "Data should have size multiple of 4";
        var dat:GLArray = data;
        load("uniformMatrix2fv", 5)(location, data.count, transpose, data.raw, dat.byteOffset);
    }
    @:GLProc function uniformMatrix3fv(location:GLint, transpose:GLboolean, data:GLfloatArray):Void {
        @:GLCheck if (data.count%9 != 0) throw "Data should have size multiple of 9";
        var dat:GLArray = data;
        load("uniformMatrix3fv", 5)(location, data.count, transpose, data.raw, dat.byteOffset);
    }
    @:GLProc function uniformMatrix4fv(location:GLint, transpose:GLboolean, data:GLfloatArray):Void {
        @:GLCheck if (data.count%16 != 0) throw "Data should have size multiple of 16";
        var dat:GLArray = data;
        load("uniformMatrix4fv", 5)(location, data.count, transpose, data.raw, dat.byteOffset);
    }
    @:GLProc function uniformMatrix2x3fv(location:GLint, transpose:GLboolean, data:GLfloatArray):Void {
        @:GLCheck if (data.count%6 != 0) throw "Data should have size multiple of 6";
        var dat:GLArray = data;
        load("uniformMatrix2x3fv", 5)(location, data.count, transpose, data.raw, dat.byteOffset);
    }
    @:GLProc function uniformMatrix3x2fv(location:GLint, transpose:GLboolean, data:GLfloatArray):Void {
        @:GLCheck if (data.count%6 != 0) throw "Data should have size multiple of 6";
        var dat:GLArray = data;
        load("uniformMatrix3x2fv", 5)(location, data.count, transpose, data.raw, dat.byteOffset);
    }
    @:GLProc function uniformMatrix2x4fv(location:GLint, transpose:GLboolean, data:GLfloatArray):Void {
        @:GLCheck if (data.count%8 != 0) throw "Data should have size multiple of 8";
        var dat:GLArray = data;
        load("uniformMatrix2x4fv", 5)(location, data.count, transpose, data.raw, dat.byteOffset);
    }
    @:GLProc function uniformMatrix4x2fv(location:GLint, transpose:GLboolean, data:GLfloatArray):Void {
        @:GLCheck if (data.count%8 != 0) throw "Data should have size multiple of 8";
        var dat:GLArray = data;
        load("uniformMatrix4x2fv", 5)(location, data.count, transpose, data.raw, dat.byteOffset);
    }
    @:GLProc function uniformMatrix3x4fv(location:GLint, transpose:GLboolean, data:GLfloatArray):Void {
        @:GLCheck if (data.count%12 != 0) throw "Data should have size multiple of 12";
        var dat:GLArray = data;
        load("uniformMatrix3x4fv", 5)(location, data.count, transpose, data.raw, dat.byteOffset);
    }
    @:GLProc function uniformMatrix4x3fv(location:GLint, transpose:GLboolean, data:GLfloatArray):Void {
        @:GLCheck if (data.count%12 != 0) throw "Data should have size multiple of 12";
        var dat:GLArray = data;
        load("uniformMatrix4x3fv", 5)(location, data.count, transpose, data.raw, dat.byteOffset);
    }

    @:GLProc function uniformBlockBinding(program:GLuint, uniformBlockIndex:GLuint, uniformBlockBinding:GLuint):Void;
    @:GLProc function useProgram(program:GLuint):Void;

    // ================================================================================================
    // V
    // ================================================================================================
    @:GLProc function validateProgram(program:GLuint):Void {
        var err:Null<String> = load("validateProgram", 1)(program);
        if (err != null) throw err;
    }
    @:GLProc function vertexAttrib1f   (index:GLuint, v0:GLfloat ):Void;
    @:GLProc function vertexAttrib1s   (index:GLuint, v0:GLshort ):Void;
    @:GLProc function vertexAttrib1d   (index:GLuint, v0:GLdouble):Void;
    @:GLProc function vertexAttribI1i  (index:GLuint, v0:GLint   ):Void;
    @:GLProc function vertexAttribI1ui (index:GLuint, v0:GLuint  ):Void;
    @:GLProc function vertexAttrib2f   (index:GLuint, v0:GLfloat , v1:GLfloat ):Void;
    @:GLProc function vertexAttrib2s   (index:GLuint, v0:GLshort , v1:GLshort ):Void;
    @:GLProc function vertexAttrib2d   (index:GLuint, v0:GLdouble, v1:GLdouble):Void;
    @:GLProc function vertexAttribI2i  (index:GLuint, v0:GLint   , v1:GLint   ):Void;
    @:GLProc function vertexAttribI2ui (index:GLuint, v0:GLuint  , v1:GLuint  ):Void;
    @:GLProc function vertexAttrib3f   (index:GLuint, v0:GLfloat , v1:GLfloat , v2:GLfloat ):Void;
    @:GLProc function vertexAttrib3s   (index:GLuint, v0:GLshort , v1:GLshort , v2:GLshort ):Void;
    @:GLProc function vertexAttrib3d   (index:GLuint, v0:GLdouble, v1:GLdouble, v2:GLdouble):Void;
    @:GLProc function vertexAttribI3i  (index:GLuint, v0:GLint   , v1:GLint   , v2:GLint   ):Void;
    @:GLProc function vertexAttribI3ui (index:GLuint, v0:GLuint  , v1:GLuint  , v2:GLuint  ):Void;
    @:GLProc function vertexAttrib4f   (index:GLuint, v0:GLfloat , v1:GLfloat , v2:GLfloat , v3:GLfloat ):Void;
    @:GLProc function vertexAttrib4s   (index:GLuint, v0:GLshort , v1:GLshort , v2:GLshort , v3:GLshort ):Void;
    @:GLProc function vertexAttrib4d   (index:GLuint, v0:GLdouble, v1:GLdouble, v2:GLdouble, v3:GLdouble):Void;
    @:GLProc function vertexAttrib4Nub (index:GLuint, v0:GLubyte , v1:GLubyte , v2:GLubyte , v3:GLubyte ):Void;
    @:GLProc function vertexAttribI4i  (index:GLuint, v0:GLint   , v1:GLint   , v2:GLint   , v3:GLint   ):Void;
    @:GLProc function vertexAttribI4ui (index:GLuint, v0:GLuint  , v1:GLuint  , v2:GLuint  , v3:GLuint  ):Void;
    @:GLProc function vertexAttrib1fv  (index:GLuint, v:GLfloatArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib1fv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib1sv  (index:GLuint, v:GLshortArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib1sv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib1dv  (index:GLuint, v:Array<GLdouble>):Void;
    @:GLProc function vertexAttribI1iv (index:GLuint, v:Array<GLint> ):Void;
    @:GLProc function vertexAttribI1uiv(index:GLuint, v:Array<GLuint>):Void;
    @:GLProc function vertexAttrib2fv  (index:GLuint, v:GLfloatArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib2fv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib2sv  (index:GLuint, v:GLshortArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib2sv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib2dv  (index:GLuint, v:Array<GLdouble>):Void;
    @:GLProc function vertexAttribI2iv (index:GLuint, v:Array<GLint> ):Void;
    @:GLProc function vertexAttribI2uiv(index:GLuint, v:Array<GLuint>):Void;
    @:GLProc function vertexAttrib3fv  (index:GLuint, v:GLfloatArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib3fv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib3sv  (index:GLuint, v:GLshortArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib3sv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib3dv  (index:GLuint, v:Array<GLdouble>):Void;
    @:GLProc function vertexAttribI3iv (index:GLuint, v:Array<GLint> ):Void;
    @:GLProc function vertexAttribI3uiv(index:GLuint, v:Array<GLuint>):Void;
    @:GLProc function vertexAttrib4fv  (index:GLuint, v:GLfloatArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib4fv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib4sv  (index:GLuint, v:GLshortArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib4sv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib4dv  (index:GLuint, v:Array<GLdouble>):Void;
    @:GLProc function vertexAttrib4Nubv(index:GLuint, v:GLubyteArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib4Nubv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttribI4iv (index:GLuint, v:Array<GLint> ):Void;
    @:GLProc function vertexAttribI4uiv(index:GLuint, v:Array<GLuint>):Void;
    @:GLProc function vertexAttrib4iv  (index:GLuint, v:Array<GLint> ):Void;
    @:GLProc function vertexAttrib4bv  (index:GLuint, v:GLbyteArray  ):Void {
        var vv:GLArray = v;
        load("vertexAttrib4bv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib4ubv (index:GLuint, v:GLubyteArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib4ubv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib4usv (index:GLuint, v:GLushortArray):Void {
        var vv:GLArray = v;
        load("vertexAttrib4usv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib4uiv (index:GLuint, v:Array<GLuint>):Void;
    @:GLProc function vertexAttrib4Nbv (index:GLuint, v:GLbyteArray  ):Void {
        var vv:GLArray = v;
        load("vertexAttrib4Nbv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib4Nsv (index:GLuint, v:GLshortArray ):Void {
        var vv:GLArray = v;
        load("vertexAttrib4Nsv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib4Niv (index:GLuint, v:Array<GLint> ):Void;
    @:GLProc function vertexAttrib4Nusv(index:GLuint, v:GLushortArray):Void {
        var vv:GLArray = v;
        load("vertexAttrib4Nusv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttrib4Nuiv(index:GLuint, v:Array<GLuint>):Void;
    @:GLProc function vertexAttribI4bv (index:GLuint, v:GLbyteArray  ):Void {
        var vv:GLArray = v;
        load("vertexAttribI4bv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttribI4ubv(index:GLuint, v:GLubyteArray ):Void {
        var vv:GLArray = v;
        load("vertexAttribI4ubv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttribI4sv (index:GLuint, v:GLshortArray ):Void {
        var vv:GLArray = v;
        load("vertexAttribI4sv", 3)(index, v.raw, vv.byteOffset);
    }
    @:GLProc function vertexAttribDivisor(index:GLuint, divisor:GLuint):Void;
    @:GLProc function vertexAttribPointer(index:GLuint, size:GLint, type:GLenum, normalized:GLboolean=false, stride:GLsizei=0, offset:GLsizei=0):Void;
    @:GLProc function vertexAttribIPointer(index:GLuint, size:GLint, type:GLenum, stride:GLsizei=0, offset:GLsizei=0):Void;
    @:GLProc function viewport(x:GLint, y:GLint, width:GLsizei, height:GLsizei):Void;

    // ================================================================================================
    // W
    // ================================================================================================
    @:GLProc function waitSync(sync:GLsync, flags:GLbitfield, timeout:GLuint64):Void
        load("waitSync", 4)(NativeBinding.native(sync), flags, haxe.Int64.getLow(timeout), haxe.Int64.getHigh(timeout));

    // GL_VERSION_1_1 CONSTS
    public static inline var ZERO                                          = 0;
    public static inline var FALSE                                         = 0;
    public static inline var LOGIC_OP                                      = 0x0BF1;
    public static inline var NONE                                          = 0;
    public static inline var TEXTURE_COMPONENTS                            = 0x1003;
    public static inline var NO_ERROR                                      = 0;
    public static inline var POINTS                                        = 0x0000;
    public static inline var CURRENT_BIT                                   = 0x00000001;
    public static inline var TRUE                                          = 1;
    public static inline var ONE                                           = 1;
    public static inline var CLIENT_PIXEL_STORE_BIT                        = 0x00000001;
    public static inline var LINES                                         = 0x0001;
    public static inline var LINE_LOOP                                     = 0x0002;
    public static inline var POINT_BIT                                     = 0x00000002;
    public static inline var CLIENT_VERTEX_ARRAY_BIT                       = 0x00000002;
    public static inline var LINE_STRIP                                    = 0x0003;
    public static inline var LINE_BIT                                      = 0x00000004;
    public static inline var TRIANGLES                                     = 0x0004;
    public static inline var TRIANGLE_STRIP                                = 0x0005;
    public static inline var TRIANGLE_FAN                                  = 0x0006;
    public static inline var QUADS                                         = 0x0007;
    public static inline var QUAD_STRIP                                    = 0x0008;
    public static inline var POLYGON_BIT                                   = 0x00000008;
    public static inline var POLYGON                                       = 0x0009;
    public static inline var POLYGON_STIPPLE_BIT                           = 0x00000010;
    public static inline var PIXEL_MODE_BIT                                = 0x00000020;
    public static inline var LIGHTING_BIT                                  = 0x00000040;
    public static inline var FOG_BIT                                       = 0x00000080;
    public static inline var DEPTH_BUFFER_BIT                              = 0x00000100;
    public static inline var ACCUM                                         = 0x0100;
    public static inline var LOAD                                          = 0x0101;
    public static inline var RETURN                                        = 0x0102;
    public static inline var MULT                                          = 0x0103;
    public static inline var ADD                                           = 0x0104;
    public static inline var NEVER                                         = 0x0200;
    public static inline var ACCUM_BUFFER_BIT                              = 0x00000200;
    public static inline var LESS                                          = 0x0201;
    public static inline var EQUAL                                         = 0x0202;
    public static inline var LEQUAL                                        = 0x0203;
    public static inline var GREATER                                       = 0x0204;
    public static inline var NOTEQUAL                                      = 0x0205;
    public static inline var GEQUAL                                        = 0x0206;
    public static inline var ALWAYS                                        = 0x0207;
    public static inline var SRC_COLOR                                     = 0x0300;
    public static inline var ONE_MINUS_SRC_COLOR                           = 0x0301;
    public static inline var SRC_ALPHA                                     = 0x0302;
    public static inline var ONE_MINUS_SRC_ALPHA                           = 0x0303;
    public static inline var DST_ALPHA                                     = 0x0304;
    public static inline var ONE_MINUS_DST_ALPHA                           = 0x0305;
    public static inline var DST_COLOR                                     = 0x0306;
    public static inline var ONE_MINUS_DST_COLOR                           = 0x0307;
    public static inline var SRC_ALPHA_SATURATE                            = 0x0308;
    public static inline var STENCIL_BUFFER_BIT                            = 0x00000400;
    public static inline var FRONT_LEFT                                    = 0x0400;
    public static inline var FRONT_RIGHT                                   = 0x0401;
    public static inline var BACK_LEFT                                     = 0x0402;
    public static inline var BACK_RIGHT                                    = 0x0403;
    public static inline var FRONT                                         = 0x0404;
    public static inline var BACK                                          = 0x0405;
    public static inline var LEFT                                          = 0x0406;
    public static inline var RIGHT                                         = 0x0407;
    public static inline var FRONT_AND_BACK                                = 0x0408;
    public static inline var AUX0                                          = 0x0409;
    public static inline var AUX1                                          = 0x040A;
    public static inline var AUX2                                          = 0x040B;
    public static inline var AUX3                                          = 0x040C;
    public static inline var INVALID_ENUM                                  = 0x0500;
    public static inline var INVALID_VALUE                                 = 0x0501;
    public static inline var INVALID_OPERATION                             = 0x0502;
    public static inline var STACK_OVERFLOW                                = 0x0503;
    public static inline var STACK_UNDERFLOW                               = 0x0504;
    public static inline var OUT_OF_MEMORY                                 = 0x0505;
    public static inline var _2D                                           = 0x0600;
    public static inline var _3D                                           = 0x0601;
    public static inline var _3D_COLOR                                     = 0x0602;
    public static inline var _3D_COLOR_TEXTURE                             = 0x0603;
    public static inline var _4D_COLOR_TEXTURE                             = 0x0604;
    public static inline var PASS_THROUGH_TOKEN                            = 0x0700;
    public static inline var POINT_TOKEN                                   = 0x0701;
    public static inline var LINE_TOKEN                                    = 0x0702;
    public static inline var POLYGON_TOKEN                                 = 0x0703;
    public static inline var BITMAP_TOKEN                                  = 0x0704;
    public static inline var DRAW_PIXEL_TOKEN                              = 0x0705;
    public static inline var COPY_PIXEL_TOKEN                              = 0x0706;
    public static inline var LINE_RESET_TOKEN                              = 0x0707;
    public static inline var EXP                                           = 0x0800;
    public static inline var VIEWPORT_BIT                                  = 0x00000800;
    public static inline var EXP2                                          = 0x0801;
    public static inline var CW                                            = 0x0900;
    public static inline var CCW                                           = 0x0901;
    public static inline var COEFF                                         = 0x0A00;
    public static inline var ORDER                                         = 0x0A01;
    public static inline var DOMAIN                                        = 0x0A02;
    public static inline var CURRENT_COLOR                                 = 0x0B00;
    public static inline var CURRENT_INDEX                                 = 0x0B01;
    public static inline var CURRENT_NORMAL                                = 0x0B02;
    public static inline var CURRENT_TEXTURE_COORDS                        = 0x0B03;
    public static inline var CURRENT_RASTER_COLOR                          = 0x0B04;
    public static inline var CURRENT_RASTER_INDEX                          = 0x0B05;
    public static inline var CURRENT_RASTER_TEXTURE_COORDS                 = 0x0B06;
    public static inline var CURRENT_RASTER_POSITION                       = 0x0B07;
    public static inline var CURRENT_RASTER_POSITION_VALID                 = 0x0B08;
    public static inline var CURRENT_RASTER_DISTANCE                       = 0x0B09;
    public static inline var POINT_SMOOTH                                  = 0x0B10;
    public static inline var POINT_SIZE                                    = 0x0B11;
    public static inline var POINT_SIZE_RANGE                              = 0x0B12;
    public static inline var POINT_SIZE_GRANULARITY                        = 0x0B13;
    public static inline var LINE_SMOOTH                                   = 0x0B20;
    public static inline var LINE_WIDTH                                    = 0x0B21;
    public static inline var LINE_WIDTH_RANGE                              = 0x0B22;
    public static inline var LINE_WIDTH_GRANULARITY                        = 0x0B23;
    public static inline var LINE_STIPPLE                                  = 0x0B24;
    public static inline var LINE_STIPPLE_PATTERN                          = 0x0B25;
    public static inline var LINE_STIPPLE_REPEAT                           = 0x0B26;
    public static inline var LIST_MODE                                     = 0x0B30;
    public static inline var MAX_LIST_NESTING                              = 0x0B31;
    public static inline var LIST_BASE                                     = 0x0B32;
    public static inline var LIST_INDEX                                    = 0x0B33;
    public static inline var POLYGON_MODE                                  = 0x0B40;
    public static inline var POLYGON_SMOOTH                                = 0x0B41;
    public static inline var POLYGON_STIPPLE                               = 0x0B42;
    public static inline var EDGE_FLAG                                     = 0x0B43;
    public static inline var CULL_FACE                                     = 0x0B44;
    public static inline var CULL_FACE_MODE                                = 0x0B45;
    public static inline var FRONT_FACE                                    = 0x0B46;
    public static inline var LIGHTING                                      = 0x0B50;
    public static inline var LIGHT_MODEL_LOCAL_VIEWER                      = 0x0B51;
    public static inline var LIGHT_MODEL_TWO_SIDE                          = 0x0B52;
    public static inline var LIGHT_MODEL_AMBIENT                           = 0x0B53;
    public static inline var SHADE_MODEL                                   = 0x0B54;
    public static inline var COLOR_MATERIAL_FACE                           = 0x0B55;
    public static inline var COLOR_MATERIAL_PARAMETER                      = 0x0B56;
    public static inline var COLOR_MATERIAL                                = 0x0B57;
    public static inline var FOG                                           = 0x0B60;
    public static inline var FOG_INDEX                                     = 0x0B61;
    public static inline var FOG_DENSITY                                   = 0x0B62;
    public static inline var FOG_START                                     = 0x0B63;
    public static inline var FOG_END                                       = 0x0B64;
    public static inline var FOG_MODE                                      = 0x0B65;
    public static inline var FOG_COLOR                                     = 0x0B66;
    public static inline var DEPTH_RANGE                                   = 0x0B70;
    public static inline var DEPTH_TEST                                    = 0x0B71;
    public static inline var DEPTH_WRITEMASK                               = 0x0B72;
    public static inline var DEPTH_CLEAR_VALUE                             = 0x0B73;
    public static inline var DEPTH_FUNC                                    = 0x0B74;
    public static inline var ACCUM_CLEAR_VALUE                             = 0x0B80;
    public static inline var STENCIL_TEST                                  = 0x0B90;
    public static inline var STENCIL_CLEAR_VALUE                           = 0x0B91;
    public static inline var STENCIL_FUNC                                  = 0x0B92;
    public static inline var STENCIL_VALUE_MASK                            = 0x0B93;
    public static inline var STENCIL_FAIL                                  = 0x0B94;
    public static inline var STENCIL_PASS_DEPTH_FAIL                       = 0x0B95;
    public static inline var STENCIL_PASS_DEPTH_PASS                       = 0x0B96;
    public static inline var STENCIL_REF                                   = 0x0B97;
    public static inline var STENCIL_WRITEMASK                             = 0x0B98;
    public static inline var MATRIX_MODE                                   = 0x0BA0;
    public static inline var NORMALIZE                                     = 0x0BA1;
    public static inline var VIEWPORT                                      = 0x0BA2;
    public static inline var MODELVIEW_STACK_DEPTH                         = 0x0BA3;
    public static inline var PROJECTION_STACK_DEPTH                        = 0x0BA4;
    public static inline var TEXTURE_STACK_DEPTH                           = 0x0BA5;
    public static inline var MODELVIEW_MATRIX                              = 0x0BA6;
    public static inline var PROJECTION_MATRIX                             = 0x0BA7;
    public static inline var TEXTURE_MATRIX                                = 0x0BA8;
    public static inline var ATTRIB_STACK_DEPTH                            = 0x0BB0;
    public static inline var CLIENT_ATTRIB_STACK_DEPTH                     = 0x0BB1;
    public static inline var ALPHA_TEST                                    = 0x0BC0;
    public static inline var ALPHA_TEST_FUNC                               = 0x0BC1;
    public static inline var ALPHA_TEST_REF                                = 0x0BC2;
    public static inline var DITHER                                        = 0x0BD0;
    public static inline var BLEND_DST                                     = 0x0BE0;
    public static inline var BLEND_SRC                                     = 0x0BE1;
    public static inline var BLEND                                         = 0x0BE2;
    public static inline var LOGIC_OP_MODE                                 = 0x0BF0;
    public static inline var INDEX_LOGIC_OP                                = 0x0BF1;
    public static inline var COLOR_LOGIC_OP                                = 0x0BF2;
    public static inline var AUX_BUFFERS                                   = 0x0C00;
    public static inline var DRAW_BUFFER                                   = 0x0C01;
    public static inline var READ_BUFFER                                   = 0x0C02;
    public static inline var SCISSOR_BOX                                   = 0x0C10;
    public static inline var SCISSOR_TEST                                  = 0x0C11;
    public static inline var INDEX_CLEAR_VALUE                             = 0x0C20;
    public static inline var INDEX_WRITEMASK                               = 0x0C21;
    public static inline var COLOR_CLEAR_VALUE                             = 0x0C22;
    public static inline var COLOR_WRITEMASK                               = 0x0C23;
    public static inline var INDEX_MODE                                    = 0x0C30;
    public static inline var RGBA_MODE                                     = 0x0C31;
    public static inline var DOUBLEBUFFER                                  = 0x0C32;
    public static inline var STEREO                                        = 0x0C33;
    public static inline var RENDER_MODE                                   = 0x0C40;
    public static inline var PERSPECTIVE_CORRECTION_HINT                   = 0x0C50;
    public static inline var POINT_SMOOTH_HINT                             = 0x0C51;
    public static inline var LINE_SMOOTH_HINT                              = 0x0C52;
    public static inline var POLYGON_SMOOTH_HINT                           = 0x0C53;
    public static inline var FOG_HINT                                      = 0x0C54;
    public static inline var TEXTURE_GEN_S                                 = 0x0C60;
    public static inline var TEXTURE_GEN_T                                 = 0x0C61;
    public static inline var TEXTURE_GEN_R                                 = 0x0C62;
    public static inline var TEXTURE_GEN_Q                                 = 0x0C63;
    public static inline var PIXEL_MAP_I_TO_I                              = 0x0C70;
    public static inline var PIXEL_MAP_S_TO_S                              = 0x0C71;
    public static inline var PIXEL_MAP_I_TO_R                              = 0x0C72;
    public static inline var PIXEL_MAP_I_TO_G                              = 0x0C73;
    public static inline var PIXEL_MAP_I_TO_B                              = 0x0C74;
    public static inline var PIXEL_MAP_I_TO_A                              = 0x0C75;
    public static inline var PIXEL_MAP_R_TO_R                              = 0x0C76;
    public static inline var PIXEL_MAP_G_TO_G                              = 0x0C77;
    public static inline var PIXEL_MAP_B_TO_B                              = 0x0C78;
    public static inline var PIXEL_MAP_A_TO_A                              = 0x0C79;
    public static inline var PIXEL_MAP_I_TO_I_SIZE                         = 0x0CB0;
    public static inline var PIXEL_MAP_S_TO_S_SIZE                         = 0x0CB1;
    public static inline var PIXEL_MAP_I_TO_R_SIZE                         = 0x0CB2;
    public static inline var PIXEL_MAP_I_TO_G_SIZE                         = 0x0CB3;
    public static inline var PIXEL_MAP_I_TO_B_SIZE                         = 0x0CB4;
    public static inline var PIXEL_MAP_I_TO_A_SIZE                         = 0x0CB5;
    public static inline var PIXEL_MAP_R_TO_R_SIZE                         = 0x0CB6;
    public static inline var PIXEL_MAP_G_TO_G_SIZE                         = 0x0CB7;
    public static inline var PIXEL_MAP_B_TO_B_SIZE                         = 0x0CB8;
    public static inline var PIXEL_MAP_A_TO_A_SIZE                         = 0x0CB9;
    public static inline var UNPACK_SWAP_BYTES                             = 0x0CF0;
    public static inline var UNPACK_LSB_FIRST                              = 0x0CF1;
    public static inline var UNPACK_ROW_LENGTH                             = 0x0CF2;
    public static inline var UNPACK_SKIP_ROWS                              = 0x0CF3;
    public static inline var UNPACK_SKIP_PIXELS                            = 0x0CF4;
    public static inline var UNPACK_ALIGNMENT                              = 0x0CF5;
    public static inline var PACK_SWAP_BYTES                               = 0x0D00;
    public static inline var PACK_LSB_FIRST                                = 0x0D01;
    public static inline var PACK_ROW_LENGTH                               = 0x0D02;
    public static inline var PACK_SKIP_ROWS                                = 0x0D03;
    public static inline var PACK_SKIP_PIXELS                              = 0x0D04;
    public static inline var PACK_ALIGNMENT                                = 0x0D05;
    public static inline var MAP_COLOR                                     = 0x0D10;
    public static inline var MAP_STENCIL                                   = 0x0D11;
    public static inline var INDEX_SHIFT                                   = 0x0D12;
    public static inline var INDEX_OFFSET                                  = 0x0D13;
    public static inline var RED_SCALE                                     = 0x0D14;
    public static inline var RED_BIAS                                      = 0x0D15;
    public static inline var ZOOM_X                                        = 0x0D16;
    public static inline var ZOOM_Y                                        = 0x0D17;
    public static inline var GREEN_SCALE                                   = 0x0D18;
    public static inline var GREEN_BIAS                                    = 0x0D19;
    public static inline var BLUE_SCALE                                    = 0x0D1A;
    public static inline var BLUE_BIAS                                     = 0x0D1B;
    public static inline var ALPHA_SCALE                                   = 0x0D1C;
    public static inline var ALPHA_BIAS                                    = 0x0D1D;
    public static inline var DEPTH_SCALE                                   = 0x0D1E;
    public static inline var DEPTH_BIAS                                    = 0x0D1F;
    public static inline var MAX_EVAL_ORDER                                = 0x0D30;
    public static inline var MAX_LIGHTS                                    = 0x0D31;
    public static inline var MAX_CLIP_PLANES                               = 0x0D32;
    public static inline var MAX_TEXTURE_SIZE                              = 0x0D33;
    public static inline var MAX_PIXEL_MAP_TABLE                           = 0x0D34;
    public static inline var MAX_ATTRIB_STACK_DEPTH                        = 0x0D35;
    public static inline var MAX_MODELVIEW_STACK_DEPTH                     = 0x0D36;
    public static inline var MAX_NAME_STACK_DEPTH                          = 0x0D37;
    public static inline var MAX_PROJECTION_STACK_DEPTH                    = 0x0D38;
    public static inline var MAX_TEXTURE_STACK_DEPTH                       = 0x0D39;
    public static inline var MAX_VIEWPORT_DIMS                             = 0x0D3A;
    public static inline var MAX_CLIENT_ATTRIB_STACK_DEPTH                 = 0x0D3B;
    public static inline var SUBPIXEL_BITS                                 = 0x0D50;
    public static inline var INDEX_BITS                                    = 0x0D51;
    public static inline var RED_BITS                                      = 0x0D52;
    public static inline var GREEN_BITS                                    = 0x0D53;
    public static inline var BLUE_BITS                                     = 0x0D54;
    public static inline var ALPHA_BITS                                    = 0x0D55;
    public static inline var DEPTH_BITS                                    = 0x0D56;
    public static inline var STENCIL_BITS                                  = 0x0D57;
    public static inline var ACCUM_RED_BITS                                = 0x0D58;
    public static inline var ACCUM_GREEN_BITS                              = 0x0D59;
    public static inline var ACCUM_BLUE_BITS                               = 0x0D5A;
    public static inline var ACCUM_ALPHA_BITS                              = 0x0D5B;
    public static inline var NAME_STACK_DEPTH                              = 0x0D70;
    public static inline var AUTO_NORMAL                                   = 0x0D80;
    public static inline var MAP1_COLOR_4                                  = 0x0D90;
    public static inline var MAP1_INDEX                                    = 0x0D91;
    public static inline var MAP1_NORMAL                                   = 0x0D92;
    public static inline var MAP1_TEXTURE_COORD_1                          = 0x0D93;
    public static inline var MAP1_TEXTURE_COORD_2                          = 0x0D94;
    public static inline var MAP1_TEXTURE_COORD_3                          = 0x0D95;
    public static inline var MAP1_TEXTURE_COORD_4                          = 0x0D96;
    public static inline var MAP1_VERTEX_3                                 = 0x0D97;
    public static inline var MAP1_VERTEX_4                                 = 0x0D98;
    public static inline var MAP2_COLOR_4                                  = 0x0DB0;
    public static inline var MAP2_INDEX                                    = 0x0DB1;
    public static inline var MAP2_NORMAL                                   = 0x0DB2;
    public static inline var MAP2_TEXTURE_COORD_1                          = 0x0DB3;
    public static inline var MAP2_TEXTURE_COORD_2                          = 0x0DB4;
    public static inline var MAP2_TEXTURE_COORD_3                          = 0x0DB5;
    public static inline var MAP2_TEXTURE_COORD_4                          = 0x0DB6;
    public static inline var MAP2_VERTEX_3                                 = 0x0DB7;
    public static inline var MAP2_VERTEX_4                                 = 0x0DB8;
    public static inline var MAP1_GRID_DOMAIN                              = 0x0DD0;
    public static inline var MAP1_GRID_SEGMENTS                            = 0x0DD1;
    public static inline var MAP2_GRID_DOMAIN                              = 0x0DD2;
    public static inline var MAP2_GRID_SEGMENTS                            = 0x0DD3;
    public static inline var TEXTURE_1D                                    = 0x0DE0;
    public static inline var TEXTURE_2D                                    = 0x0DE1;
    public static inline var FEEDBACK_BUFFER_POINTER                       = 0x0DF0;
    public static inline var FEEDBACK_BUFFER_SIZE                          = 0x0DF1;
    public static inline var FEEDBACK_BUFFER_TYPE                          = 0x0DF2;
    public static inline var SELECTION_BUFFER_POINTER                      = 0x0DF3;
    public static inline var SELECTION_BUFFER_SIZE                         = 0x0DF4;
    public static inline var TEXTURE_WIDTH                                 = 0x1000;
    public static inline var TRANSFORM_BIT                                 = 0x00001000;
    public static inline var TEXTURE_HEIGHT                                = 0x1001;
    public static inline var TEXTURE_INTERNAL_FORMAT                       = 0x1003;
    public static inline var TEXTURE_BORDER_COLOR                          = 0x1004;
    public static inline var TEXTURE_BORDER                                = 0x1005;
    public static inline var DONT_CARE                                     = 0x1100;
    public static inline var FASTEST                                       = 0x1101;
    public static inline var NICEST                                        = 0x1102;
    public static inline var AMBIENT                                       = 0x1200;
    public static inline var DIFFUSE                                       = 0x1201;
    public static inline var SPECULAR                                      = 0x1202;
    public static inline var POSITION                                      = 0x1203;
    public static inline var SPOT_DIRECTION                                = 0x1204;
    public static inline var SPOT_EXPONENT                                 = 0x1205;
    public static inline var SPOT_CUTOFF                                   = 0x1206;
    public static inline var CONSTANT_ATTENUATION                          = 0x1207;
    public static inline var LINEAR_ATTENUATION                            = 0x1208;
    public static inline var QUADRATIC_ATTENUATION                         = 0x1209;
    public static inline var COMPILE                                       = 0x1300;
    public static inline var COMPILE_AND_EXECUTE                           = 0x1301;
    public static inline var BYTE                                          = 0x1400;
    public static inline var UNSIGNED_BYTE                                 = 0x1401;
    public static inline var SHORT                                         = 0x1402;
    public static inline var UNSIGNED_SHORT                                = 0x1403;
    public static inline var INT                                           = 0x1404;
    public static inline var UNSIGNED_INT                                  = 0x1405;
    public static inline var FLOAT                                         = 0x1406;
    public static inline var _2_BYTES                                      = 0x1407;
    public static inline var _3_BYTES                                      = 0x1408;
    public static inline var _4_BYTES                                      = 0x1409;
    public static inline var DOUBLE                                        = 0x140A;
    public static inline var CLEAR                                         = 0x1500;
    public static inline var AND                                           = 0x1501;
    public static inline var AND_REVERSE                                   = 0x1502;
    public static inline var COPY                                          = 0x1503;
    public static inline var AND_INVERTED                                  = 0x1504;
    public static inline var NOOP                                          = 0x1505;
    public static inline var XOR                                           = 0x1506;
    public static inline var OR                                            = 0x1507;
    public static inline var NOR                                           = 0x1508;
    public static inline var EQUIV                                         = 0x1509;
    public static inline var INVERT                                        = 0x150A;
    public static inline var OR_REVERSE                                    = 0x150B;
    public static inline var COPY_INVERTED                                 = 0x150C;
    public static inline var OR_INVERTED                                   = 0x150D;
    public static inline var NAND                                          = 0x150E;
    public static inline var SET                                           = 0x150F;
    public static inline var EMISSION                                      = 0x1600;
    public static inline var SHININESS                                     = 0x1601;
    public static inline var AMBIENT_AND_DIFFUSE                           = 0x1602;
    public static inline var COLOR_INDEXES                                 = 0x1603;
    public static inline var MODELVIEW                                     = 0x1700;
    public static inline var PROJECTION                                    = 0x1701;
    public static inline var TEXTURE                                       = 0x1702;
    public static inline var COLOR                                         = 0x1800;
    public static inline var DEPTH                                         = 0x1801;
    public static inline var STENCIL                                       = 0x1802;
    public static inline var COLOR_INDEX                                   = 0x1900;
    public static inline var STENCIL_INDEX                                 = 0x1901;
    public static inline var DEPTH_COMPONENT                               = 0x1902;
    public static inline var RED                                           = 0x1903;
    public static inline var GREEN                                         = 0x1904;
    public static inline var BLUE                                          = 0x1905;
    public static inline var ALPHA                                         = 0x1906;
    public static inline var RGB                                           = 0x1907;
    public static inline var RGBA                                          = 0x1908;
    public static inline var LUMINANCE                                     = 0x1909;
    public static inline var LUMINANCE_ALPHA                               = 0x190A;
    public static inline var BITMAP                                        = 0x1A00;
    public static inline var POINT                                         = 0x1B00;
    public static inline var LINE                                          = 0x1B01;
    public static inline var FILL                                          = 0x1B02;
    public static inline var RENDER                                        = 0x1C00;
    public static inline var FEEDBACK                                      = 0x1C01;
    public static inline var SELECT                                        = 0x1C02;
    public static inline var FLAT                                          = 0x1D00;
    public static inline var SMOOTH                                        = 0x1D01;
    public static inline var KEEP                                          = 0x1E00;
    public static inline var REPLACE                                       = 0x1E01;
    public static inline var INCR                                          = 0x1E02;
    public static inline var DECR                                          = 0x1E03;
    public static inline var VENDOR                                        = 0x1F00;
    public static inline var RENDERER                                      = 0x1F01;
    public static inline var VERSION                                       = 0x1F02;
    public static inline var EXTENSIONS                                    = 0x1F03;
    public static inline var S                                             = 0x2000;
    public static inline var ENABLE_BIT                                    = 0x00002000;
    public static inline var T                                             = 0x2001;
    public static inline var R                                             = 0x2002;
    public static inline var Q                                             = 0x2003;
    public static inline var MODULATE                                      = 0x2100;
    public static inline var DECAL                                         = 0x2101;
    public static inline var TEXTURE_ENV_MODE                              = 0x2200;
    public static inline var TEXTURE_ENV_COLOR                             = 0x2201;
    public static inline var TEXTURE_ENV                                   = 0x2300;
    public static inline var EYE_LINEAR                                    = 0x2400;
    public static inline var OBJECT_LINEAR                                 = 0x2401;
    public static inline var SPHERE_MAP                                    = 0x2402;
    public static inline var TEXTURE_GEN_MODE                              = 0x2500;
    public static inline var OBJECT_PLANE                                  = 0x2501;
    public static inline var EYE_PLANE                                     = 0x2502;
    public static inline var NEAREST                                       = 0x2600;
    public static inline var LINEAR                                        = 0x2601;
    public static inline var NEAREST_MIPMAP_NEAREST                        = 0x2700;
    public static inline var LINEAR_MIPMAP_NEAREST                         = 0x2701;
    public static inline var NEAREST_MIPMAP_LINEAR                         = 0x2702;
    public static inline var LINEAR_MIPMAP_LINEAR                          = 0x2703;
    public static inline var TEXTURE_MAG_FILTER                            = 0x2800;
    public static inline var TEXTURE_MIN_FILTER                            = 0x2801;
    public static inline var TEXTURE_WRAP_S                                = 0x2802;
    public static inline var TEXTURE_WRAP_T                                = 0x2803;
    public static inline var CLAMP                                         = 0x2900;
    public static inline var REPEAT                                        = 0x2901;
    public static inline var POLYGON_OFFSET_UNITS                          = 0x2A00;
    public static inline var POLYGON_OFFSET_POINT                          = 0x2A01;
    public static inline var POLYGON_OFFSET_LINE                           = 0x2A02;
    public static inline var R3_G3_B2                                      = 0x2A10;
    public static inline var V2F                                           = 0x2A20;
    public static inline var V3F                                           = 0x2A21;
    public static inline var C4UB_V2F                                      = 0x2A22;
    public static inline var C4UB_V3F                                      = 0x2A23;
    public static inline var C3F_V3F                                       = 0x2A24;
    public static inline var N3F_V3F                                       = 0x2A25;
    public static inline var C4F_N3F_V3F                                   = 0x2A26;
    public static inline var T2F_V3F                                       = 0x2A27;
    public static inline var T4F_V4F                                       = 0x2A28;
    public static inline var T2F_C4UB_V3F                                  = 0x2A29;
    public static inline var T2F_C3F_V3F                                   = 0x2A2A;
    public static inline var T2F_N3F_V3F                                   = 0x2A2B;
    public static inline var T2F_C4F_N3F_V3F                               = 0x2A2C;
    public static inline var T4F_C4F_N3F_V4F                               = 0x2A2D;
    public static inline var CLIP_PLANE0                                   = 0x3000;
    public static inline var CLIP_PLANE1                                   = 0x3001;
    public static inline var CLIP_PLANE2                                   = 0x3002;
    public static inline var CLIP_PLANE3                                   = 0x3003;
    public static inline var CLIP_PLANE4                                   = 0x3004;
    public static inline var CLIP_PLANE5                                   = 0x3005;
    public static inline var LIGHT0                                        = 0x4000;
    public static inline var COLOR_BUFFER_BIT                              = 0x00004000;
    public static inline var LIGHT1                                        = 0x4001;
    public static inline var LIGHT2                                        = 0x4002;
    public static inline var LIGHT3                                        = 0x4003;
    public static inline var LIGHT4                                        = 0x4004;
    public static inline var LIGHT5                                        = 0x4005;
    public static inline var LIGHT6                                        = 0x4006;
    public static inline var LIGHT7                                        = 0x4007;
    public static inline var HINT_BIT                                      = 0x00008000;
    public static inline var POLYGON_OFFSET_FILL                           = 0x8037;
    public static inline var POLYGON_OFFSET_FACTOR                         = 0x8038;
    public static inline var ALPHA4                                        = 0x803B;
    public static inline var ALPHA8                                        = 0x803C;
    public static inline var ALPHA12                                       = 0x803D;
    public static inline var ALPHA16                                       = 0x803E;
    public static inline var LUMINANCE4                                    = 0x803F;
    public static inline var LUMINANCE8                                    = 0x8040;
    public static inline var LUMINANCE12                                   = 0x8041;
    public static inline var LUMINANCE16                                   = 0x8042;
    public static inline var LUMINANCE4_ALPHA4                             = 0x8043;
    public static inline var LUMINANCE6_ALPHA2                             = 0x8044;
    public static inline var LUMINANCE8_ALPHA8                             = 0x8045;
    public static inline var LUMINANCE12_ALPHA4                            = 0x8046;
    public static inline var LUMINANCE12_ALPHA12                           = 0x8047;
    public static inline var LUMINANCE16_ALPHA16                           = 0x8048;
    public static inline var INTENSITY                                     = 0x8049;
    public static inline var INTENSITY4                                    = 0x804A;
    public static inline var INTENSITY8                                    = 0x804B;
    public static inline var INTENSITY12                                   = 0x804C;
    public static inline var INTENSITY16                                   = 0x804D;
    public static inline var RGB4                                          = 0x804F;
    public static inline var RGB5                                          = 0x8050;
    public static inline var RGB8                                          = 0x8051;
    public static inline var RGB10                                         = 0x8052;
    public static inline var RGB12                                         = 0x8053;
    public static inline var RGB16                                         = 0x8054;
    public static inline var RGBA2                                         = 0x8055;
    public static inline var RGBA4                                         = 0x8056;
    public static inline var RGB5_A1                                       = 0x8057;
    public static inline var RGBA8                                         = 0x8058;
    public static inline var RGB10_A2                                      = 0x8059;
    public static inline var RGBA12                                        = 0x805A;
    public static inline var RGBA16                                        = 0x805B;
    public static inline var TEXTURE_RED_SIZE                              = 0x805C;
    public static inline var TEXTURE_GREEN_SIZE                            = 0x805D;
    public static inline var TEXTURE_BLUE_SIZE                             = 0x805E;
    public static inline var TEXTURE_ALPHA_SIZE                            = 0x805F;
    public static inline var TEXTURE_LUMINANCE_SIZE                        = 0x8060;
    public static inline var TEXTURE_INTENSITY_SIZE                        = 0x8061;
    public static inline var PROXY_TEXTURE_1D                              = 0x8063;
    public static inline var PROXY_TEXTURE_2D                              = 0x8064;
    public static inline var TEXTURE_PRIORITY                              = 0x8066;
    public static inline var TEXTURE_RESIDENT                              = 0x8067;
    public static inline var TEXTURE_BINDING_1D                            = 0x8068;
    public static inline var TEXTURE_BINDING_2D                            = 0x8069;
    public static inline var VERTEX_ARRAY                                  = 0x8074;
    public static inline var NORMAL_ARRAY                                  = 0x8075;
    public static inline var COLOR_ARRAY                                   = 0x8076;
    public static inline var INDEX_ARRAY                                   = 0x8077;
    public static inline var TEXTURE_COORD_ARRAY                           = 0x8078;
    public static inline var EDGE_FLAG_ARRAY                               = 0x8079;
    public static inline var VERTEX_ARRAY_SIZE                             = 0x807A;
    public static inline var VERTEX_ARRAY_TYPE                             = 0x807B;
    public static inline var VERTEX_ARRAY_STRIDE                           = 0x807C;
    public static inline var NORMAL_ARRAY_TYPE                             = 0x807E;
    public static inline var NORMAL_ARRAY_STRIDE                           = 0x807F;
    public static inline var COLOR_ARRAY_SIZE                              = 0x8081;
    public static inline var COLOR_ARRAY_TYPE                              = 0x8082;
    public static inline var COLOR_ARRAY_STRIDE                            = 0x8083;
    public static inline var INDEX_ARRAY_TYPE                              = 0x8085;
    public static inline var INDEX_ARRAY_STRIDE                            = 0x8086;
    public static inline var TEXTURE_COORD_ARRAY_SIZE                      = 0x8088;
    public static inline var TEXTURE_COORD_ARRAY_TYPE                      = 0x8089;
    public static inline var TEXTURE_COORD_ARRAY_STRIDE                    = 0x808A;
    public static inline var EDGE_FLAG_ARRAY_STRIDE                        = 0x808C;
    public static inline var VERTEX_ARRAY_POINTER                          = 0x808E;
    public static inline var NORMAL_ARRAY_POINTER                          = 0x808F;
    public static inline var COLOR_ARRAY_POINTER                           = 0x8090;
    public static inline var INDEX_ARRAY_POINTER                           = 0x8091;
    public static inline var TEXTURE_COORD_ARRAY_POINTER                   = 0x8092;
    public static inline var EDGE_FLAG_ARRAY_POINTER                       = 0x8093;
    public static inline var COLOR_INDEX1_EXT                              = 0x80E2;
    public static inline var COLOR_INDEX2_EXT                              = 0x80E3;
    public static inline var COLOR_INDEX4_EXT                              = 0x80E4;
    public static inline var COLOR_INDEX8_EXT                              = 0x80E5;
    public static inline var COLOR_INDEX12_EXT                             = 0x80E6;
    public static inline var COLOR_INDEX16_EXT                             = 0x80E7;
    public static inline var EVAL_BIT                                      = 0x00010000;
    public static inline var LIST_BIT                                      = 0x00020000;
    public static inline var TEXTURE_BIT                                   = 0x00040000;
    public static inline var SCISSOR_BIT                                   = 0x00080000;
    public static inline var ALL_ATTRIB_BITS                               = 0x000fffff;
    public static inline var CLIENT_ALL_ATTRIB_BITS                        = 0xffffffff;
    // GL_VERSION_1_2 CONSTS
    public static inline var SMOOTH_POINT_SIZE_RANGE                       = 0x0B12;
    public static inline var SMOOTH_POINT_SIZE_GRANULARITY                 = 0x0B13;
    public static inline var SMOOTH_LINE_WIDTH_RANGE                       = 0x0B22;
    public static inline var SMOOTH_LINE_WIDTH_GRANULARITY                 = 0x0B23;
    public static inline var UNSIGNED_BYTE_3_3_2                           = 0x8032;
    public static inline var UNSIGNED_SHORT_4_4_4_4                        = 0x8033;
    public static inline var UNSIGNED_SHORT_5_5_5_1                        = 0x8034;
    public static inline var UNSIGNED_INT_8_8_8_8                          = 0x8035;
    public static inline var UNSIGNED_INT_10_10_10_2                       = 0x8036;
    public static inline var RESCALE_NORMAL                                = 0x803A;
    public static inline var TEXTURE_BINDING_3D                            = 0x806A;
    public static inline var PACK_SKIP_IMAGES                              = 0x806B;
    public static inline var PACK_IMAGE_HEIGHT                             = 0x806C;
    public static inline var UNPACK_SKIP_IMAGES                            = 0x806D;
    public static inline var UNPACK_IMAGE_HEIGHT                           = 0x806E;
    public static inline var TEXTURE_3D                                    = 0x806F;
    public static inline var PROXY_TEXTURE_3D                              = 0x8070;
    public static inline var TEXTURE_DEPTH                                 = 0x8071;
    public static inline var TEXTURE_WRAP_R                                = 0x8072;
    public static inline var MAX_3D_TEXTURE_SIZE                           = 0x8073;
    public static inline var BGR                                           = 0x80E0;
    public static inline var BGRA                                          = 0x80E1;
    public static inline var MAX_ELEMENTS_VERTICES                         = 0x80E8;
    public static inline var MAX_ELEMENTS_INDICES                          = 0x80E9;
    public static inline var CLAMP_TO_EDGE                                 = 0x812F;
    public static inline var TEXTURE_MIN_LOD                               = 0x813A;
    public static inline var TEXTURE_MAX_LOD                               = 0x813B;
    public static inline var TEXTURE_BASE_LEVEL                            = 0x813C;
    public static inline var TEXTURE_MAX_LEVEL                             = 0x813D;
    public static inline var LIGHT_MODEL_COLOR_CONTROL                     = 0x81F8;
    public static inline var SINGLE_COLOR                                  = 0x81F9;
    public static inline var SEPARATE_SPECULAR_COLOR                       = 0x81FA;
    public static inline var UNSIGNED_BYTE_2_3_3_REV                       = 0x8362;
    public static inline var UNSIGNED_SHORT_5_6_5                          = 0x8363;
    public static inline var UNSIGNED_SHORT_5_6_5_REV                      = 0x8364;
    public static inline var UNSIGNED_SHORT_4_4_4_4_REV                    = 0x8365;
    public static inline var UNSIGNED_SHORT_1_5_5_5_REV                    = 0x8366;
    public static inline var UNSIGNED_INT_8_8_8_8_REV                      = 0x8367;
    public static inline var UNSIGNED_INT_2_10_10_10_REV                   = 0x8368;
    public static inline var ALIASED_POINT_SIZE_RANGE                      = 0x846D;
    public static inline var ALIASED_LINE_WIDTH_RANGE                      = 0x846E;
    // GL_VERSION_1_3 CONSTS
    public static inline var MULTISAMPLE                                   = 0x809D;
    public static inline var SAMPLE_ALPHA_TO_COVERAGE                      = 0x809E;
    public static inline var SAMPLE_ALPHA_TO_ONE                           = 0x809F;
    public static inline var SAMPLE_COVERAGE                               = 0x80A0;
    public static inline var SAMPLE_BUFFERS                                = 0x80A8;
    public static inline var SAMPLES                                       = 0x80A9;
    public static inline var SAMPLE_COVERAGE_VALUE                         = 0x80AA;
    public static inline var SAMPLE_COVERAGE_INVERT                        = 0x80AB;
    public static inline var CLAMP_TO_BORDER                               = 0x812D;
    public static inline var TEXTURE0                                      = 0x84C0;
    public static inline var TEXTURE1                                      = 0x84C1;
    public static inline var TEXTURE2                                      = 0x84C2;
    public static inline var TEXTURE3                                      = 0x84C3;
    public static inline var TEXTURE4                                      = 0x84C4;
    public static inline var TEXTURE5                                      = 0x84C5;
    public static inline var TEXTURE6                                      = 0x84C6;
    public static inline var TEXTURE7                                      = 0x84C7;
    public static inline var TEXTURE8                                      = 0x84C8;
    public static inline var TEXTURE9                                      = 0x84C9;
    public static inline var TEXTURE10                                     = 0x84CA;
    public static inline var TEXTURE11                                     = 0x84CB;
    public static inline var TEXTURE12                                     = 0x84CC;
    public static inline var TEXTURE13                                     = 0x84CD;
    public static inline var TEXTURE14                                     = 0x84CE;
    public static inline var TEXTURE15                                     = 0x84CF;
    public static inline var TEXTURE16                                     = 0x84D0;
    public static inline var TEXTURE17                                     = 0x84D1;
    public static inline var TEXTURE18                                     = 0x84D2;
    public static inline var TEXTURE19                                     = 0x84D3;
    public static inline var TEXTURE20                                     = 0x84D4;
    public static inline var TEXTURE21                                     = 0x84D5;
    public static inline var TEXTURE22                                     = 0x84D6;
    public static inline var TEXTURE23                                     = 0x84D7;
    public static inline var TEXTURE24                                     = 0x84D8;
    public static inline var TEXTURE25                                     = 0x84D9;
    public static inline var TEXTURE26                                     = 0x84DA;
    public static inline var TEXTURE27                                     = 0x84DB;
    public static inline var TEXTURE28                                     = 0x84DC;
    public static inline var TEXTURE29                                     = 0x84DD;
    public static inline var TEXTURE30                                     = 0x84DE;
    public static inline var TEXTURE31                                     = 0x84DF;
    public static inline var ACTIVE_TEXTURE                                = 0x84E0;
    public static inline var CLIENT_ACTIVE_TEXTURE                         = 0x84E1;
    public static inline var MAX_TEXTURE_UNITS                             = 0x84E2;
    public static inline var TRANSPOSE_MODELVIEW_MATRIX                    = 0x84E3;
    public static inline var TRANSPOSE_PROJECTION_MATRIX                   = 0x84E4;
    public static inline var TRANSPOSE_TEXTURE_MATRIX                      = 0x84E5;
    public static inline var TRANSPOSE_COLOR_MATRIX                        = 0x84E6;
    public static inline var SUBTRACT                                      = 0x84E7;
    public static inline var COMPRESSED_ALPHA                              = 0x84E9;
    public static inline var COMPRESSED_LUMINANCE                          = 0x84EA;
    public static inline var COMPRESSED_LUMINANCE_ALPHA                    = 0x84EB;
    public static inline var COMPRESSED_INTENSITY                          = 0x84EC;
    public static inline var COMPRESSED_RGB                                = 0x84ED;
    public static inline var COMPRESSED_RGBA                               = 0x84EE;
    public static inline var TEXTURE_COMPRESSION_HINT                      = 0x84EF;
    public static inline var NORMAL_MAP                                    = 0x8511;
    public static inline var REFLECTION_MAP                                = 0x8512;
    public static inline var TEXTURE_CUBE_MAP                              = 0x8513;
    public static inline var TEXTURE_BINDING_CUBE_MAP                      = 0x8514;
    public static inline var TEXTURE_CUBE_MAP_POSITIVE_X                   = 0x8515;
    public static inline var TEXTURE_CUBE_MAP_NEGATIVE_X                   = 0x8516;
    public static inline var TEXTURE_CUBE_MAP_POSITIVE_Y                   = 0x8517;
    public static inline var TEXTURE_CUBE_MAP_NEGATIVE_Y                   = 0x8518;
    public static inline var TEXTURE_CUBE_MAP_POSITIVE_Z                   = 0x8519;
    public static inline var TEXTURE_CUBE_MAP_NEGATIVE_Z                   = 0x851A;
    public static inline var PROXY_TEXTURE_CUBE_MAP                        = 0x851B;
    public static inline var MAX_CUBE_MAP_TEXTURE_SIZE                     = 0x851C;
    public static inline var COMBINE                                       = 0x8570;
    public static inline var COMBINE_RGB                                   = 0x8571;
    public static inline var COMBINE_ALPHA                                 = 0x8572;
    public static inline var RGB_SCALE                                     = 0x8573;
    public static inline var ADD_SIGNED                                    = 0x8574;
    public static inline var INTERPOLATE                                   = 0x8575;
    public static inline var CONSTANT                                      = 0x8576;
    public static inline var PRIMARY_COLOR                                 = 0x8577;
    public static inline var PREVIOUS                                      = 0x8578;
    public static inline var SOURCE0_RGB                                   = 0x8580;
    public static inline var SOURCE1_RGB                                   = 0x8581;
    public static inline var SOURCE2_RGB                                   = 0x8582;
    public static inline var SOURCE0_ALPHA                                 = 0x8588;
    public static inline var SOURCE1_ALPHA                                 = 0x8589;
    public static inline var SOURCE2_ALPHA                                 = 0x858A;
    public static inline var OPERAND0_RGB                                  = 0x8590;
    public static inline var OPERAND1_RGB                                  = 0x8591;
    public static inline var OPERAND2_RGB                                  = 0x8592;
    public static inline var OPERAND0_ALPHA                                = 0x8598;
    public static inline var OPERAND1_ALPHA                                = 0x8599;
    public static inline var OPERAND2_ALPHA                                = 0x859A;
    public static inline var TEXTURE_COMPRESSED_IMAGE_SIZE                 = 0x86A0;
    public static inline var TEXTURE_COMPRESSED                            = 0x86A1;
    public static inline var NUM_COMPRESSED_TEXTURE_FORMATS                = 0x86A2;
    public static inline var COMPRESSED_TEXTURE_FORMATS                    = 0x86A3;
    public static inline var DOT3_RGB                                      = 0x86AE;
    public static inline var DOT3_RGBA                                     = 0x86AF;
    public static inline var MULTISAMPLE_BIT                               = 0x20000000;
    // GL_VERSION_1_4 CONSTS
    public static inline var BLEND_DST_RGB                                 = 0x80C8;
    public static inline var BLEND_SRC_RGB                                 = 0x80C9;
    public static inline var BLEND_DST_ALPHA                               = 0x80CA;
    public static inline var BLEND_SRC_ALPHA                               = 0x80CB;
    public static inline var POINT_SIZE_MIN                                = 0x8126;
    public static inline var POINT_SIZE_MAX                                = 0x8127;
    public static inline var POINT_FADE_THRESHOLD_SIZE                     = 0x8128;
    public static inline var POINT_DISTANCE_ATTENUATION                    = 0x8129;
    public static inline var GENERATE_MIPMAP                               = 0x8191;
    public static inline var GENERATE_MIPMAP_HINT                          = 0x8192;
    public static inline var DEPTH_COMPONENT16                             = 0x81A5;
    public static inline var DEPTH_COMPONENT24                             = 0x81A6;
    public static inline var DEPTH_COMPONENT32                             = 0x81A7;
    public static inline var MIRRORED_REPEAT                               = 0x8370;
    public static inline var FOG_COORDINATE_SOURCE                         = 0x8450;
    public static inline var FOG_COORDINATE                                = 0x8451;
    public static inline var FRAGMENT_DEPTH                                = 0x8452;
    public static inline var CURRENT_FOG_COORDINATE                        = 0x8453;
    public static inline var FOG_COORDINATE_ARRAY_TYPE                     = 0x8454;
    public static inline var FOG_COORDINATE_ARRAY_STRIDE                   = 0x8455;
    public static inline var FOG_COORDINATE_ARRAY_POINTER                  = 0x8456;
    public static inline var FOG_COORDINATE_ARRAY                          = 0x8457;
    public static inline var COLOR_SUM                                     = 0x8458;
    public static inline var CURRENT_SECONDARY_COLOR                       = 0x8459;
    public static inline var SECONDARY_COLOR_ARRAY_SIZE                    = 0x845A;
    public static inline var SECONDARY_COLOR_ARRAY_TYPE                    = 0x845B;
    public static inline var SECONDARY_COLOR_ARRAY_STRIDE                  = 0x845C;
    public static inline var SECONDARY_COLOR_ARRAY_POINTER                 = 0x845D;
    public static inline var SECONDARY_COLOR_ARRAY                         = 0x845E;
    public static inline var MAX_TEXTURE_LOD_BIAS                          = 0x84FD;
    public static inline var TEXTURE_FILTER_CONTROL                        = 0x8500;
    public static inline var TEXTURE_LOD_BIAS                              = 0x8501;
    public static inline var INCR_WRAP                                     = 0x8507;
    public static inline var DECR_WRAP                                     = 0x8508;
    public static inline var TEXTURE_DEPTH_SIZE                            = 0x884A;
    public static inline var DEPTH_TEXTURE_MODE                            = 0x884B;
    public static inline var TEXTURE_COMPARE_MODE                          = 0x884C;
    public static inline var TEXTURE_COMPARE_FUNC                          = 0x884D;
    public static inline var COMPARE_R_TO_TEXTURE                          = 0x884E;
    // GL_VERSION_1_5 CONSTS
    public static inline var FOG_COORD_SRC                                 = FOG_COORDINATE_SOURCE;
    public static inline var FOG_COORD                                     = FOG_COORDINATE;
    public static inline var FOG_COORD_ARRAY                               = FOG_COORDINATE_ARRAY;
    public static inline var SRC0_RGB                                      = SOURCE0_RGB;
    public static inline var FOG_COORD_ARRAY_POINTER                       = FOG_COORDINATE_ARRAY_POINTER;
    public static inline var FOG_COORD_ARRAY_TYPE                          = FOG_COORDINATE_ARRAY_TYPE;
    public static inline var SRC1_ALPHA                                    = SOURCE1_ALPHA;
    public static inline var CURRENT_FOG_COORD                             = CURRENT_FOG_COORDINATE;
    public static inline var FOG_COORD_ARRAY_STRIDE                        = FOG_COORDINATE_ARRAY_STRIDE;
    public static inline var SRC0_ALPHA                                    = SOURCE0_ALPHA;
    public static inline var SRC1_RGB                                      = SOURCE1_RGB;
    public static inline var FOG_COORD_ARRAY_BUFFER_BINDING                = FOG_COORDINATE_ARRAY_BUFFER_BINDING;
    public static inline var SRC2_ALPHA                                    = SOURCE2_ALPHA;
    public static inline var SRC2_RGB                                      = SOURCE2_RGB;
    public static inline var BUFFER_SIZE                                   = 0x8764;
    public static inline var BUFFER_USAGE                                  = 0x8765;
    public static inline var QUERY_COUNTER_BITS                            = 0x8864;
    public static inline var CURRENT_QUERY                                 = 0x8865;
    public static inline var QUERY_RESULT                                  = 0x8866;
    public static inline var QUERY_RESULT_AVAILABLE                        = 0x8867;
    public static inline var ARRAY_BUFFER                                  = 0x8892;
    public static inline var ELEMENT_ARRAY_BUFFER                          = 0x8893;
    public static inline var ARRAY_BUFFER_BINDING                          = 0x8894;
    public static inline var ELEMENT_ARRAY_BUFFER_BINDING                  = 0x8895;
    public static inline var VERTEX_ARRAY_BUFFER_BINDING                   = 0x8896;
    public static inline var NORMAL_ARRAY_BUFFER_BINDING                   = 0x8897;
    public static inline var COLOR_ARRAY_BUFFER_BINDING                    = 0x8898;
    public static inline var INDEX_ARRAY_BUFFER_BINDING                    = 0x8899;
    public static inline var TEXTURE_COORD_ARRAY_BUFFER_BINDING            = 0x889A;
    public static inline var EDGE_FLAG_ARRAY_BUFFER_BINDING                = 0x889B;
    public static inline var SECONDARY_COLOR_ARRAY_BUFFER_BINDING          = 0x889C;
    public static inline var FOG_COORDINATE_ARRAY_BUFFER_BINDING           = 0x889D;
    public static inline var WEIGHT_ARRAY_BUFFER_BINDING                   = 0x889E;
    public static inline var VERTEX_ATTRIB_ARRAY_BUFFER_BINDING            = 0x889F;
    public static inline var READ_ONLY                                     = 0x88B8;
    public static inline var WRITE_ONLY                                    = 0x88B9;
    public static inline var READ_WRITE                                    = 0x88BA;
    public static inline var BUFFER_ACCESS                                 = 0x88BB;
    public static inline var BUFFER_MAPPED                                 = 0x88BC;
    public static inline var BUFFER_MAP_POINTER                            = 0x88BD;
    public static inline var STREAM_DRAW                                   = 0x88E0;
    public static inline var STREAM_READ                                   = 0x88E1;
    public static inline var STREAM_COPY                                   = 0x88E2;
    public static inline var STATIC_DRAW                                   = 0x88E4;
    public static inline var STATIC_READ                                   = 0x88E5;
    public static inline var STATIC_COPY                                   = 0x88E6;
    public static inline var DYNAMIC_DRAW                                  = 0x88E8;
    public static inline var DYNAMIC_READ                                  = 0x88E9;
    public static inline var DYNAMIC_COPY                                  = 0x88EA;
    public static inline var SAMPLES_PASSED                                = 0x8914;
    // GL_VERSION_2_0 CONSTS
    public static inline var BLEND_EQUATION_RGB                            = BLEND_EQUATION;
    public static inline var VERTEX_ATTRIB_ARRAY_ENABLED                   = 0x8622;
    public static inline var VERTEX_ATTRIB_ARRAY_SIZE                      = 0x8623;
    public static inline var VERTEX_ATTRIB_ARRAY_STRIDE                    = 0x8624;
    public static inline var VERTEX_ATTRIB_ARRAY_TYPE                      = 0x8625;
    public static inline var CURRENT_VERTEX_ATTRIB                         = 0x8626;
    public static inline var VERTEX_PROGRAM_POINT_SIZE                     = 0x8642;
    public static inline var VERTEX_PROGRAM_TWO_SIDE                       = 0x8643;
    public static inline var VERTEX_ATTRIB_ARRAY_POINTER                   = 0x8645;
    public static inline var STENCIL_BACK_FUNC                             = 0x8800;
    public static inline var STENCIL_BACK_FAIL                             = 0x8801;
    public static inline var STENCIL_BACK_PASS_DEPTH_FAIL                  = 0x8802;
    public static inline var STENCIL_BACK_PASS_DEPTH_PASS                  = 0x8803;
    public static inline var MAX_DRAW_BUFFERS                              = 0x8824;
    public static inline var DRAW_BUFFER0                                  = 0x8825;
    public static inline var DRAW_BUFFER1                                  = 0x8826;
    public static inline var DRAW_BUFFER2                                  = 0x8827;
    public static inline var DRAW_BUFFER3                                  = 0x8828;
    public static inline var DRAW_BUFFER4                                  = 0x8829;
    public static inline var DRAW_BUFFER5                                  = 0x882A;
    public static inline var DRAW_BUFFER6                                  = 0x882B;
    public static inline var DRAW_BUFFER7                                  = 0x882C;
    public static inline var DRAW_BUFFER8                                  = 0x882D;
    public static inline var DRAW_BUFFER9                                  = 0x882E;
    public static inline var DRAW_BUFFER10                                 = 0x882F;
    public static inline var DRAW_BUFFER11                                 = 0x8830;
    public static inline var DRAW_BUFFER12                                 = 0x8831;
    public static inline var DRAW_BUFFER13                                 = 0x8832;
    public static inline var DRAW_BUFFER14                                 = 0x8833;
    public static inline var DRAW_BUFFER15                                 = 0x8834;
    public static inline var BLEND_EQUATION_ALPHA                          = 0x883D;
    public static inline var POINT_SPRITE                                  = 0x8861;
    public static inline var COORD_REPLACE                                 = 0x8862;
    public static inline var MAX_VERTEX_ATTRIBS                            = 0x8869;
    public static inline var VERTEX_ATTRIB_ARRAY_NORMALIZED                = 0x886A;
    public static inline var MAX_TEXTURE_COORDS                            = 0x8871;
    public static inline var MAX_TEXTURE_IMAGE_UNITS                       = 0x8872;
    public static inline var FRAGMENT_SHADER                               = 0x8B30;
    public static inline var VERTEX_SHADER                                 = 0x8B31;
    public static inline var MAX_FRAGMENT_UNIFORM_COMPONENTS               = 0x8B49;
    public static inline var MAX_VERTEX_UNIFORM_COMPONENTS                 = 0x8B4A;
    public static inline var MAX_VARYING_FLOATS                            = 0x8B4B;
    public static inline var MAX_VERTEX_TEXTURE_IMAGE_UNITS                = 0x8B4C;
    public static inline var MAX_COMBINED_TEXTURE_IMAGE_UNITS              = 0x8B4D;
    public static inline var SHADER_TYPE                                   = 0x8B4F;
    public static inline var FLOAT_VEC2                                    = 0x8B50;
    public static inline var FLOAT_VEC3                                    = 0x8B51;
    public static inline var FLOAT_VEC4                                    = 0x8B52;
    public static inline var INT_VEC2                                      = 0x8B53;
    public static inline var INT_VEC3                                      = 0x8B54;
    public static inline var INT_VEC4                                      = 0x8B55;
    public static inline var BOOL                                          = 0x8B56;
    public static inline var BOOL_VEC2                                     = 0x8B57;
    public static inline var BOOL_VEC3                                     = 0x8B58;
    public static inline var BOOL_VEC4                                     = 0x8B59;
    public static inline var FLOAT_MAT2                                    = 0x8B5A;
    public static inline var FLOAT_MAT3                                    = 0x8B5B;
    public static inline var FLOAT_MAT4                                    = 0x8B5C;
    public static inline var SAMPLER_1D                                    = 0x8B5D;
    public static inline var SAMPLER_2D                                    = 0x8B5E;
    public static inline var SAMPLER_3D                                    = 0x8B5F;
    public static inline var SAMPLER_CUBE                                  = 0x8B60;
    public static inline var SAMPLER_1D_SHADOW                             = 0x8B61;
    public static inline var SAMPLER_2D_SHADOW                             = 0x8B62;
    public static inline var DELETE_STATUS                                 = 0x8B80;
    public static inline var COMPILE_STATUS                                = 0x8B81;
    public static inline var LINK_STATUS                                   = 0x8B82;
    public static inline var VALIDATE_STATUS                               = 0x8B83;
    public static inline var INFO_LOG_LENGTH                               = 0x8B84;
    public static inline var ATTACHED_SHADERS                              = 0x8B85;
    public static inline var ACTIVE_UNIFORMS                               = 0x8B86;
    public static inline var ACTIVE_UNIFORM_MAX_LENGTH                     = 0x8B87;
    public static inline var SHADER_SOURCE_LENGTH                          = 0x8B88;
    public static inline var ACTIVE_ATTRIBUTES                             = 0x8B89;
    public static inline var ACTIVE_ATTRIBUTE_MAX_LENGTH                   = 0x8B8A;
    public static inline var FRAGMENT_SHADER_DERIVATIVE_HINT               = 0x8B8B;
    public static inline var SHADING_LANGUAGE_VERSION                      = 0x8B8C;
    public static inline var CURRENT_PROGRAM                               = 0x8B8D;
    public static inline var POINT_SPRITE_COORD_ORIGIN                     = 0x8CA0;
    public static inline var LOWER_LEFT                                    = 0x8CA1;
    public static inline var UPPER_LEFT                                    = 0x8CA2;
    public static inline var STENCIL_BACK_REF                              = 0x8CA3;
    public static inline var STENCIL_BACK_VALUE_MASK                       = 0x8CA4;
    public static inline var STENCIL_BACK_WRITEMASK                        = 0x8CA5;
    // GL_VERSION_2_1 CONSTS
    public static inline var CURRENT_RASTER_SECONDARY_COLOR                = 0x845F;
    public static inline var PIXEL_PACK_BUFFER                             = 0x88EB;
    public static inline var PIXEL_UNPACK_BUFFER                           = 0x88EC;
    public static inline var PIXEL_PACK_BUFFER_BINDING                     = 0x88ED;
    public static inline var PIXEL_UNPACK_BUFFER_BINDING                   = 0x88EF;
    public static inline var FLOAT_MAT2x3                                  = 0x8B65;
    public static inline var FLOAT_MAT2x4                                  = 0x8B66;
    public static inline var FLOAT_MAT3x2                                  = 0x8B67;
    public static inline var FLOAT_MAT3x4                                  = 0x8B68;
    public static inline var FLOAT_MAT4x2                                  = 0x8B69;
    public static inline var FLOAT_MAT4x3                                  = 0x8B6A;
    public static inline var SRGB                                          = 0x8C40;
    public static inline var SRGB8                                         = 0x8C41;
    public static inline var SRGB_ALPHA                                    = 0x8C42;
    public static inline var SRGB8_ALPHA8                                  = 0x8C43;
    public static inline var SLUMINANCE_ALPHA                              = 0x8C44;
    public static inline var SLUMINANCE8_ALPHA8                            = 0x8C45;
    public static inline var SLUMINANCE                                    = 0x8C46;
    public static inline var SLUMINANCE8                                   = 0x8C47;
    public static inline var COMPRESSED_SRGB                               = 0x8C48;
    public static inline var COMPRESSED_SRGB_ALPHA                         = 0x8C49;
    public static inline var COMPRESSED_SLUMINANCE                         = 0x8C4A;
    public static inline var COMPRESSED_SLUMINANCE_ALPHA                   = 0x8C4B;
    // GL_VERSION_3_0 CONSTS
    public static inline var MAX_CLIP_DISTANCES                            = MAX_CLIP_PLANES;
    public static inline var CLIP_DISTANCE5                                = CLIP_PLANE5;
    public static inline var CLIP_DISTANCE1                                = CLIP_PLANE1;
    public static inline var CLIP_DISTANCE3                                = CLIP_PLANE3;
    public static inline var COMPARE_REF_TO_TEXTURE                        = COMPARE_R_TO_TEXTURE_ARB;
    public static inline var CLIP_DISTANCE0                                = CLIP_PLANE0;
    public static inline var CLIP_DISTANCE4                                = CLIP_PLANE4;
    public static inline var CLIP_DISTANCE2                                = CLIP_PLANE2;
    public static inline var MAX_VARYING_COMPONENTS                        = MAX_VARYING_FLOATS;
    public static inline var CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT           = 0x0001;
    public static inline var MAJOR_VERSION                                 = 0x821B;
    public static inline var MINOR_VERSION                                 = 0x821C;
    public static inline var NUM_EXTENSIONS                                = 0x821D;
    public static inline var CONTEXT_FLAGS                                 = 0x821E;
    public static inline var DEPTH_BUFFER                                  = 0x8223;
    public static inline var STENCIL_BUFFER                                = 0x8224;
    public static inline var COMPRESSED_RED                                = 0x8225;
    public static inline var COMPRESSED_RG                                 = 0x8226;
    public static inline var RGBA32F                                       = 0x8814;
    public static inline var RGB32F                                        = 0x8815;
    public static inline var RGBA16F                                       = 0x881A;
    public static inline var RGB16F                                        = 0x881B;
    public static inline var VERTEX_ATTRIB_ARRAY_INTEGER                   = 0x88FD;
    public static inline var MAX_ARRAY_TEXTURE_LAYERS                      = 0x88FF;
    public static inline var MIN_PROGRAM_TEXEL_OFFSET                      = 0x8904;
    public static inline var MAX_PROGRAM_TEXEL_OFFSET                      = 0x8905;
    public static inline var CLAMP_VERTEX_COLOR                            = 0x891A;
    public static inline var CLAMP_FRAGMENT_COLOR                          = 0x891B;
    public static inline var CLAMP_READ_COLOR                              = 0x891C;
    public static inline var FIXED_ONLY                                    = 0x891D;
    public static inline var TEXTURE_RED_TYPE                              = 0x8C10;
    public static inline var TEXTURE_GREEN_TYPE                            = 0x8C11;
    public static inline var TEXTURE_BLUE_TYPE                             = 0x8C12;
    public static inline var TEXTURE_ALPHA_TYPE                            = 0x8C13;
    public static inline var TEXTURE_LUMINANCE_TYPE                        = 0x8C14;
    public static inline var TEXTURE_INTENSITY_TYPE                        = 0x8C15;
    public static inline var TEXTURE_DEPTH_TYPE                            = 0x8C16;
    public static inline var UNSIGNED_NORMALIZED                           = 0x8C17;
    public static inline var TEXTURE_1D_ARRAY                              = 0x8C18;
    public static inline var PROXY_TEXTURE_1D_ARRAY                        = 0x8C19;
    public static inline var TEXTURE_2D_ARRAY                              = 0x8C1A;
    public static inline var PROXY_TEXTURE_2D_ARRAY                        = 0x8C1B;
    public static inline var TEXTURE_BINDING_1D_ARRAY                      = 0x8C1C;
    public static inline var TEXTURE_BINDING_2D_ARRAY                      = 0x8C1D;
    public static inline var R11F_G11F_B10F                                = 0x8C3A;
    public static inline var UNSIGNED_INT_10F_11F_11F_REV                  = 0x8C3B;
    public static inline var RGB9_E5                                       = 0x8C3D;
    public static inline var UNSIGNED_INT_5_9_9_9_REV                      = 0x8C3E;
    public static inline var TEXTURE_SHARED_SIZE                           = 0x8C3F;
    public static inline var TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH         = 0x8C76;
    public static inline var TRANSFORM_FEEDBACK_BUFFER_MODE                = 0x8C7F;
    public static inline var MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS    = 0x8C80;
    public static inline var TRANSFORM_FEEDBACK_VARYINGS                   = 0x8C83;
    public static inline var TRANSFORM_FEEDBACK_BUFFER_START               = 0x8C84;
    public static inline var TRANSFORM_FEEDBACK_BUFFER_SIZE                = 0x8C85;
    public static inline var PRIMITIVES_GENERATED                          = 0x8C87;
    public static inline var TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN         = 0x8C88;
    public static inline var RASTERIZER_DISCARD                            = 0x8C89;
    public static inline var MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 0x8C8A;
    public static inline var MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS       = 0x8C8B;
    public static inline var INTERLEAVED_ATTRIBS                           = 0x8C8C;
    public static inline var SEPARATE_ATTRIBS                              = 0x8C8D;
    public static inline var TRANSFORM_FEEDBACK_BUFFER                     = 0x8C8E;
    public static inline var TRANSFORM_FEEDBACK_BUFFER_BINDING             = 0x8C8F;
    public static inline var RGBA32UI                                      = 0x8D70;
    public static inline var RGB32UI                                       = 0x8D71;
    public static inline var RGBA16UI                                      = 0x8D76;
    public static inline var RGB16UI                                       = 0x8D77;
    public static inline var RGBA8UI                                       = 0x8D7C;
    public static inline var RGB8UI                                        = 0x8D7D;
    public static inline var RGBA32I                                       = 0x8D82;
    public static inline var RGB32I                                        = 0x8D83;
    public static inline var RGBA16I                                       = 0x8D88;
    public static inline var RGB16I                                        = 0x8D89;
    public static inline var RGBA8I                                        = 0x8D8E;
    public static inline var RGB8I                                         = 0x8D8F;
    public static inline var RED_INTEGER                                   = 0x8D94;
    public static inline var GREEN_INTEGER                                 = 0x8D95;
    public static inline var BLUE_INTEGER                                  = 0x8D96;
    public static inline var ALPHA_INTEGER                                 = 0x8D97;
    public static inline var RGB_INTEGER                                   = 0x8D98;
    public static inline var RGBA_INTEGER                                  = 0x8D99;
    public static inline var BGR_INTEGER                                   = 0x8D9A;
    public static inline var BGRA_INTEGER                                  = 0x8D9B;
    public static inline var SAMPLER_1D_ARRAY                              = 0x8DC0;
    public static inline var SAMPLER_2D_ARRAY                              = 0x8DC1;
    public static inline var SAMPLER_1D_ARRAY_SHADOW                       = 0x8DC3;
    public static inline var SAMPLER_2D_ARRAY_SHADOW                       = 0x8DC4;
    public static inline var SAMPLER_CUBE_SHADOW                           = 0x8DC5;
    public static inline var UNSIGNED_INT_VEC2                             = 0x8DC6;
    public static inline var UNSIGNED_INT_VEC3                             = 0x8DC7;
    public static inline var UNSIGNED_INT_VEC4                             = 0x8DC8;
    public static inline var INT_SAMPLER_1D                                = 0x8DC9;
    public static inline var INT_SAMPLER_2D                                = 0x8DCA;
    public static inline var INT_SAMPLER_3D                                = 0x8DCB;
    public static inline var INT_SAMPLER_CUBE                              = 0x8DCC;
    public static inline var INT_SAMPLER_1D_ARRAY                          = 0x8DCE;
    public static inline var INT_SAMPLER_2D_ARRAY                          = 0x8DCF;
    public static inline var UNSIGNED_INT_SAMPLER_1D                       = 0x8DD1;
    public static inline var UNSIGNED_INT_SAMPLER_2D                       = 0x8DD2;
    public static inline var UNSIGNED_INT_SAMPLER_3D                       = 0x8DD3;
    public static inline var UNSIGNED_INT_SAMPLER_CUBE                     = 0x8DD4;
    public static inline var UNSIGNED_INT_SAMPLER_1D_ARRAY                 = 0x8DD6;
    public static inline var UNSIGNED_INT_SAMPLER_2D_ARRAY                 = 0x8DD7;
    public static inline var QUERY_WAIT                                    = 0x8E13;
    public static inline var QUERY_NO_WAIT                                 = 0x8E14;
    public static inline var QUERY_BY_REGION_WAIT                          = 0x8E15;
    public static inline var QUERY_BY_REGION_NO_WAIT                       = 0x8E16;
    // GL_VERSION_3_1 CONSTS
    public static inline var TEXTURE_RECTANGLE                             = 0x84F5;
    public static inline var TEXTURE_BINDING_RECTANGLE                     = 0x84F6;
    public static inline var PROXY_TEXTURE_RECTANGLE                       = 0x84F7;
    public static inline var MAX_RECTANGLE_TEXTURE_SIZE                    = 0x84F8;
    public static inline var SAMPLER_2D_RECT                               = 0x8B63;
    public static inline var SAMPLER_2D_RECT_SHADOW                        = 0x8B64;
    public static inline var TEXTURE_BUFFER                                = 0x8C2A;
    public static inline var MAX_TEXTURE_BUFFER_SIZE                       = 0x8C2B;
    public static inline var TEXTURE_BINDING_BUFFER                        = 0x8C2C;
    public static inline var TEXTURE_BUFFER_DATA_STORE_BINDING             = 0x8C2D;
    public static inline var TEXTURE_BUFFER_FORMAT                         = 0x8C2E;
    public static inline var SAMPLER_BUFFER                                = 0x8DC2;
    public static inline var INT_SAMPLER_2D_RECT                           = 0x8DCD;
    public static inline var INT_SAMPLER_BUFFER                            = 0x8DD0;
    public static inline var UNSIGNED_INT_SAMPLER_2D_RECT                  = 0x8DD5;
    public static inline var UNSIGNED_INT_SAMPLER_BUFFER                   = 0x8DD8;
    public static inline var RED_SNORM                                     = 0x8F90;
    public static inline var RG_SNORM                                      = 0x8F91;
    public static inline var RGB_SNORM                                     = 0x8F92;
    public static inline var RGBA_SNORM                                    = 0x8F93;
    public static inline var R8_SNORM                                      = 0x8F94;
    public static inline var RG8_SNORM                                     = 0x8F95;
    public static inline var RGB8_SNORM                                    = 0x8F96;
    public static inline var RGBA8_SNORM                                   = 0x8F97;
    public static inline var R16_SNORM                                     = 0x8F98;
    public static inline var RG16_SNORM                                    = 0x8F99;
    public static inline var RGB16_SNORM                                   = 0x8F9A;
    public static inline var RGBA16_SNORM                                  = 0x8F9B;
    public static inline var SIGNED_NORMALIZED                             = 0x8F9C;
    public static inline var PRIMITIVE_RESTART                             = 0x8F9D;
    public static inline var PRIMITIVE_RESTART_INDEX                       = 0x8F9E;
    public static inline var BUFFER_ACCESS_FLAGS                           = 0x911F;
    public static inline var BUFFER_MAP_LENGTH                             = 0x9120;
    public static inline var BUFFER_MAP_OFFSET                             = 0x9121;
    // GL_VERSION_3_2 CONSTS
    public static inline var CONTEXT_CORE_PROFILE_BIT                      = 0x00000001;
    public static inline var CONTEXT_COMPATIBILITY_PROFILE_BIT             = 0x00000002;
    public static inline var LINES_ADJACENCY                               = 0x000A;
    public static inline var LINE_STRIP_ADJACENCY                          = 0x000B;
    public static inline var TRIANGLES_ADJACENCY                           = 0x000C;
    public static inline var TRIANGLE_STRIP_ADJACENCY                      = 0x000D;
    public static inline var PROGRAM_POINT_SIZE                            = 0x8642;
    public static inline var GEOMETRY_VERTICES_OUT                         = 0x8916;
    public static inline var GEOMETRY_INPUT_TYPE                           = 0x8917;
    public static inline var GEOMETRY_OUTPUT_TYPE                          = 0x8918;
    public static inline var MAX_GEOMETRY_TEXTURE_IMAGE_UNITS              = 0x8C29;
    public static inline var FRAMEBUFFER_ATTACHMENT_LAYERED                = 0x8DA7;
    public static inline var FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS          = 0x8DA8;
    public static inline var GEOMETRY_SHADER                               = 0x8DD9;
    public static inline var MAX_GEOMETRY_UNIFORM_COMPONENTS               = 0x8DDF;
    public static inline var MAX_GEOMETRY_OUTPUT_VERTICES                  = 0x8DE0;
    public static inline var MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS          = 0x8DE1;
    public static inline var MAX_VERTEX_OUTPUT_COMPONENTS                  = 0x9122;
    public static inline var MAX_GEOMETRY_INPUT_COMPONENTS                 = 0x9123;
    public static inline var MAX_GEOMETRY_OUTPUT_COMPONENTS                = 0x9124;
    public static inline var MAX_FRAGMENT_INPUT_COMPONENTS                 = 0x9125;
    public static inline var CONTEXT_PROFILE_MASK                          = 0x9126;
    // GL_VERSION_3_3 CONSTS
    public static inline var VERTEX_ATTRIB_ARRAY_DIVISOR                   = 0x88FE;
    public static inline var ANY_SAMPLES_PASSED                            = 0x8C2F;
    public static inline var TEXTURE_SWIZZLE_R                             = 0x8E42;
    public static inline var TEXTURE_SWIZZLE_G                             = 0x8E43;
    public static inline var TEXTURE_SWIZZLE_B                             = 0x8E44;
    public static inline var TEXTURE_SWIZZLE_A                             = 0x8E45;
    public static inline var TEXTURE_SWIZZLE_RGBA                          = 0x8E46;
    public static inline var RGB10_A2UI                                    = 0x906F;
    // GL_ARB_SHADOW
    public static inline var TEXTURE_COMPARE_MODE_ARB                      = 0x884C;
    public static inline var TEXTURE_COMPARE_FUNC_ARB                      = 0x884D;
    public static inline var COMPARE_R_TO_TEXTURE_ARB                      = 0x884E;
    // GL_ARB_IMAGING
    public static inline var CONSTANT_COLOR                                = 0x8001;
    public static inline var ONE_MINUS_CONSTANT_COLOR                      = 0x8002;
    public static inline var CONSTANT_ALPHA                                = 0x8003;
    public static inline var ONE_MINUS_CONSTANT_ALPHA                      = 0x8004;
    public static inline var BLEND_COLOR                                   = 0x8005;
    public static inline var FUNC_ADD                                      = 0x8006;
    public static inline var MIN                                           = 0x8007;
    public static inline var MAX                                           = 0x8008;
    public static inline var BLEND_EQUATION                                = 0x8009;
    public static inline var FUNC_SUBTRACT                                 = 0x800A;
    public static inline var FUNC_REVERSE_SUBTRACT                         = 0x800B;
    public static inline var CONVOLUTION_1D                                = 0x8010;
    public static inline var CONVOLUTION_2D                                = 0x8011;
    public static inline var SEPARABLE_2D                                  = 0x8012;
    public static inline var CONVOLUTION_BORDER_MODE                       = 0x8013;
    public static inline var CONVOLUTION_FILTER_SCALE                      = 0x8014;
    public static inline var CONVOLUTION_FILTER_BIAS                       = 0x8015;
    public static inline var REDUCE                                        = 0x8016;
    public static inline var CONVOLUTION_FORMAT                            = 0x8017;
    public static inline var CONVOLUTION_WIDTH                             = 0x8018;
    public static inline var CONVOLUTION_HEIGHT                            = 0x8019;
    public static inline var MAX_CONVOLUTION_WIDTH                         = 0x801A;
    public static inline var MAX_CONVOLUTION_HEIGHT                        = 0x801B;
    public static inline var POST_CONVOLUTION_RED_SCALE                    = 0x801C;
    public static inline var POST_CONVOLUTION_GREEN_SCALE                  = 0x801D;
    public static inline var POST_CONVOLUTION_BLUE_SCALE                   = 0x801E;
    public static inline var POST_CONVOLUTION_ALPHA_SCALE                  = 0x801F;
    public static inline var POST_CONVOLUTION_RED_BIAS                     = 0x8020;
    public static inline var POST_CONVOLUTION_GREEN_BIAS                   = 0x8021;
    public static inline var POST_CONVOLUTION_BLUE_BIAS                    = 0x8022;
    public static inline var POST_CONVOLUTION_ALPHA_BIAS                   = 0x8023;
    public static inline var HISTOGRAM                                     = 0x8024;
    public static inline var PROXY_HISTOGRAM                               = 0x8025;
    public static inline var HISTOGRAM_WIDTH                               = 0x8026;
    public static inline var HISTOGRAM_FORMAT                              = 0x8027;
    public static inline var HISTOGRAM_RED_SIZE                            = 0x8028;
    public static inline var HISTOGRAM_GREEN_SIZE                          = 0x8029;
    public static inline var HISTOGRAM_BLUE_SIZE                           = 0x802A;
    public static inline var HISTOGRAM_ALPHA_SIZE                          = 0x802B;
    public static inline var HISTOGRAM_LUMINANCE_SIZE                      = 0x802C;
    public static inline var HISTOGRAM_SINK                                = 0x802D;
    public static inline var MINMAX                                        = 0x802E;
    public static inline var MINMAX_FORMAT                                 = 0x802F;
    public static inline var MINMAX_SINK                                   = 0x8030;
    public static inline var TABLE_TOO_LARGE                               = 0x8031;
    public static inline var COLOR_MATRIX                                  = 0x80B1;
    public static inline var COLOR_MATRIX_STACK_DEPTH                      = 0x80B2;
    public static inline var MAX_COLOR_MATRIX_STACK_DEPTH                  = 0x80B3;
    public static inline var POST_COLOR_MATRIX_RED_SCALE                   = 0x80B4;
    public static inline var POST_COLOR_MATRIX_GREEN_SCALE                 = 0x80B5;
    public static inline var POST_COLOR_MATRIX_BLUE_SCALE                  = 0x80B6;
    public static inline var POST_COLOR_MATRIX_ALPHA_SCALE                 = 0x80B7;
    public static inline var POST_COLOR_MATRIX_RED_BIAS                    = 0x80B8;
    public static inline var POST_COLOR_MATRIX_GREEN_BIAS                  = 0x80B9;
    public static inline var POST_COLOR_MATRIX_BLUE_BIAS                   = 0x80BA;
    public static inline var POST_COLOR_MATRIX_ALPHA_BIAS                  = 0x80BB;
    public static inline var COLOR_TABLE                                   = 0x80D0;
    public static inline var POST_CONVOLUTION_COLOR_TABLE                  = 0x80D1;
    public static inline var POST_COLOR_MATRIX_COLOR_TABLE                 = 0x80D2;
    public static inline var PROXY_COLOR_TABLE                             = 0x80D3;
    public static inline var PROXY_POST_CONVOLUTION_COLOR_TABLE            = 0x80D4;
    public static inline var PROXY_POST_COLOR_MATRIX_COLOR_TABLE           = 0x80D5;
    public static inline var COLOR_TABLE_SCALE                             = 0x80D6;
    public static inline var COLOR_TABLE_BIAS                              = 0x80D7;
    public static inline var COLOR_TABLE_FORMAT                            = 0x80D8;
    public static inline var COLOR_TABLE_WIDTH                             = 0x80D9;
    public static inline var COLOR_TABLE_RED_SIZE                          = 0x80DA;
    public static inline var COLOR_TABLE_GREEN_SIZE                        = 0x80DB;
    public static inline var COLOR_TABLE_BLUE_SIZE                         = 0x80DC;
    public static inline var COLOR_TABLE_ALPHA_SIZE                        = 0x80DD;
    public static inline var COLOR_TABLE_LUMINANCE_SIZE                    = 0x80DE;
    public static inline var COLOR_TABLE_INTENSITY_SIZE                    = 0x80DF;
    public static inline var IGNORE_BORDER                                 = 0x8150;
    public static inline var CONSTANT_BORDER                               = 0x8151;
    public static inline var WRAP_BORDER                                   = 0x8152;
    public static inline var REPLICATE_BORDER                              = 0x8153;
    public static inline var CONVOLUTION_BORDER_COLOR                      = 0x8154;
    // GL_ARB_FRAMEBUFFER_OBJECT
    public static inline var INVALID_FRAMEBUFFER_OPERATION                 = 0x0506;
    public static inline var FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING         = 0x8210;
    public static inline var FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE         = 0x8211;
    public static inline var FRAMEBUFFER_ATTACHMENT_RED_SIZE               = 0x8212;
    public static inline var FRAMEBUFFER_ATTACHMENT_GREEN_SIZE             = 0x8213;
    public static inline var FRAMEBUFFER_ATTACHMENT_BLUE_SIZE              = 0x8214;
    public static inline var FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE             = 0x8215;
    public static inline var FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE             = 0x8216;
    public static inline var FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE           = 0x8217;
    public static inline var FRAMEBUFFER_DEFAULT                           = 0x8218;
    public static inline var FRAMEBUFFER_UNDEFINED                         = 0x8219;
    public static inline var DEPTH_STENCIL_ATTACHMENT                      = 0x821A;
    public static inline var INDEX                                         = 0x8222;
    public static inline var MAX_RENDERBUFFER_SIZE                         = 0x84E8;
    public static inline var DEPTH_STENCIL                                 = 0x84F9;
    public static inline var UNSIGNED_INT_24_8                             = 0x84FA;
    public static inline var DEPTH24_STENCIL8                              = 0x88F0;
    public static inline var TEXTURE_STENCIL_SIZE                          = 0x88F1;
    public static inline var DRAW_FRAMEBUFFER_BINDING                      = 0x8CA6;
    public static inline var FRAMEBUFFER_BINDING                           = 0x8CA6;
    public static inline var RENDERBUFFER_BINDING                          = 0x8CA7;
    public static inline var READ_FRAMEBUFFER                              = 0x8CA8;
    public static inline var DRAW_FRAMEBUFFER                              = 0x8CA9;
    public static inline var READ_FRAMEBUFFER_BINDING                      = 0x8CAA;
    public static inline var RENDERBUFFER_SAMPLES                          = 0x8CAB;
    public static inline var FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE            = 0x8CD0;
    public static inline var FRAMEBUFFER_ATTACHMENT_OBJECT_NAME            = 0x8CD1;
    public static inline var FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL          = 0x8CD2;
    public static inline var FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE  = 0x8CD3;
    public static inline var FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER          = 0x8CD4;
    public static inline var FRAMEBUFFER_COMPLETE                          = 0x8CD5;
    public static inline var FRAMEBUFFER_INCOMPLETE_ATTACHMENT             = 0x8CD6;
    public static inline var FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT     = 0x8CD7;
    public static inline var FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER            = 0x8CDB;
    public static inline var FRAMEBUFFER_INCOMPLETE_READ_BUFFER            = 0x8CDC;
    public static inline var FRAMEBUFFER_UNSUPPORTED                       = 0x8CDD;
    public static inline var MAX_COLOR_ATTACHMENTS                         = 0x8CDF;
    public static inline var COLOR_ATTACHMENT0                             = 0x8CE0;
    public static inline var COLOR_ATTACHMENT1                             = 0x8CE1;
    public static inline var COLOR_ATTACHMENT2                             = 0x8CE2;
    public static inline var COLOR_ATTACHMENT3                             = 0x8CE3;
    public static inline var COLOR_ATTACHMENT4                             = 0x8CE4;
    public static inline var COLOR_ATTACHMENT5                             = 0x8CE5;
    public static inline var COLOR_ATTACHMENT6                             = 0x8CE6;
    public static inline var COLOR_ATTACHMENT7                             = 0x8CE7;
    public static inline var COLOR_ATTACHMENT8                             = 0x8CE8;
    public static inline var COLOR_ATTACHMENT9                             = 0x8CE9;
    public static inline var COLOR_ATTACHMENT10                            = 0x8CEA;
    public static inline var COLOR_ATTACHMENT11                            = 0x8CEB;
    public static inline var COLOR_ATTACHMENT12                            = 0x8CEC;
    public static inline var COLOR_ATTACHMENT13                            = 0x8CED;
    public static inline var COLOR_ATTACHMENT14                            = 0x8CEE;
    public static inline var COLOR_ATTACHMENT15                            = 0x8CEF;
    public static inline var DEPTH_ATTACHMENT                              = 0x8D00;
    public static inline var STENCIL_ATTACHMENT                            = 0x8D20;
    public static inline var FRAMEBUFFER                                   = 0x8D40;
    public static inline var RENDERBUFFER                                  = 0x8D41;
    public static inline var RENDERBUFFER_WIDTH                            = 0x8D42;
    public static inline var RENDERBUFFER_HEIGHT                           = 0x8D43;
    public static inline var RENDERBUFFER_INTERNAL_FORMAT                  = 0x8D44;
    public static inline var STENCIL_INDEX1                                = 0x8D46;
    public static inline var STENCIL_INDEX4                                = 0x8D47;
    public static inline var STENCIL_INDEX8                                = 0x8D48;
    public static inline var STENCIL_INDEX16                               = 0x8D49;
    public static inline var RENDERBUFFER_RED_SIZE                         = 0x8D50;
    public static inline var RENDERBUFFER_GREEN_SIZE                       = 0x8D51;
    public static inline var RENDERBUFFER_BLUE_SIZE                        = 0x8D52;
    public static inline var RENDERBUFFER_ALPHA_SIZE                       = 0x8D53;
    public static inline var RENDERBUFFER_DEPTH_SIZE                       = 0x8D54;
    public static inline var RENDERBUFFER_STENCIL_SIZE                     = 0x8D55;
    public static inline var FRAMEBUFFER_INCOMPLETE_MULTISAMPLE            = 0x8D56;
    public static inline var MAX_SAMPLES                                   = 0x8D57;
}
