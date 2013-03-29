package ogl;

import #if cpp cpp #else neko #end.Lib;
import ogl.Macros;

class GL implements GLConsts implements GLProcs {
    static inline function load(n:String, p:Int):Dynamic
        return Lib.load("ogl","hx_gl_"+n, p);

    // A
    @:GLProc function attachShader(program:Int, shader:Int):Void;
    // B
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
    @:GLProc function bufferData(target:Int, data:Array<Float>, usage:Int) {
        load("bufferData_float", 3)(target, data, usage);
    }
    // C
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
    // D
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
    // E
    @:GLProc function enableVertexAttribArray(index:Int):Void;
    // F
    // G
    @:GLProc function genBuffers(n:Int):Array<Int> {
        var buffers = [];
        load("genBuffers", 2)(n, buffers);
        return buffers;
    }
    @:GLProc function genVertexArrays(n:Int):Array<Int> {
        var arrays = [];
        load("genVertexArrays", 2)(n, arrays);
        return arrays;
    }
    // H
    // I
    // J
    // K
    // L
    @:GLProc function linkProgram(program:Int):Void {
        var err:Null<String> = load("linkProgram", 1)(program);
        if (err != null) throw err;
    }
    // M
    // N
    // O
    // P
    // Q
    // R
    // S
    @:GLProc function shaderSource(shader:Int, source:String):Void {
        load("shaderSource", 2)(shader, [source]);
    }
    // T
    // U
    @:GLProc function useProgram(program:Int):Void;
    // V
    @:GLConst var BGRA;
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
    // W
    // X
    // Y
    // Z
}
