function install_aom() {	
	if [[ ${VERSION_MAJOR} -lt 4 ]]; then
		exit 0
	fi
	
	curl -L -o "/tmp/aom.7z" "https://github.com/Xaymar/aom/releases/download/${AOM_VERSION}/aom-windows-${BUILD_BITS}-shared.7z"
	7z x -o/tmp/aom "/tmp/aom.7z"
	sed -i -E "s/^prefix=.*$/prefix=\/usr\/${BUILD_PREFIX}/g" /tmp/aom/lib/pkgconfig/aom.pc
	cp /tmp/aom/lib/pkgconfig/aom.pc /tmp/aom/lib/pkgconfig/libaom.pc
	sudo cp -a /tmp/aom/. /usr/${BUILD_PREFIX}/
	cp -a /tmp/aom/bin/*.dll ./distrib/bin/
}

install_aom
