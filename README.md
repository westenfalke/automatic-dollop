# automatic-dollop
Almost A Static Site Generator 

## Feature
 - your due diligence
 - @see [Tested Features](tested_features.md)

## runtime dependencies
- [bash manual](https://www.gnu.org/software/bash/manual/bash.html)
- [pandoc demo](https://pandoc.org/demos.html)
- [jq tutorial](https://stedolan.github.io/jq/tutorial/)
- some [CLI](https://de.wikipedia.org/wiki/CLI) command from '/usr/bin' in the scope of [busybox](https://git.busybox.net/busybox)

## development dependencies 
- [bats-core](https://github.com/bats-core/bats-core)
- [bats-assert](https://github.com/bats-core/bats-assert)
- [bats-file](https://github.com/bats-core/bats-file)
- [bats-support](https://github.com/bats-core/bats-support)

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

## No Feature
- Analytics capabilities
(
    in my case my ISP provides GDPR conform analytics so I don't mind today
)
- Integrated search engine
(
    you'll have to feed the metadata to the search engin of your liking, starting with the sitemap.xml
)
- Automated deployment
(
    there are already plenty of solutions out there
)
- Improved security features (
    there is not a lot to improve on a static website, hence SSL is a defacto standard its's no longer a USP
)
