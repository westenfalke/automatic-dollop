# automatic-dollop
Almost A Static Site Generator 

## Feature
 - your due diligence
 - @see [Tested Features](tested_features.md)

## runtime dependencies
- bash [manual](https://www.gnu.org/software/bash/manual/bash.html)
- pandoc [demo](https://pandoc.org/demos.html)
- some CLI [command](https://busybox.net/downloads/BusyBox.html#commands) from '/usr/bin' in the scope of [busybox](https://git.busybox.net/busybox)

## development dependencies
- [wget](https://en.wikipedia.org/wiki/Wget)
- [tree (command)](https://en.wikipedia.org/wiki/Tree_(command))
- [bats-core](https://github.com/bats-core/bats-core)
- [bats-assert](https://github.com/bats-core/bats-assert)
- [bats-file](https://github.com/bats-core/bats-file)
- [bats-support](https://github.com/bats-core/bats-support)

## With a little Help from my friends (Cheat & Sheet)
This is likely to work only on a GitHub CODESPACE and your installation path will probably vary.
### HowTo get Bats (Installed) 
>I strongly recommend to __do your due diligence__ when installing stuff on your system.
``` bash
#!/usr/bin/env bash
wget -qO- https://github.com/bats-core/bats-core/archive/refs/tags/v1.9.0.tar.gz    | tar xvz -C /workspaces/${RepositoryName}/test
pushd /workspaces/${RepositoryName}/test && ln -s bats-core-1.9.0 bats; popd

wget -qO- https://github.com/bats-core/bats-support/archive/refs/tags/v0.3.0.tar.gz | tar xvz -C /workspaces/${RepositoryName}/test/test_helper
pushd /workspaces/${RepositoryName}/test/test_helper && ln -s bats-support-0.3.0 bats-support; popd

wget -qO- https://github.com/bats-core/bats-assert/archive/refs/tags/v2.1.0.tar.gz  | tar xvz -C /workspaces/${RepositoryName}/test/test_helper
pushd /workspaces/${RepositoryName}/test/test_helper && ln -s bats-assert-2.1.0 bats-assert; popd

wget -qO- https://github.com/bats-core/bats-file/archive/refs/tags/v0.3.0.tar.gz    | tar xvz -C /workspaces/${RepositoryName}/test/test_helper
pushd /workspaces/${RepositoryName}/test/test_helper && ln -s bats-file-0.3.0 bats-file; popd
```

``` bash
/workspaces/${RepositoryName}/test/test_helper/
├── bats -> bats-core-1.9.0
├── bats-core-1.9.0
├── bats-file -> bats-file-0.3.0
├── bats-file -> bats-file-0.3.0
├── bats-file-0.3.0
├── bats-support -> bats-support-0.3.0/
├── bats-support-0.3.0
└── ext-setup.bash
```

## Not a Feature
- Analytics capabilities
(
    in my case my ISP provides GDPR conforming analytics so I don't care right now
)
- Integrated search engine
(
    you'll have to feed the metadata to the search engine of your liking, starting with the sitemap.xml
)
- Automated deployment
(
    there are already plenty of solutions out there
)
- Improved security features (
    there is not a lot to improve on a static website, hence SSL is a defacto standard and not a USP any longer
)
