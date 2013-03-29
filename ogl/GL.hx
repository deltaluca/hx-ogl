package ogl;

import #if cpp cpp #else neko #end.Lib;
import ogl.Macros;

class GL implements GLConsts implements GLProcs {
    static inline function load(n:String, p:Int):Dynamic
        return Lib.load("ogl","hx_gl_"+n, p);

    // ================================================================================================
    // A
    // ================================================================================================
    @:GLProc function attachShader(program:Int, shader:Int):Void;

    // ================================================================================================
    // B
    // ================================================================================================
    @:GLConst var ARRAY_BUFFER;
    @:GLConst var COPY_READ_BUFFER;
    @:GLConst var COPY_WRITE_BUFFER;
    @:GLConst var ELEMENT_ARRAY_BUFFER;
    @:GLConst var PIXEL_PACK_BUFFER;
    @:GLConst var PIXEL_UNPACK_BUFFER;
    @:GLConst var TEXTURE_BUFFER;
    @:GLConst var TRANSFORM_FEEDBACK_BUFFER;
    @:GLConst var UNIFORM_BUFFER;
    @:GLProc function bindBuffer(target:Int, buffer:Int):Void;
    @:GLConst var TEXTURE_1D;
    @:GLConst var TEXTURE_2D;
    @:GLConst var TEXTURE_3D;
    @:GLConst var TEXTURE_1D_ARRAY;
    @:GLConst var TEXTURE_2D_ARRAY;
    @:GLConst var TEXTURE_RECTANGLE;
    @:GLConst var TEXTURE_CUBE_MAP;
    @:GLConst var TEXTURE_2D_MULTISAMPLE;
    @:GLConst var TEXTURE_2D_MULTISAMPLE_ARRAY;
    @:GLProc function bindTexture(target:Int, texture:Int):Void;
    @:GLProc function bindVertexArray(array:Int):Void;
    @:GLConst var STREAM_DRAW;
    @:GLConst var STREAM_READ;
    @:GLConst var STREAM_COPY;
    @:GLConst var STATIC_DRAW;
    @:GLConst var STATIC_READ;
    @:GLConst var STATIC_COPY;
    @:GLConst var DYNAMIC_DRAW;
    @:GLConst var DYNAMIC_READ;
    @:GLConst var DYNAMIC_COPY;
    // Change of API, specify ahead of time, the GL type for data.
    @:GLProc function bufferData<T>(target:Int, data:Array<T>, type:Int, usage:Int):Void;

    // ================================================================================================
    // C
    // ================================================================================================
    @:GLConst var COLOR_BUFFER_BIT;
    @:GLConst var DEPTH_BUFFER_BIT;
    @:GLConst var STENCIL_BUFFER_BIT;
    @:GLProc function clear(mask:Int):Void;
    @:GLProc function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void;
    @:GLProc function compileShader(shader:Int):Void {
        var err:Null<String> = load("compileShader", 1)(shader);
        if (err != null) throw err;
    }
    @:GLConst var VERTEX_SHADER;
    @:GLConst var GEOMETRY_SHADER;
    @:GLConst var FRAGMENT_SHADER;
    @:GLProc function createShader(shaderType:Int):Int;
    @:GLProc function createProgram():Int;

    // ================================================================================================
    // D
    // ================================================================================================
    @:GLProc function deleteShader(shader:Int):Void;
    @:GLProc function disableVertexAttribArray(index:Int):Void;
    @:GLConst var POINTS;
    @:GLConst var LINE_STRIP;
    @:GLConst var LINE_LOOP;
    @:GLConst var LINES;
    @:GLConst var LINE_STRIP_ADJACENCY;
    @:GLConst var LINES_ADJACENCY;
    @:GLConst var TRIANGLE_STRIP;
    @:GLConst var TRIANGLE_FAN;
    @:GLConst var TRIANGLES;
    @:GLConst var TRIANGLE_STRIP_ADJACENCY;
    @:GLConst var TRIANGLES_ADJACENCY;
    @:GLProc function drawArrays(mode:Int, first:Int, count:Int):Void;

    // ================================================================================================
    // E
    // ================================================================================================
    @:GLProc function enableVertexAttribArray(index:Int):Void;

    // ================================================================================================
    // F
    // ================================================================================================

