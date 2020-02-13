#!/usr/bin/env bash
set -eu


# Building python from sources according to:
# https://github.com/python/cpython#build-instructions

function help() {
    echo "This is a help message for ${0} script."
}

function main() {
    local cores=$(grep -c processor /proc/cpuinfo)

    cd "${1}"
    ./configure
    make -j"${cores}" -l"${cores}"
}

main $@

echo "Script ${0} completed."


# The end
