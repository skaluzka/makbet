#!/usr/bin/env bash
set -eu


function main() {
    "${1}" "${2}"
}

main $@

echo "Script ${0} completed."


# The end
