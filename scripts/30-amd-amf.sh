REPOSITORY="https://github.com/GPUOpen-LibrariesAndSDKs/AMF.git"

function amd_amf() {	
	if [[ ${VERSION_MAJOR} -lt 4 ]]; then
		exit 0
	fi

	git clone --depth 1 --branch "${AMDAMF_VERSION}" "${REPOSITORY}" /tmp/amd-amf
	pushd /tmp/amd-amf > /dev/null
	sudo cp -R amf/public/include/ /usr/${BUILD_PREFIX}/include/AMF
	popd > /dev/null
}

amd_amf
