all: lib main
	cp ndll/Linux64/ogl.ndll bin/ogl.ndll && cd bin && ./Main-debug
#	cd bin && neko Main.n

.PHONY: lib
lib:
	haxelib run hxcpp Build.xml -DHXCPP_M64 -debug

main: Main.hx
	haxe -main Main -cpp bin -D HXCPP_M64 -debug
#	haxe -main Main -neko bin/Main.n -debug

.PHONY: haxelib
haxelib: lib
	rm -f ogl.zip
	zip -r ogl src ogl include ndll Build.xml haxelib.xml
	haxelib test ogl.zip
