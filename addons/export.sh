export $1="$2"
if [[ "${CI}" == "true" ]]; then
	echo "::set-output name=$1::$2"
fi
echo "export $1=\"$2\"" >> ${SCRIPTROOT}/.env
