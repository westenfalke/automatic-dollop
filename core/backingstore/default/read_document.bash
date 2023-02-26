#!/usr/bin/env bash
read_document() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -A T=$@"
        eval "declare -rA T_bucket=${T[bucket]}"
        # namespace to path, avoid leaking the path seperator as an implementaion detail      
        declare -r dir_name="${T_bucket[namespace]//.//}"
        mkdir -pv "$dir_name"
        declare -r file_name="${T_bucket[bucket_name]}"
        declare -r document_file_name="${dir_name}/${file_name}"
        if [[ -e document_file_name ]]; then
            exit 2
        else
            T[payload]="$(cat "$document_file_name")"
            printf "%s" "$(declare -p T|sed 's/^.*T=//')" 
        fi
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"