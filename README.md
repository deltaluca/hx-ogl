Haxe-c++ bindings for OpenGL 3.3+

This is incredibly early alpha I suppose, I am not at this time intending myself to fully
support the entirety of the API, and the API that is supported will not have been
thoroughly tested if at all.

Anyone wishing to use OpenGL 3,x in hxcpp/neko should consider testing and submitting pull requests :)

#### Table of Contents
- [API Changes to OpenGL](#API Changes to OpenGL) 
- [GLArray](#GLArray) WebGL style typed arrays for GL data.
- [GLM](#GLM) Vector/Matrix types emulating subset of GLSL types (As per GLM library)
- [DebugDraw](#DebugDraw) Utility for line/triangle drawing for debug purposes.

<a name="API Changes to OpenGL"/>
#### API Changes to OpenGL.

Major change, is that unless -D ogl-dont-check-errors is set, every GL call will call glGetError to look for errors
and if found, will be thrown in Haxe. This is also true of things like glCompileShader, glLinkProgram which will check
for success and throw with the error message given otherwise.

Most of the API is unchanged, the most common change is replacing instances of an 'out' pointer argument with a return value.

eg:
```
    // C
    GLuint textures[10];
    GLint data;
    glGenTextures(10, textures);
    glGetBufferParameteriv(target, value, &data);

    // Haxe
    var textures = GL.genTextures(10);
    var data = GL.getBufferParameteriv(target, value);
```

Most other changes regard uses of GLvoid* data buffers and arrays of GLbyte/GLshort/GLfloat, these are replaced by uses of GLArray in hx-ogl which roughly mimics WebGL TypedArrays

```
    // C
    // GLvoid* data
    // size/offset in bytes
    glBufferData(target, size, data, usage);
    glBufferSubData(target, offset, size, data);
    glTexImage1D(target, level, internalFormat, width, border, format, type, data);
    
    // Haxe
    // data : GLArray
    // size is determined by the array, and offset is in 'element' counts.
    // i.e. if data type is GL_FLOAT, then a Haxe offset of 1xGL_FLOAT is a C offset of 4 bytes
    GL.bufferData(target, data, usage);
    GL.bufferSubData(target, offset, data);
    // GL data type is given by the array
    GL.texImage1D(target, level, internalFormat, width, border, format, data);
```

<a name="GLArray"/>
#### GLArray

GLArray is the underlying type of the (abstract) typed arrays:
* GLubyteArray
* GLbyteArray
* GLushortArray
* GLshortArray
* GLuintArray -- normally, functions will work with Array<GLuint> instead
* GLintArray -- normally, functions will work with Array<GLint> instead
* GLfloatArray
* GLdoubleArray -- normally, functions will work with Array<GLdouble> instead

All of these share the same interface:
```
    // produce typed array using given data as storage
    function new(raw:haxe.io.BytesData) 
    
    // for implict casting of BytesData to a typed array
    @:from static function fromRaw(raw:BytesData):GL#Array
    
    // for implict casting of an Array of values to typed array
    // Supports nested arrays that will be flattened so that
    // [[1,2],[3,4,5],6,7] is treat equally to [1,2,3,4,5,6,7]
    // similar to GLSL vector constructors.
    @:from static function fromArr(arr:Array<Dynamic>):GL#Array 
    
    // create typed array with space for 'count' elements
    static function alloc(count:Int):GL#Array 
    
    // create a view onto an existing array
    // starting at 'byteOffset' in the BytesData
    // looking at 'count' elements
    static function view(arr:GLArray, byteOffset:Int, count:Int):GL#Array
    
    // size of a data element in this array
    public var size(get,never):Int;
    
    // access to raw BytesData associated with typed array
    // a view on a particular array will have the same raw value as the original
    public var raw(get,never):BytesData;
    
    // number of elements viewed by array
    public var count(get,never):BytesData
    
    // access element at index 'i'
    // set element at index 'i'
    @:arrayAccess public function get(i:Int):# ;
    @:arrayAccess public function set(i:Int, val:#):#;
    
    // resize the raw data storage for this array
    // this can be called on views, and resizes the underlying data store.
    // data will be copied.
    public function resize(count:Int):Void;
```

Example:
```
   var vertex_data:GLfloatArray = [
      [-1,1,1],[-1,1,1-1],[-1,-1,1],
      [-1,1,-1],[1,1,-1],[-1,-1,-1]
   ];
   var vertex_buffer = GL.genBuffers(1)[0];
   GL.bindBuffer(GL.ARRAY_BUFFER, vertex_buffer);
   GL.bufferData(GL.ARRAY_BUFFER, vertex_data, GL.DYNAMIC_DRAW);
   
   // update first 3 vertices from vertex_data
   GL.bufferSubData(GL.ARRAY_BUFFER, 0, GLfloatArray.view(vertex_data, 0, 3));
   // update second 3 vertices from vertex_data
   GL.bufferSubData(GL.ARRAY_BUFFER, 3, GLfloatArray.view(vertex_data, 3*vertex_data.size, 3));
```

<a name="GLM"/>
#### GLM

Inspired by the GLM library, emulating GLSL vector/matrix types and behaviours in C, there are some equivalent types in hx-ogl
for float vector types, and float matrix types based on GLfloatArray
```
  var cameraPos:Vec3 = [100,40,20];
  var model = Mat4.rotateX(Math.PI);
  var view = Mat4.lookAt(cameraPos, [0,0,0]);
  var proj = Mat4.perspective(45, 4/3, 0.1, 1000);
  GL.uniformMatrix4fv(matrixID, false, proj * view * model);
```  

<a name="DebugDraw"/>
#### DebugDraw
  
Utility for drawing lines/triangles with OGL.
```
    // Construct new DebugDraw instance.
    // If 'textured' is true, then fragment colours are chosen from a 1D texture using the
    // 'red' component of a vertex colour, with vertex 'alpha' used, and 'green'/'blue' ignored.
    function new(textured:Bool=false)
    
    // Release GL buffers/arrays/programs
    function destroy():Void
    
    // Draw a solid line
    function drawLine(p0:Vec3, p1:Vec3, colour:Vec4):Void;
    
    // Draw a dashed line
    function drawDashedLine(p0:Vec3, p1:Vec3, colour:Vec4, solidLength:Float, gapLength:Float):Void;
    
    // Begin drawing, must be called before setting transform
    function begin(texture:GLuint=-1):Void;
    
    // Flush any currently buffered calls to GPU
    function flush():Void;
    
    // End drawing, any buffered calls will be flushed.
    function end():Void;
    
    // Clear any currently buffered calls
    function clear():Void;
    
    // Set transform for next batch of calls, any currently buffered calls will be flushed.
    function setTransform(mat:Mat4):Void;
```

The following are for manual drawing of geometry:
```
    // Swap to line rendering mode, any currently buffered triangle geom. will be flushed.
    function swapLines():Void;
    
    // Swap to triangle rendering mode, any currently buffered line geom. will be flushed.
    function swapFills():Void;
    
    // Push a single vertex into geom. buffer.
    function pushVertex(p:Vec3, colour:Vec4):Void;
    
    // Push a sequence of vertex data into geom. buffer.
    // [p, c, p, c, p, c, ...]
    function pushData(xs:Array<Float>):Void;
```
