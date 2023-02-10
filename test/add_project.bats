#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"

setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"

    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv ${TEST_PROJECT_DIR}
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) script.. creates a project with input from Array definition" {
    TEST_PARAMS_AS_AN_AARRAY="([BASE_DIR]="/tmp/bats/add_project/test_folder/new_project_dir_script" [PROJECT_NAME]="ssg_test_project" [CONFIG_NAME]=".ssgrc"   [BACKINGSTORE]="disk" )"
    eval "declare -rA test_arguments_aarray=$TEST_PARAMS_AS_AN_AARRAY"
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_success
    assert [ -e "${test_arguments_aarray[BASE_DIR]}/${test_arguments_aarray[CONFIG_NAME]}" ]
    run cat "${test_arguments_aarray[BASE_DIR]}/${test_arguments_aarray[CONFIG_NAME]}"
    assert_output --partial "PROJECT_NAME=${test_arguments_aarray[PROJECT_NAME]}"
    assert_output --partial "BACKINGSTORE=${test_arguments_aarray[BACKINGSTORE]}"
}

@test "(${MODULE_NAME}) function creates a project with input from Array definition" {
    TEST_PARAMS_AS_AN_AARRAY="([BASE_DIR]="/tmp/bats/add_project/test_folder/new_project_dir_function" [PROJECT_NAME]="ssg_test_project" [CONFIG_NAME]=".ssgrc"   [BACKINGSTORE]="disk" )"
    eval "declare -rA test_arguments_aarray=$TEST_PARAMS_AS_AN_AARRAY"
    run ${TEST_UNDER_EXAMINATION} "$TEST_PARAMS_AS_AN_AARRAY"
    assert_success
    assert [ -e "${test_arguments_aarray[BASE_DIR]}/${test_arguments_aarray[CONFIG_NAME]}" ]
    run cat "${test_arguments_aarray[BASE_DIR]}/${test_arguments_aarray[CONFIG_NAME]}"
    assert_output --partial "PROJECT_NAME=${test_arguments_aarray[PROJECT_NAME]}"
    assert_output --partial "BACKINGSTORE=${test_arguments_aarray[BACKINGSTORE]}"
}

@test "(${MODULE_NAME}) script.. fails if the project already exits" {
    TEST_PARAMS_AS_AN_AARRAY="([BASE_DIR]="/tmp/bats/add_project/test_folder/existing_dir_script" [PROJECT_NAME]="ssg_test_project" [CONFIG_NAME]=".ssgrc"   [BACKINGSTORE]="disk" )"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    mkdir -pv ${test_arguments[BASE_DIR]}
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_failure
}

@test "(${MODULE_NAME}) function fails if the project already exits" {
    TEST_PARAMS_AS_AN_AARRAY="([BASE_DIR]="/tmp/bats/add_project/test_folder/existing_dir_function" [PROJECT_NAME]="ssg_test_project" [CONFIG_NAME]=".ssgrc"   [BACKINGSTORE]="disk" )"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    mkdir -pv ${test_arguments[BASE_DIR]}
    run "$TEST_UNDER_EXAMINATION" "$TEST_PARAMS_AS_AN_AARRAY"
    assert_failure
}

# this functions will have access to the global VARS specified in the setup
@test "(${MODULE_NAME}) function fails without a positional paramerter" {
    run "$TEST_UNDER_EXAMINATION"
    assert_failure
}

# calling the script will deny access to the global VARS specified in the setup
@test "(${MODULE_NAME}) script.. fails without a positional paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure
}