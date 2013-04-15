all: main
	./bin/Main
#	cd bin && neko Main.n

.PHONY: lib
lib:
	haxelib run hxcpp Build.xml -DHXCPP_M64

main: haxelib Main.hx
	haxe -main Main.hx -cpp bin -D HXCPP_M64 -lib ogl -lib glfw3

.PHONY: haxelib
haxelib: lib
	rm -f ogl.zip
	zip -r ogl src ogl include ndll Build.xml haxelib.xml samples -x \*samples/bin\*
	haxelib test ogl.zip
