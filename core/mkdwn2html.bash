#!/usr/bin/env bash
mkdwn2html() {
    set -o nounset
    if [[ "$#" != '1' ]]; then
        exit 128
    else
        eval "declare -A T=$@"
        eval "declare -rA T_bucket=${T[bucket]}"
        eval "declare -rA T_parameter=${T[payload]}"
        #declare -r kind=${T_bucket[backingstore_kind]}
        pwd >&2
        declare -r document_dir="${T_bucket[namespace]/.//}/${T_bucket[bucket_name]}"
        printf "%s\n" "${document_dir}/${T_parameter[metadata_file]}" >&2
        pandoc \
            --from=markdown "${document_dir}/${T_parameter[input_file]}" \
            --to=html --output="${document_dir}/${T_parameter[output_file]}" \
            --verbose --trace 
        #    --metadata-file="${document_dir}/${T_parameter[metadata_file]}" \
        #    --standalone  --verbose --trace 
        #    --data-dir=".pandoc" \
        #    --template=${TEMPLETE:-"default.html"}

    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"