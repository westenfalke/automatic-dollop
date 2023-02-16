# Test Report
## Tested Features 1..12
- [x] ok 1 (add_element) fails if the type of backingstore is not implemented
- [x] ok 2 (add_element) adds one data element to a namespaced bucket
- [x] ok 3 (add_element) adds two data elements to a namespaced bucket
- [x] ok 4 (add_element) fails on calls without a paramerter
- [x] ok 5 (add_project) create a uniq namespace, an alias and main configuration
- [x] ok 6 (add_project) fails if the namespace already exits
- [x] ok 7 (add_project) fails on calls without a paramerter
- [x] ok 8 (list_buckets) fails on calls without a paramerter
- [x] ok 9 (maybe_add_namespace) adds a new uniq namespace
- [x] ok 10 (maybe_add_namespace) fails if the namespace already exits
- [x] ok 11 (maybe_add_namespace) fails on calls without a paramerter
- [x] ok 12 (template) fails on calls without a paramerter

## Listing files and directories
``` bash
/tmp/bats
├── add_element
│   └── test_folder
│       ├── namespace_one_element
│       │   └── a_namespaced_bucket
│       └── namespace_two_elements
│           └── a_namespaced_bucket
├── add_project
│   └── test_folder
│       ├── existing_project_namespace
│       └── new_project_namespace
│           └── main_config
├── list_buckets
│   └── test_folder
├── maybe_add_namespace
│   └── test_folder
│       ├── existing_namespace
│       └── new_namespace
├── template
│   └── test_folder
├── add_element_first_run
├── add_project_first_run
├── list_buckets_first_run
├── maybe_add_namespace_first_run
└── template_first_run

16 directories, 8 files
```
