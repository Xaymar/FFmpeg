function install_libx264() {	
	if [[ ${VERSION_MAJOR} -lt 1 ]]; then
		exit 0
	fi
	if [[ "${LICENSE}" != "GPL" ]]; then
		exit 0
	fi

	curl -L -o "/tmp/x264.zip" "https://github.com/Xaymar/x264/releases/download/${X264_VERSION}/x264-${BUILD_BITS}-shared-GPLv2.zip"
	7z x -o/tmp/x264/ "/tmp/x264.zip"
	sudo cp -a /tmp/x264/. /usr/${BUILD_PREFIX}/
	cp -a /tmp/x264/bin/*.dll ./distrib/bin/
}

install_libx264
