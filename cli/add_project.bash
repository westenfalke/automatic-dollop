#!/usr/bin/env bash
add_project() {
    set -o nounset
    set -o errexit
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        maybe_add_namespace.bash "$@"
        eval "declare -rA project=$@"
        add_element.bash "([payload]='backingstore=${project[backingstore]}' \
                            [bucket]=\"( \
                                [backingstore]='${project[backingstore]}' \
                                [bucket_name]='${project[bucket_name]}' \
                                [type]='wireframe' \
                                [namespace]='${project[namesapce]}')\" )"    
        add_element.bash "([payload]='namespace_alias=${project[namespace_alias]}' \
                            [bucket]=\"( \
                                [backingstore]='${project[backingstore]}' \
                                [bucket_name]='${project[bucket_name]}' \
                                [type]='wireframe' \
                                [namespace]='${project[namesapce]}')\" )"    
    fi
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"