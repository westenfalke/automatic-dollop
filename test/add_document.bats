#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_and_backingstore_default_setup

    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(cli.${MODULE_NAME} backingstore='default') add a document to a document_dir " {

    declare -r document_dir='user.maintained.documents'
    declare -r namespace_alias='document_dir'
    declare -r backingstore='default'
    declare -r document_file_name='index.md'
    declare -r source_document_file_name='content_to_add.md'
    printf -v document_content "%s\n" "Document Content" # replace  with heredocument
    readonly document_content
    printf "%s" "$document_content" > "$source_document_file_name"
    declare -r type='wireframe'
    declare -r added_document="${document_dir//.//}/${document_file_name}"
    declare -r parameter="( [payload]='$document_content' \
                            [bucket]=\"([backingstore]='$backingstore' \
                                        [namespace]='$document_dir' \
                                        [bucket_name]='$document_file_name' \
                                        [namespace_alias]='$namespace_alias' \
                                        [type]='$type' )\" )"
    run "${TEST_UNDER_EXAMINATION}.bash" "$parameter"
    assert_success
    run diff "$source_document_file_name" "$added_document" # replace with maybe_document_exist & read_document
    assert_success
}

@test "(cli.${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}

