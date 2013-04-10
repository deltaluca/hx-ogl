package ogl;

import #if cpp cpp #else neko #end.Lib;
import ogl.Macros;

abstract Window(NativeBinding) to NativeBinding {
    @:allow(ogl)
    function new(x:Dynamic) this = new NativeBinding(x);

    @:allow(ogl)
    public static inline function cvt(x:Dynamic):Window return new Window(x);

    @:op(A==B) public static inline function eq(a:Window, b:Window):Bool return a.nativeObject == b.nativeObject;
}

abstract Monitor(NativeBinding) to NativeBinding {
    @:allow(ogl)
    function new(x:Dynamic) this = new NativeBinding(x);

    @:allow(ogl)
    public static inline function cvt(x:Dynamic):Monitor return new Monitor(x);

    @:op(A==B) public static inline function eq(a:Monitor, b:Monitor):Bool return a.nativeObject == b.nativeObject;
}

class GLFW implements GLConsts implements GLProcs {
    @:allow(ogl)
    static inline function load(n:String, p:Int):Dynamic
        return Lib.load("ogl","hx_glfw_"+n, p);


    @:GLProc function setErrorCallback(cb:Null<Int->String->Void>):Void;

    @:GLProc function init():Void;
    @:GLProc function terminate():Void;

    @:GLProc function getMonitors():Array<Monitor> {
        var out:Array<Monitor> = [];
        load("getMonitors", 1)(out);
        return out;
    }
    @:GLProc function getPrimaryMonitor():Monitor;

    @:GLProc function makeContextCurrent(window:Window):Void;
    @:GLProc function getCurrentContext():Null<Window>;
    @:GLProc function swapBuffers(window:Window):Void;
    @:GLProc function swapInterval(interval:Int):Void;

    @:GLProc function createWindow(width:Int, height:Int, title:String, ?monitor:Null<Monitor>, ?share:Null<Window>):Window;
    @:GLProc function destroyWindow(window:Window):Void;

    @:GLConst var STEREO;
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
    @:GLConst var AUX_BUFFERS;
    @:GLConst var SAMPLES;
    @:GLConst var SRGB_CAPABLE;
    @:GLConst var OPENGL_API;
    @:GLConst var OPENGL_ES_API;
    @:GLProc function defaultWindowHints():Void;
    @:GLProc function windowHint(target:Int, hint:Int):Void;

    @:GLConst var FOCUSED;
    @:GLConst var ICONIFIED;
    @:GLConst var VISIBLE;
    @:GLConst var RESIZABLE;
    @:GLConst var DECORATED;
    @:GLConst var CLIENT_API;
    @:GLConst var CONTEXT_VERSION_MAJOR;
    @:GLConst var CONTEXT_VERSION_MINOR;
    @:GLConst var CONTEXT_REVISION;
    @:GLConst var OPENGL_FORWARD_COMPAT;
    @:GLConst var OPENGL_DEBUG_CONTEXT;
    @:GLConst var OPENGL_PROFILE;
    @:GLConst var CONTEXT_ROBUSTNESS;

    @:GLConst var OPENGL_CORE_PROFILE;
    @:GLConst var OPENGL_COMPAT_PROFILE;
    @:GLConst var OPENGL_NO_PROFILE;

    @:GLConst var LOSE_CONTEXT_ON_RESET;
    @:GLConst var NO_RESET_NOTIFICATION;
    @:GLConst var NO_ROBUSTNESS;

    @:GLProc function getWindowParam(window:Window, param:Int):Int;

    @:GLProc function getWindowPos(window:Window):{x:Int, y:Int} {
        var vals = [0,0];
        load("getWindowPos", 2)(NativeBinding.native(window), vals);
        return {x:vals[0], y:vals[1]};
    }
    @:GLProc function getWindowSize(window:Window):{width:Int, height:Int} {
        var vals = [0,0];
        load("getWindowSize", 2)(NativeBinding.native(window), vals);
        return {width:vals[0], height:vals[1]};
    }
    @:GLProc function setWindowPos(window:Window, x:Int, y:Int):Void;
    @:GLProc function setWindowSize(window:Window, width:Int, height:Int):Void;
    @:GLProc function setWindowTitle(window:Window, title:String):Void;

    @:GLProc function hideWindow(window:Window):Void;
    @:GLProc function showWindow(window:Window):Void;
    @:GLProc function iconifyWindow(window:Window):Void;
    @:GLProc function restoreWindow(window:Window):Void;

    @:GLProc function windowShouldClose(window:Window):Bool;
    @:GLProc function setWindowShouldClose(window:Window, value:Bool):Void;

    @:GLProc function pollEvents():Void;
    @:GLProc function waitEvents():Void;

