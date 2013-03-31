package ogl;

import #if cpp cpp #else neko #end.Lib;
import ogl.Macros;

abstract Buffer(BufferImp) from BufferImp to BufferImp {
    public inline function new(x:Dynamic) this = new BufferImp(x);

    @:allow(ogl)
    inline static function cvt(x:Dynamic):Buffer return BufferImp.cvt(x);

    @:arrayAccess public inline function get<T>(index:Int):T
        return untyped GL.load("Buffer_get_T", 2)(this.nativeObject, index);
    @:arrayAccess public inline function set<T>(index:Int, value:T):T
        return untyped GL.load("Buffer_set_T", 3)(this.nativeObject, index, value);
}

class BufferImp extends NativeBinding {
    @:allow(ogl)
    public function new(x:Dynamic) super(x);

    @:allow(ogl)
    static inline function cvt(x:Null<Dynamic>):Null<Buffer>
        return if (x == null) null else new Buffer(x);

    // GL type of elements.
    public var type(get,never):Int;
    inline function get_type() return GL.load("Buffer_get_type", 1)(nativeObject);
    // Total byte size of buffer.
    public var size(get,never):Int;
    inline function get_size() return GL.load("Buffer_get_size", 1)(nativeObject);
    // Number of elements in buffer.
    public var count(get,never):Int;
    inline function get_count() return GL.load("Buffer_get_count", 1)(nativeObject);
    // Raw pointer to buffer data.
    public var raw(get,never):{ref:Dynamic, raw:Dynamic};
    inline function get_raw() return {
        ref: nativeObject,
        raw: GL.load("Buffer_get_raw", 1)(nativeObject)
    };

    inline public function toString():String {
        var type = this.type;
        var name = (type == GL.UNSIGNED_BYTE  ? "GL_UNSIGNED_BYTE"  : type == GL.BYTE  ? "GL_BYTE"  :
                    type == GL.UNSIGNED_SHORT ? "GL_UNSIGNED_SHORT" : type == GL.SHORT ? "GL_SHORT" :
                    type == GL.UNSIGNED_INT   ? "GL_UNSIGNED_INT"   : type == GL.INT   ? "GL_INT"   :
                    type == GL.FLOAT          ? "GL_FLOAT" :
                    "UNKNOWN");
        return '{Buffer ${name}x$count}';
    }
}

abstract Vec3(Array<Float>) from Array<Float> to Array<Float> {
    public inline function new(x:Float, y:Float, z:Float) this = [x, y, z];

    // .xyz
//    public var x(get,set):Float; inline function get_x() return untyped this[0]; inline function set_x(x:Float) return untyped this[0] = x;
//    public var y(get,set):Float; inline function get_y() return this[1]; inline function set_y(y:Float) return this[1] = y;
//    public var z(get,set):Float; inline function get_z() return this[2]; inline function set_z(z:Float) return this[2] = z;

    // .rgb
//    public var r(get,set):Float; inline function get_r() return this[0]; inline function set_r(r:Float) return this[0] = r;
//    public var g(get,set):Float; inline function get_g() return this[1]; inline function set_g(g:Float) return this[1] = g;
//    public var b(get,set):Float; inline function get_b() return this[2]; inline function set_b(b:Float) return this[2] = b;

    // .uvw
//    public var u(get,set):Float; inline function get_u() return this[0]; inline function set_u(u:Float) return this[0] = u;
//    public var v(get,set):Float; inline function get_v() return this[1]; inline function set_v(v:Float) return this[1] = v;
//    public var w(get,set):Float; inline function get_w() return this[2]; inline function set_w(w:Float) return this[2] = w;

    // array access
    @:arrayAccess public inline function get(i:Int):Float return this[i];
    @:arrayAccess public inline function set(i:Int,x:Float):Float return this[i]=x;
}

