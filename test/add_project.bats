#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"

setup() {
    load 'test_helper/ext-setup'
    _ext_and_backingstore_default_setup

    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(cli.${MODULE_NAME} backingstore='default') create a uniq directory, an alias and configuration file" {
    declare -r project_dir='project.dir.new'
    declare -r namespace_alias='ssg_test_project'
    declare -r bucket_name='main.config'
    declare -r backingstore='default'
    parameter="([namespace]='$project_dir' \
                [namespace_alias]='$namespace_alias' \
                [bucket_name]='$bucket_name' \
                [backingstore]='$backingstore' )"
    
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    assert [ -d "${project_dir//.//}" ]
    assert [ -e "${project_dir//.//}/${bucket_name}" ]
    run cat "${project_dir//.//}/${bucket_name}"
    assert_output --partial "namespace_alias=${namespace_alias}"
    assert_output --partial "backingstore=${default}"
}

@test "(cli.${MODULE_NAME} backingstore='default') fails if the project_dir already exits" {
    declare -r project_dir='project.dir.existing'
    declare -r namespace_alias='ssg_test_project'
    declare -r bucket_name='main.config'
    declare -r backingstore='default'
    parameter="([namespace]='$project_dir' \
                [namespace_alias]='$namespace_alias' \
                [bucket_name]='$bucket_name' \
                [backingstore]='$backingstore' )"

    maybe_add_namespace.bash "$parameter"
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_failure 2
}

@test "(cli.${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}