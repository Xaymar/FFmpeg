function install_libx264() {	
	if [[ ${VERSION_MAJOR} -lt 1 ]]; then
		return 0
	fi
	if [[ "${LICENSE}" != "GPL" ]]; then
		return 0
	fi

	curl -L -o "/tmp/x264.zip" "https://github.com/Xaymar/x264/releases/download/${X264_VERSION}/x264-${BUILD_BITS}-shared-GPLv2.zip"
	if [[ $? -ne 0 ]]; then return 1; fi
	7z x -o/tmp/x264/ "/tmp/x264.zip"
	if [[ $? -ne 0 ]]; then return 1; fi
	sudo cp -a /tmp/x264/. /usr/${BUILD_PREFIX}/
	if [[ $? -ne 0 ]]; then return 1; fi
	cp -a /tmp/x264/bin/*.dll ./distrib/bin/
	if [[ $? -ne 0 ]]; then return 1; fi
}

install_libx264
if [[ $? -ne 0 ]]; then exit 1; fi
