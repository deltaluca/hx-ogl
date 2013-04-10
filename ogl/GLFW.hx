package ogl;

import #if cpp cpp #else neko #end.Lib;
import ogl.Macros;

class GLFW implements GLConsts implements GLProcs {
    @:allow(ogl)
    static inline function load(n:String, p:Int):Dynamic
        return Lib.load("ogl","hx_glfw_"+n, p);


    @:GLProc function init():Void;
    @:GLProc function terminate():Void;


    @:GLConst var WINDOW;
    @:GLConst var FULLSCREEN;

    @:GLConst var OPENED;
    @:GLConst var ACTIVE;
    @:GLConst var ICONIFIED;
    @:GLConst var ACCELERATED;
    @:GLConst var RED_BITS;
    @:GLConst var GREEN_BITS;
    @:GLConst var BLUE_BITS;
    @:GLConst var ALPHA_BITS;
    @:GLConst var DEPTH_BITS;
    @:GLConst var STENCIL_BITS;

    @:GLConst var REFRESH_RATE;
    @:GLConst var ACCUM_RED_BITS;
    @:GLConst var ACCUM_GREEN_BITS;
    @:GLConst var ACCUM_BLUE_BITS;
    @:GLConst var ACCUM_ALPHA_BITS;
    @:GLConst var AUX_BUFFERS;
    @:GLConst var STEREO;
    @:GLConst var WINDOW_NO_RESIZE;
    @:GLConst var FSAA_SAMPLES;
    @:GLConst var OPENGL_VERSION_MAJOR;
    @:GLConst var OPENGL_VERSION_MINOR;
    @:GLConst var OPENGL_FORWARD_COMPAT;
    @:GLConst var OPENGL_DEBUG_CONTEXT;
    @:GLConst var OPENGL_PROFILE;

    @:GLConst var OPENGL_COMPAT_PROFILE;
    @:GLConst var OPENGL_CORE_PROFILE;

    @:GLProc function openWindow(width:Int, height:Int, red:Int, green:Int, blue:Int, alpha:Int, depth:Int, stencil:Int, mode:Int):Bool;
    @:GLProc function openWindowHint(target:Int, value:Int):Void;
    @:GLProc function closeWindow():Void;
    @:GLProc function setWindowCloseCallback(cb:Null<Void->Bool>):Void;
    @:GLProc function getWindowParam(param:Int):Int;
    @:GLProc function setWindowTitle(title:String):Void;
    @:GLProc function setWindowSize(width:Int, height:Int):Void;
    @:GLProc function setWindowPos(x:Int, y:Int):Void;
    @:GLProc function getWindowSize():{width:Int, height:Int} {
        var vals = [0,0];
        load("getWindowSize", 1)(vals);
        return {width:vals[0], height:vals[1]};
    }
    @:GLProc function setWindowSizeCallback(cb:Null<Int->Int->Void>):Void;
    @:GLProc function iconifyWindow():Void;
    @:GLProc function restoreWindow():Void;
    @:GLProc function swapInterval(interval:Int):Void;
    @:GLProc function setWindowRefreshCallback(cb:Null<Void->Void>):Void;


    @:GLProc function swapBuffers():Void;
    @:GLProc function pollEvents():Void;


    @:GLConst var KEY_UNKNOWN;
    @:GLConst var KEY_SPACE;
    @:GLConst var KEY_SPECIAL;
    @:GLConst var KEY_ESC;
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
    @:GLConst var KEY_UP;
    @:GLConst var KEY_DOWN;
    @:GLConst var KEY_LEFT;
    @:GLConst var KEY_RIGHT;
    @:GLConst var KEY_LSHIFT;
    @:GLConst var KEY_RSHIFT;
    @:GLConst var KEY_LCTRL;
    @:GLConst var KEY_RCTRL;
    @:GLConst var KEY_LALT;
    @:GLConst var KEY_RALT;
    @:GLConst var KEY_TAB;
    @:GLConst var KEY_ENTER;
    @:GLConst var KEY_BACKSPACE;
    @:GLConst var KEY_INSERT;
    @:GLConst var KEY_DEL;
    @:GLConst var KEY_PAGEUP;
    @:GLConst var KEY_PAGEDOWN;
    @:GLConst var KEY_HOME;
    @:GLConst var KEY_END;
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
    @:GLConst var KEY_KP_DIVIDE;
    @:GLConst var KEY_KP_MULTIPLY;
    @:GLConst var KEY_KP_SUBTRACT;
    @:GLConst var KEY_KP_ADD;
    @:GLConst var KEY_KP_DECIMAL;
    @:GLConst var KEY_KP_EQUAL;
    @:GLConst var KEY_KP_ENTER;
    @:GLConst var KEY_KP_NUM_LOCK;
    @:GLConst var KEY_CAPS_LOCK;
    @:GLConst var KEY_SCROLL_LOCK;
    @:GLConst var KEY_PAUSE;
    @:GLConst var KEY_LSUPER;
    @:GLConst var KEY_RSUPER;
    @:GLConst var KEY_MENU;
    @:GLConst var KEY_LAST;
    // Addition to API
    @:GLProc function KEY(char:String):Int {
        return char.toUpperCase().charCodeAt(0);
    }

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

    // Slight API change, return 'true' if pressed
    @:GLProc function getKey(key:Int):Bool;
    @:GLProc function getMouseButton(button:Int):Bool;
    @:GLProc function getMousePos():{x:Int, y:Int} {
        var vals = [0,0];
        load("getMousePos", 1)(vals);
        return {x:vals[0], y:vals[1]};
    }
    @:GLProc function setMousePos(x:Int, y:Int):Void;
    @:GLProc function getMouseWheel():Int;
    @:GLProc function setMouseWheel(pos:Int):Void;
    @:GLProc function setKeyCallback(cb:Null<Int->Bool->Void>):Void;
    @:GLProc function setCharCallback(cb:Null<Int->Bool->Void>):Void;
    @:GLProc function setMouseButtonCallback(cb:Null<Int->Bool->Void>):Void;
    @:GLProc function setMousePosCallback(cb:Null<Int->Int->Void>):Void;
    @:GLProc function setMouseWheelCallback(cb:Null<Int->Void>):Void;


    @:GLProc function getTime():Float;
    @:GLProc function setTime(time:Float):Void;
    @:GLProc function sleep(time:Float):Void;

}
