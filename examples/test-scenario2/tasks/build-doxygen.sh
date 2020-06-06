#!/usr/bin/env bash
set -eu


# Building doxygen from sources according to:
# http://www.doxygen.nl/manual/install.html

function help() {
    echo "This is a help message for ${0} script."
}

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

echo "Script ${0} completed."


# The end
