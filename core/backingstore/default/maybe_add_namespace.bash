#!/usr/bin/env bash
maybe_add_namespace() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -A T=$@"
        declare -r backingstore="${T[backingstore]}"
        declare -r project_directory="${T[namesapce]//.//}"              
        if [[ -e "$project_directory" ]]; then
            # thing about returning an alternative namespace
            exit 2
        else
            mkdir -pv "$project_directory"
            printf "%s" "$@"
        fi
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"