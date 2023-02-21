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
    #PATH="${PROJECT_ROOT}/cli:${PROJECT_ROOT}/core/backingstore/default:${PROJECT_ROOT}/core:$PATH"
    PATH="${PROJECT_ROOT}/cli:${PROJECT_ROOT}/core:$PATH"
    pwd <&2
    echo $PATH >&2
    BATS_TEST_DIRNAME='/tmp/bats'
    TEST_UNDER_EXAMINATION="$(basename ${BATS_TEST_FILENAME%.*})"
    TEST_CONCERN_DIR="${BATS_TEST_DIRNAME}/$(realpath "${BATS_TEST_FILENAME%.*}" --relative-to="${PROJECT_ROOT}")"
    mkdir -pv "$TEST_CONCERN_DIR" && cd "$TEST_CONCERN_DIR" || exit "$?"
    FIRST_RUN_OF_TEST_UNDER_EXAMINATION="${TEST_CONCERN_DIR}/${TEST_UNDER_EXAMINATION}.first_run"
}

_ext_and_backingstore_default_setup() {
    _ext_setup
    PATH="${PROJECT_ROOT}/core/backingstore/default:$PATH"
}
