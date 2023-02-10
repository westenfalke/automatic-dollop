#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"

setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv "${TEST_PROJECT_DIR}"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) map JSON into associative array" { 
    #tbd read values from JSON file and don't use fixed values
    local -A generic_arguments
    generic_arguments+=( [hash_key]='left_value' )
    generic_arguments+=( [hash_value]='right_value' )
    generic_arguments+=( [property_names]='property_1 property_2 property_n_1 property_n' )
    generic_arguments+=( [json_file]='test/JSON2AArray.json' )
    readonly generic_arguments
    run JSON2AArray  "$(declare -p generic_arguments|sed s/declare.*generic_arguments=//)"
    assert_output '([PARAM_NAME_n]="value_n" [PARAM_NAME_n-1]="value_n-1" [PARAM_NAME_2]="value_2" [PARAM_NAME_1]="value_1" )'
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