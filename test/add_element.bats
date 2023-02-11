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
    declare -r  bucket_dir="${TEST_PROJECT_DIR}/project_dir_function"
    declare -rA param_aarray='( [element]="dohikey" [bucket]="([backingstore]="disk" [file]="backingstore.dat" [type]="wireframe" [directory]="${bucket_dir}")" )'
    declare -r  param_decl_auto="$(declare -p param_aarray|sed s/^declare.*param_aarray=//)" #spellcheck
    run ${TEST_UNDER_EXAMINATION} "${param_decl_auto}"
    assert_success
    eval "declare -rA params_bucket_aarray=${param_aarray[bucket]}"
    assert [ -d "${params_bucket_aarray[directory]}" ] 
    assert [ -e "${params_bucket_aarray[directory]}/${params_bucket_aarray[file]}" ] 
}

@test "(${MODULE_NAME}) script.. adds an ambiguos element to a polymorfic bucket" {
    declare -r  bucket_dir="${TEST_PROJECT_DIR}/project_dir_script"
    declare -rA param_aarray='( [element]="dohikey" [bucket]="([backingstore]="disk" [file]="backingstore.dat" [type]="wireframe" [directory]="${bucket_dir}")" )'
    declare -r  param_decl_auto="$(declare -p param_aarray|sed s/^declare.*param_aarray=//)" #spellcheck
    run ${TEST_UNDER_EXAMINATION} "${param_decl_auto}"
    assert_success
    eval "declare -rA params_bucket_aarray=${param_aarray[bucket]}"
    assert [ -d "${params_bucket_aarray[directory]}" ] 
    assert [ -e "${params_bucket_aarray[directory]}/${params_bucket_aarray[file]}" ] 
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