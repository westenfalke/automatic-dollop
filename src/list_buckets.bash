#!/usr/bin/env bash
list_buckets() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -rA T=$@"
        eval "declare -rA T_bucket=${T[bucket]}"
        declare -r backingstore=${T_bucket[backingstore]}
        if [[ "$backingstore" == "plain_text_on_disk" ]] ; then
            printf "%s\n" "$(declare -p T)" >&2
            pushd "${T_bucket[namespace]//.//}"
            find ./ -maxdepth 1 -type f | xargs -n 1 basename
            popd >/dev/null
            exit 1
        else
            printf "Backingstore type '%s' not yet implemented" "${backingstore}" >&2
            exit 4
        fi
    fi

}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"