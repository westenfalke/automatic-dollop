#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
source JSON2AArray.bash

getParameter() {
    local -A generic_arguments
    generic_arguments+=( [hash_key]='parameter' )
    generic_arguments+=( [hash_value]='defaults' )
    generic_arguments+=( [property_names]='base_dir backingstore project_name config_name' )
    generic_arguments+=( [json_file]='test/add_project.json' )
    readonly generic_arguments
    JSON2AArray  "$(declare -p generic_arguments|sed s/declare.*generic_arguments=//)"
}

setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"

    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv ${TEST_PROJECT_DIR}
        TEST_PARAMS_AS_AN_AARRAY="$(getParameter)"
        eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
        run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) script.. creates a project" {
    TEST_PARAMS_AS_AN_AARRAY="$(getParameter)"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    assert [ -e "${test_arguments[BASE_DIR]}/${test_arguments[CONFIG_NAME]}" ]
    run cat "${test_arguments[BASE_DIR]}/${test_arguments[CONFIG_NAME]}"
    assert_output --partial "PROJECT_NAME=${test_arguments[PROJECT_NAME]}"
    assert_output --partial "BACKINGSTORE=${test_arguments[BACKINGSTORE]}"
}

@test "(${MODULE_NAME}) script.. fails if the project already exits" {
    TEST_PARAMS_AS_AN_AARRAY="$(getParameter)"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_failure
}

@test "(${MODULE_NAME}) function fails if the project already exits" {
    TEST_PARAMS_AS_AN_AARRAY="$(getParameter)"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
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