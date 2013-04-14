package ogl;

import #if cpp cpp #else neko #end.Lib;
import ogl.Macros;

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

abstract GLubyteArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 1, GL.UNSIGNED_BYTE);
    @:from public static inline function fromRaw(raw:BytesData) return new GLubyteArray(raw);
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;
    @:arrayAccess public inline function get(i:Int):GLubyte {
        var byte = untyped __global__.__hxcpp_memory_get_byte(this.buffer, i);
        return (byte < 0) ? (byte & 0xff) | 0x80 : byte;
    }
    @:arrayAccess public inline function set(i:Int, x:GLubyte):GLubyte {
        untyped __global__.__hxcpp_memory_set_byte(this.buffer, i, x&0xff);
        return get(this, i);
    }
    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLbyteArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 1, GL.BYTE);
    @:from public static inline function fromRaw(raw:BytesData) return new GLbyteArray(raw);
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;
    @:arrayAccess public inline function get(i:Int):GLbyte {
        var byte = untyped __global__.__hxcpp_memory_get_byte(this.buffer, i);
        return (byte < 0) ? (byte & 0xff) | 0x80 : byte;
    }
    @:arrayAccess public inline function set(i:Int, x:GLbyte):GLbyte {
        untyped __global__.__hxcpp_memory_set_byte(this.buffer, i, x&0xff);
        return get(this, i);
    }
    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLushortArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 2, GL.UNSIGNED_SHORT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLushortArray(raw);
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;
    @:arrayAccess public inline function get(i:Int):GLushort
        return untyped __global__.__hxcpp_memory_get_ui16(this.buffer, i*2);
    @:arrayAccess public inline function set(i:Int, x:GLushort):GLushort {
        untyped __global__.__hxcpp_memory_set_i16(this.buffer, i*2, x);
        return get(this, i);
    }
    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLshortArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 2, GL.SHORT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLshortArray(raw);
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;
    @:arrayAccess public inline function get(i:Int):GLshort
        return untyped __global__.__hxcpp_memory_get_ui16(this.buffer, i*2);
    @:arrayAccess public inline function set(i:Int, x:GLshort):GLshort {
        untyped __global__.__hxcpp_memory_set_i16(this.buffer, i*2, x);
        return get(this, i);
    }
    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLuintArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 4, GL.UNSIGNED_INT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLuintArray(raw);
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;
    @:arrayAccess public inline function get(i:Int):GLuint
        return untyped __global__.__hxcpp_memory_get_i32(this.buffer, i*4);
    @:arrayAccess public inline function set(i:Int, x:GLuint):GLuint {
        untyped __global__.__hxcpp_memory_set_i32(this.buffer, i*4, x);
        return get(this, i);
    }
    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLintArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 4, GL.INT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLintArray(raw);
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;
    @:arrayAccess public inline function get(i:Int):GLint
        return untyped __global__.__hxcpp_memory_get_i32(this.buffer, i*4);
    @:arrayAccess public inline function set(i:Int, x:GLint):GLint {
        untyped __global__.__hxcpp_memory_set_i32(this.buffer, i*4, x);
        return get(this, i);
    }
    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLfloatArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 4, GL.FLOAT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLfloatArray(raw);
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;
    @:arrayAccess public inline function get(i:Int):GLfloat
        return untyped __global__.__hxcpp_memory_get_float(this.buffer, i*4);
    @:arrayAccess public inline function set<T>(i:Int, x:T):GLfloat {
        untyped __global__.__hxcpp_memory_set_float(this.buffer, i*4, x);
        return get(this, i);
    }
    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLdoubleArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 8, GL.DOUBLE);
    @:from public static inline function fromRaw(raw:BytesData) return new GLdoubleArray(raw);
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;
    @:arrayAccess public inline function get(i:Int):GLdouble
        return untyped __global__.__hxcpp_memory_get_double(this.buffer, i*8);
    @:arrayAccess public inline function set<T>(i:Int, x:T):GLdouble {
        untyped __global__.__hxcpp_memory_set_double(this.buffer, i*8, x);
        return get(this, i);
    }
    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

class GLArray {
    public var size:Int;
    public var type:GLenum;
    public var buffer:BytesData;
    public var count(get, never):Int;
    inline function get_count() return Std.int(buffer.length / size);
    public function new(buffer:BytesData, size:Int, type:Int) {
        this.buffer = buffer;
        this.size = size;
        this.type = type;
    }
}

@:build(ogl.GLVector.run(2)) abstract Vec2(Array<Float>) from Array<Float> to Array<Float> {
    public inline function new(x:Float, y:Float) this = [x, y];
    @:from public static inline function fromIntArray(xs:Array<Int>) return new Vec2(xs[0],xs[1]);

    // .xy
    public var x(get,set):Float; inline function get_x() return this[0]; inline function set_x(x:Float) return this[0] = x;
    public var y(get,set):Float; inline function get_y() return this[1]; inline function set_y(y:Float) return this[1] = y;

    // .rg
    public var r(get,set):Float; inline function get_r() return this[0]; inline function set_r(r:Float) return this[0] = r;
    public var g(get,set):Float; inline function get_g() return this[1]; inline function set_g(g:Float) return this[1] = g;

    // .st
    public var s(get,set):Float; inline function get_s() return this[0]; inline function set_s(s:Float) return this[0] = s;
    public var t(get,set):Float; inline function get_t() return this[1]; inline function set_t(t:Float) return this[1] = t;

    // array access
    @:arrayAccess public inline function geti(i:Int):Float return this[i];
    @:arrayAccess public inline function getf(i:Int):Float return this[i];
    @:arrayAccess public inline function seti(i:Int,x:Int)  :Float return this[i]=x;
    @:arrayAccess public inline function setf(i:Int,x:Float):Float return this[i]=x;
}

@:build(ogl.GLVector.run(3)) abstract Vec3(Array<Float>) from Array<Float> to Array<Float> {
    public inline function new(x:Float, y:Float, z:Float) this = [x, y, z];
    @:from public static inline function fromIntArray(xs:Array<Int>) return new Vec3(xs[0],xs[1],xs[2]);

    // .xyz
    public var x(get,set):Float; inline function get_x() return this[0]; inline function set_x(x:Float) return this[0] = x;
    public var y(get,set):Float; inline function get_y() return this[1]; inline function set_y(y:Float) return this[1] = y;
    public var z(get,set):Float; inline function get_z() return this[2]; inline function set_z(z:Float) return this[2] = z;

    // .rgb
    public var r(get,set):Float; inline function get_r() return this[0]; inline function set_r(r:Float) return this[0] = r;
    public var g(get,set):Float; inline function get_g() return this[1]; inline function set_g(g:Float) return this[1] = g;
    public var b(get,set):Float; inline function get_b() return this[2]; inline function set_b(b:Float) return this[2] = b;

    // .stp
    public var s(get,set):Float; inline function get_s() return this[0]; inline function set_s(s:Float) return this[0] = s;
    public var t(get,set):Float; inline function get_t() return this[1]; inline function set_t(t:Float) return this[1] = t;
    public var p(get,set):Float; inline function get_p() return this[2]; inline function set_p(p:Float) return this[2] = p;

    // array access
    @:arrayAccess public inline function geti(i:Int):Float return this[i];
    @:arrayAccess public inline function getf(i:Int):Float return this[i];
    @:arrayAccess public inline function seti(i:Int,x:Int)  :Float return this[i]=x;
    @:arrayAccess public inline function setf(i:Int,x:Float):Float return this[i]=x;
}

@:build(ogl.GLVector.run(4)) abstract Vec4(Array<Float>) from Array<Float> to Array<Float> {
    public inline function new(x:Float, y:Float, z:Float, w:Float) this = [x, y, z, w];
    @:from public static inline function fromIntArray(xs:Array<Int>) return new Vec4(xs[0],xs[1],xs[2],xs[3]);

    // .xyzw
    public var x(get,set):Float; inline function get_x() return this[0]; inline function set_x(x:Float) return this[0] = x;
    public var y(get,set):Float; inline function get_y() return this[1]; inline function set_y(y:Float) return this[1] = y;
    public var z(get,set):Float; inline function get_z() return this[2]; inline function set_z(z:Float) return this[2] = z;
    public var w(get,set):Float; inline function get_w() return this[2]; inline function set_w(w:Float) return this[2] = w;

    // .rgba
    public var r(get,set):Float; inline function get_r() return this[0]; inline function set_r(r:Float) return this[0] = r;
    public var g(get,set):Float; inline function get_g() return this[1]; inline function set_g(g:Float) return this[1] = g;
    public var b(get,set):Float; inline function get_b() return this[2]; inline function set_b(b:Float) return this[2] = b;
    public var a(get,set):Float; inline function get_a() return this[2]; inline function set_a(a:Float) return this[2] = a;

    // .stpq
    public var s(get,set):Float; inline function get_s() return this[0]; inline function set_s(s:Float) return this[0] = s;
    public var t(get,set):Float; inline function get_t() return this[1]; inline function set_t(t:Float) return this[1] = t;
    public var p(get,set):Float; inline function get_p() return this[2]; inline function set_p(p:Float) return this[2] = p;
    public var q(get,set):Float; inline function get_q() return this[2]; inline function set_q(q:Float) return this[2] = q;

    // array access
    @:arrayAccess public inline function geti(i:Int):Float return this[i];
    @:arrayAccess public inline function getf(i:Int):Float return this[i];
    @:arrayAccess public inline function seti(i:Int,x:Int)  :Float return this[i]=x;
    @:arrayAccess public inline function setf(i:Int,x:Float):Float return this[i]=x;
}

