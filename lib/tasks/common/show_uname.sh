#!/usr/bin/env bash
set -eu


function main() {
    uname "${1}"
}

main "$@"

echo "Script ${0} completed."


# The end