    // ================================================================================================
    // G
    // ================================================================================================
    @:GLProc function genBuffers(n:Int):Array<Int> {
        var buffers = [];
        load("genBuffers", 2)(n, buffers);
        return buffers;
    }
    @:GLProc function genTextures(n:Int):Array<Int> {
        var textures = [];
        load("genTextures", 2)(n, textures);
        return textures;
    }
    @:GLProc function genVertexArrays(n:Int):Array<Int> {
        var arrays = [];
        load("genVertexArrays", 2)(n, arrays);
        return arrays;
    }

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
    @:GLProc function linkProgram(program:Int):Void {
        var err:Null<String> = load("linkProgram", 1)(program);
        if (err != null) throw err;
    }

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
    @:GLProc function shaderSource(shader:Int, source:String):Void {
        load("shaderSource", 2)(shader, [source]);
    }

    // ================================================================================================
    // T
    // ================================================================================================
    @:GLConst var PROXY_TEXTURE_2D;
    @:GLConst var PROXY_TEXTURE_1D_ARRAY;
    @:GLConst var PROXY_TEXTURE_RECTANGLE;
    @:GLConst var TEXTURE_CUBE_MAP_POSITIVE_X;
    @:GLConst var TEXTURE_CUBE_MAP_POSITIVE_Y;
    @:GLConst var TEXTURE_CUBE_MAP_POSITIVE_Z;
    @:GLConst var TEXTURE_CUBE_MAP_NEGATIVE_X;
    @:GLConst var TEXTURE_CUBE_MAP_NEGATIVE_Y;
    @:GLConst var TEXTURE_CUBE_MAP_NEGATIVE_Z;
    @:GLConst var PROXY_TEXTURE_CUBE_MAP;
    @:GLConst var RED;
    @:GLConst var RG;
    @:GLConst var RGB;
    @:GLConst var BGR;
    @:GLConst var RGBA;
    @:GLConst var BGRA;
    @:GLProc function texImage2D<T>(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, data:Array<T>):Void;
    @:GLConst var TEXTURE_BASE_LEVEL;
    @:GLConst var TEXTURE_COMPARE_FUNC;
    @:GLConst var TEXTURE_COMPARE_MODE;
    @:GLConst var TEXTURE_LOD_BIAS;
    @:GLConst var TEXTURE_MIN_FILTER;
    @:GLConst var TEXTURE_MAG_FILTER;
    @:GLConst var TEXTURE_MIN_LOD;
    @:GLConst var TEXTURE_MAX_LOD;
    @:GLConst var TEXTURE_MAX_LEVEL;
    @:GLConst var TEXTURE_SWIZZLE_R;
    @:GLConst var TEXTURE_SWIZZLE_G;
    @:GLConst var TEXTURE_SWIZZLE_B;
    @:GLConst var TEXTURE_SWIZZLE_A;
    @:GLConst var TEXTURE_WRAP_S;
    @:GLConst var TEXTURE_WRAP_T;
    @:GLConst var TEXTURE_WRAP_R;
    @:GLConst var COMPARE_REF_TO_TEXTURE;
    @:GLConst var LEQUAL;
    @:GLConst var GEQUAL;
    @:GLConst var LESS;
    @:GLConst var GREATER;
    @:GLConst var EQUAL;
    @:GLConst var NOTEQUAL;
    @:GLConst var ALWAYS;
    @:GLConst var NEVER;
    @:GLConst var NEAREST;
    @:GLConst var LINEAR;
    @:GLConst var NEAREST_MIPMAP_NEAREST;
    @:GLConst var LINEAR_MIPMAP_NEAREST;
    @:GLConst var NEAREST_MIPMAP_LINEAR;
    @:GLConst var LINEAR_MIPMAP_LINEAR;
    @:GLConst var ZERO;
    @:GLConst var ALPHA;
    @:GLConst var ONE;
    @:GLConst var BLUE;
    @:GLConst var GREEN;
    @:GLConst var CLAMP_TO_EDGE;
    @:GLConst var CLAMP_TO_BORDER;
    @:GLConst var MIRRORED_REPEAT;
    @:GLConst var REPEAT;
    @:GLProc function texParameteri(target:Int, pname:Int, param:Int):Void;
    @:GLProc function texParameterf(target:Int, pname:Int, param:Float):Void;

    // ================================================================================================
    // U
    // ================================================================================================
    @:GLProc function useProgram(program:Int):Void;

    // ================================================================================================
    // V
    // ================================================================================================
    @:GLConst var BYTE;
    @:GLConst var UNSIGNED_BYTE;
    @:GLConst var SHORT;
    @:GLConst var UNSIGNED_SHORT;
    @:GLConst var INT;
    @:GLConst var UNSIGNED_INT;
    @:GLConst var HALF_FLOAT;
    @:GLConst var FLOAT;
    @:GLConst var DOUBLE;
    @:GLConst var INT_2_10_10_10_REV;
    @:GLConst var UNSIGNED_INT_2_10_10_10_REV;
    @:GLProc function vertexAttribPointer(index:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int):Void;

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
}
