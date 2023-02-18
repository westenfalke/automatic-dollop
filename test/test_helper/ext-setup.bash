#!/usr/bin/env bash
 tap_print_var_value() {
    printf "%s\n" "# \${${1}}='${!1}'" >&3
 }
    
_ext_setup() {
    LC_ALL=POSIX
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-file/load'
    #PROJECT_ROOT="$( cd "$( dirname "${BATS_TEST_FILENAME}" )/.." >/dev/null 2>&1 && pwd )"
    #PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." >/dev/null 2>&1 && pwd )"
    PROJECT_ROOT="$( realpath "$( dirname "${BASH_SOURCE[0]}" )/../.." )"
    PATH="${PROJECT_ROOT}/src/backingstore/default:${PROJECT_ROOT}/src:$PATH"
    TEST_BUILD_DIR='/tmp/bats'
    TEST_UNDER_EXAMINATION="$(basename ${BATS_TEST_FILENAME%.*})"
    TEST_CONCERN_DIR="${TEST_BUILD_DIR}/${TEST_UNDER_EXAMINATION}"
    TEST_PROJECT_DIR="${TEST_CONCERN_DIR}/root_directory"
    mkdir -pv "$TEST_PROJECT_DIR" && cd "$TEST_PROJECT_DIR" || exit "$?"
    FIRST_RUN_OF_TEST_UNDER_EXAMINATION="${TEST_CONCERN_DIR}/${TEST_UNDER_EXAMINATION}.first_run"
}
