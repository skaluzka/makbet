#!/usr/bin/env bash
set -eu


# Building kcov from sources according to:
# https://github.com/SimonKagstrom/kcov/blob/master/INSTALL.md

function main() {
    local cores
    cores=$(grep -c processor /proc/cpuinfo)

    cd "${1}"
    mkdir -pv build
    cd build
    cmake ..
    make -j"${cores}" -l"${cores}"
}

main "$@"

echo "Script ${0} completed."


# The end
