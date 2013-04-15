package;

import Sample;
import ogl.GL;
import ogl.GLM;
import ogl.GLArray;

class Sample3 {
    public function new() {}

    var vBuffer:GLuint;
    var program:GLuint;
    var uMatrix:GLuint;

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
            #version 330 core
            layout (location=0) in vec3 vPosition;
            uniform mat4 MVP;
            void main() {
                vec4 v = vec4(vPosition, 1);
                gl_Position = MVP * v;
            }
        ");
        GL.shaderSource(fShader, "
            #version 330 core
            out vec3 colour;
            void main() {
                colour = vec3(1,0,0);
            }
        ");

        GL.compileShader(vShader);
        GL.compileShader(fShader);

        GL.attachShader(program, vShader);
        GL.attachShader(program, fShader);
        GL.linkProgram(program);

        GL.deleteShader(vShader);
        GL.deleteShader(fShader);

        uMatrix = GL.getUniformLocation(program, "MVP");

        return "The First Triangle, Transformed by Matrices";
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

        var projection = Mat4.perspective(45, 4/3, 0.1, 100);
        var view = Mat4.lookAt([4,3,3], [0,0,0], [0,1,0]);
        var model = Mat4.identity();
        var MVP = projection * view * model;
        GL.uniformMatrix4fv(uMatrix, false, MVP);

        GL.drawArrays(GL.TRIANGLES, 0, 3);

        GL.disableVertexAttribArray(0);
    }
}

