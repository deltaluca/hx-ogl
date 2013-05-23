package;

import Sample;
import ogl.GL;
import ogl.GLM;
import ogl.GLArray;
import sys.io.File;

class Sample6 {
    public function new() {}

    var vBuffer:GLuint;
    var uvBuffer:GLuint;
    var nBuffer:GLuint;
    var texture:GLuint;
    var program:GLuint;

    var uMVP:GLuint;
    var uMVit:GLuint;
    var uM:GLuint;
    var ulpos:GLuint;

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

        var t = 1/3; var T = 2/3;
        var q = 1/4; var h = 1/2; var m = 3/4;
        var uvData:GLfloatArray = [
            [q,t],[0,t],[q,T], [0,t],[0,T],[q,T],
            [1,t],[m,t],[1,T], [m,t],[m,T],[1,T],
            [h,t],[h,T],[m,t], [m,t],[h,T],[m,T],
            [q,T],[h,t],[q,t], [q,T],[h,T],[h,t],
            [q,t],[h,0],[q,0], [q,t],[h,t],[h,0],
            [q,1],[h,T],[q,T], [q,1],[h,1],[h,T],
        ];
        uvBuffer = GL.genBuffers(1)[0];
        GL.bindBuffer(GL.ARRAY_BUFFER, uvBuffer);
        GL.bufferData(GL.ARRAY_BUFFER, uvData, GL.STATIC_DRAW);

        var n0 = [-1,0,0]; var n1 = [0,0,-1]; var n2 = [1, 0,0];
        var n3 = [ 0,0,1]; var n4 = [0,1, 0]; var n5 = [0,-1,0];
        var nData:GLfloatArray = [
            n0,n0,n0,  n0,n0,n0,
            n1,n1,n1,  n1,n1,n1,
            n2,n2,n2,  n2,n2,n2,
            n3,n3,n3,  n3,n3,n3,
            n4,n4,n4,  n4,n4,n4,
            n5,n5,n5,  n5,n5,n5,
        ];
        nBuffer = GL.genBuffers(1)[0];
        GL.bindBuffer(GL.ARRAY_BUFFER, nBuffer);
        GL.bufferData(GL.ARRAY_BUFFER, nData, GL.STATIC_DRAW);

        var vShader = GL.createShader(GL.VERTEX_SHADER);
        var fShader = GL.createShader(GL.FRAGMENT_SHADER);
        program = GL.createProgram();

        GL.shaderSource(vShader, "
            #version 130
            in vec3 vPosition;
            in vec2 vUV;
            in vec3 vNormal;
            uniform mat4 MVP;
            uniform mat4 MVit;
            uniform mat4 M;
            out vec2 fUV;
            out vec3 fnormal;
            out vec3 fpos;
            void main() {
                vec4 v = vec4(vPosition, 1);
                gl_Position = MVP * v;
                fUV = vUV;
                fnormal = normalize((MVit * vec4(vNormal,0)).xyz);
                fpos = (M * v).xyz;
            }
        ");
        GL.shaderSource(fShader, "
            #version 130
            in vec2 fUV;
            in vec3 fnormal;
            in vec3 fpos;
            uniform vec3 lpos;
            uniform sampler2D tex;
            out vec3 colour;
            void main() {
                vec3 l = lpos - fpos;
                float dist = length(l);
                l = normalize(l);
                float cosTheta = clamp(dot(fnormal, l), 0, 1);
                colour = texture(tex, fUV).rgb * (cosTheta * 4 / (dist * dist) + 0.1);
            }
        ");

        GL.compileShader(vShader);
        GL.compileShader(fShader);

        GL.attachShader(program, vShader);
        GL.attachShader(program, fShader);

        GL.bindAttribLocation(program, 0, "vPosition");
        GL.bindAttribLocation(program, 1, "vUV");
        GL.bindAttribLocation(program, 2, "vNormal");
        GL.linkProgram(program);

        GL.deleteShader(vShader);
        GL.deleteShader(fShader);

        uMVP  = GL.getUniformLocation(program, "MVP");
        uMVit = GL.getUniformLocation(program, "MVit");
        uM    = GL.getUniformLocation(program, "M");
        ulpos = GL.getUniformLocation(program, "lpos");

        GL.enable(GL.DEPTH_TEST);

        var file = File.read("cube_texture.png", true);
        var pngData = (new format.png.Reader(file)).read();
        var textureData:GLubyteArray = format.png.Tools.extract32(pngData).getData();
        var pngHeader = format.png.Tools.getHeader(pngData);

        texture = GL.genTextures(1)[0];
        GL.bindTexture(GL.TEXTURE_2D, texture);
        GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGB, pngHeader.width, pngHeader.height, 0, GL.RGBA, textureData);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
        GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR_MIPMAP_LINEAR);
        GL.generateMipmap(GL.TEXTURE_2D);

        // reset animation.
        glfw3.GLFW.setTime(0);

        return "A Shaded Cube";
    }

    public function cleanup() {
        GL.deleteBuffers([vBuffer, uvBuffer, nBuffer]);
        GL.deleteProgram(program);
        GL.useProgram(0); // back to fixed-function
        GL.disable(GL.DEPTH_TEST);
        GL.deleteTextures([texture]);
    }

    public function render() {
        GL.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);

        GL.useProgram(program);
        GL.enableVertexAttribArray(0);
        GL.enableVertexAttribArray(1);
        GL.enableVertexAttribArray(2);

        GL.bindBuffer(GL.ARRAY_BUFFER, vBuffer);
        GL.vertexAttribPointer(0, 3, GL.FLOAT, false, 0, 0);
        GL.bindBuffer(GL.ARRAY_BUFFER, uvBuffer);
        GL.vertexAttribPointer(1, 2, GL.FLOAT, false, 0, 0);
        GL.bindBuffer(GL.ARRAY_BUFFER, nBuffer);
        GL.vertexAttribPointer(2, 3, GL.FLOAT, false, 0, 0);

        var projection = Mat4.perspective(45, 4/3, 0.1, 100);
        var view = Mat4.lookAt([4,3,3], [0,0,0], [0,1,0]);

        var t = glfw3.GLFW.getTime()/4;
        var s = Math.sin(t*3)*0.5+1;
        var model = Mat4.rotateX(t*-1)*Mat4.rotateY(t*3)*Mat4.rotateZ(t*-2)*Mat4.scale(s,s,s);

        GL.uniformMatrix4fv(uMVP, false, projection * view * model);
        GL.uniformMatrix4fv(uMVit, false, (view * model).inverse().transpose());
        GL.uniformMatrix4fv(uM, false, model);

        var s = Math.sin(t*2)*0.5+3;
        var model = Mat4.rotateX(t*2)*Mat4.rotateY(t*-1)*Mat4.rotateZ(t*3)*Mat4.scale(s,s,s);
        GL.uniform3fv(ulpos, GLfloatArray.view(model, 0, 3));

        GL.drawArrays(GL.TRIANGLES, 0, 12*3);

        GL.disableVertexAttribArray(0);
        GL.disableVertexAttribArray(1);
        GL.disableVertexAttribArray(2);
    }
}


