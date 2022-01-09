export PKG_CONFIG_PATH=/usr/${BUILD_PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH}

# Configure FFmpeg
./configure \
	--arch="${BUILD_ARCH}" \
	--target-os="${BUILD_TARGET}" \
	--cross-prefix="${BUILD_PREFIX}-" \
	--prefix="${PWD}/distrib" \
	--bindir="${PWD}/distrib/bin" \
	--libdir="${PWD}/distrib/lib" \
	--shlibdir="${PWD}/distrib/bin" \
	--pkg-config=pkg-config \
	--extra-cflags=-O3 --extra-cflags=-mmmx --extra-cflags=-msse --extra-cflags=-msse2 --extra-cflags=-msse3 --extra-cflags=-mssse3 \
	--extra-cflags=-msse4.1 --extra-cflags=-msse4.2 --extra-cflags=-mavx --extra-cflags=-maes --extra-cflags=-mpclmul \
	--pkg-config=pkg-config \
	${BUILD_FLAGS}

# Compile FFmpeg
make -j$((`nproc` * 2))

# Install FFmpeg
sudo make install

# Move .lib files which are in the wrong place.
mv ./distrib/bin/*.lib ./distrib/lib/
