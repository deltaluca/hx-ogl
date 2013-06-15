package;

import Sample;
import ogl.GL;
import ogl.GLM;
import ogl.GLArray;

class Sample2 {
    public function new() {}

    var vBuffer:GLuint;
    var program:GLuint;

    public function init() {
        var vData:GLfloatArray = [
            [-1,-1,0],
            [ 1,-1,0],
            [ 0, 1,0],
        ];
        vBuffer = GL.genBuffers(1)[0];
        GL.bindBuffer(GL.ARRAY_BUFFER, vBuffer);
        GL.bufferData(GL.ARRAY_BUFFER, vData, GL.STATIC_DRAW);

        var vShader = GL.createShader(GL.VERTEX_SHADER);
        var fShader = GL.createShader(GL.FRAGMENT_SHADER);
        program = GL.createProgram();

        GL.shaderSource(vShader, "
            #version 130
            in vec3 vPosition;
            void main() {
                gl_Position.xyz = vPosition;
                gl_Position.w = 1;
            }
        ");
        GL.shaderSource(fShader, "
            #version 130
            out vec3 colour;
            void main() {
                colour = vec3(1,0,0);
            }
        ");

        GL.compileShader(vShader);
        GL.compileShader(fShader);

        GL.attachShader(program, vShader);
        GL.attachShader(program, fShader);

        GL.bindAttribLocation(program, 0, "vPosition");
        GL.linkProgram(program);

        GL.deleteShader(vShader);
        GL.deleteShader(fShader);

        return "The First Triangle, Coloured with Shaders";
    }

    public function cleanup() {
        GL.deleteBuffers([vBuffer]);
        GL.deleteProgram(program);
        GL.useProgram(0); // back to fixed-function
    }

    public function render() {
        GL.clear(GL.COLOR_BUFFER_BIT);

        GL.useProgram(program);
        GL.enableVertexAttribArray(0);

        GL.bindBuffer(GL.ARRAY_BUFFER, vBuffer);
        GL.vertexAttribPointer(0, 3, GL.FLOAT, false, 0, 0);

        GL.drawArrays(GL.TRIANGLES, 0, 3);

        GL.disableVertexAttribArray(0);
    }
}
