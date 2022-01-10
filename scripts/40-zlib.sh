function install_zlib() {
	curl -L -o "/tmp/zlib.zip" "https://github.com/Xaymar/zlib-ng/releases/download/${ZLIB_VERSION}/zlib-ng-${BUILD_BITS}.zip"
	if [[ $? -ne 0 ]]; then return 1; fi
	7z x -o/tmp/zlib/ "/tmp/zlib.zip"
	if [[ $? -ne 0 ]]; then return 1; fi
	sudo cp -a /tmp/zlib/. /usr/${BUILD_PREFIX}/
	if [[ $? -ne 0 ]]; then return 1; fi
	cp -a /tmp/zlib/bin/*.dll ./distrib/bin/
	if [[ $? -ne 0 ]]; then return 1; fi
}

install_zlib
if [[ $? -ne 0 ]]; then exit 1; fi
