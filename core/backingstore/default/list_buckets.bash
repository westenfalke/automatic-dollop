#!/usr/bin/env bash
list_buckets() {
    set -o nounset
    set -o errexit
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -rA T=$@"
        eval "declare -rA T_bucket=${T[bucket]}"
        declare -r backingstore=${T_bucket[backingstore_kind]}
        printf "%s\n" "$(declare -p T)" >&2
        pushd "${T_bucket[namespace]//.//}"
        find ./ -maxdepth 1 -type f | xargs -n 1 basename
        popd >/dev/null
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"