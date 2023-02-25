#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_and_backingstore_default_setup

    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME} backingstore='default') create config for a new website project" {

    declare -r namespace='single.site.project'
    declare -r namespace_alias='ssp'
    declare -r bucket_name='main.config'
    declare -r backingstore='default'
    parameter="([namespace]='$namespace' \
                [namespace_alias]='$namespace_alias' \
                [bucket_name]='$bucket_name' \
                [backingstore]='$backingstore' )"
    
    run "add_project.bash" "$parameter"
    assert_success
}