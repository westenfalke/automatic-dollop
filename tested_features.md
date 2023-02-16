# Test Report
## Tested Features 1..11
- [x] ok 1 (add_element) fails if backinstore is not 'plain_text_on_disk'
- [x] ok 2 (add_element) adds one ambiguos element to a polymorfic bucket
- [x] ok 3 (add_element) adds two ambiguos element to a polymorfic bucket
- [x] ok 4 (add_element) fails with exit code (128) without a positional paramerter
- [x] ok 5 (add_project) creates a project within an uniq namespace
- [x] ok 6 (add_project) fails with exit code (2) if the project within the namespace already exits
- [x] ok 7 (add_project) fails with exit code (128) without a positional paramerter
- [x] ok 8 (maybe_add_namespace) adds a new non existing namespace
- [x] ok 9 (maybe_add_namespace) fails with exit code (2) if the namespace already exits
- [x] ok 10 (maybe_add_namespace) fails with exit code (128) without a positional paramerter
- [x] ok 11 (template) fails with exit code (128) without a positional paramerter

## Listing files and directories
``` bash
/tmp/bats
├── add_element
│   └── test_folder
│       ├── project_dir_one_element
│       │   └── backingstore.dat
│       └── project_dir_two_element
│           └── backingstore.dat
├── add_project
│   └── test_folder
│       ├── existing_dir_script
│       └── new_project_dir_script
│           └── .ssgrc
├── maybe_add_namespace
│   └── test_folder
│       └── existing_dir
├── template
│   └── test_folder
├── add_element_first_run
├── add_project_first_run
├── maybe_add_namespace_first_run
└── template_first_run

13 directories, 7 files
```
