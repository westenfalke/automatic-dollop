#!/usr/bin/env bash
add_element() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -A T=$@"
        eval "declare -rA T_bucket=${T[bucket]}"
        declare -r backingstore=${T_bucket[backingstore_kind]}
        # namespace to path, avoid leaking the path seperator as an implementaion detail      
        declare -r dir_name="${T_bucket[namespace]//.//}"
        mkdir -pv "$dir_name"
        declare -r file_name="${T_bucket[bucket_name]}"
        declare -r bucket_file_name="${dir_name}/${file_name}"
        printf "%s\n" "${T[payload]}" >> "$bucket_file_name"
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"