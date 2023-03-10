#!/usr/bin/env bash
backingstore() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -A T=$@"
        eval "declare -rA T_bucket=${T[bucket]}"
        declare -r backingstore=${T_bucket[backingstore]}    
        declare -r backingstore_path="$( dirname "${BASH_SOURCE[0]}" )/backingstore/${backingstore}"
        printf -v cmd "%s/%s" "$backingstore_path" "${T[request]}"
        if [[ -e "$cmd" ]] ; then
            "${cmd}" "$@"
        else
            exit 4
        fi
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"