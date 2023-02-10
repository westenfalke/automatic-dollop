#!/usr/bin/env bash
# keep ${FUNCNAME} and 'basename' in sync
# function will be launched only if not sourced 
template() {
    set -o nounset
    declare -r fail="$1"
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"