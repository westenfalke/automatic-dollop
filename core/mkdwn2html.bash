#!/usr/bin/env bash
mkdwn2html() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        return 0
        eval "declare -A T=$@"
        pandoc \
            --from=markdown "${INPUT_FILE}" \
            --to=html --output="${OUTPUT_FILE}" \
            --metadata-file=${METADATA_FILE} \
            --data-dir=${DATA_DIR} \
            --standalone  --verbose --trace 
        #    --template=${TEMPLETE:-"default.html"}

    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"