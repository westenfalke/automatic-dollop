#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"
setup() {
    load 'test_helper/ext-setup'
    _ext_and_backingstore_default_setup
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(backingstore.default.${MODULE_NAME}) adds a new uniq namespace" {
    TEST_PARAMS_AS_AN_AARRAY="([namespace]="full.qualified.namespace.new" \
                               [namespace_alias]="ssg_test_project" \
                               [bucket_name]="bucket" \
                               [backingstore]='default')"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_success
}

@test "(backingstore.default.${MODULE_NAME}) fails if the namespace already exits" {
    TEST_PARAMS_AS_AN_AARRAY="([namespace]="full.qualified.namespace.existing" [namespace_alias]="ssg_test_project" [bucket_name]="bucket"   [backingstore]='default')"
    eval "declare -rA test_arguments=$TEST_PARAMS_AS_AN_AARRAY"
    mkdir -pv ${test_arguments[namespace]//.//}
    run ${TEST_UNDER_EXAMINATION}.bash "$TEST_PARAMS_AS_AN_AARRAY"
    assert_failure 2
}

@test "(backingstore.default.${MODULE_NAME}) fails on calls without a paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure 128
}