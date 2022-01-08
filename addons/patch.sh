echo "Applying custom patches..."

declare -a PATCHES
PATCHES[${#PATCHES[@]}]="${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_TWEAK}"
PATCHES[${#PATCHES[@]}]="${VERSION_MAJOR}.${VERSION_MINOR}"
PATCHES[${#PATCHES[@]}]="${VERSION_MAJOR}"

for patchset in ${PATCHES[@]}; do
	if [[ -d "${SCRIPTROOT}/patches/${patchset}" ]]; then
		echo "  Found ${patchset}..."
		for file in ${SCRIPTROOT}/patches/${patchset}/*.patch; do
			# Skip files that don't actually exist.
			[ -e "${file}" ] || continue
			echo "    Applying '${file}'..."
			git apply "${file}"			
		done
	fi
done
