# automatic-dollop
Almost A Static Site Generator 

## Feature
 - your due diligence
 - @see Teest Protocol ```<link pending>``` 

## runtime dependencies
- [bash](https://www.gnu.org/software/bash/)
- [pandoc](https://github.com/jgm/pandoc)
- some [CLI](https://de.wikipedia.org/wiki/CLI) command from '/usr/bin' in the scope of [busybox](https://git.busybox.net/busybox)

## development depandencies 
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
    should be provided by your ISP, GDPR conform and exactly matched the kind of web server you are using
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
    there is not a lot to improve on a static website, an SSL is a defacto standard and therefore no longer an usp
)
