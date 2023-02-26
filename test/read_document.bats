#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_and_backingstore_default_setup

    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(backingstore.default.${MODULE_NAME}) read a documents content a directory" {

    declare -r document_dir='user.maintained.documents'
    declare -r namespace_alias='document_dir'
    declare -r backingstore='default'
    declare -r document_file_name='index.md'
    declare -r source_document_file_name='content_to_add.md'
    printf -v document_content "%s" "Document Content" # replace  with heredocument
    readonly document_content
    declare -r no_document_content=''
    printf "%s" "$document_content" > "$source_document_file_name"
    declare -r type='wireframe'
    declare -r document_declaration="( [payload]='$no_document_content' \
                                        [bucket]=\"([backingstore]='$backingstore' \
                                            [namespace]='$document_dir' \
                                            [bucket_name]='$document_file_name' \
                                            [namespace_alias]='$namespace_alias' \
                                            [type]='$type' )\" )"
    eval "declare -A document_request=$document_declaration"
    document_request[payload]="$document_content"
    declare -r document_data_request_declaration="$(declare -p document_request|sed 's/^.*document_request=//')"
    run "add_document.bash" "$document_data_request_declaration"
    assert_success
    document_request[payload]="$no_document_content"
    declare -r document_date_result_declaration="$("${TEST_UNDER_EXAMINATION}.bash" "$(declare -p document_request|sed 's/^.*document_request=//')")"
    eval "declare -rA document_data_result=$document_date_result_declaration"
    assert [ "$document_content" == "${document_data_result[payload]}" ]
}

@test "(backingstore.default.${MODULE_NAME}) fails on calls without a parameter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}

