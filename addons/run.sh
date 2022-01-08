for file in ${SCRIPTROOT}/scripts/*.sh; do
	[ -e "${file}" ] || continue
	. ${file}
done
