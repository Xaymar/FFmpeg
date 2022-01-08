#!/bin/bash

REPOSITORY="https://github.com/mirror/mingw-w64.git"

CROSS_TOOLCHAIN=$1
GCC_SYSROOT="`${CROSS_TOOLCHAIN}-gcc -print-sysroot`"

mingw_clone() {
	if [ ! -d /tmp/mingw ]; then
		git clone -b "${MINGW_VERSION}" --depth 1 "${REPOSITORY}" /tmp/mingw
		if [[ $? -ne 0 ]]; then exit 1; fi
	else
		pushd /tmp/mingw > /dev/null
		git fetch --all
		if [[ $? -ne 0 ]]; then exit 1; fi
		git reset --hard "${MINGW_VERSION}"
		if [[ $? -ne 0 ]]; then exit 1; fi
		popd > /dev/null
	fi
}

mingw_build_crt() {
	pushd /tmp/mingw/mingw-w64-crt > /dev/null

	# Clear potentially passed flags.
	unset CFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset PKG_CONFIG_LIBDIR

	# Configure MinGW
	local mingw_configure=(
		--prefix="${GCC_SYSROOT}/usr/${CROSS_TOOLCHAIN}"
#		--host=`gcc -dumpmachine`
		--host="${CROSS_TOOLCHAIN}"
		--enable-lib32
		--enable-lib64
	)
	./configure ${mingw_configure[@]}
	if [[ $? -ne 0 ]]; then exit 1; fi

	# Build MinGW
	make -j`nproc`
	if [[ $? -ne 0 ]]; then exit 1; fi

	# Install MinGW
	sudo make install
	if [[ $? -ne 0 ]]; then exit 1; fi

	popd > /dev/null
}

mingw_build_headers() {
	pushd /tmp/mingw/mingw-w64-headers > /dev/null

	# Clear potentially passed flags.
	unset CFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset PKG_CONFIG_LIBDIR

	# Configure MinGW
	local mingw_configure=(
		--prefix="${GCC_SYSROOT}/usr/${CROSS_TOOLCHAIN}"
#		--host=`gcc -dumpmachine`
		--host="${CROSS_TOOLCHAIN}"
		--with-default-win32-winnt="0x0601"
		--enable-idl
	)
	./configure ${mingw_configure[@]}
	if [[ $? -ne 0 ]]; then exit 1; fi

	# Build MinGW
	make -j`nproc`
	if [[ $? -ne 0 ]]; then exit 1; fi

	# Install MinGW
	sudo make install
	if [[ $? -ne 0 ]]; then exit 1; fi

	popd > /dev/null
}

mingw_build_library_winpthreads() {
	pushd /tmp/mingw/mingw-w64-libraries/winpthreads > /dev/null

	# Clear potentially passed flags.
	unset CFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset PKG_CONFIG_LIBDIR

	# Configure MinGW
	local mingw_configure=(
		--prefix="${GCC_SYSROOT}/usr/${CROSS_TOOLCHAIN}"
		--host="${CROSS_TOOLCHAIN}"
		--disable-shared
		--enable-static
		--with-pic
	)
	./configure ${mingw_configure[@]}
	if [[ $? -ne 0 ]]; then exit 1; fi

	# Build MinGW
	make -j`nproc`
	if [[ $? -ne 0 ]]; then exit 1; fi

	# Install MinGW
	sudo make install
	if [[ $? -ne 0 ]]; then exit 1; fi

	popd > /dev/null
}

mingw_build_libraries() {
	mingw_build_library_winpthreads
	if [[ $? -ne 0 ]]; then exit 1; fi
}

mingw_build() {
	pushd /tmp/mingw > /dev/null

	# Clear potentially passed flags.
	unset CFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset PKG_CONFIG_LIBDIR

	mingw_build_crt
	if [[ $? -ne 0 ]]; then exit 1; fi
	mingw_build_headers
	if [[ $? -ne 0 ]]; then exit 1; fi
	mingw_build_libraries
	if [[ $? -ne 0 ]]; then exit 1; fi

	popd > /dev/null
}

#mingw_clone
if [[ $? -ne 0 ]]; then exit 1; fi
#mingw_build
if [[ $? -ne 0 ]]; then exit 1; fi
