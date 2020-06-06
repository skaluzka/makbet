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

echo "Script ${0} completed."


# The end
