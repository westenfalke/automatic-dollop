#!/usr/bin/env bash
add_element() {
    set -o nounset
    eval "declare -A T=$@"
    eval "declare -rA T_bucket=${T[bucket]}"
    declare -r T_dir_name="${T_bucket[directory]}"
    mkdir -pv "$T_dir_name"
    declare -r T_file_name="${T_bucket[directory]}/${T_bucket[file]}"
    touch "$T_file_name"
    printf "%s\n" "${T[element]}"
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"