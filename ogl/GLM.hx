package ogl;

import ogl.Macros;
import ogl.GL;
import ogl.GLArray;

class Padder {
    public static function pad(x:String, y:Array<Float>) {
        var z = [];
        var max = 0;
        for (yt in y) {
            var ys = Std.string(Math.fround(yt*1e10)*1e-10);
            if (ys.length > max) max = ys.length;
            z.push(ys);
        }
        for (i in 0...z.length) {
            z[i] = StringTools.rpad(z[i], " ", max);
        }
        return (~/\$([0-9]+)/g).map(x, function (t) return z[Std.parseInt(t.matched(0).substr(1))]);
    }
}

@:build(ogl.GLVector.run(2)) abstract Vec2(Array<Float>) to Array<Float> from Array<Float> {
    public inline function new(x:Array<Float>) this = x;
    @:from public static inline function fromFloatArr2(xs:Array<Array<Float>>) {
        var ys = [];
        for (x in xs) ys = ys.concat(x);
        return new Vec2(ys);
    }
    @:from public static inline function fromAnon(x:{x:Float,y:Float}) return new Vec2([x.x,x.y]);
    @:from public static inline function fromGL(x:GLfloatArray) return new Vec2([x[0],x[1]]);
    @:to public inline function toGL() return GLfloatArray.fromArr(this);
    @:to public inline function toAnon() return {x:x, y:y};

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

    @:op(A==B) public static inline function eq(a:Vec2, b:Vec2) return a != null && b != null && (a.x == b.x && a.y == b.y) || a == null && b == null;

    public static inline function length   (a:Vec2) return Math.sqrt(a.x*a.x+a.y*a.y);
    public static inline function normalise(a:Vec2) return a*(1/length(a));
    public static inline function distance (a:Vec2, b:Vec2) return length(a - b);

    @:to public inline function toString() {
        var a:Vec2 = this;
        return Padder.pad("<$0 $1>",[a.x,a.y]);
    }
}

@:build(ogl.GLVector.run(3)) abstract Vec3(Array<Float>) to Array<Float> from Array<Float> {
    public inline function new(x:Array<Float>) this = x;
    @:from public static inline function fromFloatArr2(xs:Array<Array<Float>>) {
        var ys = [];
        for (x in xs) ys = ys.concat(x);
        return new Vec3(ys);
    }
    @:from public static inline function fromAnon(x:{x:Float,y:Float,z:Float}) return new Vec3([x.x,x.y,x.z]);
    @:from public static inline function fromGL(x:GLfloatArray) return new Vec3([x[0],x[1],x[2]]);
    @:to public inline function toGL() return GLfloatArray.fromArr(this);
    @:to public inline function toAnon() return {x:x, y:y, z:z};

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

    @:op(A==B) public static inline function eq(a:Vec3, b:Vec3) return a != null && b != null && (a.x == b.x && a.y == b.y && a.z == b.z) || a == null && b == null;

    public static inline function length   (a:Vec3) return Math.sqrt(a.x*a.x+a.y*a.y+a.z*a.z);
    public static inline function normalise(a:Vec3) return a*(1/length(a));
    public static inline function distance (a:Vec3, b:Vec3) return length(a - b);

    @:to public inline function toString() {
        var a:Vec3 = this;
        return Padder.pad("<$0 $1 $2>",[a.x,a.y,a.z]);
    }
}

