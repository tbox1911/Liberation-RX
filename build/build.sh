#!/usr/bin/env bash
# by Vitalii B.
# Dependencies: Mikero DePbo Tools v.0.7.92 or later
# Download page: https://mikero.bytex.digital/Downloads
# Direct link: https://mikero.bytex.digital/api/download?filename=depbo-tools-0.7.92-linux-64bit.tgz
echo -e "- Liberation_RX PBO build script -\n"

which makepbo &>/dev/null
if [[ $? = 1 ]]; then
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
    echo "Building PBO for map ${dir}"
    cp -r ../maps/${dir} .
    cp -r ../core.liberation/* ./${dir}/
    if [[ -d custom ]]; then
	cp -r ./custom/* ./${dir}/
    fi
    makepbo -X=none ${dir} ${dir}.pbo >/dev/null
    rm -rf ./${dir}
    echo "Done."
done
exit 0
