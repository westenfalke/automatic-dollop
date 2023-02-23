#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_and_backingstore_default_setup
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(default.${MODULE_NAME}) adds one element to a namespaced bucket" {
    declare -r bucket_namespace='full.qualified.namespace.one_element'
    declare -r bucket_name='a_namespaced_bucket'
    declare -r payload='dohikey'
    declare -r backingstore='default'
    declare -r type='wireframe'
    declare -r parameter="( [payload]='$payload' \
                                    [bucket]=\"([backingstore]='$backingstore' \
                                        [bucket_name]='$bucket_name' \
                                        [type]='$type' \
                                        [namespace]='$bucket_namespace')\" )"

    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    assert [ -d "${bucket_namespace//.//}" ] 
    assert [ -e "${bucket_namespace//.//}/${bucket_name}" ] 
    
    run cat "${bucket_namespace//.//}/${bucket_name}"
    assert_output "${payload}"

}

@test "(default.${MODULE_NAME}) adds two elements to a namespaced bucket" {
    declare -r bucket_namespace='full.qualified.namespace.two_elements'
    declare -r bucket_name='a_namespaced_bucket'
    declare -r payload='dohikey'
    declare -r backingstore='default'
    declare -r type='wireframe'
    declare -r parameter="( [payload]='$payload' \
                            [bucket]=\"([backingstore]='$backingstore' \
                                        [bucket_name]='$bucket_name' \
                                        [type]='$type' \
                                        [namespace]='$bucket_namespace')\" )"
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    assert [ -d "${bucket_namespace//.//}" ] 
    assert [ -e "${bucket_namespace//.//}/${bucket_name}" ]     
    run cat "${bucket_namespace//.//}/${bucket_name}"
    assert_output "${payload}"
    run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    assert_success
    run cat "${bucket_namespace//.//}/${bucket_name}"
    assert_output  --partial "${payload}
${payload}"    

}

@test "(default.${MODULE_NAME}) fails on calls without a paramerter" {
    run ${TEST_UNDER_EXAMINATION}.bash
    assert_failure 128
}