#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"

setup() {
    load 'test_helper/ext-setup'
    _ext_setup

    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv ${TEST_PROJECT_DIR}
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) create a uniq namespace, an alias and main configuration" {
    declare -r namespace='full.qualified.namespace.project_new'
    declare -r namespace_alias='ssg_test_project'
    declare -r bucket_name='main_config'
    declare -r plain_text_on_disk='plain_text_on_disk'
    parameter="([namesapce]='$namespace' \
                [namespace_alias]='$namespace_alias' \
                [bucket_name]='$bucket_name' \
                [backingstore]='$plain_text_on_disk' )"
    
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    assert [ -d "${namespace//.//}" ]
    assert [ -e "${namespace//.//}/${bucket_name}" ]
    run cat "${namespace//.//}/${bucket_name}"
    assert_output --partial "namespace_alias=${namespace_alias}"
    assert_output --partial "backingstore=${plain_text_on_disk}"
}

@test "(${MODULE_NAME}) fails if the namespace already exits" {
    declare -r namespace='full.qualified.namespace.project_existing'
    declare -r namespace_alias='ssg_test_project'
    declare -r bucket_name='main_config'
    declare -r plain_text_on_disk='plain_text_on_disk'
    parameter="([namesapce]='$namespace' \
                [namespace_alias]='$namespace_alias' \
                [bucket_name]='$bucket_name' \
                [backingstore]='$plain_text_on_disk' )"

    maybe_add_namespace.bash "$parameter"
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_failure 2
}

@test "(${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}