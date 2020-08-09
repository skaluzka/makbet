#!/usr/bin/env bash
set -eu


function main() {
    w
}

main "$@"

if (( "${MAKBET_VERBOSE}" >= 1 ))
then
    echo "Script ${0} completed."
fi


# The end
