#!/usr/bin/env bash
set -eu


function main() {

    local delay_in_seconds
    delay_in_seconds="${1}"

    sleep "${delay_in_seconds}"
}

main "$@"

if (( "${MAKBET_VERBOSE}" >= 1 ))
then
    echo "Script ${0} completed."
fi


# End of file
