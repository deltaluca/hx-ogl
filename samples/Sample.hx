package;

import ogl.GL;
import ogl.GLM;
import ogl.GLArray;

import glfw3.GLFW;

typedef SampleNo = {
    public function init():String;
    public function cleanup():Void;
    public function render():Void;
}

class Sample {
    static var window:Window;

    static var samples:Array<SampleNo>;
    static var curSample:SampleNo;

    static function loadSample(id:Int) {
        if (id < 0 || id >= samples.length) return;
        if (curSample != null)
            curSample.cleanup();
        curSample = samples[id];
        var title = curSample.init();
        GLFW.setWindowTitle(window, 'Sample ${id+1}/${samples.length} : $title');
    }

    static function main() {
        GLFW.setErrorCallback(function (i,e) throw(e));
        GLFW.init();
        GLFW.windowHint(GLFW.RESIZABLE, 0);
        window = GLFW.createWindow(800, 600, "");
        GLFW.makeContextCurrent(window);
        GL.init();

        samples = [
            new Sample1(),
            new Sample2(),
            new Sample3(),
            new Sample4(),
            new Sample5(),
            new Sample6(),
        ];
        loadSample(4);

        GLFW.setKeyCallback(window, function (_, key:Int, _, state:Int, _) {
            if (state == GLFW.PRESS)
                loadSample(key - GLFW.ONE);
        });

        while (!GLFW.windowShouldClose(window)) {
            GLFW.pollEvents();
            curSample.render();
            GLFW.swapBuffers(window);
        }

        GLFW.destroyWindow(window);
        GLFW.terminate();
    }
}
