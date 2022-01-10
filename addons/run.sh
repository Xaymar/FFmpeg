for file in ${SCRIPTROOT}/scripts/*.sh; do
	[ -e "${file}" ] || continue
	echo "================================================================================"
	echo ">> ${file}"
	echo "================================================================================"
	. ${SCRIPTROOT}/.env
	${file}
	if [[ $? -ne 0 ]]; then exit 1; fi
done
