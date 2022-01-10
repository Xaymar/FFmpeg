REPOSITORY="https://git.videolan.org/git/ffmpeg/nv-codec-headers.git"

function nvidia_nvenc() {	
	if [[ ${VERSION_MAJOR} -lt 3 ]]; then
		return 0
	fi

	git clone --depth 1 --branch "${NVIDIANVENC_VERSION}" "${REPOSITORY}" /tmp/nvidia-nvenc
	if [[ $? -ne 0 ]]; then return 1; fi
	pushd "/tmp/nvidia-nvenc" > /dev/null
	if [[ $? -ne 0 ]]; then return 1; fi
	make PREFIX=/usr/${BUILD_PREFIX}
	if [[ $? -ne 0 ]]; then return 1; fi
	sudo make PREFIX=/usr/${BUILD_PREFIX} install
	if [[ $? -ne 0 ]]; then return 1; fi
	popd > /dev/null
	if [[ $? -ne 0 ]]; then return 1; fi
}

nvidia_nvenc
if [[ $? -ne 0 ]]; then exit 1; fi
