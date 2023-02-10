## depend
- jq already installed
- no longer needed # ~gmsl~ ~remake~ 
- not yet # libxml2-utils ->  xmllint
- # sudo apt install 


``` json
{
  "parameter": {
      "base_dir": "BASE_DIR",
      "backingstore": "BACKINGSTORE",
      "project_name": "PROJECT_NAME",
      "config_name": "CONFIG_NAME"
      },
    "defaults": {
      "base_dir": "/tmp/bats",
      "backingstore": "disk",
      "project_name": "ssg_test_project",
      "config_name": ".ssgrc"
      }
}
```

``` bash
printf "( %s )\n"  $(jq '.[].base_dir' add_project.json |sed -e ':a;N;$!ba;s/\n/=/' -e 's/^"/["/' -e 's/"=/"]=/')

( ["BASE_DIR"]="/tmp/bats" )
```



``` docker
{
  "image": "mcr.microsoft.com/devcontainers/universal:2",
  "features": {
    "ghcr.io/rocker-org/devcontainer-features/pandoc:1": {},
    "ghcr.io/devcontainers-contrib/features/wget-apt-get:1": {},
    "ghcr.io/guiyomh/features/vim:0": {},
    "ghcr.io/devcontainers-contrib/features/w3m-apt-get:1": {},
    "ghcr.io/edouard-lopez/devcontainer-features/bats:0": {}
  }
}

```

``` bash
test/test_helper/
├── bats-assert -> bats-assert-2.1.0
├── bats-assert-2.1.0
├── bats-file -> bats-file-0.3.0
├── bats-file-0.3.0
├── bats-support -> bats-support-0.3.0/
├── bats-support-0.3.0
└── ext-setup.bash
```

``` bash
git submodule add https://github.com/bats-core/bats-core.git test/bats
via feature
wget https://github.com/bats-core/bats-support/archive/refs/tags/v0.3.0.tar.gz
wget https://github.com/bats-core/bats-assert/archive/refs/tags/v2.1.0.tar.gz
wget https://github.com/bats-core/bats-file/archive/refs/tags/v0.3.0.tar.gz

git submodule add https://github.com/bats-core/bats-support.git test/test_helper/bats-support

git submodule add https://github.com/bats-core/bats-assert.git test/test_helper/bats-assert

git submodule add https://github.com/bats-core/bats-file.git test/test_helper/bats-file
```

