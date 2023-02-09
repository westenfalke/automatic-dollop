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
printf "( %s )\n"  $(jq '.[].base_dir' test_params.json |sed -e ':a;N;$!ba;s/\n/=/' -e 's/^"/["/' -e 's/"=/"]=/')

( ["BASE_DIR"]="/tmp/bats" )
```

``` bash
declare -a arr=( $(jq -r '.[].base_dir' test_params.json) )
declare -p arr
printf '%s\n' "${arr[@]}"
printf -v param "%s\n" "$(jq '.[].base_dir' test_params.json |sed -e ':a;N;$!ba;s/\n/=/' -e 's/^"/[/' -e 's/"=/]=/' )"
printf "json: %s\n" "$param"

declare -A aarr=( [key1]="value1"  [key2]="value2" )
declare -p aarr
#eval "declare -A jarr=( $param )"
#eval "declare -A jarr=( $(jq '.[].base_dir' test_params.json |sed -e ':a;N;$!ba;s/\n/=/' -e 's/^"/[/' -e 's/"=/]=/' ) )"
json="$(cat test_params.json)"
declare -A jarr
eval "jarr+=( [$(jq '.parameter.base_dir'     <<< "$json")]=$(jq '.defaults.base_dir'     <<< "$json"))"
eval "jarr+=( [$(jq '.parameter.backingstore' <<< "$json")]=$(jq '.defaults.backingstore' <<< "$json"))"
eval "jarr+=( [$(jq '.parameter.project_name' <<< "$json")]=$(jq '.defaults.project_name' <<< "$json"))"
eval "jarr+=( [$(jq '.parameter.config_name'  <<< "$json")]=$(jq '.defaults.config_name'  <<< "$json"))"
declare -p jarr
printf '%s\n' "${!aarr[@]}"
printf '%s\n' "${aarr[@]}"
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