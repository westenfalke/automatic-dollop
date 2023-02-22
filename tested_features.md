# Test Report
## Tested Features 1..19
- [x] ok 1 (add_element) adds one element to a namespaced bucket
- [x] ok 2 (add_element) adds two elements to a namespaced bucket
- [x] ok 3 (add_element) fails on calls without a paramerter
- [x] ok 4 (add_project) create a uniq namespace, an alias and main configuration
- [x] ok 5 (add_project) fails if the namespace already exits
- [x] ok 6 (add_project) fails on calls without a paramerter
- [x] ok 7 (backingstore) fails if the type of backingstore is not implemented
- [x] ok 8 (backingstore) adds one element to a namespaced bucket
- [x] ok 9 (backingstore) adds two elements to a namespaced bucket
- [x] ok 10 (backingstore) fails on calls without a paramerter
- [x] ok 11 (list_buckets) list buckets in full qualified a namespace
- [x] ok 12 (list_buckets) fails on calls without a paramerter
- [x] ok 13 (maybe_add_namespace) adds a new uniq namespace
- [x] ok 14 (maybe_add_namespace) fails if the namespace already exits
- [x] ok 15 (maybe_add_namespace) fails on calls without a paramerter
- [x] ok 16 (mkdwn2html) create html body from markdown oneliner (backingstore default)
- [x] ok 17 (mkdwn2html) fails on calls without a paramerter
- [x] ok 18 (read_bucket) fails on calls without a paramerter
- [x] ok 19 (template) fails on calls without a paramerter

## Listing files and directories
``` bash
/tmp/bats
└── test
    ├── add_element
    │   ├── full
    │   │   └── qualified
    │   │       └── namespace
    │   │           ├── one_element
    │   │           │   └── a_namespaced_bucket
    │   │           └── two_elements
    │   │               └── a_namespaced_bucket
    │   └── add_element.first_run
    ├── add_project
    │   ├── full
    │   │   └── qualified
    │   │       └── namespace
    │   │           ├── project_existing
    │   │           └── project_new
    │   │               └── main.config
    │   └── add_project.first_run
    ├── backingstore
    │   ├── full
    │   │   └── qualified
    │   │       └── namespace
    │   │           ├── one_element
    │   │           │   └── a_namespaced_bucket
    │   │           └── two_elements
    │   │               └── a_namespaced_bucket
    │   └── backingstore.first_run
    ├── list_buckets
    │   ├── full
    │   │   └── qualified
    │   │       └── namespace
    │   │           ├── bucket_00
    │   │           ├── bucket_01
    │   │           └── bucket_02
    │   └── list_buckets.first_run
    ├── maybe_add_namespace
    │   ├── full
    │   │   └── qualified
    │   │       └── namespace
    │   │           ├── existing
    │   │           └── new
    │   └── maybe_add_namespace.first_run
    ├── mkdwn2html
    │   ├── manuel
    │   │   └── maintained
    │   │       └── documents
    │   │           ├── index.html
    │   │           ├── index.md
    │   │           └── metadata.yaml
    │   └── mkdwn2html.first_run
    ├── read_bucket
    │   └── read_bucket.first_run
    └── template
        └── template.first_run

35 directories, 19 files
```
