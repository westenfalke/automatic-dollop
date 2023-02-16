#!/usr/bin/env bash
list_buckets() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"