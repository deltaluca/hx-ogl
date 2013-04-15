package;

import Sample;
import ogl.GL;
import ogl.GLM;
import ogl.GLArray;

class Sample1 {
    public function new() {}

    var vBuffer:GLuint;

    public function init() {
        var vData:GLfloatArray = [
            [-1,-1,0],
            [ 1,-1,0],
            [ 0, 1,0],
        ];
        vBuffer = GL.genBuffers(1)[0];
        GL.bindBuffer(GL.ARRAY_BUFFER, vBuffer);
        GL.bufferData(GL.ARRAY_BUFFER, vData, GL.STATIC_DRAW);

        return "The First Triangle";
    }

    public function cleanup() {
        GL.deleteBuffers([vBuffer]);
    }

    public function render() {
        GL.clear(GL.COLOR_BUFFER_BIT);

        GL.enableVertexAttribArray(0);

        GL.bindBuffer(GL.ARRAY_BUFFER, vBuffer);
        GL.vertexAttribPointer(0, 3, GL.FLOAT, false, 0, 0);

        GL.drawArrays(GL.TRIANGLES, 0, 3);

        GL.disableVertexAttribArray(0);
    }
}
