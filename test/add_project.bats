#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"

JSON2Array() {
# ARGS $@ generic example
# JASON2Array_ARGS+=( [hash_key]='<left_value>' )
# JASON2Array_ARGS+=( [hash_value]='<right_value>' )
# JASON2Array_ARGS+=( [property_names]='<property_1> <property_2> ... <property_n-1> <property_n>' )
# JASON2Array_ARGS+=( [json_file]='<filename>' )
#
# ARGS $@ specific example
# JASON2Array_ARGS+=( [hash_key]='parameter' )
# JASON2Array_ARGS+=( [hash_value]='defaults' )
# JASON2Array_ARGS+=( [property_names]='base_dir backingstore project_name config_name' )
# JASON2Array_ARGS+=( [json_file]='test_params.json' )
#
# Array genecric Result
# Array+=( [PARAM_NAME_1]='<value_1>' )
# Array+=( [PARAM_NAME_2]='<value_2>' )
# Array+=( [...]='<...>' )
# Array+=( [PARAM_NAME_n-1]='<value_n-1>' )
# Array+=( [PARAM_NAME_n]='<value_n>' )
#
# Array specific Result
# Array+=[BASE_DIR]="/tmp/bats/add_project/test_folder/foo" 
# Array+=[PROJECT_NAME]="ssg_test_project" 
# Array+=[CONFIG_NAME]=".ssgrc" [BACKINGSTORE]="disk" 
#
# JSON generic json_file
# {
#     "left_value": {
#       "property_1": "PARAM_NAME_1",
#       "property_2": "PARAM_NAME_2",
#       "property...": "...",
#       "property_n-1": "PARAM_NAME_n-1",
#       "property_n": "PARAM_NAME_n"
#       },
#     "right_value": {
#       "property_1": "value_1",
#       "property_2": "value_2",
#       "property...": "...",
#       "property_n-1": "value_n-1",
#       "property_n": "value_n"
#       }
# }
#
# JSON specific json_file
# {
#   "parameter": {
#       "base_dir": "BASE_DIR",
#       "backingstore": "BACKINGSTORE",
#       "project_name": "PROJECT_NAME",
#       "config_name": "CONFIG_NAME"
#       },
#     "defaults": {
#       "base_dir": "/tmp/bats/add_project/test_folder/foo",
#       "backingstore": "disk",
#       "project_name": "ssg_test_project",
#       "config_name": ".ssgrc"
#       }
# }
#

    eval "declare -rA JASON2Array_ARGS=$@"
    declare -p JASON2Array_ARGS >&2
    args_as_json="$(cat "${JASON2Array_ARGS[json_file]}")"
    declare -A test_arguments
    for property_name in ${JASON2Array_ARGS[property_names]} ; do
        eval "test_arguments+=( [$(jq .${JASON2Array_ARGS[hash_key]}.${property_name} <<< "$args_as_json")]=$(jq .${JASON2Array_ARGS[hash_value]}.${property_name} <<< "$args_as_json"))"
    done
    readonly test_arguments
    printf "%s\n" "$(declare -p test_arguments|sed s/declare.*test_arguments=//)"
}

getParameter() {
    local -A generic_arguments
    generic_arguments+=( [hash_key]='parameter' )
    generic_arguments+=( [hash_value]='defaults' )
    generic_arguments+=( [property_names]='base_dir backingstore project_name config_name' )
    generic_arguments+=( [json_file]='test_params.json' )
    readonly generic_arguments
    declare -p generic_arguments >&2

    JSON2Array  "$(declare -p generic_arguments|sed s/declare.*generic_arguments=//)"
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