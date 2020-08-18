#!/usr/bin/env bash
set -eu


function main() {
    for f in "${@}"
    do
        echo "Checking if \"${f}\" file exists..."
        if [ -f "${f}" ]
        then
            echo "${f} -> File found."
        fi
    done
}

main "$@"

if (( "${MAKBET_VERBOSE}" >= 1 ))
then
    echo "Script ${0} completed."
fi


# End of file
