#!/usr/bin/env bash
maybe_add_namespace() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -A T=$@"
        declare -r backingstore="${T[backingstore]}"
        declare -r project_directory="${T[namespace]//.//}"              
        if [[ -e "$project_directory" ]]; then
            exit 2
        else
            mkdir -pv "$project_directory"
            printf "%s" "$@"
        fi
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"