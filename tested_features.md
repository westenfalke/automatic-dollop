# Test Report
## Tested Features 1..12
- [x] ok 1 (add_element) function adds an ambiguos element to a polymorfic bucket
- [x] ok 2 (add_element) script.. adds an ambiguos element to a polymorfic bucket
- [x] ok 3 (add_element) function fails without a positional paramerter
- [x] ok 4 (add_element) script.. fails without a positional paramerter
- [x] ok 5 (add_project) script.. creates a project with input from Array definition
- [x] ok 6 (add_project) function creates a project with input from Array definition
- [x] ok 7 (add_project) script.. fails exit code (2) if the project already exits
- [x] ok 8 (add_project) function fails exit code (2) if the project already exits
- [x] ok 9 (add_project) function fails exit code (1) without a positional paramerter
- [x] ok 10 (add_project) script.. fails exit code (1) without a positional paramerter
- [x] ok 11 (template) function fails exit code (1) without a positional paramerter
- [x] ok 12 (template) script.. fails exit code (1) without a positional paramerter

## Listing files and directories
``` bash
/tmp/bats
├── add_element
│   └── test_folder
│       ├── project_dir_function
│       │   └── backingstore.dat
│       └── project_dir_script
│           └── backingstore.dat
├── add_project
│   └── test_folder
│       ├── existing_dir_function
│       ├── existing_dir_script
│       ├── new_project_dir_function
│       │   └── .ssgrc
│       └── new_project_dir_script
│           └── .ssgrc
├── template
│   └── test_folder
├── add_element_first_run
├── add_project_first_run
└── template_first_run

12 directories, 7 files
```
