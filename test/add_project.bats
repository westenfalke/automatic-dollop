#!/usr/bin/env bats

getParameter() {
    args_as_json="$(cat test_params.json)"
    declare -A test_arguments
    eval "test_arguments+=( [$(jq '.parameter.base_dir'     <<< "$args_as_json")]=$(jq '.defaults.base_dir'     <<< "$args_as_json"))"
    eval "test_arguments+=( [$(jq '.parameter.backingstore' <<< "$args_as_json")]=$(jq '.defaults.backingstore' <<< "$args_as_json"))"
    eval "test_arguments+=( [$(jq '.parameter.project_name' <<< "$args_as_json")]=$(jq '.defaults.project_name' <<< "$args_as_json"))"
    eval "test_arguments+=( [$(jq '.parameter.config_name'  <<< "$args_as_json")]=$(jq '.defaults.config_name'  <<< "$args_as_json"))"
    readonly test_arguments
    printf "%s\n" "$(declare -p test_arguments|sed s/declare.*test_arguments=//)"
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


@test "the backingstore for the project is configured" {
    TEST_PARAMS_AS_AN_AARRAY="$(getParameter)"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    assert [ -e "${test_arguments[BASE_DIR]}/${test_arguments[CONFIG_NAME]}" ]
    run cat "${test_arguments[BASE_DIR]}/${test_arguments[CONFIG_NAME]}"
    assert_output --partial "PROJECT_NAME=${test_arguments[PROJECT_NAME]}"
    assert_output --partial "BACKINGSTORE=${test_arguments[BACKINGSTORE]}"
}

@test 'script fails if the project dir already exits' {
    TEST_PARAMS_AS_AN_AARRAY="$(getParameter)"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_failure
}

@test 'function fails if project dir already exits' {
    TEST_PARAMS_AS_AN_AARRAY="$(getParameter)"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    run ${TEST_UNDER_EXAMINATION} "$TEST_PARAMS_AS_AN_AARRAY"
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