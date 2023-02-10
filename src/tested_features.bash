#!/usr/bin/env bash
set -eu
declare -r src_dir="$(dirname $0)"
pushd "${src_dir}/.."
rm -rf /tmp/bats
bats test -t|sed -e s'/^ok/-\ [x]\ ok/' -e s'/^not ok/-\ [-]\ not ok/' -e '1 s/^/\# Test Report\n##\ Tested\ Features\ /' |tee "$(basename ${0%.*}).md"
printf '\n## Listing files and directories\n``` bash\n%s\n```\n' "$(tree -a --dirsfirst /tmp/bats)"|tee -a "$(basename ${0%.*}).md"
popd