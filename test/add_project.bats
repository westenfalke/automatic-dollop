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

@test "(${MODULE_NAME}) create a uniq namespace, an alias and main connfiguration" {
    declare -r namespace="${TEST_PROJECT_DIR}/new_project_namespace"
    declare -r namespace_alias='ssg_test_project'
    declare -r bucket_name='main_connfig'
    declare -r plain_text_on_disk='plain_text_on_disk'
    declare -r fqn="${namespace}/${bucket_name}"
    parameter="([NAMESPACE]='$namespace' \
                [NAMESPACE_ALIAS]='$namespace_alias' \
                [BUCKET_NAME]='$bucket_name' \
                [BACKINGSTORE]='$plain_text_on_disk' )"
    
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    assert [ -d "${namespace}" ]
    assert [ -e "${fqn}" ]
    run cat "${fqn}"
    assert_output --partial "NAMESPACE_ALIAS=${namespace_alias}"
    assert_output --partial "BACKINGSTORE=${plain_text_on_disk}"
}

@test "(${MODULE_NAME}) fails if the namespace already exits" {
    declare -r namespace="${TEST_PROJECT_DIR}/existing_project_namespace"
    declare -r namespace_alias='ssg_test_project'
    declare -r bucket_name='main_connfig'
    declare -r plain_text_on_disk='plain_text_on_disk'
    declare -r fqn="${namespace}/${bucket_name}"
    parameter="([NAMESPACE]='$namespace' \
                [NAMESPACE_ALIAS]='$namespace_alias' \
                [BUCKET_NAME]='$bucket_name' \
                [BACKINGSTORE]='$plain_text_on_disk' )"

    maybe_add_namespace.bash "$parameter"
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_failure 2

}

@test "(${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}