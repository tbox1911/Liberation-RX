#!/usr/bin/env bash
# by Vitalii B.
# Dependencies: Mikero DePbo Tools v. == 0.7.92 or >= 0.8.76
# Download page: https://mikero.bytex.digital/Downloads
# Direct link: https://mikero.bytex.digital/api/download?filename=depbo-tools-0.8.79-linux-x86_64.tgz
echo -e "- Liberation_RX PBO build script -\n"

rm ./*.pbo 2>/dev/null

BUILD_ONLY=(
)

which makepbo &>/dev/null
if [[ $? = 1 ]]; then
    echo -e "	\e[31mWARNING!!!\e[0m
		You have no DePbo tools installed!
		Please, visit \e[33mhttps://mikero.bytex.digital/Downloads\e[0m page to get the latest version for Linux."
    exit 1
fi

for dir in $(ls -1 ../maps | grep -E "^Liberation_RX\.*"); do
	if [[ "${BUILD_ONLY[*]}" =~ $(echo "${dir}" | awk -F. '{ print $2 }') || -z "${BUILD_ONLY}" ]]; then
		if [[ -n "${1}" ]]; then
			dir="Liberation_RX.${1}"
		fi
		echo "Building PBO for map ${dir}"
		cp -r ../maps/"${dir}" .
		cp -r ../core.liberation/* ./"${dir}"/

		echo -e "//Liberation_RX was build on :
GRLIB_build_date = \"$(date +'%d/%m/%Y')\";
GRLIB_build_time = \"$(date +'%H:%M:%S')\";
" > ./"${dir}"/build_info.sqf

		tag=$(git tag | tail -n1)
		sed -i "s/\(\"Last version\) .*\"\]/\1 $tag\"\]/" ./"${dir}"/GREUH/Scripts/GREUH_version.sqf

		if [[ -d custom ]]; then
			cp -r ./custom/* ./"${dir}"/
		fi

		makepbo -X=none "${dir}" "${dir}".pbo >/dev/null
		rm -rf ./"${dir}"
		echo "Done."
	fi
done
exit 0
