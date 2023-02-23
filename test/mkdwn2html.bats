#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_and_backingstore_default_setup
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}->backingstore default) create html body from markdown oneliner" {
    # create a simple markdown document with just on line of text 
    # transform the document into html (body only)
    # find the text in the html document
    # !!! No syntax check, hence ths isn't a test of the transformator
    # !!! but of getting the parameter across
    
    declare -r bucket_namespace='manuel.maintained'
    declare -r bucket_name='documents'
    declare -r documents_dir="${bucket_namespace/.//}/${bucket_name}"
    mkdir -pv "${documents_dir}"
    declare -r input_file='index.md'
    declare -r oneliner='Hello westenfalke'
    printf "%s" "${oneliner}" > "${documents_dir}/${input_file}"
    declare -r metadata_file='metadata.yaml'
    touch "${documents_dir}/${metadata_file}"
    declare -r output_file='index.html'
    declare -r backingstore='default'
    declare -r type='wireframe'
    declare -r parameter="( [payload]=\"([input_file]='${input_file}' \
                                         [output_file]='${output_file}' \
                                         [metadata_file]='${metadata_file}' )\"
                            [request]='pandoc' \
                            [bucket]=\"([backingstore]='$backingstore' \
                                [bucket_name]='$bucket_name' \
                                [type]='$type' \
                                [namespace]='$bucket_namespace')\" )"

    run "${TEST_UNDER_EXAMINATION}.bash" "$parameter"
    assert_success
    run cat ${documents_dir}/${output_file}
    assert_output --partial "${oneliner}"
}

@test "(${MODULE_NAME}->backingstore default) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}