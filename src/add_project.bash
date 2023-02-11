#!/usr/bin/env bash
add_project() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 1
    else
        declare fail="${1}"
        eval "declare -rA project=$@"
        declare -r project_directory="${project[BASE_DIR]}"
        if [[ -e "${project[BASE_DIR]}" ]]; then
            exit 2
        else
            mkdir -vp "${project_directory}"
            declare -r project_configuration="${project[BASE_DIR]}/${project[CONFIG_NAME]}"
            printf "%s=%s\n" "BACKINGSTORE" "${project[BACKINGSTORE]}"  >> "${project_configuration}"
            printf "%s=%s\n" "PROJECT_NAME" "${project[PROJECT_NAME]}"  >> "${project_configuration}"
        fi
    fi
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"