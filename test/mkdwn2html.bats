#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_and_backingstore_default_setup
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(backingstore.default.${MODULE_NAME}) create html body from markdown" {
   
    declare -r only_body='true'
    declare -r bucket_namespace='directory.for.user.maintained.only_body'
    declare -r bucket_name='documents'
    declare -r documents_dir="${bucket_namespace//.//}/${bucket_name}"
    mkdir -pv "$documents_dir"
    declare -r metadata_file='metadata.yaml'
    declare -r is_title_form_metadata='Test Title From Metadata'
    printf "title: %s\n" "$is_title_form_metadata" > "${documents_dir}/${metadata_file}"
    declare -r input_file='onliner.md'
    declare -r is_the_same_as_input='Test in/output prameter only.'
    printf "%s\n" "$is_the_same_as_input" > "${documents_dir}/${input_file}"
    declare -r output_file='just_one_paragraph.html'
    declare -r backingstore='default'
    declare -r type='wireframe'
    declare -r parameter="( [payload]=\"([input_file]='$input_file' \
                                         [output_file]='$output_file' \
                                         [body_only]='$only_body' \
                                         [metadata_file]='$metadata_file' )\"
                            [request]='mkdwn2html.bash' \
                            [bucket]=\"([backingstore]='$backingstore' \
                                [bucket_name]='$bucket_name' \
                                [type]='$type' \
                                [namespace]='$bucket_namespace')\" )"

    run "${TEST_UNDER_EXAMINATION}.bash" "$parameter"
    assert_success
    run cat "${documents_dir}/${output_file}"
    assert_output --partial "$is_the_same_as_input"
    refute_output --partial "$is_title_form_metadata" 
}

@test "(backingstore.default.${MODULE_NAME}) create html from markdown with a title form metadata" {
   
    declare -r complete_html
    declare -r bucket_namespace='directory.for.user.maintained.metadata'
    declare -r bucket_name='documents'
    declare -r documents_dir="${bucket_namespace//.//}/${bucket_name}"
    mkdir -pv "$documents_dir"
    declare -r metadata_file='metadata.yaml'
    declare -r is_title_form_metadata='Test Title From Metadata'
    printf "title: %s\n" "$is_title_form_metadata" > "${documents_dir}/${metadata_file}"
    declare -r input_file='onliner.md'
    declare -r is_the_same_as_input='Test in/output prameter only.'
    printf "%s\n" "$is_the_same_as_input" > "${documents_dir}/${input_file}"
    declare -r output_file='title_head_and_body.html'
    declare -r backingstore='default'
    declare -r type='wireframe'
    declare -r parameter="( [payload]=\"([input_file]='$input_file' \
                                         [output_file]='$output_file' \
                                         [body_only]='$complete_html' \
                                         [metadata_file]='$metadata_file' )\"
                            [request]='mkdwn2html.bash' \
                            [bucket]=\"([backingstore]='$backingstore' \
                                [bucket_name]='$bucket_name' \
                                [type]='$type' \
                                [namespace]='$bucket_namespace')\" )"

    run "${TEST_UNDER_EXAMINATION}.bash" "$parameter"
    assert_success
    run cat ${documents_dir}/${output_file}
    assert_output --partial "${is_the_same_as_input}"
    assert_output --partial "${is_title_form_metadata}" 
}

@test "(backingstore.default.${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}