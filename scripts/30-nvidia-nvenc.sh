REPOSITORY="https://git.videolan.org/git/ffmpeg/nv-codec-headers.git"

function nvidia_nvenc() {	
	if [[ ${VERSION_MAJOR} -lt 3 ]]; then
		exit 0
	fi

	git clone --depth 1 --branch "${NVIDIANVENC_VERSION}" "${REPOSITORY}" /tmp/nvidia-nvenc
	pushd "/tmp/nvidia-nvenc" > /dev/null
	make PREFIX=/usr/${BUILD_PREFIX}
	sudo make PREFIX=/usr/${BUILD_PREFIX} install
	popd > /dev/null
}

nvidia_nvenc
