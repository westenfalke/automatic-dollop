#!/usr/bin/env bash
add_project() {
    set -o nounset
    source params.bash
    declare fail="${1}"
    source <(printf "%s\n" "$@")
    declare -r _configfile_="${BASE_DIR}/${PARAM_CONFIG_NAME}"
    if [[ -e "$BASE_DIR" ]]; then
        exit 1
    else
        mkdir -vp "$BASE_DIR"
    fi
    printf "%s=%s\n" "${PARAM_BACKINGSTORE}" "$BACKINGSTORE"  >> "$_configfile_"
    printf "%s=%s\n" "${PARAM_PROJECT_NAME}" "$PROJECT_NAME"  >> "$_configfile_"
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"