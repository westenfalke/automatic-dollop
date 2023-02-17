#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
# TEST_UNDER_EXAMINATION: template.bash
# keep ${FUNCNAME} and 'basename' in sync
# function will be launched only if not sourced 
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) list buckets in full qualified a namespace" {
    declare -r namespace="namespace"
    declare -r namespace_alias='ssg_test_project'
    declare -r plain_text_on_disk='plain_text_on_disk'
    declare -ra buckets=( bucket_00 bucket_01 bucket_02 )
 
    run add_project.bash "([namesapce]='$namespace' \
                            [namespace_alias]='$namespace_alias' \
                            [bucket_name]='${buckets[0]}' \
                            [backingstore]='$plain_text_on_disk' )"
    assert_success
    add_element.bash "([data]='foo=bar' \
                        [bucket]=\"( \
                            [backingstore]='${plain_text_on_disk}' \
                            [bucket_name]='${buckets[1]}' \
                            [type]='wireframe' \
                            [namespace]='${namespace}')\" )"    
    assert_success
    add_element.bash "([data]='bat=baz' \
                        [bucket]=\"( \
                            [backingstore]='${plain_text_on_disk}' \
                            [bucket_name]='${buckets[2]}' \
                            [type]='wireframe' \
                            [namespace]='${namespace}')\" )"    
    assert_success
    run "${TEST_UNDER_EXAMINATION}.bash" "([data]='cmd=list' \
                                            [bucket]=\"( \
                                                [backingstore]='${plain_text_on_disk}' \
                                                [bucket_name]='*' \
                                                [type]='wireframe' \
                                                [namespace]='${namespace}')\" )"    
    for bucket in ${buckets[@]}; do
        assert_output --partial "$bucket"
    done
    assert_output --partial "${buckets[1]}"
    assert_output --partial "${buckets[2]}"
}

@test "(${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash" 
    assert_failure 128
}