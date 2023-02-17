# Test Report
## Tested Features 1..13
- [x] ok 1 (add_element) fails if the type of backingstore is not implemented
- [x] ok 2 (add_element) adds one data element to a namespaced bucket
- [x] ok 3 (add_element) adds two data elements to a namespaced bucket
- [x] ok 4 (add_element) fails on calls without a paramerter
- [x] ok 5 (add_project) create a uniq namespace, an alias and main configuration
- [x] ok 6 (add_project) fails if the namespace already exits
- [x] ok 7 (add_project) fails on calls without a paramerter
- [x] ok 8 (list_buckets) list buckets in full qualified a namespace
- [x] ok 9 (list_buckets) fails on calls without a paramerter
- [x] ok 10 (maybe_add_namespace) adds a new uniq namespace
- [x] ok 11 (maybe_add_namespace) fails if the namespace already exits
- [x] ok 12 (maybe_add_namespace) fails on calls without a paramerter
- [x] ok 13 (template) fails on calls without a paramerter

## Listing files and directories
``` bash
/tmp/bats
├── add_element
│   ├── root_directory
│   │   └── full
│   │       └── qualified
│   │           └── namespace
│   │               ├── one_element
│   │               │   └── a_namespaced_bucket
│   │               └── two_elements
│   │                   └── a_namespaced_bucket
│   └── add_element.first_run
├── add_project
│   ├── root_directory
│   │   └── full
│   │       └── qualified
│   │           └── namespace
│   │               ├── project_existing
│   │               └── project_new
│   │                   └── main_config
│   └── add_project.first_run
├── list_buckets
│   ├── root_directory
│   │   └── full
│   │       └── qualified
│   │           └── namespace
│   │               ├── bucket_00
│   │               ├── bucket_01
│   │               └── bucket_02
│   └── list_buckets.first_run
├── maybe_add_namespace
│   ├── root_directory
│   │   └── full
│   │       └── qualified
│   │           └── namespace
│   │               ├── existing
│   │               └── new
│   └── maybe_add_namespace.first_run
└── template
    ├── root_directory
    └── template.first_run

28 directories, 11 files
```
