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
            add_element.bash "([data]='BACKINGSTORE=${project[BACKINGSTORE]}' \
                               [bucket]=\"( \
                                  [backingstore]='plain_text_on_disk' \
                                  [file]='${project[CONFIG_NAME]}' \
                                  [type]='wireframe' \
                                  [directory]='${project[BASE_DIR]}')\" )"    
            add_element.bash "([data]='PROJECT_NAME=${project[PROJECT_NAME]}' \
                               [bucket]=\"( \
                                  [backingstore]='plain_text_on_disk' \
                                  [file]='${project[CONFIG_NAME]}' \
                                  [type]='wireframe' \
                                  [directory]='${project[BASE_DIR]}')\" )"    
        fi
    fi
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"