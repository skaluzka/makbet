#!/usr/bin/env bash
set -eu


function main() {
    for d in "${@}"
    do
        echo "Checking if \"${d}\" directory exists..."
        if [ -d "${d}" ]
        then
            echo "${d} -> Directory found."
        fi
    done
}

main $@

echo "Script ${0} completed."


# The end
