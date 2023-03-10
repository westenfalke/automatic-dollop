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

@test "(backingstore.default.${MODULE_NAME}) list buckets in full qualified a namespace" {
    declare -r namespace="full.qualified.namespace"
    declare -r namespace_alias='ssg_test_project'
    declare -r backingstore='default'
    declare -ra buckets=( bucket_00 bucket_01 bucket_02 )
 
    run add_project.bash "([namespace]='$namespace' \
                            [namespace_alias]='$namespace_alias' \
                            [bucket_name]='${buckets[0]}' \
                            [backingstore]='$backingstore' )"
    assert_success
    add_element.bash "([payload]='foo=bar' \
                        [bucket]=\"( \
                            [backingstore]='$backingstore' \
                            [bucket_name]='${buckets[1]}' \
                            [type]='wireframe' \
                            [namespace]='$namespace')\" )"    
    assert_success
    add_element.bash "([payload]='bat=baz' \
                        [bucket]=\"( \
                            [backingstore]='$backingstore' \
                            [bucket_name]='${buckets[2]}' \
                            [type]='wireframe' \
                            [namespace]='$namespace')\" )"    
    assert_success
    run "${TEST_UNDER_EXAMINATION}.bash" "([payload]='cmd=list' \
                                            [bucket]=\"( \
                                                [backingstore]='$backingstore' \
                                                [bucket_name]='*' \
                                                [type]='wireframe' \
                                                [namespace]='$namespace')\" )"    
    assert_success
    for bucket in ${buckets[@]}; do
        assert_output --partial "$bucket"
    done
    assert_output --partial "${buckets[1]}"
    assert_output --partial "${buckets[2]}"
}

@test "(backingstore.default.${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash" 
    assert_failure 128
}