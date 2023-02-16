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
    declare -r namespace="${TEST_PROJECT_DIR}/new_project_namespace"
    declare -r project_name='ssg_test_project'
    declare -r config_file='.ssgrc'
    declare -r plain_text_on_disk='plain_text_on_disk'
    declare -r fqn="${namespace}/${config_file}"
    parameter="([NAMESPACE]='$namespace' \
                [PROJECT_NAME]='$project_name' \
                [CATEGORY_NAME]='$config_file' \
                [BACKINGSTORE]='$plain_text_on_disk' )"
    
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    assert [ -d "${namespace}" ]
    assert [ -e "${fqn}" ]
    run cat "${fqn}"
    assert_output --partial "PROJECT_NAME=${project_name}"
    assert_output --partial "BACKINGSTORE=${plain_text_on_disk}"
}

@test "(${MODULE_NAME}) fails if the project within the namespace already exits" {
    declare -r namespace="${TEST_PROJECT_DIR}/existing_project_namespace"
    declare -r project_name='ssg_test_project'
    declare -r config_file='.ssgrc'
    declare -r plain_text_on_disk='plain_text_on_disk'
    declare -r fqn="${namespace}/${config_file}"
    parameter="([NAMESPACE]='$namespace' \
                [PROJECT_NAME]='$project_name' \
                [CATEGORY_NAME]='$config_file' \
                [BACKINGSTORE]='$plain_text_on_disk' )"

    maybe_add_namespace.bash "$parameter"
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_failure 2

}

@test "(${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}