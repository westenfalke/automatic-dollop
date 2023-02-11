#!/usr/bin/env bash
add_element() {
    set -o nounset
    eval "declare -A TYPE=$@"
    eval "declare -rA TYPE_bucket=${TYPE[bucket]}"
    declare -r TYPE_dir_name="${TYPE_bucket[directory]}"
    mkdir -pv "$TYPE_dir_name"
    declare -r TYPE_file_name="${TYPE_bucket[directory]}/${TYPE_bucket[file]}"
    touch "$TYPE_file_name"
    printf "%s\n" "${TYPE[element]}"
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"