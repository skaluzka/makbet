#!/usr/bin/env bash
set -eu


# Building git from sources according to:
# https://github.com/git/git/blob/master/INSTALL

function help() {
    echo "This is a help message for ${0} script."
}

function main() {
    local cores
    cores=$(grep -c processor /proc/cpuinfo)

    cd "${1}"
    make all -j"${cores}" -l"${cores}"
}

main "$@"

echo "Script ${0} completed."


# The end
