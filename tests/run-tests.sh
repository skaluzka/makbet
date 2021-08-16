#!/usr/bin/env bash
set -euo pipefail

# This file is a part of makbet's project tests suite.
# Do not change it, unless you know what you are doing.


# Fetch current working directory.
# shellcheck disable=SC2155
readonly CWD="$(pwd)"

# Export mandatory MAKBET_PATH variable.
# shellcheck disable=SC2155
export MAKBET_PATH="$( readlink -f "${CWD}/.." )"

# Export MAKBET_CACHE_DIR variable in addition.
export MAKBET_CACHE_DIR="${MAKBET_PATH}/.makbet-cache"

export MAKBET_TESTS_DIR="${MAKBET_PATH}/tests"
export MAKBET_TESTS_LOGS_DIR="${MAKBET_TESTS_DIR}/logs"
export MAKBET_TESTS_OUTPUT_DIR="${MAKBET_TESTS_DIR}/output"
export MAKBET_TESTS_SRC_DIR="${MAKBET_TESTS_DIR}/src"

#
# Declare exit/return codes.
#
readonly RC_SUCCESS=0
readonly RC_ERROR=1

#
# Initialize the global exit/return code variable (__rc)
# with ${RC_SUCCESS} value (see above).
#
__rc="${RC_SUCCESS}"


#
# OK, Let's play!
#
echo -e "\n[INFO]: CWD=${CWD}\n"
echo -e "[INFO]: Preparing directory structure...\n"

# Prepare empty ./tests/output/ directory.
rm -rf "${MAKBET_TESTS_OUTPUT_DIR}"
mkdir -pv "${MAKBET_TESTS_OUTPUT_DIR}"

# Prepare empty ./tests/logs/ directory.
rm -rf "${MAKBET_TESTS_LOGS_DIR}"
mkdir -pv "${MAKBET_TESTS_LOGS_DIR}"

# Collect all test files.
# shellcheck disable=SC2155
readonly test_files=$( find "${MAKBET_TESTS_SRC_DIR}" -type f -iname "t[0-9][0-9]__make*" | sort )

# Declare few global counters.
test_files_counter=0
total_files="$(echo "${test_files}" | wc -l)"
failed_counter=0
passed_counter=0

echo -e "\n[INFO]: Found ${total_files} test files in ${CWD} directory.\n"
echo -e "\n[INFO]: Starting tests loop...\n"

time {

    # Start iteration through test file list.
    for __file_path in ${test_files}
    do

        # Increment test case file counter.
        test_files_counter=$(( test_files_counter+1 ))

        echo "Test:   ${test_files_counter}/${total_files}"
        echo "File:   ${__file_path}"

        __file_name=$( basename "${__file_path}" )

        logs_subdir=$( dirname "${__file_path//src/logs}" )
        log_file_path="${logs_subdir}/${__file_name}.log"

        output_subdir=$( dirname "${__file_path//src/output}" )
        output_file_path="${output_subdir}/${__file_name}.out"

        # Create directory structure inside ./tests/logs/ dir.
        mkdir -p "${logs_subdir}"

        # Create directory structure inside ./tests/output/ dir.
        mkdir -p "${output_subdir}"

        #
        # Disable errors handling before calling the test case file.
        #
        set +e

        #
        # Call test case file.
        #
        "${__file_path}" \
            "${output_file_path}" \
            "${__file_path//src/resources\/expected}" \
            > "${log_file_path}" 2>&1

        # Fetch exit/return code after execution of above^^ test case file.
        __file_pathrc=$?

        #
        # Enable errors handling after calling test case file.
        #
        set -e

        #
        # Print test results.
        #
        if [ "${__file_pathrc}" -eq 0 ]
        then
            passed_counter=$(( passed_counter+1 ))
            echo "Result: OK"
        else

            #
            # Set global exit/return code to ${RC_ERROR}.
            #
            __rc="${RC_ERROR}"

            failed_counter=$(( failed_counter+1 ))
            echo "Result: FAILED!!!"
            echo "        Please check the log file: ${log_file_path}"
        fi

        echo

    done

    # Print short summary.
    echo -e "\nTotal test files: ${test_files_counter}"
    echo "Passed:           ${passed_counter}"
    echo -e "Failed:           ${failed_counter}\n"

#
# End of "time {...}" code block.
#
}

echo -e "\n\n[INFO]: Script ${0} completed.\n"

#
# Exit the script with either ${RC_SUCCESS} or ${RC_ERROR} value.
#
exit "${__rc}"


# End of file
