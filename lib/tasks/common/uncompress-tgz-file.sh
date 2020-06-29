#!/usr/bin/env bash
set -eu


function main() {
    mkdir -pv "${2}"
    tar xzf "${1}" -C "${2}"
}

main "$@"

if (( "${MAKBET_VERBOSE}" >= 1 ))
then
    echo "Script ${0} completed."
fi


# The end
