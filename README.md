Haxe-c++ bindings for OpenGL 3.3+

This is incredibly early alpha I suppose, I am not at this time intending myself to fully
support the entirety of the API, and the API that is supported will not have been
thoroughly tested if at all.

Anyone wishing to use OpenGL in hxcpp (without any other dependancy, or else use NME!)
should consider testing and submitting pull requests :)


#### API Changes to OpenGL.

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
  
