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

