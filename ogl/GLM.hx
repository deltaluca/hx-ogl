package ogl;

import ogl.Macros;
import ogl.GL;
import ogl.GLArray;

@:build(ogl.GLVector.run(2)) abstract Vec2(GLfloatArray) to GLfloatArray {
    public inline function new(x:GLfloatArray) this = x;
    @:from public static inline function fromHaxe(x:Array<Dynamic>) return new Vec2(GLfloatArray.fromArr(x));
    @:from public static inline function fromGL(x:GLfloatArray) return new Vec2(x);

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

@:build(ogl.GLVector.run(3)) abstract Vec3(GLfloatArray) to GLfloatArray {
    public inline function new(x:GLfloatArray) this = x;
    @:from public static inline function fromHaxe(x:Array<Dynamic>) return new Vec3(GLfloatArray.fromArr(x));
    @:from public static inline function fromGL(x:GLfloatArray) return new Vec3(x);

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

@:build(ogl.GLVector.run(4)) abstract Vec4(GLfloatArray) to GLfloatArray {
    public inline function new(x:GLfloatArray) this = x;
    @:from public static inline function fromHaxe(x:Array<Dynamic>) return new Vec4(GLfloatArray.fromArr(x));
    @:from public static inline function fromGL(x:GLfloatArray) return new Vec4(x);

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

abstract Mat3x2(GLfloatArray) to GLfloatArray {
    public inline function new(x:GLfloatArray) this = x;
    @:from public static inline function fromHaxe(x:Array<Dynamic>) return new Mat3x2(GLfloatArray.fromArr(x));
    @:from public static inline function fromGL(x:GLfloatArray) return new Mat3x2(x);

    // array access
    @:arrayAccess public inline function get(i:Int):Float return this[i];
    @:arrayAccess public inline function set(i:Int,x:Float):Float return this[i]=x;

    public static inline function identity():Mat3x2
        return [1.0, 0.0, 0.0,
                0.0, 1.0, 0.0];

    // (x, y) => (2*x/w - 1, 1 - 2*y/h)
    public static inline function viewportMap(width:Float, height:Float):Mat3x2
        return [2.0/width,  0.0,
                   0.0, -2.0/height,
                  -1.0,     1.0    ];

    @:op(A*B) public static inline function mul(b:Mat3x2, a:Mat3x2):Mat3x2
        return [b[0]*a[0] + b[3]*a[1],
                b[1]*a[0] + b[4]*a[1],
                b[2]*a[0] + b[5]*a[1] + a[2],

                b[0]*a[3] + b[3]*a[4],
                b[1]*a[3] + b[4]*a[4],
                b[2]*a[3] + b[5]*a[4] + a[5]];
}

abstract Mat4(GLfloatArray) to GLfloatArray {
    public inline function new(x:GLfloatArray) this = x;
    @:from public static inline function fromHaxe(x:Array<Dynamic>) return new Mat4(GLfloatArray.fromArr(x));
    @:from public static inline function fromGL(x:GLfloatArray) return new Mat4(x);

    // array access
    @:arrayAccess public inline function get(i:Int):Float return this[i];
    @:arrayAccess public inline function set(i:Int,x:Float):Float return this[i]=x;

    public static function identity():Mat4
        return [1.0, 0.0, 0.0, 0.0,
                0.0, 1.0, 0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                0.0, 0.0, 0.0, 1.0];
    public static function translate(x:Float, y:Float, z:Float):Mat4
        return [1.0, 0.0, 0.0, 0.0,
                0.0, 1.0, 0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                 x,   y,   z,  1.0];
    public static function scale(x:Float, y:Float, z:Float):Mat4
        return [ x,  0.0, 0.0, 0.0,
                0.0,  y,  0.0, 0.0,
                0.0, 0.0,  z,  0.0,
                0.0, 0.0, 0.0, 1.0];
    public static function rotateX(angle:Float):Mat4 {
        var c = Math.cos(angle); var s = Math.sin(angle);
        return [1.0, 0.0, 0.0, 0.0,
                0.0,  c,   s,  0.0,
                0.0, -s,   c,  0.0,
                0.0, 0.0, 0.0, 1.0];
    }
    public static function rotateY(angle:Float):Mat4 {
        var c = Math.cos(angle); var s = Math.sin(angle);
        return [ c,  0.0, -s,  0.0,
                0.0, 1.0, 0.0, 0.0,
                 s,  0.0,  c,  0.0,
                0.0, 0.0, 0.0, 1.0];
    }
    public static function rotateZ(angle:Float):Mat4 {
        var c = Math.cos(angle); var s = Math.sin(angle);
        return [ c,   s,  0.0, 0.0,
                -s,   c,  0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                0.0, 0.0, 0.0, 1.0];
    }
    public static function perspective(fovY:Float, aspectRatio:Float, zNear:Float, zFar:Float):Mat4 {
        var f = 1.0/Math.tan(fovY/2);
        var t = 1.0/(zNear-zFar);
        return [f/aspectRatio, 0.0,      0.0,        0.0,
                      0.0,      f,       0.0,        0.0,
                      0.0,     0.0, (zFar+zNear)*t, -1.0,
                      0.0,     0.0, 2*zFar*zNear*t , 0.0];
    }
    public static function lookAt(eye:Vec3, centre:Vec3, ?up:Null<Vec3>):Mat4 {
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

        var d0 = -e0*s0 - e1*s1 - e2*s2;
        var d1 = -e0*u0 - e1*u1 - e2*u2;
        var d2 =  e0*f0 + e1*f1 + e2*f2;

        return [s0, u0, -f0, 0.0,
                s1, u1, -f1, 0.0,
                s2, u2, -f2, 0.0,
                d0, d1, d2, 1.0];
    }

    @:op(A*B) public static function mul(b:Mat4, a:Mat4):Mat4
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

