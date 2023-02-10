#!/usr/bin/env bash
# keep ${FUNCNAME} and 'basename' in sync
# function will be launched only if not sourced 
add_element() {
    set -o nounset
    eval "declare -A add_element_arguments=$@"
    eval "declare -rA add_element_bucket_aarray=${add_element_arguments[bucket]}"
    mkdir -pv "${add_element_bucket_aarray[directory]}"
    touch "${add_element_bucket_aarray[directory]}/${add_element_bucket_aarray[file]}"
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"