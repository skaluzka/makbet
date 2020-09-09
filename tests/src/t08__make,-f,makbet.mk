#!/usr/bin/env bash
# shellcheck disable=SC2002,SC2164
set -u
set -x


readonly output_file="${1}"
readonly expected_file="${2}"
pushd "${MAKBET_TESTS_LOGS_DIR}" > /dev/null
make -f "${MAKBET_PATH}/makbet.mk" > "${output_file}"
diff -u -s \
    <( \
        cat "${output_file}" \
        | sed '2d;8d' \
        | nl -b a \
    ) \
    <( \
        cat "${expected_file}" \
        | sed '2d;8d' \
        | nl -b a \
    )
readonly __rc=$?
popd > /dev/null
exit ${__rc}


# End of file