# yq/yq
[doku yq](https://mikefarah.gitbook.io/yq/)
[doku yq v3.x](https://mikefarah.gitbook.io/yq/v/v3.x/)

``` bash
sudo add-apt-repository ppa:rmescandon/yq
sudo apt update
sudo apt install yq -y
```
``` bash
#!/usr/bin/env bash

 tap_print_var_value() {
    printf "%s\n" "# \${${1}}='${!1}'" >&3
 }
    
_ext_setup() {
    LC_ALL=POSIX
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-file/load'
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    PROJECT_ROOT="$( cd "$( dirname "${BATS_TEST_FILENAME}" )/.." >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    #PATH="$PROJECT_ROOT/src:$PATH"
    PATH="${PROJECT_ROOT}:$PATH"
    TEST_BUILD_DIR='/tmp/bats'
    TEST_UNDER_EXAMINATION="$(basename ${BATS_TEST_FILENAME%.*})"
    TEST_CONCERN_DIR="${TEST_BUILD_DIR}/${TEST_UNDER_EXAMINATION}"
    TEST_PROJECT_DIR="${TEST_CONCERN_DIR}/project_folder"
    FIRST_RUN_OF_TEST_UNDER_EXAMINATION="${TEST_BUILD_DIR}/${TEST_UNDER_EXAMINATION}_first_run"
}
```

``` bash
#!/usr/bin/env bash
JSON2AArray() {
    set -o nounset
    eval "declare -rA JSON2AArray_ARGS=$@"
    args_as_json="$(cat "${JSON2AArray_ARGS[json_file]}")"
    declare -A AArray
    for property_name in ${JSON2AArray_ARGS[property_names]} ; do
        eval "AArray+=( [$(jq .${JSON2AArray_ARGS[hash_key]}.${property_name} <<< "$args_as_json")]=$(jq .${JSON2AArray_ARGS[hash_value]}.${property_name} <<< "$args_as_json"))"
    done
    readonly AArray
    printf "%s\n" "$(declare -p AArray|sed s/declare.*AArray=//)"
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "$@"
# Declare an associative array from JSON ina way to elaborate and complicated manner
# declare -A AArray=([PARAM_NAME_n]="value_n"                           [PARAM_NAME_n-1]="value_n-1"      [PARAM_NAME_2]="value_2" [PARAM_NAME_1]="value_1" )
# devlare -A AArray=([BASE_DIR]="/tmp/bats/add_project/test_folder/foo" [PROJECT_NAME]="ssg_test_project" [CONFIG_NAME]=".ssgrc"   [BACKINGSTORE]="disk" )
# 
# ([PARAM_NAME_n]="value_n" [PARAM_NAME_n-1]="value_n-1" [PARAM_NAME_2]="value_2" [PARAM_NAME_1]="value_1" )
# ARGS $@ generic example
# JSON2AArray_ARGS+=( [hash_key]='<left_value>' )
# JSON2AArray_ARGS+=( [hash_value]='<right_value>' )
# JSON2AArray_ARGS+=( [property_names]='<property_1> <property_2> ... <property_n-1> <property_n>' )
# JSON2AArray_ARGS+=( [json_file]='<filename>' )
#
# ARGS $@ specific example
# JSON2AArray_ARGS+=( [hash_key]='parameter' )
# JSON2AArray_ARGS+=( [hash_value]='defaults' )
# JSON2AArray_ARGS+=( [property_names]='base_dir backingstore project_name config_name' )
# JSON2AArray_ARGS+=( [json_file]='test_params.json' )
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

```

``` bash
#!/usr/bin/env bats
MODULE_NAME="$(basename ${BATS_TEST_FILENAME%.*})"

setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "${TEST_UNDER_EXAMINATION}.bash"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv "${TEST_PROJECT_DIR}"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "(${MODULE_NAME}) map JSON into associative array" { 
    #tbd read values from JSON file and don't use fixed values
    local -A generic_arguments
    generic_arguments+=( [hash_key]='left_value' )
    generic_arguments+=( [hash_value]='right_value' )
    generic_arguments+=( [property_names]='property_1 property_2 property_n_1 property_n' )
    generic_arguments+=( [json_file]='test/JSON2AArray.json' )
    readonly generic_arguments
    run JSON2AArray  "$(declare -p generic_arguments|sed s/declare.*generic_arguments=//)"
    assert_output '([PARAM_NAME_n]="value_n" [PARAM_NAME_n-1]="value_n-1" [PARAM_NAME_2]="value_2" [PARAM_NAME_1]="value_1" )'
}

# this functions will have access to the global VARS specified in the setup
@test "(${MODULE_NAME}) function fails without a positional paramerter" {
    run "$TEST_UNDER_EXAMINATION"
    assert_failure
}

# calling the script will deny access to the global VARS specified in the setup
@test "(${MODULE_NAME}) script.. fails without a positional paramerter" {
    run "${TEST_UNDER_EXAMINATION}.bash"
    assert_failure
}
```

``` bash
getParameter() {
    local -A generic_arguments
    generic_arguments+=( [hash_key]='parameter' )
    generic_arguments+=( [hash_value]='defaults' )
    generic_arguments+=( [property_names]='base_dir backingstore project_name config_name' )
    generic_arguments+=( [json_file]='test/add_project.json' )
    readonly generic_arguments
    JSON2AArray  "$(declare -p generic_arguments|sed s/declare.*generic_arguments=//)"
}

```
