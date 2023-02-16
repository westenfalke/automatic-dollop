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

@test "(${MODULE_NAME}) fails if backinstore is not 'plain_text_on_disk'" {
    declare -r  bucket_namespace="${TEST_PROJECT_DIR}/project_dir_inmemory"
    # left value = right value == spellchecked_right_value_of_T
    declare -rA T='( [data]="dohikey" [bucket]="([backingstore]="inmemory" [category]="backingstore.dat" [type]="wireframe" [namespace]="${bucket_namespace}")" )'
    declare -r spellchecked_right_value_of_T="$(declare -p T|sed s/^declare.*T=//)" 
    run ${TEST_UNDER_EXAMINATION} "${spellchecked_right_value_of_T}"
    assert_failure 4
    assert [ ! -d "${bucket_namespace}" ]
}

@test "(${MODULE_NAME}) adds one ambiguos element to a polymorfic bucket" {
    declare -r  bucket_namespace="${TEST_PROJECT_DIR}/project_dir_one_element"
    declare -rA T='( [data]="dohikey" [bucket]="([backingstore]="plain_text_on_disk" [category]="backingstore.dat" [type]="wireframe" [namespace]="${bucket_namespace}")" )'
    declare -r  spellchecked_right_value_of_T="$(declare -p T|sed s/^declare.*T=//)" #spellcheck
    run ${TEST_UNDER_EXAMINATION}.bash "${spellchecked_right_value_of_T}"
    assert_success
    eval "declare -rA T_bucket=${T[bucket]}"
    assert [ -d "${T_bucket[namespace]}" ] 
    assert [ -e "${T_bucket[namespace]}/${T_bucket[category]}" ] 
    
    run cat "${T_bucket[namespace]}/${T_bucket[category]}"
    assert_output "${T[data]}"

}

@test "(${MODULE_NAME}) adds two ambiguos element to a polymorfic bucket" {
    declare -r  bucket_namespace="${TEST_PROJECT_DIR}/project_dir_two_element"
    declare -rA T='( [data]="dohikey" [bucket]="([backingstore]="plain_text_on_disk" [category]="backingstore.dat" [type]="wireframe" [namespace]="${bucket_namespace}")" )'
    declare -r  spellchecked_right_value_of_T="$(declare -p T|sed s/^declare.*T=//)" #spellcheck
    eval "declare -rA T_bucket=${T[bucket]}"
    run ${TEST_UNDER_EXAMINATION}.bash "${spellchecked_right_value_of_T}"
    assert_success
    run ${TEST_UNDER_EXAMINATION}.bash "${spellchecked_right_value_of_T}"
    assert_success
    run cat "${T_bucket[namespace]}/${T_bucket[category]}"
    assert_output  --partial "${T[data]}
${T[data]}"    

}

@test "(${MODULE_NAME}) fails with exit code (128) without a positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}.bash
    assert_failure 128
}