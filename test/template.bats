#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
# TEST_UNDER_EXAMINATION: template.bash
# keep ${FUNCNAME} and 'basename' in sync
# function will be launched only if not sourced 
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "${TEST_UNDER_EXAMINATION}.bash"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv "${TEST_PROJECT_DIR}"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) fails with exit code (128) without a positional paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}