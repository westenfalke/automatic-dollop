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

@test "(${MODULE_NAME}) function adds an ambiguos element to a polymorfic bucket" {
    declare -r  T_bucket_aarray_directory="${TEST_PROJECT_DIR}/project_dir_function"
    declare -rA T='( [element]="dohikey" [bucket]="([backingstore]="disk" [file]="backingstore.dat" [type]="wireframe" [directory]="${T_bucket_aarray_directory}")" )'
    declare -r  T_decl_auto="$(declare -p T|sed s/^declare.*T=//)" #spellcheck
    run ${TEST_UNDER_EXAMINATION} "${T_decl_auto}"
    assert_success
    eval "declare -rA T_bucket_aarray=${T[bucket]}"
    assert [ -d "${T_bucket_aarray[directory]}" ] 
    assert [ -e "${T_bucket_aarray[directory]}/${T_bucket_aarray[file]}" ] 
}

@test "(${MODULE_NAME}) script.. adds an ambiguos element to a polymorfic bucket" {
    declare -r  T_bucket_aarray_directory="${TEST_PROJECT_DIR}/project_dir_script"
    declare -rA T='( [element]="dohikey" [bucket]="([backingstore]="disk" [file]="backingstore.dat" [type]="wireframe" [directory]="${T_bucket_aarray_directory}")" )'
    declare -r  T_decl_auto="$(declare -p T|sed s/^declare.*T=//)" #spellcheck
    run ${TEST_UNDER_EXAMINATION} "${T_decl_auto}"
    assert_success
    eval "declare -rA T_bucket_aarray=${T[bucket]}"
    assert [ -d "${T_bucket_aarray[directory]}" ] 
    assert [ -e "${T_bucket_aarray[directory]}/${T_bucket_aarray[file]}" ] 
}

# this functions will have access to the global VARS specified in the setup
@test "(${MODULE_NAME}) function fails without a positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}
    assert_failure
}

# calling the script will deny access to the global VARS specified in the setup
@test "(${MODULE_NAME}) script.. fails without a positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}.bash
    assert_failure
}