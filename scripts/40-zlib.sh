function install_zlib() {
	curl -L -o "/tmp/zlib.zip" "https://github.com/Xaymar/zlib-ng/releases/download/${ZLIB_VERSION}/zlib-ng-${BUILD_BITS}.zip"
	7z x -o/tmp/zlib/ "/tmp/zlib.zip"
	sudo cp -a /tmp/zlib/. /usr/${BUILD_PREFIX}/
	cp -a /tmp/zlib/bin/*.dll ./distrib/bin/
}

install_zlib
