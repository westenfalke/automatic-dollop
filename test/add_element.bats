#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "${TEST_UNDER_EXAMINATION}.bash"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv "${TEST_PROJECT_DIR}"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) fails if the type of backingstore is not implemented" {
    declare -r bucket_namespace="${TEST_PROJECT_DIR}/project_dir_not_implemented"
    declare -r bucket_name='a_namespaced_bucket'
    declare -r data='dohikey'
    declare -r backingstore_not_implemented='not_implemented'
    declare -r type='wireframe'
    declare -r fqn="${bucket_namespace}/${bucket_name}"
    declare -r parameter="( [data]='$data' \
                            [bucket]=\"([backingstore]='$backingstore_not_implemented' \
                                        [bucket_name]='$bucket_name' \
                                        [type]='$type' \
                                        [namespace]='$bucket_namespace')\" )"
    run ${TEST_UNDER_EXAMINATION} "$parameter"
    assert_failure 4
    assert [ ! -d "${bucket_namespace}" ]
    assert [ ! -e "${fqn}" ]
}

@test "(${MODULE_NAME}) adds one data element to a namespaced bucket" {
    declare -r bucket_namespace="${TEST_PROJECT_DIR}/namespace_one_element"
    declare -r bucket_name='a_namespaced_bucket'
    declare -r data='dohikey'
    declare -r backingstore='plain_text_on_disk'
    declare -r type='wireframe'
    declare -r fqn="${bucket_namespace}/${bucket_name}"
    declare -r parameter="( [data]='$data' \
                            [bucket]=\"([backingstore]='$backingstore' \
                                        [bucket_name]='$bucket_name' \
                                        [type]='$type' \
                                        [namespace]='$bucket_namespace')\" )"
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    assert [ -d "${bucket_namespace}" ] 
    assert [ -e "${fqn}" ] 
    
    run cat "${fqn}"
    assert_output "${data}"

}

@test "(${MODULE_NAME}) adds two data elements to a namespaced bucket" {
    declare -r bucket_namespace="${TEST_PROJECT_DIR}/namespace_two_elements"
    declare -r bucket_name='a_namespaced_bucket'
    declare -r data='dohikey'
    declare -r backingstore='plain_text_on_disk'
    declare -r type='wireframe'
    declare -r fqn="${bucket_namespace}/${bucket_name}"
    declare -r parameter="( [data]='$data' \
                            [bucket]=\"([backingstore]='$backingstore' \
                                        [bucket_name]='$bucket_name' \
                                        [type]='$type' \
                                        [namespace]='$bucket_namespace')\" )"
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    assert [ -d "${bucket_namespace}" ] 
    assert [ -e "${fqn}" ]     
    run cat "${fqn}"
    assert_output "${data}"
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    run cat "${fqn}"
    assert_output  --partial "${data}
${data}"    

}

@test "(${MODULE_NAME}) fails on calls without a paramerter" {
    run ${TEST_UNDER_EXAMINATION}.bash
    assert_failure 128
}