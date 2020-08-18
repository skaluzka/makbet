#!/usr/bin/env bash
set -eu


function main() {
    "${1}" "${2}"
}

main "$@"

if (( "${MAKBET_VERBOSE}" >= 1 ))
then
    echo "Script ${0} completed."
fi


# End of file
