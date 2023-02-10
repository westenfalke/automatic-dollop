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
    declare -r  ambiguos_element_description="element"
    declare -r  polymorfic_bucket_description="bucket"
    declare -r  an_ambiguos_element_object="doohickey"
    declare -r  bucket_dir="${TEST_PROJECT_DIR}/project_dir_function"
    declare -rA a_polymorfic_bucket_implementation_aarray='([backingstore]="disk" [file]="backingstore.dat" [type]="wireframe" [directory]="${bucket_dir}")'
    declare -r  a_polymorfic_bucket_implementation_declaration=$(declare -p a_polymorfic_bucket_implementation_aarray|sed s/^declare.*a_polymorfic_bucket_implementation_aarray=//)
    declare -r  parameter_declaration='( [$ambiguos_element_description]="$an_ambiguos_element_object" [$polymorfic_bucket_description]="$a_polymorfic_bucket_implementation_declaration" )'
    eval "declare -rA parameter_aarray=$parameter_declaration"
    parameter="$(declare -p parameter_aarray|sed s/^declare.*parameter_aarray=//)"
    run ${TEST_UNDER_EXAMINATION} "${parameter}"
    assert_success
    eval "declare -rA bucket_aarray=${parameter_aarray[bucket]}"
    assert [ -d "${bucket_aarray[directory]}" ] 
    assert [ -e "${bucket_aarray[directory]}/${bucket_aarray[file]}" ] 
}

@test "(${MODULE_NAME}) script.. adds an ambiguos element to a polymorfic bucket" {
    declare -r  ambiguos_element_description="element"
    declare -r  polymorfic_bucket_description="bucket"
    declare -r  an_ambiguos_element_object="doohickey"
    declare -r  bucket_dir="${TEST_PROJECT_DIR}/project_dir_script"
    declare -rA a_polymorfic_bucket_implementation_aarray='([backingstore]="disk" [file]="backingstore.dat" [type]="wireframe" [directory]="${bucket_dir}")'
    declare -r  a_polymorfic_bucket_implementation_declaration=$(declare -p a_polymorfic_bucket_implementation_aarray|sed s/^declare.*a_polymorfic_bucket_implementation_aarray=//)
    declare -r  parameter_declaration='( [$ambiguos_element_description]="$an_ambiguos_element_object" [$polymorfic_bucket_description]="$a_polymorfic_bucket_implementation_declaration" )'
    eval "declare -rA parameter_aarray=$parameter_declaration"
    parameter="$(declare -p parameter_aarray|sed s/^declare.*parameter_aarray=//)"
    run "${TEST_UNDER_EXAMINATION}.bash" "${parameter}"
    assert_success
    eval "declare -rA bucket_aarray=${parameter_aarray[bucket]}"
    assert [ -d "${bucket_aarray[directory]}" ] 
    assert [ -e "${bucket_aarray[directory]}/${bucket_aarray[file]}" ] 
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