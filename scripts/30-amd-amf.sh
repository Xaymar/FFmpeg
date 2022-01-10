REPOSITORY="https://github.com/GPUOpen-LibrariesAndSDKs/AMF.git"

function amd_amf() {	
	if [[ ${VERSION_MAJOR} -lt 4 ]]; then
		return 0
	fi

	git clone --depth 1 --branch "${AMDAMF_VERSION}" "${REPOSITORY}" /tmp/amd-amf
	if [[ $? -ne 0 ]]; then return 1; fi
	pushd /tmp/amd-amf > /dev/null
	if [[ $? -ne 0 ]]; then return 1; fi
	sudo cp -R amf/public/include/ /usr/${BUILD_PREFIX}/include/AMF
	if [[ $? -ne 0 ]]; then return 1; fi
	popd > /dev/null
	if [[ $? -ne 0 ]]; then return 1; fi
}

amd_amf
if [[ $? -ne 0 ]]; then exit 1; fi
