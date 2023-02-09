#!/usr/bin/env bash
# keep ${FUNCNAME} and 'basename' in sync
# function will be launched only if not sourced 
add_element() {
    set -o nounset
    declare fail="${1}"
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"