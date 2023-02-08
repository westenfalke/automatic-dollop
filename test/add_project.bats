#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"
    load "../params"
    TEST_PROJECT_NAME="TEST_ProjectName"
    TEST_BASE_DIR="${TEST_PROJECT_DIR}/foo"
    TEST_BACKINGSTORE=disk
    TEST_CONFIGFILE="${TEST_BASE_DIR}/${PARAM_CONFIG_NAME}"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv ${TEST_PROJECT_DIR}
        run ${TEST_UNDER_EXAMINATION}.bash $(printf "%s=%s\n%s=%s\n%s=%s\n" "${PARAM_BASE_DIR}" "${TEST_BASE_DIR}" "${PARAM_PROJECT_NAME}" "${TEST_PROJECT_NAME}" "${PARAM_BACKINGSTORE}" "${TEST_BACKINGSTORE}" )
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "the backingstore for the project is configured" {
    assert [ -e "$TEST_CONFIGFILE" ]
    run cat "$TEST_CONFIGFILE"
    assert_output --partial "${PARAM_PROJECT_NAME}=${TEST_PROJECT_NAME}"
    assert_output --partial "${PARAM_BACKINGSTORE}=${TEST_BACKINGSTORE}"
}

@test 'script fails if the project dir already exits' {
    run ${TEST_UNDER_EXAMINATION}.bash $(printf "%s=%s\n%s=%s\n%s=%s\n" "${PARAM_BASE_DIR}" "${TEST_PROJECT_DIR}" "${PARAM_PROJECT_NAME}" "${TEST_PROJECT_NAME}" "${PARAM_BACKINGSTORE}" "${TEST_BACKINGSTORE}" )
    assert_failure
}

@test 'function fails if project dir already exits' {
    run ${TEST_UNDER_EXAMINATION} $(printf "%s=%s\n%s=%s\n%s=%s\n" "${PARAM_BASE_DIR}" "${TEST_PROJECT_DIR}" "${PARAM_PROJECT_NAME}" "${TEST_PROJECT_NAME}" "${PARAM_BACKINGSTORE}" "${TEST_BACKINGSTORE}" )
    assert_failure
}

# this functions will have access to the global VARS specified in the setup
@test 'function fails without positional paramerter' {
    run "$TEST_UNDER_EXAMINATION"
    assert_failure
}

# calling the script will deny access to the global VARS specified in the setup
@test "script fails without positional paramerter" {
    run "$TEST_UNDER_EXAMINATION.bash"
    assert_failure
}