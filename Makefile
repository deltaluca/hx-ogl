all: haxelib
	haxe -x Testgl -lib ogl
#	cd bin && neko Main.n

.PHONY: lib
lib:
	haxelib run hxcpp Build.xml -DHXCPP_M64

main: haxelib
	haxe -main Main.hx -cpp bin -D HXCPP_M64 -lib ogl -lib glfw3 -lib goodies -debug

.PHONY: haxelib
haxelib: lib
	rm -f ogl.zip
	zip -r ogl src ogl include ndll Build.xml haxelib.json samples -x \*samples/bin\*
	haxelib local ogl.zip
