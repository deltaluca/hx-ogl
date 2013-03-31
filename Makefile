all: lib main
	cd bin && ./Main-debug
#	cd bin && neko Main.n

.PHONY: lib
lib:
	haxelib run hxcpp Build.xml -DHXCPP_M64 -debug

main: haxelib Main.hx
	haxe -main Main.hx -cpp bin -D HXCPP_M64 -debug -lib ogl

.PHONY: haxelib
haxelib: lib
	rm -f ogl.zip
	zip -r ogl src ogl include ndll Build.xml haxelib.xml
	haxelib test ogl.zip
