# Ask git for a description of the current commit.
DESCRIPTION=`git describe --long HEAD`
if [ "${DESCRIPTION:0:1}" == "n" ] || [ "${DESCRIPTION:0:1}" == "v" ]; then
	DESCRIPTION=${DESCRIPTION:1}
fi
#echo "echo FFmpeg v${DESCRIPTION}"

# Extract version information from description.
VERSION=${DESCRIPTION//./ }
VERSION=${VERSION//-/ }
VERSION=( ${VERSION} )
VERSION_MAJOR=${VERSION[0]}
VERSION_MINOR=${VERSION[1]}
VERSION_PATCH=${VERSION[2]}
VERSION_TWEAK=${VERSION[3]}
COMMIT=${VERSION[4]:1}
#echo "echo FFmpeg v${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}.${VERSION_TWEAK}-${COMMIT}"
. ${SCRIPTROOT}/addons/export.sh VERSION_MAJOR "${VERSION_MAJOR}"
. ${SCRIPTROOT}/addons/export.sh VERSION_MINOR "${VERSION_MINOR}"
. ${SCRIPTROOT}/addons/export.sh VERSION_PATCH "${VERSION_PATCH}"
. ${SCRIPTROOT}/addons/export.sh VERSION_TWEAK "${VERSION_TWEAK}"
. ${SCRIPTROOT}/addons/export.sh COMMIT "${COMMIT}"

# Set up some baseline directories
if [ ! -d distrib ]; then mkdir distrib; fi
if [ ! -d distrib/bin ]; then mkdir distrib/bin; fi
if [ ! -d distrib/lib ]; then mkdir distrib/lib; fi
if [ ! -d distrib/include ]; then mkdir distrib/include; fi
if [ ! -d distrib/share ]; then mkdir distrib/share; fi

# Target Architecture
if [ "${BUILD_BITS}" == "32" ]; then
	BUILD_ARCH="i686"
	BUILD_TARGET="mingw32"
	BUILD_PREFIX="i686-w64-mingw32"
else
	BUILD_ARCH="x86_64"
	BUILD_TARGET="mingw64"
	BUILD_PREFIX="x86_64-w64-mingw32"
fi
. ${SCRIPTROOT}/addons/export.sh BUILD_ARCH "${BUILD_ARCH}"
. ${SCRIPTROOT}/addons/export.sh BUILD_TARGET "${BUILD_TARGET}"
. ${SCRIPTROOT}/addons/export.sh BUILD_PREFIX "${BUILD_PREFIX}"

# License (GPL vs LGPL, v2 vs v3)
declare -a BUILD_FLAGS
if [ "${LICENSE}" == "GPL" ]; then
	#echo "::set-output name=flags_license::--enable-gpl"
	BUILD_FLAGS+=("--enable-gpl")
fi
if [ "${LICENSE_VERSION}" == "3" ]; then
	#echo "::set-output name=flags_license_version::--enable-version3"
	BUILD_FLAGS+=("--enable-version3")
fi

# Build Type
if [ "${BUILD_TYPE}" == "static" ]; then
	#echo "::set-output name=flags_type::--enable-static --disable-shared"
	BUILD_FLAGS+=("--enable-static")
	BUILD_FLAGS+=("--disable-shared")
else
	#echo "::set-output name=flags_type::--disable-static --enable-shared"
	BUILD_FLAGS+=("--disable-static")
	BUILD_FLAGS+=("--enable-shared")
fi
. ${SCRIPTROOT}/addons/export.sh BUILD_FLAGS "`echo ${BUILD_FLAGS[@]}`"