@:build(ogl.GLVector.run(4)) abstract Vec4(Array<Float>) to Array<Float> from Array<Float> {
    public inline function new(x:Array<Float>) this = x;
    @:from public static inline function fromFloatArr2(xs:Array<Array<Float>>) {
        var ys = [];
        for (x in xs) ys = ys.concat(x);
        return new Vec4(ys);
    }
    @:from public static inline function fromAnon(x:{x:Float,y:Float,z:Float,w:Float}) return new Vec4([x.x,x.y,x.z,x.w]);
    @:from public static inline function fromGL(x:GLfloatArray) return new Vec4([x[0],x[1],x[2],x[3]]);
    @:to public inline function toGL() return GLfloatArray.fromArr(this);
    @:to public inline function toAnon() return {x:x, y:y, z:z, w:w};

    // .xyzw
    public var x(get,set):Float; inline function get_x() return this[0]; inline function set_x(x:Float) return this[0] = x;
    public var y(get,set):Float; inline function get_y() return this[1]; inline function set_y(y:Float) return this[1] = y;
    public var z(get,set):Float; inline function get_z() return this[2]; inline function set_z(z:Float) return this[2] = z;
    public var w(get,set):Float; inline function get_w() return this[3]; inline function set_w(w:Float) return this[3] = w;

    // .rgba
    public var r(get,set):Float; inline function get_r() return this[0]; inline function set_r(r:Float) return this[0] = r;
    public var g(get,set):Float; inline function get_g() return this[1]; inline function set_g(g:Float) return this[1] = g;
    public var b(get,set):Float; inline function get_b() return this[2]; inline function set_b(b:Float) return this[2] = b;
    public var a(get,set):Float; inline function get_a() return this[3]; inline function set_a(a:Float) return this[3] = a;

    // .stpq
    public var s(get,set):Float; inline function get_s() return this[0]; inline function set_s(s:Float) return this[0] = s;
    public var t(get,set):Float; inline function get_t() return this[1]; inline function set_t(t:Float) return this[1] = t;
    public var p(get,set):Float; inline function get_p() return this[2]; inline function set_p(p:Float) return this[2] = p;
    public var q(get,set):Float; inline function get_q() return this[3]; inline function set_q(q:Float) return this[3] = q;

    // array access
    @:arrayAccess public inline function geti(i:Int):Float return this[i];
    @:arrayAccess public inline function getf(i:Int):Float return this[i];
    @:arrayAccess public inline function seti(i:Int,x:Int)  :Float return this[i]=x;
    @:arrayAccess public inline function setf(i:Int,x:Float):Float return this[i]=x;

    @:op(A==B) public static inline function eq(a:Vec4, b:Vec4) return a != null && b != null && (a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w) || a == null && b == null;

    public static inline function length   (a:Vec4) return Math.sqrt(a.x*a.x+a.y*a.y+a.z*a.z+a.w*a.w);
    public static inline function normalise(a:Vec4) return a*(1/length(a));
    public static inline function distance (a:Vec4, b:Vec4) return length(a - b);

    @:to public inline function toString() {
        var a:Vec4 = this;
        return Padder.pad("<$0 $1 $2 $3>",[a.x,a.y,a.z,a.w]);
    }
}

abstract Mat3x2(Array<Float>) from Array<Float> to Array<Float> {
    public inline function new(x:Array<Float>) this = x;
    @:from public static inline function fromFloatArr2(xs:Array<Array<Float>>) {
        var ys = [];
        for (x in xs) ys = ys.concat(x);
        return new Mat3x2(ys);
    }
    @:from public static inline function fromGL(x:GLfloatArray) return new Mat3x2([x[0],x[1],x[2],x[3],x[4],x[5]]);
    @:to public inline function toGL() return GLfloatArray.fromArr(this);

    // array access
    @:arrayAccess public inline function get(i:Int):Float return this[i];
    @:arrayAccess public inline function set(i:Int,x:Float):Float return this[i]=x;

    public static inline function identity():Mat3x2
        return [1.0, 0.0,
                0.0, 1.0,
                0.0, 0.0];

    public static inline function scale(x:Float, y:Float):Mat3x2
        return [x,   0.0,
                0.0,  y,
                0.0, 0.0];

    public static inline function translate(x:Float, y:Float):Mat3x2
        return [1.0, 0.0,
                0.0, 1.0,
                 x,   y];

    public static inline function rotate(angle:Float):Mat3x2 {
        var c = Math.cos(angle); var s = Math.sin(angle);
        return [c, s,
               -s, c,
                0, 0];
    }

    // (x, y) => (2*x/w - 1, 1 - 2*y/h)
    public static inline function viewportMap(width:Float, height:Float):Mat3x2
        return [2.0/width,  0.0,
                   0.0, -2.0/height,
                  -1.0,     1.0    ];

    @:op(A*B) public static inline function mul(_b:Mat3x2, _a:Mat3x2):Mat3x2 {
        var a = _a;
        var b = _b;
        return [b[0]*a[0] + b[2]*a[1],
                b[1]*a[0] + b[3]*a[1],

                b[0]*a[2] + b[2]*a[3],
                b[1]*a[2] + b[3]*a[3],

                b[0]*a[4] + b[2]*a[5] + b[4],
                b[1]*a[4] + b[3]*a[5] + b[5]];
    }

    @:op(A*B) public static inline function mulv(_b:Mat3x2, _a:Vec2):Vec2 {
        var a = _a;
        var b = _b;
        return [b[0]*a[0] + b[2]*a[1] + b[4],
                b[1]*a[0] + b[3]*a[1] + b[5]];
    }

    // Multiply rectangle specified by Vec4 as a pair of Vec2 (point+vector)
    @:op(A*B) public static inline function mulrect(_b:Mat3x2, _a:Vec4):Vec4 {
        var a = _a;
        var b = _b;
        return [b[0]*a[0] + b[2]*a[1] + b[4],
                b[1]*a[0] + b[3]*a[1] + b[5],
                b[0]*a[2] + b[2]*a[3],
                b[1]*a[2] + b[3]*a[3]];
    }

    public inline function inverse():Mat3x2 {
        var a:Mat3x2 = this;
        var det = 1.0/(a[0]*a[3] - a[1]*a[2]);
        return [a[3]*det, -a[1]*det,
               -a[2]*det,  a[0]*det,
               (a[2]*a[5] - a[3]*a[4])*det,
               (a[1]*a[4] - a[0]*a[5])*det];
    }

    @:to public inline function toString() {
        var a:Mat3x2 = this;
        return Padder.pad("[$0 $2 $4\n $1 $3 $5]",[a[0],a[1],a[2],a[3],a[4],a[5]]);
    }
}

