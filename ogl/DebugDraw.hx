package ogl;

import ogl.GLM;
import ogl.GL;
import ogl.GLArray;

class DebugDraw {

    static inline var VERTEX_SIZE = 7; // xyz rgba

    var lineMode:Bool = true; // true when drawing lines, false when drawing triangles.
    var vertexData:GLfloatArray;
    var numVertices:Int = 0;

    var vertexArray:GLuint;
    var vertexBuffer:GLuint;
    var program:GLuint;
    var projUniform:GLuint;

    public function new(textured=false) {
        vertexData = GL.allocBuffer(GL.FLOAT, VERTEX_SIZE*6); // 6 = lcf(line=2 verts, tri=3 verts)
        vertexArray = GL.genVertexArrays(1)[0];
        GL.bindVertexArray(vertexArray);

        vertexBuffer = GL.genBuffers(1)[0];
        GL.bindBuffer(GL.ARRAY_BUFFER, vertexBuffer);
        GL.bufferData(GL.ARRAY_BUFFER, vertexData, GL.STREAM_DRAW);

        var vertexShader = GL.createShader(GL.VERTEX_SHADER);
        var fragmentShader = GL.createShader(GL.FRAGMENT_SHADER);
        if (textured) {
            GL.shaderSource(vertexShader, "
                #version 130
                in vec3 vPos;
                in vec4 vColour;
                uniform mat4 proj;
                out vec4 uv_a;
                void main() {
                    gl_Position = proj * vec4(vPos, 1);
                    uv_a = vColour;
                }
            ");
            GL.shaderSource(fragmentShader, "
                #version 130
                in vec4 uv_a;
                out vec4 outColour;
                uniform sampler2D tex;
                void main() {
                    outColour = vec4(texture(tex, uv_a.xy).rgb,uv_a.a);
                }
            ");
        }
        else {
            GL.shaderSource(vertexShader, "
                #version 130
                in vec3 vPos;
                in vec4 vColour;
                uniform mat4 proj;
                out vec4 colour;
                void main() {
                    gl_Position = proj * vec4(vPos, 1);
                    colour = vColour;
                }
            ");
            GL.shaderSource(fragmentShader, "
                #version 130
                in vec4 colour;
                out vec4 outColour;
                void main() {
                    outColour = colour;
                }
            ");
        }
        GL.compileShader(vertexShader);
        GL.compileShader(fragmentShader);

        program = GL.createProgram();
        GL.attachShader(program, vertexShader);
        GL.attachShader(program, fragmentShader);
        GL.bindAttribLocation(program, 0, "vPos");
        GL.bindAttribLocation(program, 1, "vColour");
        GL.linkProgram(program);

        GL.deleteShader(vertexShader);
        GL.deleteShader(fragmentShader);

        projUniform = GL.getUniformLocation(program, "proj");
    }

    public function destroy() {
        GL.deleteProgram(program);
        GL.deleteVertexArrays([vertexArray]);
        GL.deleteBuffers([vertexBuffer]);
    }

    inline function vertex(vindex:Int, off:Int, p:Vec3, c:Vec4, dup=false) {
        vindex += off*VERTEX_SIZE;
        vertexData.subDataVec(p, vindex);
        vertexData.subDataVec(c, vindex+3);
        if (dup) {
            vertexData.subDataVec(p, vindex+VERTEX_SIZE);
            vertexData.subDataVec(c, vindex+VERTEX_SIZE+3);
        }
    }

    public inline function swapLines() {
        if (!lineMode) flush();
        lineMode = true;
    }
    public inline function swapFills() {
        if (lineMode) flush();
        lineMode = false;
    }

    public inline function pushVertex(p:Vec3, c:Vec4) {
        var vindex = reserve(1);
        vertex(vindex, 0, p, c);
    }
    public inline function pushData(xs:Array<Float>) {
        var vindex = reserve(Std.int(xs.length/VERTEX_SIZE));
        vertexData.subData(xs, vindex);
    }

    public inline function drawLine(p0:Vec3, p1:Vec3, c:Vec4) {
        swapLines();
        pushData([p0.x,p0.y,p0.z, c.r,c.g,c.b,c.a,
                  p1.x,p1.y,p1.z, c.r,c.g,c.b,c.a]);
    }

    public function drawDashedLine(p0:Vec3, p1:Vec3, c:Vec4, solidLength:Float, gapLength:Float) {
        var dt = Vec3.distance(p0, p1);
        var del = Vec3.normalise(p1 - p0);
        var d = 0.0;
        var p = p0;
        while (d < dt) {
            var dp = d + solidLength;
            if (dp > dt) dp = dt;
            drawLine(p0 + del*d, p0 + del*dp, c);
            d = dp;
            if (d >= dt) break;
            var dp = d + gapLength;
            if (dp > dt) dp = dt;
            d = dp;
            if (d >= dt) break;
        }
    }

    inline function reserve(numVerts:Int) {
        var current = numVertices * VERTEX_SIZE;
        var newsize = current + (numVerts * VERTEX_SIZE);
        if (newsize > vertexData.count) {
            var size = vertexData.count;
            do size *= 2 while (size < newsize);
            vertexData.resize(size);
            GL.bindBuffer(GL.ARRAY_BUFFER, vertexBuffer);
            GL.bufferData(GL.ARRAY_BUFFER, vertexData, GL.STREAM_DRAW);
        }
        numVertices += numVerts;
        return current;
    }

    public function clear() {
        numVertices = 0;
        return this;
    }

    public function begin(texture:GLuint=-1) {
        GL.useProgram(program);
        GL.enableVertexAttribArray(0);
        GL.enableVertexAttribArray(1);
        if (texture != -1) GL.bindTexture(GL.TEXTURE_2D, texture);

        GL.bindBuffer(GL.ARRAY_BUFFER, vertexBuffer);
        GL.vertexAttribPointer(0, 3, GL.FLOAT, false, VERTEX_SIZE*4, 0);
        GL.vertexAttribPointer(1, 4, GL.FLOAT, false, VERTEX_SIZE*4, 3*4);
        return this;
    }

    public function setTransform(mat:Mat4,dontClear=false) {
        flush(dontClear);
        GL.uniformMatrix4fv(projUniform, false, mat);
        return this;
    }

    public function flush(dontClear=false) {
        if (numVertices == 0) return this;

        GL.bufferSubData(GL.ARRAY_BUFFER, 0, GLfloatArray.view(vertexData, 0, numVertices*VERTEX_SIZE));
        GL.drawArrays(lineMode ? GL.LINES : GL.TRIANGLES, 0, numVertices);

        if (!dontClear)
            clear();
        return this;
    }

    public function end(dontClear=false) {
        flush(dontClear);
        GL.disableVertexAttribArray(0);
        GL.disableVertexAttribArray(1);
        return this;
    }
}
