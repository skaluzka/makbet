#!/usr/bin/env bash
set -eu


# Building make from sources according to:
# http://git.savannah.gnu.org/cgit/make.git/tree/README.git

function main() {
    local cores
    cores=$(grep -c processor /proc/cpuinfo)

    cd "${1}"
    ./configure
    make -j"${cores}" -l"${cores}"
}

main "$@"

echo "Script ${0} completed."


# The end
