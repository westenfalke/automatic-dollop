#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "${TEST_UNDER_EXAMINATION}.bash"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv "${TEST_PROJECT_DIR}"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

# this functions will have access to the global VARS specified in the setup
@test "(${MODULE_NAME}) function fails without a positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}
    assert_failure
}

# calling the script will deny access to the global VARS specified in the setup
@test "(${MODULE_NAME}) script.. fails without a positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}.bash
    assert_failure
}