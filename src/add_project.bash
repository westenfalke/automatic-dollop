#!/usr/bin/env bash
add_project() {
    set -o nounset
    set -x
    declare fail="${1}"
    eval "declare -rA arguments=$@"
    if [[ -e "${arguments[BASE_DIR]}" ]]; then
        exit 1
    else
        mkdir -vp "${arguments[BASE_DIR]}"
        printf "%s=%s\n" "BACKINGSTORE" "${arguments[BACKINGSTORE]}"  >> "${arguments[BASE_DIR]}/${arguments[CONFIG_NAME]}"
        printf "%s=%s\n" "PROJECT_NAME" "${arguments[PROJECT_NAME]}"  >> "${arguments[BASE_DIR]}/${arguments[CONFIG_NAME]}"
    fi
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"