#!/usr/bin/env bash
read_bucket() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
   else
        eval "declare -rA T=$@"
        eval "declare -rA T_bucket=${T[bucket]}"
        declare -r backingstore=${T_bucket[backingstore_kind]}
        declare -r file_name="${T_bucket[bucket_name]}"
        cat "${T_bucket[namespace]//.//}/${file_name}"
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"