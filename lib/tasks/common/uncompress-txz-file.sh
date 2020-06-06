#!/usr/bin/env bash
set -eu


function main() {
    mkdir -pv "${2}"
    tar -xJf "${1}" -C "${2}"
}

main "$@"

echo "Script ${0} completed."


# The end
