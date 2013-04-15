package ogl;

import ogl.GL;
import haxe.io.BytesData;

abstract GLubyteArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 1, GL.UNSIGNED_BYTE);
    @:from public static inline function fromRaw(raw:BytesData):GLubyteArray return new GLubyteArray(raw);
    @:from public static inline function fromArr(arr:Array<GLubyte>):GLubyteArray return GL.buffer(arr, GL.UNSIGNED_BYTE);
    public static inline function alloc(count:Int):GLubyteArray return GL.allocBuffer(GL.UNSIGNED_BYTE, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLubyteArray(arr.buffer);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 1;
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLubyte {
        var byte = untyped __global__.__hxcpp_memory_get_byte(this.buffer, this.byteOffset+i);
        return (byte < 0) ? (byte & 0xff) | 0x80 : byte;
    }
    @:arrayAccess public inline function set(i:Int, x:GLubyte):GLubyte {
        untyped __global__.__hxcpp_memory_set_byte(this.buffer, this.byteOffset+i, x&0xff);
        return get(this, i);
    }

    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLbyteArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 1, GL.BYTE);
    @:from public static inline function fromRaw(raw:BytesData) return new GLbyteArray(raw);
    @:from public static inline function fromArr(arr:Array<GLbyte>):GLbyteArray return GL.buffer(arr, GL.BYTE);
    public static inline function alloc(count:Int):GLbyteArray return GL.allocBuffer(GL.BYTE, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLbyteArray(arr.buffer);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 1;
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLbyte {
        var byte = untyped __global__.__hxcpp_memory_get_byte(this.buffer, this.byteOffset+i);
        return (byte < 0) ? (byte & 0xff) | 0x80 : byte;
    }
    @:arrayAccess public inline function set(i:Int, x:GLbyte):GLbyte {
        untyped __global__.__hxcpp_memory_set_byte(this.buffer, this.byteOffset+i, x&0xff);
        return get(this, i);
    }

    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLushortArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 2, GL.UNSIGNED_SHORT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLushortArray(raw);
    @:from public static inline function fromArr(arr:Array<GLushort>):GLushortArray return GL.buffer(arr, GL.UNSIGNED_SHORT);
    public static inline function alloc(count:Int):GLushortArray return GL.allocBuffer(GL.UNSIGNED_SHORT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLushortArray(arr.buffer);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 2;
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLushort
        return untyped __global__.__hxcpp_memory_get_ui16(this.buffer, this.byteOffset+i*2);
    @:arrayAccess public inline function set(i:Int, x:GLushort):GLushort {
        untyped __global__.__hxcpp_memory_set_i16(this.buffer, this.byteOffset+i*2, x);
        return get(this, i);
    }

    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLshortArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 2, GL.SHORT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLshortArray(raw);
    @:from public static inline function fromArr(arr:Array<GLshort>):GLshortArray return GL.buffer(arr, GL.SHORT);
    public static inline function alloc(count:Int):GLshortArray return GL.allocBuffer(GL.SHORT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLshortArray(arr.buffer);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 2;
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLshort
        return untyped __global__.__hxcpp_memory_get_ui16(this.buffer, this.byteOffset+i*2);
    @:arrayAccess public inline function set(i:Int, x:GLshort):GLshort {
        untyped __global__.__hxcpp_memory_set_i16(this.buffer, this.byteOffset+i*2, x);
        return get(this, i);
    }

    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLuintArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 4, GL.UNSIGNED_INT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLuintArray(raw);
    @:from public static inline function fromArr(arr:Array<GLuint>):GLuintArray return GL.buffer(arr, GL.UNSIGNED_INT);
    public static inline function alloc(count:Int):GLuintArray return GL.allocBuffer(GL.UNSIGNED_INT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLuintArray(arr.buffer);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 4;
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLuint
        return untyped __global__.__hxcpp_memory_get_i32(this.buffer, this.byteOffset+i*4);
    @:arrayAccess public inline function set(i:Int, x:GLuint):GLuint {
        untyped __global__.__hxcpp_memory_set_i32(this.buffer, this.byteOffset+i*4, x);
        return get(this, i);
    }

    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLintArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 4, GL.INT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLintArray(raw);
    @:from public static inline function fromArr(arr:Array<GLint>):GLintArray return GL.buffer(arr, GL.INT);
    public static inline function alloc(count:Int):GLintArray return GL.allocBuffer(GL.INT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLintArray(arr.buffer);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 4;
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLint
        return untyped __global__.__hxcpp_memory_get_i32(this.buffer, this.byteOffset+i*4);
    @:arrayAccess public inline function set(i:Int, x:GLint):GLint {
        untyped __global__.__hxcpp_memory_set_i32(this.buffer, this.byteOffset+i*4, x);
        return get(this, i);
    }

    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLfloatArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 4, GL.FLOAT);
    @:from public static inline function fromRaw(raw:BytesData) return new GLfloatArray(raw);
    @:from public static inline function fromArr(arr:Array<GLfloat>):GLfloatArray return GL.buffer(arr, GL.FLOAT);
    public static inline function alloc(count:Int):GLfloatArray return GL.allocBuffer(GL.FLOAT, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLfloatArray(arr.buffer);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 4;
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLfloat
        return untyped __global__.__hxcpp_memory_get_float(this.buffer, this.byteOffset+i*4);
    @:arrayAccess public inline function set<T>(i:Int, x:T):GLfloat {
        untyped __global__.__hxcpp_memory_set_float(this.buffer, this.byteOffset+i*4, x);
        return get(this, i);
    }

    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

abstract GLdoubleArray(GLArray) to GLArray {
    inline public function new(raw:BytesData) this = new GLArray(raw, 8, GL.DOUBLE);
    @:from public static inline function fromRaw(raw:BytesData) return new GLdoubleArray(raw);
    @:from public static inline function fromArr(arr:Array<GLdouble>):GLdoubleArray return GL.buffer(arr, GL.DOUBLE);
    public static inline function alloc(count:Int):GLdoubleArray return GL.allocBuffer(GL.DOUBLE, count);
    public static inline function view(arr:GLArray, byteOffset:Int, count:Int) {
        var ret = new GLdoubleArray(arr.buffer);
        arr = ret; arr.view(byteOffset, count);
        return ret;
    }

    public var size(get, never):Int;
    inline function get_size() return 8;
    public var raw(get, never):BytesData;
    inline function get_raw() return this.buffer;
    public var count(get, never):Int;
    inline function get_count() return this.count;

    @:arrayAccess public inline function get(i:Int):GLdouble
        return untyped __global__.__hxcpp_memory_get_double(this.buffer, this.byteOffset+i*8);
    @:arrayAccess public inline function set<T>(i:Int, x:T):GLdouble {
        untyped __global__.__hxcpp_memory_set_double(this.buffer, this.byteOffset+i*8, x);
        return get(this, i);
    }

    inline public function resize(count:Int) GL.load("arrbuffer_resize", 2)(this.buffer, count*this.size);
}

class GLArray {
    public var isView:Bool = false;
    public var fixedCount:Int = 0;
    public var byteOffset:GLsizeiptr = 0;

    public var size:Int; // element size
    public var type:GLenum;
    public var buffer:BytesData;
    public var count(get, never):Int;
    inline function get_count()
        return if (isView) fixedCount else Std.int(buffer.length / size);

    public function new(buffer:BytesData, size:Int, type:Int) {
        this.buffer = buffer;
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
