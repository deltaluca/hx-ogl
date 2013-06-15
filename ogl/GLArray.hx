package ogl;

import ogl.GL;
import haxe.io.BytesData;

import #if neko neko #else cpp #end.Lib;
class ByteUtils {
    public static inline function length(b:Dynamic) {
        return Lib.load("ogl", "hx_gl_vector_len", 1)(b);
    }
}

abstract GLubyteArray(GLArray) to GLArray {
    inline public function new(raw:Dynamic) this = new GLArray(raw, 1, GL.UNSIGNED_BYTE);
    @:from public static inline function fromData(b:BytesData):GLubyteArray return new GLubyteArray(GL.dataBuffer(b, GL.UNSIGNED_BYTE));
    @:from public static inline function fromArr(arr:Array<Dynamic>):GLubyteArray return new GLubyteArray(GL.buffer(arr, GL.UNSIGNED_BYTE));
    public static inline function alloc(count:Int):GLubyteArray return GL.allocBuffer(GL.UNSIGNED_BYTE, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLubyteArray(arr.vector);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 1;
    public var raw(get, never):Dynamic;
    inline function get_raw() return this.vector;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLubyte {
        var byte = Lib.load("ogl", "hx_gl_vector_get_byte", 3)(this.vector, this.byteOffset, i);
        return (byte < 0) ? (byte & 0xff) | 0x80 : byte;
    }
    @:arrayAccess public inline function set(i:Int, x:GLubyte):GLubyte
        return Lib.load("ogl", "hx_gl_vector_set_byte", 4)(this.vector, this.byteOffset, i, x&0xff);

    inline public function resize(count:Int) GL.load("arrvector_resize", 2)(this.vector, count*this.size);
}

abstract GLbyteArray(GLArray) to GLArray {
    inline public function new(raw:Dynamic) this = new GLArray(raw, 1, GL.BYTE);
    @:from public static inline function fromData(b:BytesData):GLbyteArray return new GLbyteArray(GL.dataBuffer(b, GL.BYTE));
    @:from public static inline function fromArr(arr:Array<Dynamic>):GLbyteArray return new GLbyteArray(GL.buffer(arr, GL.BYTE));
    public static inline function alloc(count:Int):GLbyteArray return GL.allocBuffer(GL.BYTE, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLbyteArray(arr.vector);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 1;
    public var raw(get, never):Dynamic;
    inline function get_raw() return this.vector;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLbyte {
        var byte = Lib.load("ogl", "hx_gl_vector_get_byte", 3)(this.vector, this.byteOffset, i);
        return (byte < 0) ? (byte & 0xff) | 0x80 : byte;
    }
    @:arrayAccess public inline function set(i:Int, x:GLbyte):GLbyte
        return Lib.load("ogl", "hx_gl_vector_set_byte", 4)(this.vector, this.byteOffset, i, x&0xff);

    inline public function resize(count:Int) GL.load("arrvector_resize", 2)(this.vector, count*this.size);
}

abstract GLushortArray(GLArray) to GLArray {
    inline public function new(raw:Dynamic) this = new GLArray(raw, 2, GL.UNSIGNED_SHORT);
    @:from public static inline function fromData(b:BytesData):GLushortArray return new GLushortArray(GL.dataBuffer(b, GL.UNSIGNED_SHORT));
    @:from public static inline function fromArr(arr:Array<Dynamic>):GLushortArray return new GLushortArray(GL.buffer(arr, GL.UNSIGNED_SHORT));
    public static inline function alloc(count:Int):GLushortArray return GL.allocBuffer(GL.UNSIGNED_SHORT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLushortArray(arr.vector);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 2;
    public var raw(get, never):Dynamic;
    inline function get_raw() return this.vector;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLushort
        return Lib.load("ogl", "hx_gl_vector_get_short", 3)(this.vector, this.byteOffset, i);
    @:arrayAccess public inline function set(i:Int, x:GLushort):GLushort
        return Lib.load("ogl", "hx_gl_vector_set_short", 4)(this.vector, this.byteOffset, i, x);

    inline public function resize(count:Int) GL.load("arrvector_resize", 2)(this.vector, count*this.size);
}

abstract GLshortArray(GLArray) to GLArray {
    inline public function new(raw:Dynamic) this = new GLArray(raw, 2, GL.SHORT);
    @:from public static inline function fromData(b:BytesData):GLshortArray return new GLshortArray(GL.dataBuffer(b, GL.SHORT));
    @:from public static inline function fromArr(arr:Array<Dynamic>):GLshortArray return new GLshortArray(GL.buffer(arr, GL.SHORT));
    public static inline function alloc(count:Int):GLshortArray return GL.allocBuffer(GL.SHORT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLshortArray(arr.vector);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 2;
    public var raw(get, never):Dynamic;
    inline function get_raw() return this.vector;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLshort
        return Lib.load("ogl", "hx_gl_vector_get_short", 3)(this.vector, this.byteOffset, i);
    @:arrayAccess public inline function set(i:Int, x:GLshort):GLshort
        return Lib.load("ogl", "hx_gl_vector_set_short", 4)(this.vector, this.byteOffset, i, x);

    inline public function resize(count:Int) GL.load("arrvector_resize", 2)(this.vector, count*this.size);
}

abstract GLuintArray(GLArray) to GLArray {
    inline public function new(raw:Dynamic) this = new GLArray(raw, 4, GL.UNSIGNED_INT);
    @:from public static inline function fromData(b:BytesData):GLuintArray return new GLuintArray(GL.dataBuffer(b, GL.UNSIGNED_INT));
    @:from public static inline function fromArr(arr:Array<Dynamic>):GLuintArray return new GLuintArray(GL.buffer(arr, GL.UNSIGNED_INT));
    public static inline function alloc(count:Int):GLuintArray return GL.allocBuffer(GL.UNSIGNED_INT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLuintArray(arr.vector);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 4;
    public var raw(get, never):Dynamic;
    inline function get_raw() return this.vector;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLuint
        return Lib.load("ogl", "hx_gl_vector_get_int", 3)(this.vector, this.byteOffset, i);
    @:arrayAccess public inline function set(i:Int, x:GLuint):GLuint
        return Lib.load("ogl", "hx_gl_vector_set_int", 4)(this.vector, this.byteOffset, i, x);

    inline public function resize(count:Int) GL.load("arrvector_resize", 2)(this.vector, count*this.size);
}

abstract GLintArray(GLArray) to GLArray {
    inline public function new(raw:Dynamic) this = new GLArray(raw, 4, GL.INT);
    @:from public static inline function fromData(b:BytesData):GLintArray return new GLintArray(GL.dataBuffer(b, GL.INT));
    @:from public static inline function fromArr(arr:Array<Dynamic>):GLintArray return new GLintArray(GL.buffer(arr, GL.INT));
    public static inline function alloc(count:Int):GLintArray return GL.allocBuffer(GL.INT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLintArray(arr.vector);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 4;
    public var raw(get, never):Dynamic;
    inline function get_raw() return this.vector;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLint
        return Lib.load("ogl", "hx_gl_vector_get_int", 3)(this.vector, this.byteOffset, i);
    @:arrayAccess public inline function set(i:Int, x:GLint):GLint
        return Lib.load("ogl", "hx_gl_vector_set_int", 4)(this.vector, this.byteOffset, i, x);

    inline public function resize(count:Int) GL.load("arrvector_resize", 2)(this.vector, count*this.size);
}

abstract GLfloatArray(GLArray) to GLArray {
    inline public function new(raw:Dynamic) this = new GLArray(raw, 4, GL.FLOAT);
    @:from public static inline function fromData(b:BytesData):GLfloatArray return new GLfloatArray(GL.dataBuffer(b, GL.FLOAT));
    @:from public static inline function fromArr(arr:Array<Dynamic>):GLfloatArray return new GLfloatArray(GL.buffer(arr, GL.FLOAT));
    public static inline function alloc(count:Int):GLfloatArray return GL.allocBuffer(GL.FLOAT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLfloatArray(arr.vector);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 4;
    public var raw(get, never):Dynamic;
    inline function get_raw() return this.vector;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLfloat
        return Lib.load("ogl", "hx_gl_vector_get_float", 3)(this.vector, this.byteOffset, i);
    @:arrayAccess public inline function set<T>(i:Int, x:T):GLfloat
        return Lib.load("ogl", "hx_gl_vector_set_float", 4)(this.vector, this.byteOffset, i, x);

    inline public function resize(count:Int) GL.load("arrvector_resize", 2)(this.vector, count*this.size);
}

abstract GLdoubleArray(GLArray) to GLArray {
    inline public function new(raw:Dynamic) this = new GLArray(raw, 8, GL.DOUBLE);
    @:from public static inline function fromData(b:BytesData):GLdoubleArray return new GLdoubleArray(GL.dataBuffer(b, GL.DOUBLE));
    @:from public static inline function fromArr(arr:Array<Dynamic>):GLdoubleArray return new GLdoubleArray(GL.buffer(arr, GL.DOUBLE));
    public static inline function alloc(count:Int):GLdoubleArray return GL.allocBuffer(GL.DOUBLE, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLdoubleArray(arr.vector);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 8;
    public var raw(get, never):Dynamic;
    inline function get_raw() return this.vector;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLdouble
        return Lib.load("ogl", "hx_gl_vector_get_double", 3)(this.vector, this.byteOffset, i);
    @:arrayAccess public inline function set<T>(i:Int, x:T):GLdouble
        return Lib.load("ogl", "hx_gl_vector_set_double", 4)(this.vector, this.byteOffset, i, x);

    inline public function resize(count:Int) GL.load("arrvector_resize", 2)(this.vector, count*this.size);
}

class GLArray {
    public var isView:Bool = false;
    public var fixedCount:Int = 0;
    public var byteOffset:GLsizeiptr = 0;

    public var size:Int; // element size
    public var type:GLenum;
    public var vector:Dynamic;
    public var count(get, never):Int;
    inline function get_count()
        return if (isView) fixedCount else Std.int(ByteUtils.length(vector) / size);

    public function new(vector:Dynamic, size:Int, type:Int) {
        this.vector = vector;
        this.size = size;
        this.type = type;
    }
    public inline function view(offset:Int, count:Int) {
        fixedCount = count;
        byteOffset = offset;
        isView = true;
    }

    inline public function toString() {
        var t = if (type == GL.BYTE)           "BYTE"
           else if (type == GL.UNSIGNED_BYTE)  "UNSIGNED_BYTE"
           else if (type == GL.SHORT)          "SHORT"
           else if (type == GL.UNSIGNED_SHORT) "UNSIGNED_SHORT"
           else if (type == GL.INT)            "INT"
           else if (type == GL.UNSIGNED_INT)   "UNSIGNED_INT"
           else if (type == GL.FLOAT)          "FLOAT"
           else                                "DOUBLE";
        return if (isView) 'GLArrayView ${byteOffset}b + ($t)x$count'
               else        'GLArray ($t)x$count';
    }
}
