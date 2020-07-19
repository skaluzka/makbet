#!/usr/bin/env bash
set -eu


readonly SLEEP=${1:-0}
readonly EXIT_CODE=${2:-0}

echo "Script opts:"
echo "PATH (\${0}) = ${0}"
echo "SLEEP (\${1}) = ${SLEEP}"
echo "EXIT_CODE (\${2}) = ${EXIT_CODE}"

sleep "${SLEEP}"

if (( "${MAKBET_VERBOSE}" >= 1 ))
then
    echo "Script ${0} completed."
fi

exit "${EXIT_CODE}"


# The end
