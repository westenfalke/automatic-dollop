#!/usr/bin/env bash
add_project() {
    set -o nounset
    set -e
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -rA project=$@"
        maybe_add_namespace.bash "$@"
        add_element.bash "([data]='BACKINGSTORE=${project[BACKINGSTORE]}' \
                            [bucket]=\"( \
                                [backingstore]='${project[BACKINGSTORE]}' \
                                [category]='${project[CATEGORY_NAME]}' \
                                [type]='wireframe' \
                                [namespace]='${project[NAMESPACE]}')\" )"    
        add_element.bash "([data]='PROJECT_NAME=${project[PROJECT_NAME]}' \
                            [bucket]=\"( \
                                [backingstore]='${project[BACKINGSTORE]}' \
                                [category]='${project[CATEGORY_NAME]}' \
                                [type]='wireframe' \
                                [namespace]='${project[NAMESPACE]}')\" )"    
    fi
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"