    static inline function wrap0(w:Window, cb:Null<Window->Void>):Null<Void->Void>
        return if (cb == null) null else function () cb(w);
    static inline function wrap1<A>(w:Window, cb:Null<Window->A->Void>):Null<A->Void>
        return if (cb == null) null else function (a:A) cb(w, a);
    static inline function wrap2<A,B>(w:Window, cb:Null<Window->A->B->Void>):Null<A->B->Void>
        return if (cb == null) null else function (a:A, b:B) cb(w, a, b);

    @:GLProc function setWindowPosCallback(window:Window, cb:Null<Window->Int->Int->Void>):Void
        load("setWindowPosCallback", 2)(NativeBinding.native(window), wrap2(window, cb));
    @:GLProc function setWindowSizeCallback(window:Window, cb:Null<Window->Int->Int->Void>):Void
        load("setWindowSizeCallback", 2)(NativeBinding.native(window), wrap2(window, cb));
    @:GLProc function setWindowRefreshCallback(window:Window, cb:Null<Window->Void>):Void
        load("setWindowRefreshCallback", 2)(NativeBinding.native(window), wrap0(window, cb));
    @:GLProc function setWindowCloseCallback(window:Window, cb:Null<Window->Void>):Void
        load("setWindowCloseCallback", 2)(NativeBinding.native(window), wrap0(window, cb));
    @:GLProc function setWindowFocusCallback(window:Window, cb:Null<Window->Bool->Void>):Void
        load("setWindowFocusCallback", 2)(NativeBinding.native(window), wrap1(window, cb));
    @:GLProc function setWindowIconifyCallback(window:Window, cb:Null<Window->Bool->Void>):Void
        load("setWindowIconifyCallback", 2)(NativeBinding.native(window), wrap1(window, cb));


    // change in API, return true if GL_PRESS for key.
    @:GLProc function getKey(window:Window, key:Int):Bool;
    @:GLProc function getMouseButton(window:Window, button:Int):Bool;
    @:GLProc function getCursorPos(window:Window):{x:Float, y:Float} {
        var vals = [0.0,0.0];
        load("getCursorPos", 2)(NativeBinding.native(window), vals);
        return {x:vals[0], y:vals[1]};
    }
    @:GLProc function setCursorPos(window:Window, x:Float, y:Float):Void;

    @:GLProc function setKeyCallback(window:Window, cb:Null<Window->Int->Int->Void>):Void
        load("setKeyCallback", 2)(NativeBinding.native(window), wrap2(window, cb));
    @:GLProc function setCharCallback(window:Window, cb:Null<Window->Int->Void>):Void
        load("setCharCallback", 2)(NativeBinding.native(window), wrap1(window, cb));
    @:GLProc function setMouseButtonCallback(window:Window, cb:Null<Window->Int->Bool->Void>):Void
        load("setMouseButtonCallback", 2)(NativeBinding.native(window), wrap2(window, cb));
    @:GLProc function setScrollCallback(window:Window, cb:Null<Window->Float->Float->Void>):Void
        load("setScrollCallback", 2)(NativeBinding.native(window), wrap2(window, cb));
    @:GLProc function setCursorPosCallback(window:Window, cb:Null<Window->Float->Float->Void>):Void
        load("setCursorPosCallback", 2)(NativeBinding.native(window), wrap2(window, cb));
    @:GLProc function setCursorEnterCallback(window:Window, cb:Null<Window->Bool->Void>):Void
        load("setCursorEnterCallback", 2)(NativeBinding.native(window), wrap1(window, cb));

    @:GLProc function getTime():Float;
    @:GLProc function setTime(time:Float):Void;

    @:GLConst var RELEASE;
    @:GLConst var PRESS;
    @:GLConst var REPEAT;