abstract Mat4(Array<Float>) from Array<Float> to Array<Float> {
    public inline function new() this = identity();

    // array access
    @:arrayAccess public inline function get(i:Int):Float return this[i];
    @:arrayAccess public inline function set(i:Int,x:Float):Float return this[i]=x;

    public static inline function identity():Mat4
        return [1.0, 0.0, 0.0, 0.0,
                0.0, 1.0, 0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                0.0, 0.0, 0.0, 1.0];
    public static inline function translate(x:Float, y:Float, z:Float):Mat4
        return [1.0, 0.0, 0.0,  x,
                0.0, 1.0, 0.0,  y,
                0.0, 0.0, 1.0,  z,
                0.0, 0.0, 0.0, 1.0];
    public static inline function scale(x:Float, y:Float, z:Float):Mat4
        return [ x,  0.0, 0.0, 0.0,
                0.0,  y,  0.0, 0.0,
                0.0, 0.0,  z,  0.0,
                0.0, 0.0, 0.0, 1.0];
    public static inline function rotateX(angle:Float):Mat4 {
        var c = Math.cos(angle); var s = Math.sin(angle);
        return [1.0, 0.0, 0.0, 0.0,
                0.0,  c,   -s, 0.0,
                0.0,  s,   c,  0.0,
                0.0, 0.0, 0.0, 1.0];
    }
    public static inline function rotateY(angle:Float):Mat4 {
        var c = Math.cos(angle); var s = Math.sin(angle);
        return [ c,  0.0,  s,  0.0,
                0.0, 1.0, 0.0, 0.0,
                 -s, 0.0,  c,  0.0,
                0.0, 0.0, 0.0, 1.0];
    }
    public static inline function rotateZ(angle:Float):Mat4 {
        var c = Math.cos(angle); var s = Math.sin(angle);
        return [c,   -s, 0.0,  0.0,
                s,    c, 0.0,  0.0,
                0.0, 0.0, 1.0, 0.0,
                0.0, 0.0, 0.0, 1.0];
    }
    public static inline function perspective(fovY:Float, aspectRatio:Float, zNear:Float, zFar:Float):Mat4 {
        var f = 1.0/Math.tan(fovY/2);
        var t = 1.0/(zNear-zFar);
        return [f/aspectRatio, 0.0,      0.0,           0.0,
                      0.0,      f,       0.0,           0.0,
                      0.0,     0.0, (zFar+zNear)*t, 2*zFar*zNear*t,
                      0.0,     0.0,     -1.0,           0.0       ];
    }
    public static inline function lookAt(eye:Vec3, centre:Vec3, ?up:Null<Vec3>):Mat4 {
        var e0 = eye[0];
        var e1 = eye[1];
        var e2 = eye[2];

        var u0 = (up == null ? 0 : up[0]);
        var u1 = (up == null ? 1 : up[1]);
        var u2 = (up == null ? 0 : up[2]);

        var f0 = centre[0] - e0;
        var f1 = centre[1] - e1;
        var f2 = centre[2] - e2;
        var n = 1/Math.sqrt(f0*f0+f1*f1+f2*f2);
        f0 *= n;
        f1 *= n;
        f2 *= n;

        var s0 = f1*u2 - f2*u1;
        var s1 = f2*u0 - f0*u2;
        var s2 = f0*u1 - f1*u0;
        n = 1/Math.sqrt(s0*s0+s1*s1+s2*s2);
        s0 *= n;
        s1 *= n;
        s2 *= n;

        u0 = s1*f2 - s2*f1;
        u1 = s2*f0 - s0*f2;
        u2 = s0*f1 - s1*f0;

        return [s0, u0, -f0, -e0*s0 - e1*s1 - e2*s2,
                s1, u1, -f1, -e0*u0 - e1*u1 - e2*u2,
                s2, u2, -f2,  e0*f0 + e1*f1 + e2*f2,
                0,   0,   0,            1          ];
    }

    @:op(A*B) public static inline function mul(a:Mat4, b:Mat4):Mat4
        return [b[0]*a[0]  + b[4]*a[1]  + b[8] *a[2]  + b[12]*a[3],
                b[1]*a[0]  + b[5]*a[1]  + b[9] *a[2]  + b[13]*a[3],
                b[2]*a[0]  + b[6]*a[1]  + b[10]*a[2]  + b[14]*a[3],
                b[3]*a[0]  + b[7]*a[1]  + b[11]*a[2]  + b[15]*a[3],

                b[0]*a[4]  + b[4]*a[5]  + b[8] *a[6]  + b[12]*a[7],
                b[1]*a[4]  + b[5]*a[5]  + b[9] *a[6]  + b[13]*a[7],
                b[2]*a[4]  + b[6]*a[5]  + b[10]*a[6]  + b[14]*a[7],
                b[3]*a[4]  + b[7]*a[5]  + b[11]*a[6]  + b[15]*a[7],

                b[0]*a[8]  + b[4]*a[9]  + b[8] *a[10] + b[12]*a[11],
                b[1]*a[8]  + b[5]*a[9]  + b[9] *a[10] + b[13]*a[11],
                b[2]*a[8]  + b[6]*a[9]  + b[10]*a[10] + b[14]*a[11],
                b[3]*a[8]  + b[7]*a[9]  + b[11]*a[10] + b[15]*a[11],

                b[0]*a[12] + b[4]*a[13] + b[8] *a[14] + b[12]*a[15],
                b[1]*a[12] + b[5]*a[13] + b[9] *a[14] + b[13]*a[15],
                b[2]*a[12] + b[6]*a[13] + b[10]*a[14] + b[14]*a[15],
                b[3]*a[12] + b[7]*a[13] + b[11]*a[14] + b[15]*a[15]];
}

