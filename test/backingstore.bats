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

@test "(${MODULE_NAME}) fails if the type of backingstore is not implemented" {
    declare -r bucket_namespace='namespace.not_implemented'
    declare -r bucket_name='a_namespaced_bucket'
    declare -r payload='dohikey'
    declare -r backingstore_not_implemented='not_implemented'
    declare -r type='wireframe'
    declare -r fqn="${bucket_namespace}/${bucket_name}"
    declare -r parameter="( [payload]='$payload' \
                            [request]='${TEST_UNDER_EXAMINATION}.bash' \
                            [bucket]=\"([backingstore_kind]='$backingstore_not_implemented' \
                                        [bucket_name]='$bucket_name' \
                                        [type]='$type' \
                                        [namespace]='$bucket_namespace')\" )"
    
    run backingstore.bash "$parameter"
    assert_failure 4
    assert [ ! -d "${bucket_namespace}" ]
    assert [ ! -e "${fqn}" ]
}

@test "(${MODULE_NAME}) adds one element to a namespaced bucket" {
    declare -r bucket_namespace='full.qualified.namespace.one_element'
    declare -r bucket_name='a_namespaced_bucket'
    declare -r payload='dohikey'
    declare -r backingstore='default'
    declare -r type='wireframe'
    declare -r parameter="( [payload]='$payload' \
                                    [request]='add_element.bash' \
                                    [bucket]=\"([backingstore_kind]='$backingstore' \
                                        [bucket_name]='$bucket_name' \
                                        [type]='$type' \
                                        [namespace]='$bucket_namespace')\" )"

    run backingstore.bash "$parameter"
    assert_success
    assert [ -d "${bucket_namespace//.//}" ] 
    assert [ -e "${bucket_namespace//.//}/${bucket_name}" ] 
    
    run cat "${bucket_namespace//.//}/${bucket_name}"
    assert_output "${payload}"

}

@test "(${MODULE_NAME}) adds two elements to a namespaced bucket" {
    declare -r bucket_namespace='full.qualified.namespace.two_elements'
    declare -r bucket_name='a_namespaced_bucket'
    declare -r payload='dohikey'
    declare -r backingstore='default'
    declare -r type='wireframe'
    declare -r parameter="( [payload]='$payload' \
                            [request]='add_element.bash' \
                            [bucket]=\"([backingstore_kind]='$backingstore' \
                                        [bucket_name]='$bucket_name' \
                                        [type]='$type' \
                                        [namespace]='$bucket_namespace')\" )"
    : run ${TEST_UNDER_EXAMINATION}.bash "$parameter"
    run backingstore.bash "$parameter"
    assert_success
    assert [ -d "${bucket_namespace//.//}" ] 
    assert [ -e "${bucket_namespace//.//}/${bucket_name}" ]     
    run cat "${bucket_namespace//.//}/${bucket_name}"
    assert_output "${payload}"
    run backingstore.bash "$parameter"
    assert_success
    run cat "${bucket_namespace//.//}/${bucket_name}"
    assert_output  --partial "${payload}
${payload}"    

}

@test "(${MODULE_NAME}) fails on calls without a paramerter" {
    run ${TEST_UNDER_EXAMINATION}.bash
    assert_failure 128
}