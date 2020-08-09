#!/usr/bin/env bash
set -eu


function main() {
    uname "${1}"
}

main "$@"

if (( "${MAKBET_VERBOSE}" >= 1 ))
then
    echo "Script ${0} completed."
fi


# The end
