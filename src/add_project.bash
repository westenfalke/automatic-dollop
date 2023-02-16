#!/usr/bin/env bash
add_project() {
    set -o nounset
    set -o errexit
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        maybe_add_namespace.bash "$@"
        eval "declare -rA project=$@"
        add_element.bash "([data]='BACKINGSTORE=${project[BACKINGSTORE]}' \
                            [bucket]=\"( \
                                [backingstore]='${project[BACKINGSTORE]}' \
                                [bucket_name]='${project[BUCKET_NAME]}' \
                                [type]='wireframe' \
                                [namespace]='${project[NAMESPACE]}')\" )"    
        add_element.bash "([data]='NAMESPACE_ALIAS=${project[NAMESPACE_ALIAS]}' \
                            [bucket]=\"( \
                                [backingstore]='${project[BACKINGSTORE]}' \
                                [bucket_name]='${project[BUCKET_NAME]}' \
                                [type]='wireframe' \
                                [namespace]='${project[NAMESPACE]}')\" )"    
    fi
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"