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

@test "(${MODULE_NAME}) adds a new uniq namespace" {
    TEST_PARAMS_AS_AN_AARRAY="([NAMESPACE]="${TEST_PROJECT_DIR}/new_namespace" [PROJECT_NAME]="ssg_test_project" [CATEGORY_NAME]=".ssgrc"   [BACKINGSTORE]="plain_text_on_disk" )"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    mkdir -pv ${test_arguments[NAMESPACE]}
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_failure 2
}

@test "(${MODULE_NAME}) fails if the namespace already exits" {
    TEST_PARAMS_AS_AN_AARRAY="([NAMESPACE]="${TEST_PROJECT_DIR}/existing_namespace" [PROJECT_NAME]="ssg_test_project" [CATEGORY_NAME]=".ssgrc"   [BACKINGSTORE]="plain_text_on_disk" )"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    mkdir -pv ${test_arguments[NAMESPACE]}
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_failure 2
}

@test "(${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}