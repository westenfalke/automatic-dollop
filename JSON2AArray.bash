#!/usr/bin/env bash
JSON2AArray() {
    set -o nounset
    eval "declare -rA JASON2AArray_ARGS=$@"
    args_as_json="$(cat "${JASON2AArray_ARGS[json_file]}")"
    declare -A AArray
    for property_name in ${JASON2AArray_ARGS[property_names]} ; do
        eval "AArray+=( [$(jq .${JASON2AArray_ARGS[hash_key]}.${property_name} <<< "$args_as_json")]=$(jq .${JASON2AArray_ARGS[hash_value]}.${property_name} <<< "$args_as_json"))"
    done
    readonly AArray
    printf "%s\n" "$(declare -p AArray|sed s/declare.*AArray=//)"
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"

# ARGS $@ generic example
# JASON2AArray_ARGS+=( [hash_key]='<left_value>' )
# JASON2AArray_ARGS+=( [hash_value]='<right_value>' )
# JASON2AArray_ARGS+=( [property_names]='<property_1> <property_2> ... <property_n-1> <property_n>' )
# JASON2AArray_ARGS+=( [json_file]='<filename>' )
#
# ARGS $@ specific example
# JASON2AArray_ARGS+=( [hash_key]='parameter' )
# JASON2AArray_ARGS+=( [hash_value]='defaults' )
# JASON2AArray_ARGS+=( [property_names]='base_dir backingstore project_name config_name' )
# JASON2AArray_ARGS+=( [json_file]='test_params.json' )
#
# AArray genecric Result
# AArray+=( [PARAM_NAME_1]='<value_1>' )
# AArray+=( [PARAM_NAME_2]='<value_2>' )
# AArray+=( [...]='<...>' )
# AArray+=( [PARAM_NAME_n-1]='<value_n-1>' )
# AArray+=( [PARAM_NAME_n]='<value_n>' )
#
# AArray specific Result
# AArray+=[BASE_DIR]="/tmp/bats/add_project/test_folder/foo" 
# AArray+=[PROJECT_NAME]="ssg_test_project" 
# AArray+=[CONFIG_NAME]=".ssgrc" [BACKINGSTORE]="disk" 
#
# JSON generic json_file
# {
#     "left_value": {
#       "property_1": "PARAM_NAME_1",
#       "property_2": "PARAM_NAME_2",
#       "property...": "...",
#       "property_n-1": "PARAM_NAME_n-1",
#       "property_n": "PARAM_NAME_n"
#       },
#     "right_value": {
#       "property_1": "value_1",
#       "property_2": "value_2",
#       "property...": "...",
#       "property_n-1": "value_n-1",
#       "property_n": "value_n"
#       }
# }
#
# JSON specific json_file
# {
#   "parameter": {
#       "base_dir": "BASE_DIR",
#       "backingstore": "BACKINGSTORE",
#       "project_name": "PROJECT_NAME",
#       "config_name": "CONFIG_NAME"
#       },
#     "defaults": {
#       "base_dir": "/tmp/bats/add_project/test_folder/foo",
#       "backingstore": "disk",
#       "project_name": "ssg_test_project",
#       "config_name": ".ssgrc"
#       }
# }
#
