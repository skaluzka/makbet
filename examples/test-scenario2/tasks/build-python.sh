#!/usr/bin/env bash
set -eu


# Building python from sources according to:
# https://github.com/python/cpython#build-instructions

function main() {
    local cores
    cores=$(grep -c processor /proc/cpuinfo)

    cd "${1}"
    ./configure
    make -j"${cores}" -l"${cores}"
}

main "$@"

if (( "${MAKBET_VERBOSE}" >= 1 ))
then
    echo "Script ${0} completed."
fi


# The end
