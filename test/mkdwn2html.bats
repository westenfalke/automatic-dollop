#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) create html body from markdown oneliner " {
    # create a simple markdown document with just on line of text 
    # transform the document into html (body only)
    # find the text in the html document
    # !!! No syntax check, hence ths isn't a test of the transformator
    # !!! but of getting the parameter across  
    run "${TEST_UNDER_EXAMINATION}.bash" "$parameter"
    assert_success
}

@test "(${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}