    @:GLConst var KEY_SPACE;
    @:GLConst var KEY_APOSTROPHE;
    @:GLConst var KEY_COMMA;
    @:GLConst var KEY_MINUS;
    @:GLConst var KEY_PERIOD;
    @:GLConst var KEY_SLASH;
    @:GLConst var KEY_0;
    @:GLConst var KEY_1;
    @:GLConst var KEY_2;
    @:GLConst var KEY_3;
    @:GLConst var KEY_4;
    @:GLConst var KEY_5;
    @:GLConst var KEY_6;
    @:GLConst var KEY_7;
    @:GLConst var KEY_8;
    @:GLConst var KEY_9;
    @:GLConst var KEY_SEMICOLON;
    @:GLConst var KEY_EQUAL;
    @:GLConst var KEY_A;
    @:GLConst var KEY_B;
    @:GLConst var KEY_C;
    @:GLConst var KEY_D;
    @:GLConst var KEY_E;
    @:GLConst var KEY_F;
    @:GLConst var KEY_G;
    @:GLConst var KEY_H;
    @:GLConst var KEY_I;
    @:GLConst var KEY_J;
    @:GLConst var KEY_K;
    @:GLConst var KEY_L;
    @:GLConst var KEY_M;
    @:GLConst var KEY_N;
    @:GLConst var KEY_O;
    @:GLConst var KEY_P;
    @:GLConst var KEY_Q;
    @:GLConst var KEY_R;
    @:GLConst var KEY_S;
    @:GLConst var KEY_T;
    @:GLConst var KEY_U;
    @:GLConst var KEY_V;
    @:GLConst var KEY_W;
    @:GLConst var KEY_X;
    @:GLConst var KEY_Y;
    @:GLConst var KEY_Z;
    @:GLConst var KEY_LEFT_BRACKET;
    @:GLConst var KEY_BACKSLASH;
    @:GLConst var KEY_RIGHT_BRACKET;
    @:GLConst var KEY_GRAVE_ACCENT;
    @:GLConst var KEY_WORLD_1;
    @:GLConst var KEY_WORLD_2;
    @:GLConst var KEY_ESCAPE;
    @:GLConst var KEY_ENTER;
    @:GLConst var KEY_TAB;
    @:GLConst var KEY_BACKSPACE;
    @:GLConst var KEY_INSERT;
    @:GLConst var KEY_DELETE;
    @:GLConst var KEY_RIGHT;
    @:GLConst var KEY_LEFT;
    @:GLConst var KEY_DOWN;
    @:GLConst var KEY_UP;
    @:GLConst var KEY_PAGE_UP;
    @:GLConst var KEY_PAGE_DOWN;
    @:GLConst var KEY_HOME;
    @:GLConst var KEY_END;
    @:GLConst var KEY_CAPS_LOCK;
    @:GLConst var KEY_SCROLL_LOCK;
    @:GLConst var KEY_NUM_LOCK;
    @:GLConst var KEY_PRINT_SCREEN;
    @:GLConst var KEY_PAUSE;
    @:GLConst var KEY_F1;
    @:GLConst var KEY_F2;
    @:GLConst var KEY_F3;
    @:GLConst var KEY_F4;
    @:GLConst var KEY_F5;
    @:GLConst var KEY_F6;
    @:GLConst var KEY_F7;
    @:GLConst var KEY_F8;
    @:GLConst var KEY_F9;
    @:GLConst var KEY_F10;
    @:GLConst var KEY_F11;
    @:GLConst var KEY_F12;
    @:GLConst var KEY_F13;
    @:GLConst var KEY_F14;
    @:GLConst var KEY_F15;
    @:GLConst var KEY_F16;
    @:GLConst var KEY_F17;
    @:GLConst var KEY_F18;
    @:GLConst var KEY_F19;
    @:GLConst var KEY_F20;
    @:GLConst var KEY_F21;
    @:GLConst var KEY_F22;
    @:GLConst var KEY_F23;
    @:GLConst var KEY_F24;
    @:GLConst var KEY_F25;
    @:GLConst var KEY_KP_0;
    @:GLConst var KEY_KP_1;
    @:GLConst var KEY_KP_2;
    @:GLConst var KEY_KP_3;
    @:GLConst var KEY_KP_4;
    @:GLConst var KEY_KP_5;
    @:GLConst var KEY_KP_6;
    @:GLConst var KEY_KP_7;
    @:GLConst var KEY_KP_8;
    @:GLConst var KEY_KP_9;
    @:GLConst var KEY_KP_DECIMAL;
    @:GLConst var KEY_KP_DIVIDE;
    @:GLConst var KEY_KP_MULTIPLY;
    @:GLConst var KEY_KP_SUBTRACT;
    @:GLConst var KEY_KP_ADD;
    @:GLConst var KEY_KP_ENTER;
    @:GLConst var KEY_KP_EQUAL;
    @:GLConst var KEY_LEFT_SHIFT;
    @:GLConst var KEY_LEFT_CONTROL;
    @:GLConst var KEY_LEFT_ALT;
    @:GLConst var KEY_LEFT_SUPER;
    @:GLConst var KEY_RIGHT_SHIFT;
    @:GLConst var KEY_RIGHT_CONTROL;
    @:GLConst var KEY_RIGHT_ALT;
    @:GLConst var KEY_RIGHT_SUPER;
    @:GLConst var KEY_MENU;
    @:GLConst var KEY_LAST;

    @:GLConst var MOUSE_BUTTON_1;
    @:GLConst var MOUSE_BUTTON_2;
    @:GLConst var MOUSE_BUTTON_3;
    @:GLConst var MOUSE_BUTTON_4;
    @:GLConst var MOUSE_BUTTON_5;
    @:GLConst var MOUSE_BUTTON_6;
    @:GLConst var MOUSE_BUTTON_7;
    @:GLConst var MOUSE_BUTTON_8;
    @:GLConst var MOUSE_BUTTON_LAST;
    @:GLConst var MOUSE_BUTTON_LEFT;
    @:GLConst var MOUSE_BUTTON_RIGHT;
    @:GLConst var MOUSE_BUTTON_MIDDLE;
}
