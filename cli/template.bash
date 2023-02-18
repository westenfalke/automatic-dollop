#!/usr/bin/env bash
# keep ${FUNCNAME} and 'basename' in sync
# function will be launched only if not sourced 
template() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"