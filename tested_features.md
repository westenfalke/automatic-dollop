# Test Report
## Tested Features 1..10
- [x] ok 1 (add_element) function fails without a positional paramerter
- [x] ok 2 (add_element) script.. fails without a positional paramerter
- [x] ok 3 (add_project) script.. creates a project with input from Array definition
- [x] ok 4 (add_project) function creates a project with input from Array definition
- [x] ok 5 (add_project) script.. fails if the project already exits
- [x] ok 6 (add_project) function fails if the project already exits
- [x] ok 7 (add_project) function fails without a positional paramerter
- [x] ok 8 (add_project) script.. fails without a positional paramerter
- [x] ok 9 (template) function fails without a positional paramerter
- [x] ok 10 (template) script.. fails without a positional paramerter

## Listing files and folder
``` bash
/tmp/bats
├── add_element
│   └── test_folder
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

10 directories, 5 files
```