abstract Mat4(Array<Float>) from Array<Float> to Array<Float> {
    public inline function new(x:Array<Float>) this = x;
    @:from public static inline function fromFloatArr2(xs:Array<Array<Float>>) {
        var ys = [];
        for (x in xs) ys = ys.concat(x);
        return new Mat4(ys);
    }
    @:from public static inline function fromGL(x:GLfloatArray) return new Mat4([
        x[0], x[1], x[2], x[3],
        x[4], x[5], x[6], x[7],
        x[8], x[9], x[10],x[11],
        x[12],x[13],x[14],x[15],
    ]);
    @:to public inline function toGL() return GLfloatArray.fromArr(this);

    @:from public static inline function from3x2(_x:Mat3x2):Mat4 {
        var x = _x;
        return [x[0], x[1], 0, 0,
                x[2], x[3], 0, 0,
                  0,    0,  1, 0,
                x[4], x[5], 0, 1];
    }

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
    public static function lookAt(_eye:Vec3, _centre:Vec3, ?_up:Null<Vec3>):Mat4 {
        var eye = _eye;
        var centre = _centre;
        var up = _up;

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

    @:op(A*B) public static function mul_3(_b:Mat4, _a:Mat3x2):Mat4 {
        var b = _b; var a = _a;
        return [b[0]*a[0]  + b[4]*a[1],
                b[1]*a[0]  + b[5]*a[1],
                b[2]*a[0]  + b[6]*a[1],
                b[3]*a[0]  + b[7]*a[1],

                b[0]*a[2]  + b[4]*a[3],
                b[1]*a[2]  + b[5]*a[3],
                b[2]*a[2]  + b[6]*a[3],
                b[3]*a[2]  + b[7]*a[3],

                b[8],
                b[9],
                b[10],
                b[11],

                b[0]*a[4] + b[4]*a[5] + b[12],
                b[1]*a[4] + b[5]*a[5] + b[13],
                b[2]*a[4] + b[6]*a[5] + b[14],
                b[3]*a[4] + b[7]*a[5] + b[15]];
    }

    @:op(A*B) public static function _3_mul(_b:Mat3x2, _a:Mat4):Mat4 {
        var b = _b;
        var a = _a;
        return [b[0]*a[0]  + b[2]*a[1]  + b[4]*a[3],
                b[1]*a[0]  + b[3]*a[1]  + b[5]*a[3],
                a[2],
                a[3],

                b[0]*a[4]  + b[2]*a[5]  + b[4]*a[7],
                b[1]*a[4]  + b[3]*a[5]  + b[5]*a[7],
                a[6],
                a[7],

                b[0]*a[8]  + b[2]*a[9]  + b[4]*a[11],
                b[1]*a[8]  + b[3]*a[9]  + b[5]*a[11],
                a[10],
                a[11],

                b[0]*a[12] + b[2]*a[13] + b[4]*a[15],
                b[1]*a[12] + b[3]*a[13] + b[5]*a[15],
                a[14],
                a[15]];
    }

    @:op(A*B) public static function mul(_b:Mat4, _a:Mat4):Mat4 {
        var b = _b;
        var a = _a;
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

    public inline function inverse():Mat4 {
        var a:Mat4 = this;
        var s0 = a[0]*a[5] -a[4] *a[1]; var c5 = a[10]*a[15]-a[14]*a[11];
        var s1 = a[0]*a[9] -a[8] *a[1]; var c4 = a[6] *a[15]-a[14]*a[7];
        var s2 = a[0]*a[13]-a[12]*a[1]; var c3 = a[6] *a[11]-a[10]*a[7];
        var s3 = a[4]*a[9] -a[8] *a[5]; var c2 = a[2] *a[15]-a[14]*a[3];
        var s4 = a[4]*a[13]-a[12]*a[5]; var c1 = a[2] *a[11]-a[10]*a[3];
        var s5 = a[8]*a[13]-a[12]*a[9]; var c0 = a[2] *a[7]- a[6] *a[3];
        var D = 1/(s0*c5-s1*c4+s2*c3+s3*c2-s4*c1+s5*c0);
        return [
            D*( a[5]*c5-a[9] *c4+a[13]*c3),D*(-a[1]*c5+a[9] *c2-a[13]*c1),D*( a[1]*c4-a[5]*c2+a[13]*c0),D*(-a[1]*c3+a[5]*c1-a[9] *c0),
            D*(-a[4]*c5+a[8] *c4-a[12]*c3),D*( a[0]*c5-a[8] *c2+a[12]*c1),D*(-a[0]*c4+a[4]*c2-a[12]*c0),D*( a[0]*c3-a[4]*c1+a[8] *c0),
            D*( a[7]*s5-a[11]*s4+a[15]*s3),D*(-a[3]*s5+a[11]*s2-a[15]*s1),D*( a[3]*s4-a[7]*s2+a[15]*s0),D*(-a[3]*s3+a[7]*s1-a[11]*s0),
            D*(-a[6]*s5+a[10]*s4-a[14]*s3),D*( a[2]*s5-a[10]*s2+a[14]*s1),D*(-a[2]*s4+a[6]*s2-a[14]*s0),D*( a[2]*s3-a[6]*s1+a[10]*s0),
        ];
    }

    @:op(A*B) public static inline function mulv(_b:Mat4, _a:Vec4):Vec4 {
        var a = _a;
        var b = _b;
        return [b[0]*a[0] + b[4]*a[1] + b[8] *a[2] + b[12]*a[3],
                b[1]*a[0] + b[5]*a[1] + b[9] *a[2] + b[13]*a[3],
                b[2]*a[0] + b[6]*a[1] + b[10]*a[2] + b[14]*a[3],
                b[3]*a[0] + b[7]*a[1] + b[11]*a[2] + b[15]*a[3]];
    }

    public inline function transpose():Mat4 {
        var a:Mat4 = this;
        return [a[0], a[4], a[8],  a[12],
                a[1], a[5], a[9],  a[13],
                a[2], a[6], a[10], a[14],
                a[3], a[7], a[11], a[15]];
    }

    @:to public inline function toString() {
        var a:Mat4 = this;
        return Padder.pad("[$0 $4 $8 $12\n $1 $5 $9 $13\n $2 $6 $10 $14\n $3 $7 $11 $15]",[
            a[0],a[1],a[2],a[3],
            a[4],a[5],a[6],a[7],
            a[8],a[9],a[10],a[11],
            a[12],a[13],a[14],a[15]]
        );
    }
}





/*





@:build(ogl.GLVector.run(2)) abstract Vec2(GLfloatArray) to GLfloatArray {
    public inline function new(x:GLfloatArray) this = x;
    @:from public static inline function fromHaxe(x:Array<Dynamic>) return new Vec2(GLfloatArray.fromArr(x));
    @:from public static inline function fromGL(x:GLfloatArray) return new Vec2(x);
    @:from public static inline function fromAnon(x:{x:Float,y:Float}) return new Vec2([x.x,x.y]);

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

    @:op(A==B) public static inline function eq(a:Vec2, b:Vec2) return a != null && b != null && (a.x == b.x && a.y == b.y) || a == null && b == null;

    public static inline function length   (a:Vec2)         return Math.sqrt(a.x*a.x+a.y*a.y);
    public static inline function distance (a:Vec2, b:Vec2) return length(a - b);
    public static inline function normalise(a:Vec2)         return a*(1/length(a));

    @:to public inline function toString() {
        var a:Vec2 = this;
        return Padder.pad("<$0 $1>",[a.x,a.y]);
    }
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

    @:op(A==B) public static inline function eq(a:Vec3, b:Vec3) return a != null && b != null && (a.x == b.x && a.y == b.y && a.z == b.z) || a == null && b == null;

    public static inline function length   (a:Vec3)         return Math.sqrt(a.x*a.x+a.y*a.y+a.z*a.z);
    public static inline function distance (a:Vec3, b:Vec3) return length(a - b);
    public static inline function normalise(a:Vec3)         return a*(1/length(a));

    @:to public inline function toString() {
        var a:Vec3 = this;
        return Padder.pad("<$0 $1 $2>",[a.x,a.y,a.z]);
    }
}

@:build(ogl.GLVector.run(4)) abstract Vec4(GLfloatArray) to GLfloatArray {
    public inline function new(x:GLfloatArray) this = x;
    @:from public static inline function fromHaxe(x:Array<Dynamic>) return new Vec4(GLfloatArray.fromArr(x));
    @:from public static inline function fromGL(x:GLfloatArray) return new Vec4(x);

    // .xyzw
    public var x(get,set):Float; inline function get_x() return this[0]; inline function set_x(x:Float) return this[0] = x;
    public var y(get,set):Float; inline function get_y() return this[1]; inline function set_y(y:Float) return this[1] = y;
    public var z(get,set):Float; inline function get_z() return this[2]; inline function set_z(z:Float) return this[2] = z;
    public var w(get,set):Float; inline function get_w() return this[3]; inline function set_w(w:Float) return this[3] = w;

    // .rgba
    public var r(get,set):Float; inline function get_r() return this[0]; inline function set_r(r:Float) return this[0] = r;
    public var g(get,set):Float; inline function get_g() return this[1]; inline function set_g(g:Float) return this[1] = g;
    public var b(get,set):Float; inline function get_b() return this[2]; inline function set_b(b:Float) return this[2] = b;
    public var a(get,set):Float; inline function get_a() return this[3]; inline function set_a(a:Float) return this[3] = a;

    // .stpq
    public var s(get,set):Float; inline function get_s() return this[0]; inline function set_s(s:Float) return this[0] = s;
    public var t(get,set):Float; inline function get_t() return this[1]; inline function set_t(t:Float) return this[1] = t;
    public var p(get,set):Float; inline function get_p() return this[2]; inline function set_p(p:Float) return this[2] = p;
    public var q(get,set):Float; inline function get_q() return this[3]; inline function set_q(q:Float) return this[3] = q;

    // array access
    @:arrayAccess public inline function geti(i:Int):Float return this[i];
    @:arrayAccess public inline function getf(i:Int):Float return this[i];
    @:arrayAccess public inline function seti(i:Int,x:Int)  :Float return this[i]=x;
    @:arrayAccess public inline function setf(i:Int,x:Float):Float return this[i]=x;

    @:op(A==B) public static inline function eq(a:Vec4, b:Vec4) return a != null && b != null && (a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w) || a == null && b == null;

    public static inline function length   (a:Vec4)         return Math.sqrt(a.x*a.x+a.y*a.y+a.z*a.z+a.w*a.w);
    public static inline function distance (a:Vec4, b:Vec4) return length(a - b);
    public static inline function normalise(a:Vec4)         return a*(1/length(a));

    @:to public inline function toString() {
        var a:Vec4 = this;
        return Padder.pad("<$0 $1 $2 $3>",[a.x,a.y,a.z,a.w]);
    }
}

abstract Mat3x2(GLfloatArray) to GLfloatArray {
    public inline function new(x:GLfloatArray) this = x;
    @:from public static inline function fromHaxe(x:Array<Dynamic>) return new Mat3x2(GLfloatArray.fromArr(x));
    @:from public static inline function fromGL(x:GLfloatArray) return new Mat3x2(x);

    // array access
    @:arrayAccess public inline function get(i:Int):Float return this[i];
    @:arrayAccess public inline function set(i:Int,x:Float):Float return this[i]=x;

    public static inline function identity():Mat3x2
        return [1.0, 0.0,
                0.0, 1.0,
                0.0, 0.0];

    public static inline function scale(x:Float, y:Float):Mat3x2
        return [x,   0.0,
                0.0,  y,
                0.0, 0.0];

    public static inline function translate(x:Float, y:Float):Mat3x2
        return [1.0, 0.0,
                0.0, 1.0,
                 x,   y];

    public static inline function rotate(angle:Float):Mat3x2 {
        var c = Math.cos(angle); var s = Math.sin(angle);
        return [c, s,
               -s, c,
                0, 0];
    }

    // (x, y) => (2*x/w - 1, 1 - 2*y/h)
    public static inline function viewportMap(width:Float, height:Float):Mat3x2
        return [2.0/width,  0.0,
                   0.0, -2.0/height,
                  -1.0,     1.0    ];

    @:op(A*B) public static inline function mul(_b:Mat3x2, _a:Mat3x2):Mat3x2 {
        var a = _a;
        var b = _b;
        return [b[0]*a[0] + b[2]*a[1],
                b[1]*a[0] + b[3]*a[1],

                b[0]*a[2] + b[2]*a[3],
                b[1]*a[2] + b[3]*a[3],

                b[0]*a[4] + b[2]*a[5] + b[4],
                b[1]*a[4] + b[3]*a[5] + b[5]];
    }

    @:op(A*B) public static inline function mulv(_b:Mat3x2, _a:Vec2):Vec2 {
        var a = _a;
        var b = _b;
        return [b[0]*a[0] + b[2]*a[1] + b[4],
                b[1]*a[0] + b[3]*a[1] + b[5]];
    }

    // Multiply rectangle specified by Vec4 as a pair of Vec2 (point+vector)
    @:op(A*B) public static inline function mulrect(_b:Mat3x2, _a:Vec4):Vec4 {
        var a = _a;
        var b = _b;
        return [b[0]*a[0] + b[2]*a[1] + b[4],
                b[1]*a[0] + b[3]*a[1] + b[5],
                b[0]*a[2] + b[2]*a[3],
                b[1]*a[2] + b[3]*a[3]];
    }

    public inline function inverse():Mat3x2 {
        var a:Mat3x2 = this;
        var det = 1.0/(a[0]*a[3] - a[1]*a[2]);
        return [a[3]*det, -a[1]*det,
               -a[2]*det,  a[0]*det,
               (a[2]*a[5] - a[3]*a[4])*det,
               (a[1]*a[4] - a[0]*a[5])*det];
    }

    @:to public inline function toString() {
        var a:Mat3x2 = this;
        return Padder.pad("[$0 $2 $4\n $1 $3 $5]",[a[0],a[1],a[2],a[3],a[4],a[5]]);
    }
}

abstract Mat4(GLfloatArray) to GLfloatArray {
    public inline function new(x:GLfloatArray) this = x;
    @:from public static inline function fromHaxe(x:Array<Dynamic>) return new Mat4(GLfloatArray.fromArr(x));
    @:from public static inline function fromGL(x:GLfloatArray) return new Mat4(x);

    @:from public static inline function from3x2(_x:Mat3x2):Mat4 {
        var x = _x;
        return [x[0], x[1], 0, 0,
                x[2], x[3], 0, 0,
                  0,    0,  1, 0,
                x[4], x[5], 0, 1];
    }

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
    public static function lookAt(_eye:Vec3, _centre:Vec3, ?_up:Null<Vec3>):Mat4 {
        var eye = _eye;
        var centre = _centre;
        var up = _up;

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

    @:op(A*B) public static function mul_3(_b:Mat4, _a:Mat3x2):Mat4 {
        var b = _b; var a = _a;
        return [b[0]*a[0]  + b[4]*a[1],
                b[1]*a[0]  + b[5]*a[1],
                b[2]*a[0]  + b[6]*a[1],
                b[3]*a[0]  + b[7]*a[1],

                b[0]*a[2]  + b[4]*a[3],
                b[1]*a[2]  + b[5]*a[3],
                b[2]*a[2]  + b[6]*a[3],
                b[3]*a[2]  + b[7]*a[3],

                b[8],
                b[9],
                b[10],
                b[11],

                b[0]*a[4] + b[4]*a[5] + b[12],
                b[1]*a[4] + b[5]*a[5] + b[13],
                b[2]*a[4] + b[6]*a[5] + b[14],
                b[3]*a[4] + b[7]*a[5] + b[15]];
    }

    @:op(A*B) public static function _3_mul(_b:Mat3x2, _a:Mat4):Mat4 {
        var b = _b;
        var a = _a;
        return [b[0]*a[0]  + b[2]*a[1]  + b[4]*a[3],
                b[1]*a[0]  + b[3]*a[1]  + b[5]*a[3],
                a[2],
                a[3],

                b[0]*a[4]  + b[2]*a[5]  + b[4]*a[7],
                b[1]*a[4]  + b[3]*a[5]  + b[5]*a[7],
                a[6],
                a[7],

                b[0]*a[8]  + b[2]*a[9]  + b[4]*a[11],
                b[1]*a[8]  + b[3]*a[9]  + b[5]*a[11],
                a[10],
                a[11],

                b[0]*a[12] + b[2]*a[13] + b[4]*a[15],
                b[1]*a[12] + b[3]*a[13] + b[5]*a[15],
                a[14],
                a[15]];
    }

    @:op(A*B) public static function mul(_b:Mat4, _a:Mat4):Mat4 {
        var b = _b;
        var a = _a;
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

    public inline function inverse():Mat4 {
        var a:Mat4 = this;
        var s0 = a[0]*a[5] -a[4] *a[1]; var c5 = a[10]*a[15]-a[14]*a[11];
        var s1 = a[0]*a[9] -a[8] *a[1]; var c4 = a[6] *a[15]-a[14]*a[7];
        var s2 = a[0]*a[13]-a[12]*a[1]; var c3 = a[6] *a[11]-a[10]*a[7];
        var s3 = a[4]*a[9] -a[8] *a[5]; var c2 = a[2] *a[15]-a[14]*a[3];
        var s4 = a[4]*a[13]-a[12]*a[5]; var c1 = a[2] *a[11]-a[10]*a[3];
        var s5 = a[8]*a[13]-a[12]*a[9]; var c0 = a[2] *a[7]- a[6] *a[3];
        var D = 1/(s0*c5-s1*c4+s2*c3+s3*c2-s4*c1+s5*c0);
        return [
            D*( a[5]*c5-a[9] *c4+a[13]*c3),D*(-a[1]*c5+a[9] *c2-a[13]*c1),D*( a[1]*c4-a[5]*c2+a[13]*c0),D*(-a[1]*c3+a[5]*c1-a[9] *c0),
            D*(-a[4]*c5+a[8] *c4-a[12]*c3),D*( a[0]*c5-a[8] *c2+a[12]*c1),D*(-a[0]*c4+a[4]*c2-a[12]*c0),D*( a[0]*c3-a[4]*c1+a[8] *c0),
            D*( a[7]*s5-a[11]*s4+a[15]*s3),D*(-a[3]*s5+a[11]*s2-a[15]*s1),D*( a[3]*s4-a[7]*s2+a[15]*s0),D*(-a[3]*s3+a[7]*s1-a[11]*s0),
            D*(-a[6]*s5+a[10]*s4-a[14]*s3),D*( a[2]*s5-a[10]*s2+a[14]*s1),D*(-a[2]*s4+a[6]*s2-a[14]*s0),D*( a[2]*s3-a[6]*s1+a[10]*s0),
        ];
    }

    @:op(A*B) public static inline function mulv(_b:Mat4, _a:Vec4):Vec4 {
        var a = _a;
        var b = _b;
        return [b[0]*a[0] + b[4]*a[1] + b[8] *a[2] + b[12]*a[3],
                b[1]*a[0] + b[5]*a[1] + b[9] *a[2] + b[13]*a[3],
                b[2]*a[0] + b[6]*a[1] + b[10]*a[2] + b[14]*a[3],
                b[3]*a[0] + b[7]*a[1] + b[11]*a[2] + b[15]*a[3]];
    }

    public inline function transpose():Mat4 {
        var a:Mat4 = this;
        return [a[0], a[4], a[8],  a[12],
                a[1], a[5], a[9],  a[13],
                a[2], a[6], a[10], a[14],
                a[3], a[7], a[11], a[15]];
    }

    @:to public inline function toString() {
        var a:Mat4 = this;
        return Padder.pad("[$0 $4 $8 $12\n $1 $5 $9 $13\n $2 $6 $10 $14\n $3 $7 $11 $15]",[
            a[0],a[1],a[2],a[3],
            a[4],a[5],a[6],a[7],
            a[8],a[9],a[10],a[11],
            a[12],a[13],a[14],a[15]]
        );
    }
}
*/
