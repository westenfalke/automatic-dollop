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

@test "(${MODULE_NAME}) function fails if backinstore is not 'plain_text_on_disk'" {
    declare -r  bucket_directory="${TEST_PROJECT_DIR}/project_dir_inmemory"
    # left value = right value == spellchecked_right_value_of_T
    declare -rA T='( [data]="dohikey" [bucket]="([backingstore]="inmemory" [file]="backingstore.dat" [type]="wireframe" [directory]="${bucket_directory}")" )'
    declare -r spellchecked_right_value_of_T="$(declare -p T|sed s/^declare.*T=//)" 
    run ${TEST_UNDER_EXAMINATION} "${spellchecked_right_value_of_T}"
    assert_failure 4
    assert [ ! -d "${bucket_directory}" ]
}

@test "(${MODULE_NAME}) function adds an ambiguos element to a polymorfic bucket" {
    declare -r  bucket_directory="${TEST_PROJECT_DIR}/project_dir_function"
    # left value = right value == spellchecked_right_value_of_T
    declare -rA T='( [data]="dohikey" [bucket]="([backingstore]="plain_text_on_disk" [file]="backingstore.dat" [type]="wireframe" [directory]="${bucket_directory}")" )'
    declare -r  spellchecked_right_value_of_T="$(declare -p T|sed s/^declare.*T=//)" #spellcheck
    run ${TEST_UNDER_EXAMINATION}.bash "${spellchecked_right_value_of_T}"
    assert_success
    eval "declare -rA T_bucket=${T[bucket]}"
    assert [ -d "${T_bucket[directory]}" ] 
    assert [ -e "${T_bucket[directory]}/${T_bucket[file]}" ] 
    
    run cat "${T_bucket[directory]}/${T_bucket[file]}"
    assert_output --partial "${T[data]}"
    
    run ${TEST_UNDER_EXAMINATION}.bash "${spellchecked_right_value_of_T}"
    assert_success
    run cat "${T_bucket[directory]}/${T_bucket[file]}"
    assert_output  "${T[data]}
${T[data]}"    

}

@test "(${MODULE_NAME}) script.. adds an ambiguos element to a polymorfic bucket" {
    declare -r  bucket_directory="${TEST_PROJECT_DIR}/project_dir_script"
    declare -rA T='( [data]="dohikey" [bucket]="([backingstore]="plain_text_on_disk" [file]="backingstore.dat" [type]="wireframe" [directory]="${bucket_directory}")" )'
    declare -r  spellchecked_right_value_of_T="$(declare -p T|sed s/^declare.*T=//)" #spellcheck
    run ${TEST_UNDER_EXAMINATION}.bash "${spellchecked_right_value_of_T}"
    assert_success
    eval "declare -rA T_bucket=${T[bucket]}"
    assert [ -d "${T_bucket[directory]}" ] 
    assert [ -e "${T_bucket[directory]}/${T_bucket[file]}" ] 
    
    run cat "${T_bucket[directory]}/${T_bucket[file]}"
    assert_output --partial "${T[data]}"
    
    run ${TEST_UNDER_EXAMINATION}.bash "${spellchecked_right_value_of_T}"
    assert_success
    run cat "${T_bucket[directory]}/${T_bucket[file]}"
    assert_output  "${T[data]}
${T[data]}"    

}

# this functions will have access to the global VARS specified in the setup
@test "(${MODULE_NAME}) function fails with exit code (1) without a positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}
    assert_failure
}

# calling the script will deny access to the global VARS specified in the setup
@test "(${MODULE_NAME}) script.. fails with exit code (1) without a positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}.bash
    assert_failure
}