## depend
- jq already installed
- no longer needed # ~gmsl~ ~remake~ 
- not yet # libxml2-utils ->  xmllint
- # sudo apt install 

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
# bat-core no longer as codespace feature
wget -qO- https://github.com/bats-core/bats-core/archive/refs/tags/v1.9.0.tar.gz    | tar xvz -C /workspaces/${RepositoryName}/test
pushd /workspaces/${RepositoryName}/test && ln -s bats-core-1.9.0 bats; popd
wget -qO- https://github.com/bats-core/bats-support/archive/refs/tags/v0.3.0.tar.gz | tar xvz -C /workspaces/${RepositoryName}/test/test_helper
pushd /workspaces/${RepositoryName}/test/test_helper && ln -s bats-support-0.3.0 bats-support; popd
wget -qO- https://github.com/bats-core/bats-assert/archive/refs/tags/v2.1.0.tar.gz  | tar xvz -C /workspaces/${RepositoryName}/test/test_helper
pushd /workspaces/${RepositoryName}/test/test_helper && ln -s bats-assert-2.1.0 bats-assert; popd
wget -qO- https://github.com/bats-core/bats-file/archive/refs/tags/v0.3.0.tar.gz    | tar xvz -C /workspaces/${RepositoryName}/test/test_helper
pushd /workspaces/${RepositoryName}/test/test_helper && ln -s bats-file-0.3.0 bats-file; popd

git submodule add https://github.com/bats-core/bats-core.git test/bats

git submodule add https://github.com/bats-core/bats-support.git test/test_helper/bats-support

git submodule add https://github.com/bats-core/bats-assert.git test/test_helper/bats-assert

git submodule add https://github.com/bats-core/bats-file.git test/test_helper/bats-file
```

# yq/yq
[doku yq](https://mikefarah.gitbook.io/yq/)
[doku yq v3.x](https://mikefarah.gitbook.io/yq/v/v3.x/)


#!/bin/bash

PS3="Select your language please: "

select lng in Bash Java C++ Quit
do
    case $lng in
        "Bash")
            echo "$lng - that's what we're talking about";;
        "Java")
           echo "$lng - is your VM ready?";;
        "C++")
           echo "$lng - let's prepare for a lot of compilation";;
        "Quit")
           echo "We're done"
           break;;
        *)
           echo "Ooops";;
    esac
done
