#!/usr/bin/env bash
# by Vitalii B.
# Dependencies: Mikero DePbo Tools v. == 0.7.92 or >= 0.8.76
# Download page: https://mikero.bytex.digital/Downloads
# Direct link: https://mikero.bytex.digital/api/download?filename=depbo-tools-0.7.92-linux-64bit.tgz
#set -x
echo -e "- Liberation_RX PBO build script -\n"

rm -f *.pbo

BUILD_ONLY=(
)

which makepbo
if [ $? -eq 1 ]; then
    echo -e "	\e[31mWARNING!!!\e[0m
		You have no DePbo tools installed!
		Please, visit \e[33mhttps://mikero.bytex.digital/Downloads\e[0m page to get the latest version for Linux."
    exit 1
fi

echo -e "//Liberation_RX was build on :
GRLIB_build_date = \"$(date +'%d/%m/%Y')\";
GRLIB_build_time = \"$(date +'%H:%M:%S')\";
" > ../core.liberation/build_info.sqf

for dir in $(ls -1 ../maps | grep -E "^Liberation_RX\.*"); do
    if [[ "${BUILD_ONLY[*]}" =~ "$(echo ${dir} | awk -F. '{ print $2 }')" || -z ${BUILD_ONLY} ]]; then
	echo "Building PBO for map ${dir}"
	cp -r ../maps/${dir} .
	cp -r ../core.liberation/* ./${dir}/
	if [[ -d custom ]]; then
		cp -r ./custom/* ./${dir}/
	fi
	if [[ -z "${1}" ]]; then
		TARGET_PATH=$(dirname "$(realpath $0)")
	else
		TARGET_PATH="${1}"
	fi
	makepbo -X=none ${dir} "${TARGET_PATH}"/"${dir}".pbo >/dev/null
	rm -rf ./${dir}
	echo "Done."
    fi
done
exit 0