abstract Mat2x3(Array<Float>) from Array<Float> to Array<Float> {
    public inline function new() this = identity();

    // array access
    @:arrayAccess public inline function get(i:Int):Float return this[i];
    @:arrayAccess public inline function set(i:Int,x:Float):Float return this[i]=x;

    public static inline function identity():Mat2x3
        return [1.0, 0.0, 0.0,
                0.0, 1.0, 0.0];

    // (x, y) => (2*x/w - 1, 1 - 2*y/h)
    public static inline function viewportMap(width:Float, height:Float):Mat2x3
        return [2.0/width,  0.0, -1,
                0.0, -2.0/height, 1];

    @:op(A*B) public static inline function mul(a:Mat2x3, b:Mat2x3):Mat2x3
        return [b[0]*a[0] + b[3]*a[1],
                b[1]*a[0] + b[4]*a[1],
                b[2]*a[0] + b[5]*a[1] + a[2],

                b[0]*a[3] + b[3]*a[4],
                b[1]*a[3] + b[4]*a[4],
                b[2]*a[3] + b[5]*a[4] + a[5]];
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
        var e0 = eye.x;
        var e1 = eye.y;
        var e2 = eye.z;

        var u0 = (up == null ? 0 : up.x);
        var u1 = (up == null ? 1 : up.y);
        var u2 = (up == null ? 0 : up.z);

        var f0 = centre.x - e0;
        var f1 = centre.y - e1;
        var f2 = centre.z - e2;
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

    // Vector constructors (functional)
    @:GLProc function v2(x:Float, y:Float):Vec2 return new Vec2(x,y);
    @:GLProc function v3(x:Float, y:Float, z:Float):Vec3 return new Vec3(x,y,z);
    @:GLProc function v4(x:Float, y:Float, z:Float, w:Float):Vec4 return new Vec4(x,y,z,w);

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
    @:GLProc function bufferData(target:GLenum, data:GLArray, usage:GLenum, ?count:Null<Int>) {
        if (count == null) count = data.count;
        load("bufferData", 4)(target, data.size*count, data.buffer, usage);
    }
    @:GLProc function bufferSubData(target:GLenum, countOffset:Int, data:GLArray, ?count:Null<Int>) {
        if (count == null) count = data.count;
        load("bufferSubData", 4)(target, countOffset*data.size, count*data.size, data.buffer);
    }

    // ================================================================================================
    // C
    // ================================================================================================
    @:GLProc function checkFramebufferStatus(target:GLenum):Void;
    @:GLProc function clampColor(target:GLenum, clamp:GLenum):Void;
    @:GLProc function clear(mask:GLbitfield):Void;
    @:GLProc function clearBufferiv(buffer:GLenum, drawBuffer:GLint, value:GLintArray):Void
        load("clearBufferiv", 3)(buffer, drawBuffer, value.raw);
    @:GLProc function clearBufferuiv(buffer:GLenum, drawBuffer:GLint, value:GLuintArray):Void
        load("clearBufferuiv", 3)(buffer, drawBuffer, value.raw);
    @:GLProc function clearBufferfv(buffer:GLenum, drawBuffer:GLint, value:GLfloatArray):Void
        load("clearBufferfv", 3)(buffer, drawBuffer, value.raw);
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
        load("compressedTexImage1D", 7)(target, level, data.type, width, border, data.buffer.length, data.buffer);
    @:GLProc function compressedTexImage2D(target:GLenum, level:GLint, width:GLsizei, height:GLsizei, border:GLint, data:GLArray):Void
        load("compressedTexImage2D", 8)(target, level, data.type, width, height, border, data.buffer.length, data.buffer);
    @:GLProc function compressedTexImage3D(target:GLenum, level:GLint, width:GLsizei, height:GLsizei, depth:GLsizei, border:GLint, data:GLArray):Void
        load("compressedTexImage3D", 9)(target, level, data.type, width, height, depth, border, data.buffer.length, data.buffer);
    @:GLProc function compressedTexSubImage1D(target:GLenum, level:GLint, xOffset:GLint, width:GLsizei, data:GLArray):Void
        load("compressedTexSubImage1D", 7)(target, level, xOffset, width, data.type, data.buffer.length, data.buffer);
    @:GLProc function compressedTexSubImage2D(target:GLenum, level:GLint, xOffset:GLint, yOffset:GLint, width:GLsizei, height:GLsizei, data:GLArray):Void
        load("compressedTexSubImage2D", 9)(target, level, xOffset, yOffset, width, height, data.type, data.buffer.length, data.buffer);
    @:GLProc function compressedTexSubImage3D(target:GLenum, level:GLint, xOffset:GLint, yOffset:GLint, zOffset:GLint, width:GLsizei, height:GLsizei, depth:GLsizei, data:GLArray):Void
        load("compressedTexSubImage3D", 11)(target, level, xOffset, yOffset, zOffset, width, height, depth, data.type, data.buffer.length, data.buffer);
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
        load("drawElements", 4)(mode, count, indices.type, indices.buffer);
    @:GLProc function drawElementsBaseVertex(mode:GLenum, count:GLsizei, indices:GLArray, baseVertex:GLint):Void
        load("drawElementsBaseVertex", 5)(mode, count, indices.type, indices.buffer, baseVertex);
    @:GLProc function drawElementsInstanced(mode:GLenum, count:GLsizei, indices:GLArray, primCount:GLsizei):Void
        load("drawElementsInstanced", 5)(mode, count, indices.type, indices.buffer, primCount);
    @:GLProc function drawElementsInstancedBaseVertex(mode:GLenum, count:GLsizei, indices:GLArray, primCount:GLsizei, baseVertex:GLint):Void
        load("drawElementsInstancedBaseVertex", 6)(mode, count, indices.type, indices.buffer, primCount, baseVertex);
    @:GLProc function drawRangeElements(mode:GLenum, start:GLuint, end:GLuint, count:GLsizei, indices:GLArray):Void
        load("drawRangeElements", 6)(mode, start, end, count, indices.type, indices.buffer);
    @:GLProc function drawRangeElementsBaseVertex(mode:GLenum, start:GLuint, end:GLuint, count:GLsizei, indices:GLArray, baseVertex:GLint):Void
        load("drawRangeElementsBaseVertex", 7)(mode, start, end, count, indices.type, indices.buffer, baseVertex);

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
        load("getBufferSubData", 4)(target, offset, size, data.buffer);
    @:GLProc function getCompressedTexImage(target:GLenum, lod:GLint, img:GLArray):Void
        load("getCompressedTexImage", 3)(target, lod, img.buffer);
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
        load("getTexImage", 5)(target, level, format, img.type, img.buffer);
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
        for (i in indices) cindices.push(i.buffer);
        load("multiDrawElements", 4)(mode, count, indices[0].type, cindices);
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
        for (i in indices) cindices.push(i.buffer);
        load("multiDrawElementsBaseVertex", 5)(mode, count, indices[0].type, cindices, baseVertex);
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
        load("readPixels", 7)(x, y, width, height, format, data.type, data.buffer);
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
    @:GLProc function texImage2D(target:Int, level:Int, internalFormat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, data:GLArray):Void
        load("texImage2D", 9)(target, level, internalFormat, width, height, border, format, type, data.buffer);
    @:GLProc function texSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, type:Int, data:GLArray):Void
        load("texSubImage2D", 9)(target, level, xoffset, yoffset, width, height, format, type, data.buffer);
    @:GLProc function texParameteri(target:Int, pname:Int, param:Int):Void;
    @:GLProc function texParameterf(target:Int, pname:Int, param:Float):Void;

    // ================================================================================================
    // U
    // ================================================================================================
    @:GLProc function uniformMatrix2x3fv(location:Int, count:Int, transpose:Bool, data:Array<Float>):Void;
    @:GLProc function uniformMatrix4fv(location:Int, count:Int, transpose:Bool, data:Array<Float>):Void;
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
    @:GLProc function vertexAttrib1fv  (index:GLuint, v:GLfloatArray ):Void;
    @:GLProc function vertexAttrib1sv  (index:GLuint, v:GLshortArray ):Void;
    @:GLProc function vertexAttrib1dv  (index:GLuint, v:GLdoubleArray):Void;
    @:GLProc function vertexAttribI1iv (index:GLuint, v:GLintArray   ):Void;
    @:GLProc function vertexAttribI1uiv(index:GLuint, v:GLuintArray  ):Void;
    @:GLProc function vertexAttrib2fv  (index:GLuint, v:GLfloatArray ):Void;
    @:GLProc function vertexAttrib2sv  (index:GLuint, v:GLshortArray ):Void;
    @:GLProc function vertexAttrib2dv  (index:GLuint, v:GLdoubleArray):Void;
    @:GLProc function vertexAttribI2iv (index:GLuint, v:GLintArray   ):Void;
    @:GLProc function vertexAttribI2uiv(index:GLuint, v:GLuintArray  ):Void;
    @:GLProc function vertexAttrib3fv  (index:GLuint, v:GLfloatArray ):Void;
    @:GLProc function vertexAttrib3sv  (index:GLuint, v:GLshortArray ):Void;
    @:GLProc function vertexAttrib3dv  (index:GLuint, v:GLdoubleArray):Void;
    @:GLProc function vertexAttribI3iv (index:GLuint, v:GLintArray   ):Void;
    @:GLProc function vertexAttribI3uiv(index:GLuint, v:GLuintArray  ):Void;
    @:GLProc function vertexAttrib4fv  (index:GLuint, v:GLfloatArray ):Void;
    @:GLProc function vertexAttrib4sv  (index:GLuint, v:GLshortArray ):Void;
    @:GLProc function vertexAttrib4dv  (index:GLuint, v:GLdoubleArray):Void;
    @:GLProc function vertexAttrib4Nubv(index:GLuint, v:GLubyteArray ):Void;
    @:GLProc function vertexAttribI4iv (index:GLuint, v:GLintArray   ):Void;
    @:GLProc function vertexAttribI4uiv(index:GLuint, v:GLuintArray  ):Void;
    @:GLProc function vertexAttrib4iv  (index:GLuint, v:GLintArray   ):Void;
    @:GLProc function vertexAttrib4bv  (index:GLuint, v:GLbyteArray  ):Void;
    @:GLProc function vertexAttrib4ubv (index:GLuint, v:GLubyteArray ):Void;
    @:GLProc function vertexAttrib4usv (index:GLuint, v:GLushortArray):Void;
    @:GLProc function vertexAttrib4uiv (index:GLuint, v:GLuintArray  ):Void;
    @:GLProc function vertexAttrib4Nbv (index:GLuint, v:GLbyteArray  ):Void;
    @:GLProc function vertexAttrib4Nsv (index:GLuint, v:GLshortArray ):Void;
    @:GLProc function vertexAttrib4Niv (index:GLuint, v:GLintArray   ):Void;
    @:GLProc function vertexAttrib4Nusv(index:GLuint, v:GLushortArray):Void;
    @:GLProc function vertexAttrib4Nuiv(index:GLuint, v:GLuintArray  ):Void;
    @:GLProc function vertexAttribI4bv (index:GLuint, v:GLbyteArray  ):Void;
    @:GLProc function vertexAttribI4ubv(index:GLuint, v:GLubyteArray ):Void;
    @:GLProc function vertexAttribI4sv (index:GLuint, v:GLshortArray ):Void;
    @:GLProc function vertexAttribDivisor(index:GLuint, divisor:GLuint):Void;
    @:GLProc function vertexAttribPointer(index:GLuint, size:GLint, type:GLenum, normalized:GLboolean, stride:GLsizei, offset:GLsizei):Void;
    @:GLProc function vertexAttribIPointer(index:GLuint, size:GLint, type:GLenum, stride:GLsizei, offset:GLsizei):Void;
    @:GLProc function viewport(x:GLint, y:GLint, width:GLsizei, height:GLsizei):Void;

    // ================================================================================================
    // W
    // ================================================================================================
    @:GLProc function waitSync(sync:GLsync, flags:GLbitfield, timeout:GLuint64):Void
        load("waitSync", 4)(NativeBinding.native(sync), flags, haxe.Int64.getLow(timeout), haxe.Int64.getHigh(timeout));

    // GL_VERSION_1_1 CONSTS
    @:GLConst var ZERO;
    @:GLConst var FALSE;
    @:GLConst var LOGIC_OP;
    @:GLConst var NONE;
    @:GLConst var TEXTURE_COMPONENTS;
    @:GLConst var NO_ERROR;
    @:GLConst var POINTS;
    @:GLConst var CURRENT_BIT;
    @:GLConst var TRUE;
    @:GLConst var ONE;
    @:GLConst var CLIENT_PIXEL_STORE_BIT;
    @:GLConst var LINES;
    @:GLConst var LINE_LOOP;
    @:GLConst var POINT_BIT;
    @:GLConst var CLIENT_VERTEX_ARRAY_BIT;
    @:GLConst var LINE_STRIP;
    @:GLConst var LINE_BIT;
    @:GLConst var TRIANGLES;
    @:GLConst var TRIANGLE_STRIP;
    @:GLConst var TRIANGLE_FAN;
    @:GLConst var QUADS;
    @:GLConst var QUAD_STRIP;
    @:GLConst var POLYGON_BIT;
    @:GLConst var POLYGON;
    @:GLConst var POLYGON_STIPPLE_BIT;
    @:GLConst var PIXEL_MODE_BIT;
    @:GLConst var LIGHTING_BIT;
    @:GLConst var FOG_BIT;
    @:GLConst var DEPTH_BUFFER_BIT;
    @:GLConst var ACCUM;
    @:GLConst var LOAD;
    @:GLConst var RETURN;
    @:GLConst var MULT;
    @:GLConst var ADD;
    @:GLConst var NEVER;
    @:GLConst var ACCUM_BUFFER_BIT;
    @:GLConst var LESS;
    @:GLConst var EQUAL;
    @:GLConst var LEQUAL;
    @:GLConst var GREATER;
    @:GLConst var NOTEQUAL;
    @:GLConst var GEQUAL;
    @:GLConst var ALWAYS;
    @:GLConst var SRC_COLOR;
    @:GLConst var ONE_MINUS_SRC_COLOR;
    @:GLConst var SRC_ALPHA;
    @:GLConst var ONE_MINUS_SRC_ALPHA;
    @:GLConst var DST_ALPHA;
    @:GLConst var ONE_MINUS_DST_ALPHA;
    @:GLConst var DST_COLOR;
    @:GLConst var ONE_MINUS_DST_COLOR;
    @:GLConst var SRC_ALPHA_SATURATE;
    @:GLConst var STENCIL_BUFFER_BIT;
    @:GLConst var FRONT_LEFT;
    @:GLConst var FRONT_RIGHT;
    @:GLConst var BACK_LEFT;
    @:GLConst var BACK_RIGHT;
    @:GLConst var FRONT;
    @:GLConst var BACK;
    @:GLConst var LEFT;
    @:GLConst var RIGHT;
    @:GLConst var FRONT_AND_BACK;
    @:GLConst var AUX0;
    @:GLConst var AUX1;
    @:GLConst var AUX2;
    @:GLConst var AUX3;
    @:GLConst var INVALID_ENUM;
    @:GLConst var INVALID_VALUE;
    @:GLConst var INVALID_OPERATION;
    @:GLConst var STACK_OVERFLOW;
    @:GLConst var STACK_UNDERFLOW;
    @:GLConst var OUT_OF_MEMORY;
    @:GLConst("2D") var _2D;
    @:GLConst("3D") var _3D;
    @:GLConst("3D_COLOR") var _3D_COLOR;
    @:GLConst("3D_COLOR_TEXTURE") var _3D_COLOR_TEXTURE;
    @:GLConst("4D_COLOR_TEXTURE") var _4D_COLOR_TEXTURE;
    @:GLConst var PASS_THROUGH_TOKEN;
    @:GLConst var POINT_TOKEN;
    @:GLConst var LINE_TOKEN;
    @:GLConst var POLYGON_TOKEN;
    @:GLConst var BITMAP_TOKEN;
    @:GLConst var DRAW_PIXEL_TOKEN;
    @:GLConst var COPY_PIXEL_TOKEN;
    @:GLConst var LINE_RESET_TOKEN;
    @:GLConst var EXP;
    @:GLConst var VIEWPORT_BIT;
    @:GLConst var EXP2;
    @:GLConst var CW;
    @:GLConst var CCW;
    @:GLConst var COEFF;
    @:GLConst var ORDER;
    @:GLConst var DOMAIN;
    @:GLConst var CURRENT_COLOR;
    @:GLConst var CURRENT_INDEX;
    @:GLConst var CURRENT_NORMAL;
    @:GLConst var CURRENT_TEXTURE_COORDS;
    @:GLConst var CURRENT_RASTER_COLOR;
    @:GLConst var CURRENT_RASTER_INDEX;
    @:GLConst var CURRENT_RASTER_TEXTURE_COORDS;
    @:GLConst var CURRENT_RASTER_POSITION;
    @:GLConst var CURRENT_RASTER_POSITION_VALID;
    @:GLConst var CURRENT_RASTER_DISTANCE;
    @:GLConst var POINT_SMOOTH;
    @:GLConst var POINT_SIZE;
    @:GLConst var POINT_SIZE_RANGE;
    @:GLConst var POINT_SIZE_GRANULARITY;
    @:GLConst var LINE_SMOOTH;
    @:GLConst var LINE_WIDTH;
    @:GLConst var LINE_WIDTH_RANGE;
    @:GLConst var LINE_WIDTH_GRANULARITY;
    @:GLConst var LINE_STIPPLE;
    @:GLConst var LINE_STIPPLE_PATTERN;
    @:GLConst var LINE_STIPPLE_REPEAT;
    @:GLConst var LIST_MODE;
    @:GLConst var MAX_LIST_NESTING;
    @:GLConst var LIST_BASE;
    @:GLConst var LIST_INDEX;
    @:GLConst var POLYGON_MODE;
    @:GLConst var POLYGON_SMOOTH;
    @:GLConst var POLYGON_STIPPLE;
    @:GLConst var EDGE_FLAG;
    @:GLConst var CULL_FACE;
    @:GLConst var CULL_FACE_MODE;
    @:GLConst var FRONT_FACE;
    @:GLConst var LIGHTING;
    @:GLConst var LIGHT_MODEL_LOCAL_VIEWER;
    @:GLConst var LIGHT_MODEL_TWO_SIDE;
    @:GLConst var LIGHT_MODEL_AMBIENT;
    @:GLConst var SHADE_MODEL;
    @:GLConst var COLOR_MATERIAL_FACE;
    @:GLConst var COLOR_MATERIAL_PARAMETER;
    @:GLConst var COLOR_MATERIAL;
    @:GLConst var FOG;
    @:GLConst var FOG_INDEX;
    @:GLConst var FOG_DENSITY;
    @:GLConst var FOG_START;
    @:GLConst var FOG_END;
    @:GLConst var FOG_MODE;
    @:GLConst var FOG_COLOR;
    @:GLConst var DEPTH_RANGE;
    @:GLConst var DEPTH_TEST;
    @:GLConst var DEPTH_WRITEMASK;
    @:GLConst var DEPTH_CLEAR_VALUE;
    @:GLConst var DEPTH_FUNC;
    @:GLConst var ACCUM_CLEAR_VALUE;
    @:GLConst var STENCIL_TEST;
    @:GLConst var STENCIL_CLEAR_VALUE;
    @:GLConst var STENCIL_FUNC;
    @:GLConst var STENCIL_VALUE_MASK;
    @:GLConst var STENCIL_FAIL;
    @:GLConst var STENCIL_PASS_DEPTH_FAIL;
    @:GLConst var STENCIL_PASS_DEPTH_PASS;
    @:GLConst var STENCIL_REF;
    @:GLConst var STENCIL_WRITEMASK;
    @:GLConst var MATRIX_MODE;
    @:GLConst var NORMALIZE;
    @:GLConst var VIEWPORT;
    @:GLConst var MODELVIEW_STACK_DEPTH;
    @:GLConst var PROJECTION_STACK_DEPTH;
    @:GLConst var TEXTURE_STACK_DEPTH;
    @:GLConst var MODELVIEW_MATRIX;
    @:GLConst var PROJECTION_MATRIX;
    @:GLConst var TEXTURE_MATRIX;
    @:GLConst var ATTRIB_STACK_DEPTH;
    @:GLConst var CLIENT_ATTRIB_STACK_DEPTH;
    @:GLConst var ALPHA_TEST;
    @:GLConst var ALPHA_TEST_FUNC;
    @:GLConst var ALPHA_TEST_REF;
    @:GLConst var DITHER;
    @:GLConst var BLEND_DST;
    @:GLConst var BLEND_SRC;
    @:GLConst var BLEND;
    @:GLConst var LOGIC_OP_MODE;
    @:GLConst var INDEX_LOGIC_OP;
    @:GLConst var COLOR_LOGIC_OP;
    @:GLConst var AUX_BUFFERS;
    @:GLConst var DRAW_BUFFER;
    @:GLConst var READ_BUFFER;
    @:GLConst var SCISSOR_BOX;
    @:GLConst var SCISSOR_TEST;
    @:GLConst var INDEX_CLEAR_VALUE;
    @:GLConst var INDEX_WRITEMASK;
    @:GLConst var COLOR_CLEAR_VALUE;
    @:GLConst var COLOR_WRITEMASK;
    @:GLConst var INDEX_MODE;
    @:GLConst var RGBA_MODE;
    @:GLConst var DOUBLEBUFFER;
    @:GLConst var STEREO;
    @:GLConst var RENDER_MODE;
    @:GLConst var PERSPECTIVE_CORRECTION_HINT;
    @:GLConst var POINT_SMOOTH_HINT;
    @:GLConst var LINE_SMOOTH_HINT;
    @:GLConst var POLYGON_SMOOTH_HINT;
    @:GLConst var FOG_HINT;
    @:GLConst var TEXTURE_GEN_S;
    @:GLConst var TEXTURE_GEN_T;
    @:GLConst var TEXTURE_GEN_R;
    @:GLConst var TEXTURE_GEN_Q;
    @:GLConst var PIXEL_MAP_I_TO_I;
    @:GLConst var PIXEL_MAP_S_TO_S;
    @:GLConst var PIXEL_MAP_I_TO_R;
    @:GLConst var PIXEL_MAP_I_TO_G;
    @:GLConst var PIXEL_MAP_I_TO_B;
    @:GLConst var PIXEL_MAP_I_TO_A;
    @:GLConst var PIXEL_MAP_R_TO_R;
    @:GLConst var PIXEL_MAP_G_TO_G;
    @:GLConst var PIXEL_MAP_B_TO_B;
    @:GLConst var PIXEL_MAP_A_TO_A;
    @:GLConst var PIXEL_MAP_I_TO_I_SIZE;
    @:GLConst var PIXEL_MAP_S_TO_S_SIZE;
    @:GLConst var PIXEL_MAP_I_TO_R_SIZE;
    @:GLConst var PIXEL_MAP_I_TO_G_SIZE;
    @:GLConst var PIXEL_MAP_I_TO_B_SIZE;
    @:GLConst var PIXEL_MAP_I_TO_A_SIZE;
    @:GLConst var PIXEL_MAP_R_TO_R_SIZE;
    @:GLConst var PIXEL_MAP_G_TO_G_SIZE;
    @:GLConst var PIXEL_MAP_B_TO_B_SIZE;
    @:GLConst var PIXEL_MAP_A_TO_A_SIZE;
    @:GLConst var UNPACK_SWAP_BYTES;
    @:GLConst var UNPACK_LSB_FIRST;
    @:GLConst var UNPACK_ROW_LENGTH;
    @:GLConst var UNPACK_SKIP_ROWS;
    @:GLConst var UNPACK_SKIP_PIXELS;
    @:GLConst var UNPACK_ALIGNMENT;
    @:GLConst var PACK_SWAP_BYTES;
    @:GLConst var PACK_LSB_FIRST;
    @:GLConst var PACK_ROW_LENGTH;
    @:GLConst var PACK_SKIP_ROWS;
    @:GLConst var PACK_SKIP_PIXELS;
    @:GLConst var PACK_ALIGNMENT;
    @:GLConst var MAP_COLOR;
    @:GLConst var MAP_STENCIL;
    @:GLConst var INDEX_SHIFT;
    @:GLConst var INDEX_OFFSET;
    @:GLConst var RED_SCALE;
    @:GLConst var RED_BIAS;
    @:GLConst var ZOOM_X;
    @:GLConst var ZOOM_Y;
    @:GLConst var GREEN_SCALE;
    @:GLConst var GREEN_BIAS;
    @:GLConst var BLUE_SCALE;
    @:GLConst var BLUE_BIAS;
    @:GLConst var ALPHA_SCALE;
    @:GLConst var ALPHA_BIAS;
    @:GLConst var DEPTH_SCALE;
    @:GLConst var DEPTH_BIAS;
    @:GLConst var MAX_EVAL_ORDER;
    @:GLConst var MAX_LIGHTS;
    @:GLConst var MAX_CLIP_PLANES;
    @:GLConst var MAX_TEXTURE_SIZE;
    @:GLConst var MAX_PIXEL_MAP_TABLE;
    @:GLConst var MAX_ATTRIB_STACK_DEPTH;
    @:GLConst var MAX_MODELVIEW_STACK_DEPTH;
    @:GLConst var MAX_NAME_STACK_DEPTH;
    @:GLConst var MAX_PROJECTION_STACK_DEPTH;
    @:GLConst var MAX_TEXTURE_STACK_DEPTH;
    @:GLConst var MAX_VIEWPORT_DIMS;
    @:GLConst var MAX_CLIENT_ATTRIB_STACK_DEPTH;
    @:GLConst var SUBPIXEL_BITS;
    @:GLConst var INDEX_BITS;
    @:GLConst var RED_BITS;
    @:GLConst var GREEN_BITS;
    @:GLConst var BLUE_BITS;
    @:GLConst var ALPHA_BITS;
    @:GLConst var DEPTH_BITS;
    @:GLConst var STENCIL_BITS;
    @:GLConst var ACCUM_RED_BITS;
    @:GLConst var ACCUM_GREEN_BITS;
    @:GLConst var ACCUM_BLUE_BITS;
    @:GLConst var ACCUM_ALPHA_BITS;
    @:GLConst var NAME_STACK_DEPTH;
    @:GLConst var AUTO_NORMAL;
    @:GLConst var MAP1_COLOR_4;
    @:GLConst var MAP1_INDEX;
    @:GLConst var MAP1_NORMAL;
    @:GLConst var MAP1_TEXTURE_COORD_1;
    @:GLConst var MAP1_TEXTURE_COORD_2;
    @:GLConst var MAP1_TEXTURE_COORD_3;
    @:GLConst var MAP1_TEXTURE_COORD_4;
    @:GLConst var MAP1_VERTEX_3;
    @:GLConst var MAP1_VERTEX_4;
    @:GLConst var MAP2_COLOR_4;
    @:GLConst var MAP2_INDEX;
    @:GLConst var MAP2_NORMAL;
    @:GLConst var MAP2_TEXTURE_COORD_1;
    @:GLConst var MAP2_TEXTURE_COORD_2;
    @:GLConst var MAP2_TEXTURE_COORD_3;
    @:GLConst var MAP2_TEXTURE_COORD_4;
    @:GLConst var MAP2_VERTEX_3;
    @:GLConst var MAP2_VERTEX_4;
    @:GLConst var MAP1_GRID_DOMAIN;
    @:GLConst var MAP1_GRID_SEGMENTS;
    @:GLConst var MAP2_GRID_DOMAIN;
    @:GLConst var MAP2_GRID_SEGMENTS;
    @:GLConst var TEXTURE_1D;
    @:GLConst var TEXTURE_2D;
    @:GLConst var FEEDBACK_BUFFER_POINTER;
    @:GLConst var FEEDBACK_BUFFER_SIZE;
    @:GLConst var FEEDBACK_BUFFER_TYPE;
    @:GLConst var SELECTION_BUFFER_POINTER;
    @:GLConst var SELECTION_BUFFER_SIZE;
    @:GLConst var TEXTURE_WIDTH;
    @:GLConst var TRANSFORM_BIT;
    @:GLConst var TEXTURE_HEIGHT;
    @:GLConst var TEXTURE_INTERNAL_FORMAT;
    @:GLConst var TEXTURE_BORDER_COLOR;
    @:GLConst var TEXTURE_BORDER;
    @:GLConst var DONT_CARE;
    @:GLConst var FASTEST;
    @:GLConst var NICEST;
    @:GLConst var AMBIENT;
    @:GLConst var DIFFUSE;
    @:GLConst var SPECULAR;
    @:GLConst var POSITION;
    @:GLConst var SPOT_DIRECTION;
    @:GLConst var SPOT_EXPONENT;
    @:GLConst var SPOT_CUTOFF;
    @:GLConst var CONSTANT_ATTENUATION;
    @:GLConst var LINEAR_ATTENUATION;
    @:GLConst var QUADRATIC_ATTENUATION;
    @:GLConst var COMPILE;
    @:GLConst var COMPILE_AND_EXECUTE;
    @:GLConst var BYTE;
    @:GLConst var UNSIGNED_BYTE;
    @:GLConst var SHORT;
    @:GLConst var UNSIGNED_SHORT;
    @:GLConst var INT;
    @:GLConst var UNSIGNED_INT;
    @:GLConst var FLOAT;
    @:GLConst("2_BYTES") var _2_BYTES;
    @:GLConst("3_BYTES") var _3_BYTES;
    @:GLConst("4_BYTES") var _4_BYTES;
    @:GLConst var DOUBLE;
    @:GLConst var CLEAR;
    @:GLConst var AND;
    @:GLConst var AND_REVERSE;
    @:GLConst var COPY;
    @:GLConst var AND_INVERTED;
    @:GLConst var NOOP;
    @:GLConst var XOR;
    @:GLConst var OR;
    @:GLConst var NOR;
    @:GLConst var EQUIV;
    @:GLConst var INVERT;
    @:GLConst var OR_REVERSE;
    @:GLConst var COPY_INVERTED;
    @:GLConst var OR_INVERTED;
    @:GLConst var NAND;
    @:GLConst var SET;
    @:GLConst var EMISSION;
    @:GLConst var SHININESS;
    @:GLConst var AMBIENT_AND_DIFFUSE;
    @:GLConst var COLOR_INDEXES;
    @:GLConst var MODELVIEW;
    @:GLConst var PROJECTION;
    @:GLConst var TEXTURE;
    @:GLConst var COLOR;
    @:GLConst var DEPTH;
    @:GLConst var STENCIL;
    @:GLConst var COLOR_INDEX;
    @:GLConst var STENCIL_INDEX;
    @:GLConst var DEPTH_COMPONENT;
    @:GLConst var RED;
    @:GLConst var GREEN;
    @:GLConst var BLUE;
    @:GLConst var ALPHA;
    @:GLConst var RGB;
    @:GLConst var RGBA;
    @:GLConst var LUMINANCE;
    @:GLConst var LUMINANCE_ALPHA;
    @:GLConst var BITMAP;
    @:GLConst var POINT;
    @:GLConst var LINE;
    @:GLConst var FILL;
    @:GLConst var RENDER;
    @:GLConst var FEEDBACK;
    @:GLConst var SELECT;
    @:GLConst var FLAT;
    @:GLConst var SMOOTH;
    @:GLConst var KEEP;
    @:GLConst var REPLACE;
    @:GLConst var INCR;
    @:GLConst var DECR;
    @:GLConst var VENDOR;
    @:GLConst var RENDERER;
    @:GLConst var VERSION;
    @:GLConst var EXTENSIONS;
    @:GLConst var S;
    @:GLConst var ENABLE_BIT;
    @:GLConst var T;
    @:GLConst var R;
    @:GLConst var Q;
    @:GLConst var MODULATE;
    @:GLConst var DECAL;
    @:GLConst var TEXTURE_ENV_MODE;
    @:GLConst var TEXTURE_ENV_COLOR;
    @:GLConst var TEXTURE_ENV;
    @:GLConst var EYE_LINEAR;
    @:GLConst var OBJECT_LINEAR;
    @:GLConst var SPHERE_MAP;
    @:GLConst var TEXTURE_GEN_MODE;
    @:GLConst var OBJECT_PLANE;
    @:GLConst var EYE_PLANE;
    @:GLConst var NEAREST;
    @:GLConst var LINEAR;
    @:GLConst var NEAREST_MIPMAP_NEAREST;
    @:GLConst var LINEAR_MIPMAP_NEAREST;
    @:GLConst var NEAREST_MIPMAP_LINEAR;
    @:GLConst var LINEAR_MIPMAP_LINEAR;
    @:GLConst var TEXTURE_MAG_FILTER;
    @:GLConst var TEXTURE_MIN_FILTER;
    @:GLConst var TEXTURE_WRAP_S;
    @:GLConst var TEXTURE_WRAP_T;
    @:GLConst var CLAMP;
    @:GLConst var REPEAT;
    @:GLConst var POLYGON_OFFSET_UNITS;
    @:GLConst var POLYGON_OFFSET_POINT;
    @:GLConst var POLYGON_OFFSET_LINE;
    @:GLConst var R3_G3_B2;
    @:GLConst var V2F;
    @:GLConst var V3F;
    @:GLConst var C4UB_V2F;
    @:GLConst var C4UB_V3F;
    @:GLConst var C3F_V3F;
    @:GLConst var N3F_V3F;
    @:GLConst var C4F_N3F_V3F;
    @:GLConst var T2F_V3F;
    @:GLConst var T4F_V4F;
    @:GLConst var T2F_C4UB_V3F;
    @:GLConst var T2F_C3F_V3F;
    @:GLConst var T2F_N3F_V3F;
    @:GLConst var T2F_C4F_N3F_V3F;
    @:GLConst var T4F_C4F_N3F_V4F;
    @:GLConst var CLIP_PLANE0;
    @:GLConst var CLIP_PLANE1;
    @:GLConst var CLIP_PLANE2;
    @:GLConst var CLIP_PLANE3;
    @:GLConst var CLIP_PLANE4;
    @:GLConst var CLIP_PLANE5;
    @:GLConst var LIGHT0;
    @:GLConst var COLOR_BUFFER_BIT;
    @:GLConst var LIGHT1;
    @:GLConst var LIGHT2;
    @:GLConst var LIGHT3;
    @:GLConst var LIGHT4;
    @:GLConst var LIGHT5;
    @:GLConst var LIGHT6;
    @:GLConst var LIGHT7;
    @:GLConst var HINT_BIT;
    @:GLConst var POLYGON_OFFSET_FILL;
    @:GLConst var POLYGON_OFFSET_FACTOR;
    @:GLConst var ALPHA4;
    @:GLConst var ALPHA8;
    @:GLConst var ALPHA12;
    @:GLConst var ALPHA16;
    @:GLConst var LUMINANCE4;
    @:GLConst var LUMINANCE8;
    @:GLConst var LUMINANCE12;
    @:GLConst var LUMINANCE16;
    @:GLConst var LUMINANCE4_ALPHA4;
    @:GLConst var LUMINANCE6_ALPHA2;
    @:GLConst var LUMINANCE8_ALPHA8;
    @:GLConst var LUMINANCE12_ALPHA4;
    @:GLConst var LUMINANCE12_ALPHA12;
    @:GLConst var LUMINANCE16_ALPHA16;
    @:GLConst var INTENSITY;
    @:GLConst var INTENSITY4;
    @:GLConst var INTENSITY8;
    @:GLConst var INTENSITY12;
    @:GLConst var INTENSITY16;
    @:GLConst var RGB4;
    @:GLConst var RGB5;
    @:GLConst var RGB8;
    @:GLConst var RGB10;
    @:GLConst var RGB12;
    @:GLConst var RGB16;
    @:GLConst var RGBA2;
    @:GLConst var RGBA4;
    @:GLConst var RGB5_A1;
    @:GLConst var RGBA8;
    @:GLConst var RGB10_A2;
    @:GLConst var RGBA12;
    @:GLConst var RGBA16;
    @:GLConst var TEXTURE_RED_SIZE;
    @:GLConst var TEXTURE_GREEN_SIZE;
    @:GLConst var TEXTURE_BLUE_SIZE;
    @:GLConst var TEXTURE_ALPHA_SIZE;
    @:GLConst var TEXTURE_LUMINANCE_SIZE;
    @:GLConst var TEXTURE_INTENSITY_SIZE;
    @:GLConst var PROXY_TEXTURE_1D;
    @:GLConst var PROXY_TEXTURE_2D;
    @:GLConst var TEXTURE_PRIORITY;
    @:GLConst var TEXTURE_RESIDENT;
    @:GLConst var TEXTURE_BINDING_1D;
    @:GLConst var TEXTURE_BINDING_2D;
    @:GLConst var VERTEX_ARRAY;
    @:GLConst var NORMAL_ARRAY;
    @:GLConst var COLOR_ARRAY;
    @:GLConst var INDEX_ARRAY;
    @:GLConst var TEXTURE_COORD_ARRAY;
    @:GLConst var EDGE_FLAG_ARRAY;
    @:GLConst var VERTEX_ARRAY_SIZE;
    @:GLConst var VERTEX_ARRAY_TYPE;
    @:GLConst var VERTEX_ARRAY_STRIDE;
    @:GLConst var NORMAL_ARRAY_TYPE;
    @:GLConst var NORMAL_ARRAY_STRIDE;
    @:GLConst var COLOR_ARRAY_SIZE;
    @:GLConst var COLOR_ARRAY_TYPE;
    @:GLConst var COLOR_ARRAY_STRIDE;
    @:GLConst var INDEX_ARRAY_TYPE;
    @:GLConst var INDEX_ARRAY_STRIDE;
    @:GLConst var TEXTURE_COORD_ARRAY_SIZE;
    @:GLConst var TEXTURE_COORD_ARRAY_TYPE;
    @:GLConst var TEXTURE_COORD_ARRAY_STRIDE;
    @:GLConst var EDGE_FLAG_ARRAY_STRIDE;
    @:GLConst var VERTEX_ARRAY_POINTER;
    @:GLConst var NORMAL_ARRAY_POINTER;
    @:GLConst var COLOR_ARRAY_POINTER;
    @:GLConst var INDEX_ARRAY_POINTER;
    @:GLConst var TEXTURE_COORD_ARRAY_POINTER;
    @:GLConst var EDGE_FLAG_ARRAY_POINTER;
    @:GLConst var COLOR_INDEX1_EXT;
    @:GLConst var COLOR_INDEX2_EXT;
    @:GLConst var COLOR_INDEX4_EXT;
    @:GLConst var COLOR_INDEX8_EXT;
    @:GLConst var COLOR_INDEX12_EXT;
    @:GLConst var COLOR_INDEX16_EXT;
    @:GLConst var EVAL_BIT;
    @:GLConst var LIST_BIT;
    @:GLConst var TEXTURE_BIT;
    @:GLConst var SCISSOR_BIT;
    @:GLConst var ALL_ATTRIB_BITS;
    @:GLConst var CLIENT_ALL_ATTRIB_BITS;
    // GL_VERSION_1_2 CONSTS
    @:GLConst var SMOOTH_POINT_SIZE_RANGE;
    @:GLConst var SMOOTH_POINT_SIZE_GRANULARITY;
    @:GLConst var SMOOTH_LINE_WIDTH_RANGE;
    @:GLConst var SMOOTH_LINE_WIDTH_GRANULARITY;
    @:GLConst var UNSIGNED_BYTE_3_3_2;
    @:GLConst var UNSIGNED_SHORT_4_4_4_4;
    @:GLConst var UNSIGNED_SHORT_5_5_5_1;
    @:GLConst var UNSIGNED_INT_8_8_8_8;
    @:GLConst var UNSIGNED_INT_10_10_10_2;
    @:GLConst var RESCALE_NORMAL;
    @:GLConst var TEXTURE_BINDING_3D;
    @:GLConst var PACK_SKIP_IMAGES;
    @:GLConst var PACK_IMAGE_HEIGHT;
    @:GLConst var UNPACK_SKIP_IMAGES;
    @:GLConst var UNPACK_IMAGE_HEIGHT;
    @:GLConst var TEXTURE_3D;
    @:GLConst var PROXY_TEXTURE_3D;
    @:GLConst var TEXTURE_DEPTH;
    @:GLConst var TEXTURE_WRAP_R;
    @:GLConst var MAX_3D_TEXTURE_SIZE;
    @:GLConst var BGR;
    @:GLConst var BGRA;
    @:GLConst var MAX_ELEMENTS_VERTICES;
    @:GLConst var MAX_ELEMENTS_INDICES;
    @:GLConst var CLAMP_TO_EDGE;
    @:GLConst var TEXTURE_MIN_LOD;
    @:GLConst var TEXTURE_MAX_LOD;
    @:GLConst var TEXTURE_BASE_LEVEL;
    @:GLConst var TEXTURE_MAX_LEVEL;
    @:GLConst var LIGHT_MODEL_COLOR_CONTROL;
    @:GLConst var SINGLE_COLOR;
    @:GLConst var SEPARATE_SPECULAR_COLOR;
    @:GLConst var UNSIGNED_BYTE_2_3_3_REV;
    @:GLConst var UNSIGNED_SHORT_5_6_5;
    @:GLConst var UNSIGNED_SHORT_5_6_5_REV;
    @:GLConst var UNSIGNED_SHORT_4_4_4_4_REV;
    @:GLConst var UNSIGNED_SHORT_1_5_5_5_REV;
    @:GLConst var UNSIGNED_INT_8_8_8_8_REV;
    @:GLConst var UNSIGNED_INT_2_10_10_10_REV;
    @:GLConst var ALIASED_POINT_SIZE_RANGE;
    @:GLConst var ALIASED_LINE_WIDTH_RANGE;
    // GL_VERSION_1_3 CONSTS
    @:GLConst var MULTISAMPLE;
    @:GLConst var SAMPLE_ALPHA_TO_COVERAGE;
    @:GLConst var SAMPLE_ALPHA_TO_ONE;
    @:GLConst var SAMPLE_COVERAGE;
    @:GLConst var SAMPLE_BUFFERS;
    @:GLConst var SAMPLES;
    @:GLConst var SAMPLE_COVERAGE_VALUE;
    @:GLConst var SAMPLE_COVERAGE_INVERT;
    @:GLConst var CLAMP_TO_BORDER;
    @:GLConst var TEXTURE0;
    @:GLConst var TEXTURE1;
    @:GLConst var TEXTURE2;
    @:GLConst var TEXTURE3;
    @:GLConst var TEXTURE4;
    @:GLConst var TEXTURE5;
    @:GLConst var TEXTURE6;
    @:GLConst var TEXTURE7;
    @:GLConst var TEXTURE8;
    @:GLConst var TEXTURE9;
    @:GLConst var TEXTURE10;
    @:GLConst var TEXTURE11;
    @:GLConst var TEXTURE12;
    @:GLConst var TEXTURE13;
    @:GLConst var TEXTURE14;
    @:GLConst var TEXTURE15;
    @:GLConst var TEXTURE16;
    @:GLConst var TEXTURE17;
    @:GLConst var TEXTURE18;
    @:GLConst var TEXTURE19;
    @:GLConst var TEXTURE20;
    @:GLConst var TEXTURE21;
    @:GLConst var TEXTURE22;
    @:GLConst var TEXTURE23;
    @:GLConst var TEXTURE24;
    @:GLConst var TEXTURE25;
    @:GLConst var TEXTURE26;
    @:GLConst var TEXTURE27;
    @:GLConst var TEXTURE28;
    @:GLConst var TEXTURE29;
    @:GLConst var TEXTURE30;
    @:GLConst var TEXTURE31;
    @:GLConst var ACTIVE_TEXTURE;
    @:GLConst var CLIENT_ACTIVE_TEXTURE;
    @:GLConst var MAX_TEXTURE_UNITS;
    @:GLConst var TRANSPOSE_MODELVIEW_MATRIX;
    @:GLConst var TRANSPOSE_PROJECTION_MATRIX;
    @:GLConst var TRANSPOSE_TEXTURE_MATRIX;
    @:GLConst var TRANSPOSE_COLOR_MATRIX;
    @:GLConst var SUBTRACT;
    @:GLConst var COMPRESSED_ALPHA;
    @:GLConst var COMPRESSED_LUMINANCE;
    @:GLConst var COMPRESSED_LUMINANCE_ALPHA;
    @:GLConst var COMPRESSED_INTENSITY;
    @:GLConst var COMPRESSED_RGB;
    @:GLConst var COMPRESSED_RGBA;
    @:GLConst var TEXTURE_COMPRESSION_HINT;
    @:GLConst var NORMAL_MAP;
    @:GLConst var REFLECTION_MAP;
    @:GLConst var TEXTURE_CUBE_MAP;
    @:GLConst var TEXTURE_BINDING_CUBE_MAP;
    @:GLConst var TEXTURE_CUBE_MAP_POSITIVE_X;
    @:GLConst var TEXTURE_CUBE_MAP_NEGATIVE_X;
    @:GLConst var TEXTURE_CUBE_MAP_POSITIVE_Y;
    @:GLConst var TEXTURE_CUBE_MAP_NEGATIVE_Y;
    @:GLConst var TEXTURE_CUBE_MAP_POSITIVE_Z;
    @:GLConst var TEXTURE_CUBE_MAP_NEGATIVE_Z;
    @:GLConst var PROXY_TEXTURE_CUBE_MAP;
    @:GLConst var MAX_CUBE_MAP_TEXTURE_SIZE;
    @:GLConst var COMBINE;
    @:GLConst var COMBINE_RGB;
    @:GLConst var COMBINE_ALPHA;
    @:GLConst var RGB_SCALE;
    @:GLConst var ADD_SIGNED;
    @:GLConst var INTERPOLATE;
    @:GLConst var CONSTANT;
    @:GLConst var PRIMARY_COLOR;
    @:GLConst var PREVIOUS;
    @:GLConst var SOURCE0_RGB;
    @:GLConst var SOURCE1_RGB;
    @:GLConst var SOURCE2_RGB;
    @:GLConst var SOURCE0_ALPHA;
    @:GLConst var SOURCE1_ALPHA;
    @:GLConst var SOURCE2_ALPHA;
    @:GLConst var OPERAND0_RGB;
    @:GLConst var OPERAND1_RGB;
    @:GLConst var OPERAND2_RGB;
    @:GLConst var OPERAND0_ALPHA;
    @:GLConst var OPERAND1_ALPHA;
    @:GLConst var OPERAND2_ALPHA;
    @:GLConst var TEXTURE_COMPRESSED_IMAGE_SIZE;
    @:GLConst var TEXTURE_COMPRESSED;
    @:GLConst var NUM_COMPRESSED_TEXTURE_FORMATS;
    @:GLConst var COMPRESSED_TEXTURE_FORMATS;
    @:GLConst var DOT3_RGB;
    @:GLConst var DOT3_RGBA;
    @:GLConst var MULTISAMPLE_BIT;
    // GL_VERSION_1_4 CONSTS
    @:GLConst var BLEND_DST_RGB;
    @:GLConst var BLEND_SRC_RGB;
    @:GLConst var BLEND_DST_ALPHA;
    @:GLConst var BLEND_SRC_ALPHA;
    @:GLConst var POINT_SIZE_MIN;
    @:GLConst var POINT_SIZE_MAX;
    @:GLConst var POINT_FADE_THRESHOLD_SIZE;
    @:GLConst var POINT_DISTANCE_ATTENUATION;
    @:GLConst var GENERATE_MIPMAP;
    @:GLConst var GENERATE_MIPMAP_HINT;
    @:GLConst var DEPTH_COMPONENT16;
    @:GLConst var DEPTH_COMPONENT24;
    @:GLConst var DEPTH_COMPONENT32;
    @:GLConst var MIRRORED_REPEAT;
    @:GLConst var FOG_COORDINATE_SOURCE;
    @:GLConst var FOG_COORDINATE;
    @:GLConst var FRAGMENT_DEPTH;
    @:GLConst var CURRENT_FOG_COORDINATE;
    @:GLConst var FOG_COORDINATE_ARRAY_TYPE;
    @:GLConst var FOG_COORDINATE_ARRAY_STRIDE;
    @:GLConst var FOG_COORDINATE_ARRAY_POINTER;
    @:GLConst var FOG_COORDINATE_ARRAY;
    @:GLConst var COLOR_SUM;
    @:GLConst var CURRENT_SECONDARY_COLOR;
    @:GLConst var SECONDARY_COLOR_ARRAY_SIZE;
    @:GLConst var SECONDARY_COLOR_ARRAY_TYPE;
    @:GLConst var SECONDARY_COLOR_ARRAY_STRIDE;
    @:GLConst var SECONDARY_COLOR_ARRAY_POINTER;
    @:GLConst var SECONDARY_COLOR_ARRAY;
    @:GLConst var MAX_TEXTURE_LOD_BIAS;
    @:GLConst var TEXTURE_FILTER_CONTROL;
    @:GLConst var TEXTURE_LOD_BIAS;
    @:GLConst var INCR_WRAP;
    @:GLConst var DECR_WRAP;
    @:GLConst var TEXTURE_DEPTH_SIZE;
    @:GLConst var DEPTH_TEXTURE_MODE;
    @:GLConst var TEXTURE_COMPARE_MODE;
    @:GLConst var TEXTURE_COMPARE_FUNC;
    @:GLConst var COMPARE_R_TO_TEXTURE;
    // GL_VERSION_1_5 CONSTS
    @:GLConst var FOG_COORD_SRC;
    @:GLConst var FOG_COORD;
    @:GLConst var FOG_COORD_ARRAY;
    @:GLConst var SRC0_RGB;
    @:GLConst var FOG_COORD_ARRAY_POINTER;
    @:GLConst var FOG_COORD_ARRAY_TYPE;
    @:GLConst var SRC1_ALPHA;
    @:GLConst var CURRENT_FOG_COORD;
    @:GLConst var FOG_COORD_ARRAY_STRIDE;
    @:GLConst var SRC0_ALPHA;
    @:GLConst var SRC1_RGB;
    @:GLConst var FOG_COORD_ARRAY_BUFFER_BINDING;
    @:GLConst var SRC2_ALPHA;
    @:GLConst var SRC2_RGB;
    @:GLConst var BUFFER_SIZE;
    @:GLConst var BUFFER_USAGE;
    @:GLConst var QUERY_COUNTER_BITS;
    @:GLConst var CURRENT_QUERY;
    @:GLConst var QUERY_RESULT;
    @:GLConst var QUERY_RESULT_AVAILABLE;
    @:GLConst var ARRAY_BUFFER;
    @:GLConst var ELEMENT_ARRAY_BUFFER;
    @:GLConst var ARRAY_BUFFER_BINDING;
    @:GLConst var ELEMENT_ARRAY_BUFFER_BINDING;
    @:GLConst var VERTEX_ARRAY_BUFFER_BINDING;
    @:GLConst var NORMAL_ARRAY_BUFFER_BINDING;
    @:GLConst var COLOR_ARRAY_BUFFER_BINDING;
    @:GLConst var INDEX_ARRAY_BUFFER_BINDING;
    @:GLConst var TEXTURE_COORD_ARRAY_BUFFER_BINDING;
    @:GLConst var EDGE_FLAG_ARRAY_BUFFER_BINDING;
    @:GLConst var SECONDARY_COLOR_ARRAY_BUFFER_BINDING;
    @:GLConst var FOG_COORDINATE_ARRAY_BUFFER_BINDING;
    @:GLConst var WEIGHT_ARRAY_BUFFER_BINDING;
    @:GLConst var VERTEX_ATTRIB_ARRAY_BUFFER_BINDING;
    @:GLConst var READ_ONLY;
    @:GLConst var WRITE_ONLY;
    @:GLConst var READ_WRITE;
    @:GLConst var BUFFER_ACCESS;
    @:GLConst var BUFFER_MAPPED;
    @:GLConst var BUFFER_MAP_POINTER;
    @:GLConst var STREAM_DRAW;
    @:GLConst var STREAM_READ;
    @:GLConst var STREAM_COPY;
    @:GLConst var STATIC_DRAW;
    @:GLConst var STATIC_READ;
    @:GLConst var STATIC_COPY;
    @:GLConst var DYNAMIC_DRAW;
    @:GLConst var DYNAMIC_READ;
    @:GLConst var DYNAMIC_COPY;
    @:GLConst var SAMPLES_PASSED;
    // GL_VERSION_2_0 CONSTS
    @:GLConst var BLEND_EQUATION_RGB;
    @:GLConst var VERTEX_ATTRIB_ARRAY_ENABLED;
    @:GLConst var VERTEX_ATTRIB_ARRAY_SIZE;
    @:GLConst var VERTEX_ATTRIB_ARRAY_STRIDE;
    @:GLConst var VERTEX_ATTRIB_ARRAY_TYPE;
    @:GLConst var CURRENT_VERTEX_ATTRIB;
    @:GLConst var VERTEX_PROGRAM_POINT_SIZE;
    @:GLConst var VERTEX_PROGRAM_TWO_SIDE;
    @:GLConst var VERTEX_ATTRIB_ARRAY_POINTER;
    @:GLConst var STENCIL_BACK_FUNC;
    @:GLConst var STENCIL_BACK_FAIL;
    @:GLConst var STENCIL_BACK_PASS_DEPTH_FAIL;
    @:GLConst var STENCIL_BACK_PASS_DEPTH_PASS;
    @:GLConst var MAX_DRAW_BUFFERS;
    @:GLConst var DRAW_BUFFER0;
    @:GLConst var DRAW_BUFFER1;
    @:GLConst var DRAW_BUFFER2;
    @:GLConst var DRAW_BUFFER3;
    @:GLConst var DRAW_BUFFER4;
    @:GLConst var DRAW_BUFFER5;
    @:GLConst var DRAW_BUFFER6;
    @:GLConst var DRAW_BUFFER7;
    @:GLConst var DRAW_BUFFER8;
    @:GLConst var DRAW_BUFFER9;
    @:GLConst var DRAW_BUFFER10;
    @:GLConst var DRAW_BUFFER11;
    @:GLConst var DRAW_BUFFER12;
    @:GLConst var DRAW_BUFFER13;
    @:GLConst var DRAW_BUFFER14;
    @:GLConst var DRAW_BUFFER15;
    @:GLConst var BLEND_EQUATION_ALPHA;
    @:GLConst var POINT_SPRITE;
    @:GLConst var COORD_REPLACE;
    @:GLConst var MAX_VERTEX_ATTRIBS;
    @:GLConst var VERTEX_ATTRIB_ARRAY_NORMALIZED;
    @:GLConst var MAX_TEXTURE_COORDS;
    @:GLConst var MAX_TEXTURE_IMAGE_UNITS;
    @:GLConst var FRAGMENT_SHADER;
    @:GLConst var VERTEX_SHADER;
    @:GLConst var MAX_FRAGMENT_UNIFORM_COMPONENTS;
    @:GLConst var MAX_VERTEX_UNIFORM_COMPONENTS;
    @:GLConst var MAX_VARYING_FLOATS;
    @:GLConst var MAX_VERTEX_TEXTURE_IMAGE_UNITS;
    @:GLConst var MAX_COMBINED_TEXTURE_IMAGE_UNITS;
    @:GLConst var SHADER_TYPE;
    @:GLConst var FLOAT_VEC2;
    @:GLConst var FLOAT_VEC3;
    @:GLConst var FLOAT_VEC4;
    @:GLConst var INT_VEC2;
    @:GLConst var INT_VEC3;
    @:GLConst var INT_VEC4;
    @:GLConst var BOOL;
    @:GLConst var BOOL_VEC2;
    @:GLConst var BOOL_VEC3;
    @:GLConst var BOOL_VEC4;
    @:GLConst var FLOAT_MAT2;
    @:GLConst var FLOAT_MAT3;
    @:GLConst var FLOAT_MAT4;
    @:GLConst var SAMPLER_1D;
    @:GLConst var SAMPLER_2D;
    @:GLConst var SAMPLER_3D;
    @:GLConst var SAMPLER_CUBE;
    @:GLConst var SAMPLER_1D_SHADOW;
    @:GLConst var SAMPLER_2D_SHADOW;
    @:GLConst var DELETE_STATUS;
    @:GLConst var COMPILE_STATUS;
    @:GLConst var LINK_STATUS;
    @:GLConst var VALIDATE_STATUS;
    @:GLConst var INFO_LOG_LENGTH;
    @:GLConst var ATTACHED_SHADERS;
    @:GLConst var ACTIVE_UNIFORMS;
    @:GLConst var ACTIVE_UNIFORM_MAX_LENGTH;
    @:GLConst var SHADER_SOURCE_LENGTH;
    @:GLConst var ACTIVE_ATTRIBUTES;
    @:GLConst var ACTIVE_ATTRIBUTE_MAX_LENGTH;
    @:GLConst var FRAGMENT_SHADER_DERIVATIVE_HINT;
    @:GLConst var SHADING_LANGUAGE_VERSION;
    @:GLConst var CURRENT_PROGRAM;
    @:GLConst var POINT_SPRITE_COORD_ORIGIN;
    @:GLConst var LOWER_LEFT;
    @:GLConst var UPPER_LEFT;
    @:GLConst var STENCIL_BACK_REF;
    @:GLConst var STENCIL_BACK_VALUE_MASK;
    @:GLConst var STENCIL_BACK_WRITEMASK;
    // GL_VERSION_2_1 CONSTS
    @:GLConst var CURRENT_RASTER_SECONDARY_COLOR;
    @:GLConst var PIXEL_PACK_BUFFER;
    @:GLConst var PIXEL_UNPACK_BUFFER;
    @:GLConst var PIXEL_PACK_BUFFER_BINDING;
    @:GLConst var PIXEL_UNPACK_BUFFER_BINDING;
    @:GLConst var FLOAT_MAT2x3;
    @:GLConst var FLOAT_MAT2x4;
    @:GLConst var FLOAT_MAT3x2;
    @:GLConst var FLOAT_MAT3x4;
    @:GLConst var FLOAT_MAT4x2;
    @:GLConst var FLOAT_MAT4x3;
    @:GLConst var SRGB;
    @:GLConst var SRGB8;
    @:GLConst var SRGB_ALPHA;
    @:GLConst var SRGB8_ALPHA8;
    @:GLConst var SLUMINANCE_ALPHA;
    @:GLConst var SLUMINANCE8_ALPHA8;
    @:GLConst var SLUMINANCE;
    @:GLConst var SLUMINANCE8;
    @:GLConst var COMPRESSED_SRGB;
    @:GLConst var COMPRESSED_SRGB_ALPHA;
    @:GLConst var COMPRESSED_SLUMINANCE;
    @:GLConst var COMPRESSED_SLUMINANCE_ALPHA;
    // GL_VERSION_3_0 CONSTS
    @:GLConst var MAX_CLIP_DISTANCES;
    @:GLConst var CLIP_DISTANCE5;
    @:GLConst var CLIP_DISTANCE1;
    @:GLConst var CLIP_DISTANCE3;
    @:GLConst var COMPARE_REF_TO_TEXTURE;
    @:GLConst var CLIP_DISTANCE0;
    @:GLConst var CLIP_DISTANCE4;
    @:GLConst var CLIP_DISTANCE2;
    @:GLConst var MAX_VARYING_COMPONENTS;
    @:GLConst var CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT;
    @:GLConst var MAJOR_VERSION;
    @:GLConst var MINOR_VERSION;
    @:GLConst var NUM_EXTENSIONS;
    @:GLConst var CONTEXT_FLAGS;
    @:GLConst var DEPTH_BUFFER;
    @:GLConst var STENCIL_BUFFER;
    @:GLConst var COMPRESSED_RED;
    @:GLConst var COMPRESSED_RG;
    @:GLConst var RGBA32F;
    @:GLConst var RGB32F;
    @:GLConst var RGBA16F;
    @:GLConst var RGB16F;
    @:GLConst var VERTEX_ATTRIB_ARRAY_INTEGER;
    @:GLConst var MAX_ARRAY_TEXTURE_LAYERS;
    @:GLConst var MIN_PROGRAM_TEXEL_OFFSET;
    @:GLConst var MAX_PROGRAM_TEXEL_OFFSET;
    @:GLConst var CLAMP_VERTEX_COLOR;
    @:GLConst var CLAMP_FRAGMENT_COLOR;
    @:GLConst var CLAMP_READ_COLOR;
    @:GLConst var FIXED_ONLY;
    @:GLConst var TEXTURE_RED_TYPE;
    @:GLConst var TEXTURE_GREEN_TYPE;
    @:GLConst var TEXTURE_BLUE_TYPE;
    @:GLConst var TEXTURE_ALPHA_TYPE;
    @:GLConst var TEXTURE_LUMINANCE_TYPE;
    @:GLConst var TEXTURE_INTENSITY_TYPE;
    @:GLConst var TEXTURE_DEPTH_TYPE;
    @:GLConst var UNSIGNED_NORMALIZED;
    @:GLConst var TEXTURE_1D_ARRAY;
    @:GLConst var PROXY_TEXTURE_1D_ARRAY;
    @:GLConst var TEXTURE_2D_ARRAY;
    @:GLConst var PROXY_TEXTURE_2D_ARRAY;
    @:GLConst var TEXTURE_BINDING_1D_ARRAY;
    @:GLConst var TEXTURE_BINDING_2D_ARRAY;
    @:GLConst var R11F_G11F_B10F;
    @:GLConst var UNSIGNED_INT_10F_11F_11F_REV;
    @:GLConst var RGB9_E5;
    @:GLConst var UNSIGNED_INT_5_9_9_9_REV;
    @:GLConst var TEXTURE_SHARED_SIZE;
    @:GLConst var TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH;
    @:GLConst var TRANSFORM_FEEDBACK_BUFFER_MODE;
    @:GLConst var MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS;
    @:GLConst var TRANSFORM_FEEDBACK_VARYINGS;
    @:GLConst var TRANSFORM_FEEDBACK_BUFFER_START;
    @:GLConst var TRANSFORM_FEEDBACK_BUFFER_SIZE;
    @:GLConst var PRIMITIVES_GENERATED;
    @:GLConst var TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN;
    @:GLConst var RASTERIZER_DISCARD;
    @:GLConst var MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS;
    @:GLConst var MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS;
    @:GLConst var INTERLEAVED_ATTRIBS;
    @:GLConst var SEPARATE_ATTRIBS;
    @:GLConst var TRANSFORM_FEEDBACK_BUFFER;
    @:GLConst var TRANSFORM_FEEDBACK_BUFFER_BINDING;
    @:GLConst var RGBA32UI;
    @:GLConst var RGB32UI;
    @:GLConst var RGBA16UI;
    @:GLConst var RGB16UI;
    @:GLConst var RGBA8UI;
    @:GLConst var RGB8UI;
    @:GLConst var RGBA32I;
    @:GLConst var RGB32I;
    @:GLConst var RGBA16I;
    @:GLConst var RGB16I;
    @:GLConst var RGBA8I;
    @:GLConst var RGB8I;
    @:GLConst var RED_INTEGER;
    @:GLConst var GREEN_INTEGER;
    @:GLConst var BLUE_INTEGER;
    @:GLConst var ALPHA_INTEGER;
    @:GLConst var RGB_INTEGER;
    @:GLConst var RGBA_INTEGER;
    @:GLConst var BGR_INTEGER;
    @:GLConst var BGRA_INTEGER;
    @:GLConst var SAMPLER_1D_ARRAY;
    @:GLConst var SAMPLER_2D_ARRAY;
    @:GLConst var SAMPLER_1D_ARRAY_SHADOW;
    @:GLConst var SAMPLER_2D_ARRAY_SHADOW;
    @:GLConst var SAMPLER_CUBE_SHADOW;
    @:GLConst var UNSIGNED_INT_VEC2;
    @:GLConst var UNSIGNED_INT_VEC3;
    @:GLConst var UNSIGNED_INT_VEC4;
    @:GLConst var INT_SAMPLER_1D;
    @:GLConst var INT_SAMPLER_2D;
    @:GLConst var INT_SAMPLER_3D;
    @:GLConst var INT_SAMPLER_CUBE;
    @:GLConst var INT_SAMPLER_1D_ARRAY;
    @:GLConst var INT_SAMPLER_2D_ARRAY;
    @:GLConst var UNSIGNED_INT_SAMPLER_1D;
    @:GLConst var UNSIGNED_INT_SAMPLER_2D;
    @:GLConst var UNSIGNED_INT_SAMPLER_3D;
    @:GLConst var UNSIGNED_INT_SAMPLER_CUBE;
    @:GLConst var UNSIGNED_INT_SAMPLER_1D_ARRAY;
    @:GLConst var UNSIGNED_INT_SAMPLER_2D_ARRAY;
    @:GLConst var QUERY_WAIT;
    @:GLConst var QUERY_NO_WAIT;
    @:GLConst var QUERY_BY_REGION_WAIT;
    @:GLConst var QUERY_BY_REGION_NO_WAIT;
    // GL_VERSION_3_1 CONSTS
    @:GLConst var TEXTURE_RECTANGLE;
    @:GLConst var TEXTURE_BINDING_RECTANGLE;
    @:GLConst var PROXY_TEXTURE_RECTANGLE;
    @:GLConst var MAX_RECTANGLE_TEXTURE_SIZE;
    @:GLConst var SAMPLER_2D_RECT;
    @:GLConst var SAMPLER_2D_RECT_SHADOW;
    @:GLConst var TEXTURE_BUFFER;
    @:GLConst var MAX_TEXTURE_BUFFER_SIZE;
    @:GLConst var TEXTURE_BINDING_BUFFER;
    @:GLConst var TEXTURE_BUFFER_DATA_STORE_BINDING;
    @:GLConst var TEXTURE_BUFFER_FORMAT;
    @:GLConst var SAMPLER_BUFFER;
    @:GLConst var INT_SAMPLER_2D_RECT;
    @:GLConst var INT_SAMPLER_BUFFER;
    @:GLConst var UNSIGNED_INT_SAMPLER_2D_RECT;
    @:GLConst var UNSIGNED_INT_SAMPLER_BUFFER;
    @:GLConst var RED_SNORM;
    @:GLConst var RG_SNORM;
    @:GLConst var RGB_SNORM;
    @:GLConst var RGBA_SNORM;
    @:GLConst var R8_SNORM;
    @:GLConst var RG8_SNORM;
    @:GLConst var RGB8_SNORM;
    @:GLConst var RGBA8_SNORM;
    @:GLConst var R16_SNORM;
    @:GLConst var RG16_SNORM;
    @:GLConst var RGB16_SNORM;
    @:GLConst var RGBA16_SNORM;
    @:GLConst var SIGNED_NORMALIZED;
    @:GLConst var PRIMITIVE_RESTART;
    @:GLConst var PRIMITIVE_RESTART_INDEX;
    @:GLConst var BUFFER_ACCESS_FLAGS;
    @:GLConst var BUFFER_MAP_LENGTH;
    @:GLConst var BUFFER_MAP_OFFSET;
    // GL_VERSION_3_2 CONSTS
    @:GLConst var CONTEXT_CORE_PROFILE_BIT;
    @:GLConst var CONTEXT_COMPATIBILITY_PROFILE_BIT;
    @:GLConst var LINES_ADJACENCY;
    @:GLConst var LINE_STRIP_ADJACENCY;
    @:GLConst var TRIANGLES_ADJACENCY;
    @:GLConst var TRIANGLE_STRIP_ADJACENCY;
    @:GLConst var PROGRAM_POINT_SIZE;
    @:GLConst var GEOMETRY_VERTICES_OUT;
    @:GLConst var GEOMETRY_INPUT_TYPE;
    @:GLConst var GEOMETRY_OUTPUT_TYPE;
    @:GLConst var MAX_GEOMETRY_TEXTURE_IMAGE_UNITS;
    @:GLConst var FRAMEBUFFER_ATTACHMENT_LAYERED;
    @:GLConst var FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS;
    @:GLConst var GEOMETRY_SHADER;
    @:GLConst var MAX_GEOMETRY_UNIFORM_COMPONENTS;
    @:GLConst var MAX_GEOMETRY_OUTPUT_VERTICES;
    @:GLConst var MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS;
    @:GLConst var MAX_VERTEX_OUTPUT_COMPONENTS;
    @:GLConst var MAX_GEOMETRY_INPUT_COMPONENTS;
    @:GLConst var MAX_GEOMETRY_OUTPUT_COMPONENTS;
    @:GLConst var MAX_FRAGMENT_INPUT_COMPONENTS;
    @:GLConst var CONTEXT_PROFILE_MASK;
    // GL_VERSION_3_3 CONSTS
    @:GLConst var VERTEX_ATTRIB_ARRAY_DIVISOR;
    @:GLConst var ANY_SAMPLES_PASSED;
    @:GLConst var TEXTURE_SWIZZLE_R;
    @:GLConst var TEXTURE_SWIZZLE_G;
    @:GLConst var TEXTURE_SWIZZLE_B;
    @:GLConst var TEXTURE_SWIZZLE_A;
    @:GLConst var TEXTURE_SWIZZLE_RGBA;
    @:GLConst var RGB10_A2UI;
    // GL_VERSION_4_0 CONSTS
    @:GLConst var GEOMETRY_SHADER_INVOCATIONS;
    @:GLConst var SAMPLE_SHADING;
    @:GLConst var MIN_SAMPLE_SHADING_VALUE;
    @:GLConst var MAX_GEOMETRY_SHADER_INVOCATIONS;
    @:GLConst var MIN_FRAGMENT_INTERPOLATION_OFFSET;
    @:GLConst var MAX_FRAGMENT_INTERPOLATION_OFFSET;
    @:GLConst var FRAGMENT_INTERPOLATION_OFFSET_BITS;
    @:GLConst var MIN_PROGRAM_TEXTURE_GATHER_OFFSET;
    @:GLConst var MAX_PROGRAM_TEXTURE_GATHER_OFFSET;
    @:GLConst var MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS;
    @:GLConst var TEXTURE_CUBE_MAP_ARRAY;
    @:GLConst var TEXTURE_BINDING_CUBE_MAP_ARRAY;
    @:GLConst var PROXY_TEXTURE_CUBE_MAP_ARRAY;
    @:GLConst var SAMPLER_CUBE_MAP_ARRAY;
    @:GLConst var SAMPLER_CUBE_MAP_ARRAY_SHADOW;
    @:GLConst var INT_SAMPLER_CUBE_MAP_ARRAY;
    @:GLConst var UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY;
    // GL_ARB_FRAMEBUFFER_OBJECT
    @:GLConst var INVALID_FRAMEBUFFER_OPERATION;
}
