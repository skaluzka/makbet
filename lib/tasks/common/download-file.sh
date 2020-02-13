#!/usr/bin/env bash
set -eu


function main() {
    curl -L "${1}" > "${2}"

    ls -al "${2}"
}

main $@

echo "Script ${0} completed."


# The end
