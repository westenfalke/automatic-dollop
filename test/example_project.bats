#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
# TEST_UNDER_EXAMINATION: template.bash
# keep ${FUNCNAME} and 'basename' in sync
# function will be launched only if not sourced 
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
    parameter="([namesapce]='$namespace' \
                [namespace_alias]='$namespace_alias' \
                [bucket_name]='$bucket_name' \
                [backingstore]='$backingstore' )"
    
    run "add_project.bash" "$parameter"
    assert_success
}