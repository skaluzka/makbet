#!/usr/bin/env bash
set -eu


# Fetch current working directory.
readonly CWD="$(pwd)"

# Export MAKBET_PATH variable.
export MAKBET_PATH="$( readlink -f "${CWD}/.." )"

# Export MAKBET_CACHE_DIR variable.
export MAKBET_CACHE_DIR="${MAKBET_PATH}/.cache"

# Export MAKBET_TESTS_DIR variable.
export MAKBET_TESTS_DIR="${MAKBET_PATH}/tests"

# Export MAKBET_TESTS_OUTPUT_DIR variable.
export MAKBET_TESTS_OUTPUT_DIR="${MAKBET_TESTS_DIR}/output"

# Export MAKBET_TESTS_SRC_DIR variable.
export MAKBET_TESTS_SRC_DIR="${MAKBET_TESTS_DIR}/src"

# Export MAKBET_TESTS_LOGS_DIR variable.
export MAKBET_TESTS_LOGS_DIR="${MAKBET_TESTS_DIR}/logs"

#
# OK, Let's play!
#

# Prepare empty .../tests/output/ directory.
rm -rf "${MAKBET_TESTS_OUTPUT_DIR}"
mkdir -pv "${MAKBET_TESTS_OUTPUT_DIR}"

# Prepare empty .../tests/logs/ directory.
rm -rf "${MAKBET_TESTS_LOGS_DIR}"
mkdir -pv "${MAKBET_TESTS_LOGS_DIR}"

# Print some extra debug messages.
echo "[INFO]: CWD=${CWD}"

# Build file list.
readonly FILE_LIST=$( find "${MAKBET_TESTS_SRC_DIR}" -type f -iname "t[0-9][0-9]__make*" | sort )

# Declare some counter variables.
file_counter=0
failed_counter=0
passed_counter=0

echo ""
echo "[INFO]: Starting tests loop..."
echo ""

time {

    # Start iteration through file list.
    for __file_path in ${FILE_LIST}
    do

        echo "STARTED: ${__file_path}"

        __file_name=$( basename "${__file_path}" )

        logs_subdir=$( dirname "${__file_path//src/logs}" )
        log_file_path="${logs_subdir}/${__file_name}.log"

        output_subdir=$( dirname "${__file_path//src/output}" )
        output_file_path="${output_subdir}/${__file_name}.out"

        # Create directory structure inside .../tests/logs/ dir.
        mkdir -p "${logs_subdir}"

        # Create directory structure inside .../tests/output/ dir.
        mkdir -p "${output_subdir}"

        # Disable errors handling.
        set +e

            # Call test scenario file.
            "${__file_path}" \
                "${output_file_path}" \
                "${__file_path//src/resources\/expected}" \
                > "${log_file_path}" 2>&1

            # Fetch file's return code.
            __file_pathrc=$?

        # Enable errors handling.
        set -e

        # Print results.
        if [ "${__file_pathrc}" -eq 0 ]
        then
            passed_counter=$(( passed_counter+1 ))
            echo "PASSED:  ${__file_path}"
        else
            failed_counter=$(( failed_counter+1 ))
            echo "FAILED:  ${__file_path}"
            echo "Please check the log file: ${log_file_path}"
        fi

        file_counter=$(( file_counter+1 ))

        echo ""

    done

    # Show summary.
    echo ""
    echo "Total test files: ${file_counter}"
    echo "Passed:           ${passed_counter}"
    echo "Failed:           ${failed_counter}"
    echo ""

# End of "time {...}" block.
}

echo ""


# End of file
