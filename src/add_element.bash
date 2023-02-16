#!/usr/bin/env bash
add_element() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -A T=$@"
        eval "declare -rA T_bucket=${T[bucket]}"
        declare -r backingstore=${T_bucket[backingstore]}
        if [[ "plain_text_on_disk" == "$backingstore" ]]; then
            declare -r dir_name="${T_bucket[namespace]}"              
            mkdir -pv "$dir_name"
            declare -r file_name="${T_bucket[category]}"
            declare -r config_file="${dir_name}/${file_name}"
            printf "%s\n" "${T[data]}" >> "$config_file"
        else
            printf "Backingstore type '%s' not yet implemented" "${backingstore}" >&2
            exit 4
        fi
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"