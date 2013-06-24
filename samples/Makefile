all:
	haxe -neko Sample.n -main Sample -lib glfw3 -lib ogl -lib format
	neko Sample.n

cpp:
	haxe -cpp bin -main Sample -lib glfw3 -lib ogl -lib format -D HXCPP_M64
	./bin/Sample
