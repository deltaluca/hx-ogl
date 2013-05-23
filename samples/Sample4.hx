package;

import Sample;
import ogl.GL;
import ogl.GLM;
import ogl.GLArray;

class Sample4 {
    public function new() {}

    var vBuffer:GLuint;
    var cBuffer:GLuint;
    var program:GLuint;
    var uMatrix:GLuint;

    public function init() {
        var vData:GLfloatArray = [
            [-1, 1, 1],[-1, 1,-1],[-1,-1, 1],   [-1, 1,-1],[-1,-1,-1],[-1,-1, 1],
            [-1, 1,-1],[ 1, 1,-1],[-1,-1,-1],   [ 1, 1,-1],[ 1,-1,-1],[-1,-1,-1],
            [ 1, 1, 1],[ 1,-1, 1],[ 1, 1,-1],   [ 1, 1,-1],[ 1,-1, 1],[ 1,-1,-1],
            [-1,-1, 1],[ 1, 1, 1],[-1, 1, 1],   [-1,-1, 1],[ 1,-1, 1],[ 1, 1, 1],
            [-1, 1, 1],[ 1, 1,-1],[-1, 1,-1],   [-1, 1, 1],[ 1, 1, 1],[ 1, 1,-1],
            [-1,-1,-1],[ 1,-1, 1],[-1,-1, 1],   [-1,-1,-1],[ 1,-1,-1],[ 1,-1, 1],
        ];
        vBuffer = GL.genBuffers(1)[0];
        GL.bindBuffer(GL.ARRAY_BUFFER, vBuffer);
        GL.bufferData(GL.ARRAY_BUFFER, vData, GL.STATIC_DRAW);

        var cData:GLfloatArray = [
            [0.583, 0.771, 0.014],
            [0.609, 0.115, 0.436],
            [0.327, 0.483, 0.844],
            [0.822, 0.569, 0.201],
            [0.435, 0.602, 0.223],
            [0.310, 0.747, 0.185],
            [0.597, 0.770, 0.761],
            [0.559, 0.436, 0.730],
            [0.359, 0.583, 0.152],
            [0.483, 0.596, 0.789],
            [0.559, 0.861, 0.639],
            [0.195, 0.548, 0.859],
            [0.014, 0.184, 0.576],
            [0.771, 0.328, 0.970],
            [0.406, 0.615, 0.116],
            [0.676, 0.977, 0.133],
            [0.971, 0.572, 0.833],
            [0.140, 0.616, 0.489],
            [0.997, 0.513, 0.064],
            [0.945, 0.719, 0.592],
            [0.543, 0.021, 0.978],
            [0.279, 0.317, 0.505],
            [0.167, 0.620, 0.077],
            [0.347, 0.857, 0.137],
            [0.055, 0.953, 0.042],
            [0.714, 0.505, 0.345],
            [0.783, 0.290, 0.734],
            [0.722, 0.645, 0.174],
            [0.302, 0.455, 0.848],
            [0.225, 0.587, 0.040],
            [0.517, 0.713, 0.338],
            [0.053, 0.959, 0.120],
            [0.393, 0.621, 0.362],
            [0.673, 0.211, 0.457],
            [0.820, 0.883, 0.371],
            [0.982, 0.099, 0.879],
        ];
        cBuffer = GL.genBuffers(1)[0];
        GL.bindBuffer(GL.ARRAY_BUFFER, cBuffer);
        GL.bufferData(GL.ARRAY_BUFFER, cData, GL.STATIC_DRAW);

        var vShader = GL.createShader(GL.VERTEX_SHADER);
        var fShader = GL.createShader(GL.FRAGMENT_SHADER);
        program = GL.createProgram();

        GL.shaderSource(vShader, "
            #version 130
            in vec3 vPosition;
            in vec3 vColour;
            uniform mat4 MVP;
            out vec3 fColour;
            void main() {
                vec4 v = vec4(vPosition, 1);
                gl_Position = MVP * v;
                fColour = vColour;
            }
        ");
        GL.shaderSource(fShader, "
            #version 130
            in vec3 fColour;
            out vec3 colour;
            void main() {
                colour = fColour;
            }
        ");

        GL.compileShader(vShader);
        GL.compileShader(fShader);

        GL.attachShader(program, vShader);
        GL.attachShader(program, fShader);

        GL.bindAttribLocation(program, 0, "vPosition");
        GL.bindAttribLocation(program, 1, "vColour");
        GL.linkProgram(program);

        GL.deleteShader(vShader);
        GL.deleteShader(fShader);

        uMatrix = GL.getUniformLocation(program, "MVP");

        GL.enable(GL.DEPTH_TEST);

        // reset animation.
        glfw3.GLFW.setTime(0);

        return "A Coloured Cube";
    }

    public function cleanup() {
        GL.deleteBuffers([vBuffer, cBuffer]);
        GL.deleteProgram(program);
        GL.useProgram(0); // back to fixed-function
        GL.disable(GL.DEPTH_TEST);
    }

    public function render() {
        GL.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);

        GL.useProgram(program);
        GL.enableVertexAttribArray(0);
        GL.enableVertexAttribArray(1);

        GL.bindBuffer(GL.ARRAY_BUFFER, vBuffer);
        GL.vertexAttribPointer(0, 3, GL.FLOAT, false, 0, 0);
        GL.bindBuffer(GL.ARRAY_BUFFER, cBuffer);
        GL.vertexAttribPointer(1, 3, GL.FLOAT, false, 0, 0);

        var projection = Mat4.perspective(45, 4/3, 0.1, 100);
        var view = Mat4.lookAt([4,3,3], [0,0,0], [0,1,0]);
        var t = glfw3.GLFW.getTime()/4;
        var model = Mat4.rotateX(t*-3)*Mat4.rotateY(t*1)*Mat4.rotateZ(t*2);
        var MVP = projection * view * model;
        GL.uniformMatrix4fv(uMatrix, false, MVP);

        GL.drawArrays(GL.TRIANGLES, 0, 12*3);

        GL.disableVertexAttribArray(0);
        GL.disableVertexAttribArray(1);
    }
}
