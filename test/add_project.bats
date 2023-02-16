#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"

setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "${TEST_UNDER_EXAMINATION}.bash"

    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv ${TEST_PROJECT_DIR}
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) creates a project within an uniq namespace" {
    TEST_PARAMS_AS_AN_AARRAY="([NAMESPACE]="/tmp/bats/add_project/test_folder/new_project_namespace" [PROJECT_NAME]="ssg_test_project" [CATEGORY_NAME]=".ssgrc"   [BACKINGSTORE]="plain_text_on_disk" )"
    eval "declare -rA test_arguments_aarray=$TEST_PARAMS_AS_AN_AARRAY"
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_success
    assert [ -e "${test_arguments_aarray[NAMESPACE]}/${test_arguments_aarray[CATEGORY_NAME]}" ]
    run cat "${test_arguments_aarray[NAMESPACE]}/${test_arguments_aarray[CATEGORY_NAME]}"
    assert_output --partial "PROJECT_NAME=${test_arguments_aarray[PROJECT_NAME]}"
    assert_output --partial "BACKINGSTORE=${test_arguments_aarray[BACKINGSTORE]}"
}

@test "(${MODULE_NAME}) fails with exit code (2) if the project within the namespace already exits" {
    TEST_PARAMS_AS_AN_AARRAY="([NAMESPACE]="/tmp/bats/add_project/test_folder/existing_project_namespace" [PROJECT_NAME]="ssg_test_project" [CATEGORY_NAME]=".ssgrc"   [BACKINGSTORE]="plain_text_on_disk" )"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    mkdir -pv ${test_arguments[NAMESPACE]}
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_failure 2
}

@test "(${MODULE_NAME}) fails with exit code (128) without a positional paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}