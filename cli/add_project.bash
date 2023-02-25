#!/usr/bin/env bash
add_project() {
    set -o nounset
    set -o errexit
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -A project=$@"
        project[bucket]="(  [backingstore]='${project[backingstore]}' \
                            [bucket_name]='${project[bucket_name]}' \
                            [type]='wireframe' \
                            [namespace]='${project[namespace]}' )"
        
        project[payload]="n.a."
        project[request]="maybe_add_namespace.bash"
        backingstore.bash "$(declare -p project|sed 's/^.*project=//')"
        
        project[payload]="backingstore=${project[backingstore]}"
        project[request]="add_element.bash"
        backingstore.bash "$(declare -p project|sed 's/^.*project=//')"

        project[payload]="namespace_alias=${project[namespace_alias]}"
        project[request]="add_element.bash"
        backingstore.bash "$(declare -p project|sed 's/^.*project=//')"

    fi
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"