class GL implements GLConsts implements GLProcs {
    @:allow(ogl)
    static inline function load(n:String, p:Int):Dynamic
        return Lib.load("ogl","hx_gl_"+n, p);

    // Haxe specific interfaces.
    @:GLProc(createBuffer)    function buffer<T>(data:Array<T>, type:Int):Buffer;
    @:GLProc(createBufferRaw) function rawBuffer(data:{ref:Dynamic,raw:Dynamic}, size:Int, type:Int, nogc:Bool=false):Buffer
        return Buffer.cvt(load("createBufferRaw", 4)(data.raw, size, type, nogc));

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
    @:GLConst var SRC_COLOR;
    @:GLConst var ONE_MINUS_SRC_COLOR;
    @:GLConst var DST_COLOR;
    @:GLConst var ONE_MINUS_DST_COLOR;
    @:GLConst var SRC_ALPHA;
    @:GLConst var ONE_MINUS_SRC_ALPHA;
    @:GLConst var DST_ALPHA;
    @:GLConst var ONE_MINUS_DST_ALPHA;
    @:GLConst var CONSTANT_COLOR;
    @:GLConst var ONE_MINUS_CONSTANT_COLOR;
    @:GLConst var CONSTANT_ALPHA;
    @:GLConst var ONE_MINUS_CONSTANT_ALPHA;
    @:GLConst var SRC_ALPHA_SATURATE;
    @:GLConst var SRC1_COLOR;
    @:GLConst var ONE_MINUS_SRC1_COLOR;
    @:GLConst var SRC1_ALPHA;
    @:GLConst var ONE_MINUS_SRC1_ALPHA;
    @:GLProc function blendFunc(sfactor:Int, dfactor:Int):Void;
    @:GLConst var STREAM_DRAW;
    @:GLConst var STREAM_READ;
    @:GLConst var STREAM_COPY;
    @:GLConst var STATIC_DRAW;
    @:GLConst var STATIC_READ;
    @:GLConst var STATIC_COPY;
    @:GLConst var DYNAMIC_DRAW;
    @:GLConst var DYNAMIC_READ;
    @:GLConst var DYNAMIC_COPY;
    @:GLProc function bufferData(target:Int, data:Buffer, usage:Int):Void;

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
    @:GLProc function depthFunc(func:Int):Void;
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
    @:GLConst var BLEND;
    @:GLConst var COLOR_LOGIC_OP;
    @:GLConst var CULL_FACE;
    @:GLConst var DEPTH_CLAMP;
    @:GLConst var DEPTH_TEST;
    @:GLConst var DITHER;
    @:GLConst var FRAMEBUFFER_SRGB;
    @:GLConst var LINE_SMOOTH;
    @:GLConst var MULTISAMPLE;
    @:GLConst var POLYGON_OFFSET_FILL;
    @:GLConst var POLYGON_OFFSET_LINE;
    @:GLConst var POLYGON_OFFSET_POINT;
    @:GLConst var POLYGON_SMOOTH;
    @:GLConst var PRIMITIVE_RESTART;
    @:GLConst var SAMPLE_ALPHA_TO_COVERAGE;
    @:GLConst var SAMPLE_ALPHA_TO_ONE;
    @:GLConst var SAMPLE_COVERAGE;
    @:GLConst var SCISSOR_TEST;
    @:GLConst var STENCIL_TEST;
    @:GLConst var TEXTURE_CUBE_MAP_SEAMLESS;
    @:GLConst var PROGRAM_POINT_SIZE;
    @:GLProc function enable(flag:Int):Void;
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
    @:GLProc function getUniformLocation(program:Int, name:String):Int;

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
    @:GLProc function texImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, data:Buffer):Void;
    @:GLProc function texSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, type:Int, data:Buffer):Void;
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
    @:GLProc function uniformMatrix4fv(location:Int, count:Int, transpose:Bool, data:Array<Float>):Void;

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
    @:GLProc function viewport(x:Int, y:Int, width:Int, height:Int):Void;

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
