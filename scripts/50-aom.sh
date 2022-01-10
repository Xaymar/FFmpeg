function install_aom() {	
	if [[ ${VERSION_MAJOR} -lt 4 ]]; then
		return 0
	fi
	
	curl -L -o "/tmp/aom.7z" "https://github.com/Xaymar/aom/releases/download/${AOM_VERSION}/aom-windows-${BUILD_BITS}-shared.7z"
	if [[ $? -ne 0 ]]; then return 1; fi
	7z x -o/tmp/aom "/tmp/aom.7z"
	if [[ $? -ne 0 ]]; then return 1; fi
	sed -i -E "s/^prefix=.*$/prefix=\/usr\/${BUILD_PREFIX}/g" /tmp/aom/lib/pkgconfig/aom.pc
	if [[ $? -ne 0 ]]; then return 1; fi
	cp /tmp/aom/lib/pkgconfig/aom.pc /tmp/aom/lib/pkgconfig/libaom.pc
	if [[ $? -ne 0 ]]; then return 1; fi
	sudo cp -a /tmp/aom/. /usr/${BUILD_PREFIX}/
	if [[ $? -ne 0 ]]; then return 1; fi
	cp -a /tmp/aom/bin/*.dll ./distrib/bin/
	if [[ $? -ne 0 ]]; then return 1; fi
}

install_aom
if [[ $? -ne 0 ]]; then exit 1; fi
