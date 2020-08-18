#!/usr/bin/env bash
set -eu


# Building doxygen from sources according to:
# http://www.doxygen.nl/manual/install.html

function main() {
    local cores
    cores=$(grep -c processor /proc/cpuinfo)

    cd "${1}"
    mkdir -pv build
    cd build
    cmake -G "Unix Makefiles" ..
    make -j"${cores}" -l"${cores}"
}

main "$@"

if (( "${MAKBET_VERBOSE}" >= 1 ))
then
    echo "Script ${0} completed."
fi


# End of file
