all: lib main
	cp ndll/Linux64/ogl.ndll bin/ogl.ndll && cd bin && ./Main-debug
#	cd bin && neko Main.n

.PHONY: lib
lib:
	haxelib run hxcpp Build.xml -DHXCPP_M64 -debug

main: lib ogl/GLM.hx
	haxe -main ogl.GLM -cpp bin -D HXCPP_M64 -debug
	cp ndll/Linux64/ogl.ndll bin/ogl.ndll && cd bin && ./GLM-debug

.PHONY: haxelib
haxelib: lib
	rm -f ogl.zip
	zip -r ogl src ogl include ndll Build.xml haxelib.xml
	haxelib test ogl.zip
