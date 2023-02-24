#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_and_backingstore_default_setup
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(backingstore.default.${MODULE_NAME}) create html body from markdown is_the_same_as_input" {
   
    declare -r bucket_namespace='directory.for.user.maintained'
    declare -r bucket_name='documents'
    declare -r documents_dir="${bucket_namespace//.//}/${bucket_name}"
    mkdir -pv "${documents_dir}"
    declare -r input_file='index.md'
    declare -r is_the_same_as_input='Test in/output prameter only.'
    printf "%s\n" "${is_the_same_as_input}" > "${documents_dir}/${input_file}"
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
    assert_output --partial "${is_the_same_as_input}"
}

@test "(backingstore.default.${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}