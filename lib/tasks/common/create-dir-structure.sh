#!/usr/bin/env bash
set -eu


function main() {
    mkdir -pv "$@"
}

main $@

echo "Script ${0} completed."


# The end
