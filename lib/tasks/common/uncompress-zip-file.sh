#!/usr/bin/env bash
set -eu


function main() {
    mkdir -pv "${2}"
    unzip -q "${1}" -d "${2}"
}

main "$@"

echo "Script ${0} completed."


# The end
