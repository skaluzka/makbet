#!/usr/bin/env bash
set -eu


readonly SLEEP=${1:-0}
readonly EXIT_CODE=${2:-0}

echo "Script params:"
echo "SLEEP (\${0}) = ${SLEEP}"
echo "EXIT_CODE (\${1}) = ${EXIT_CODE}"

# Wait ${SLEEP} seconds.
sleep "${SLEEP}"

echo "Script ${0} completed." && exit "${EXIT_CODE}"


# The end
