# Requirements Document

## Introduction

This document specifies the requirements for packaging and publishing the Submoduler Ruby gem.

Submoduler is a command-line tool for managing git submodules in monorepo environments, providing features like status reporting, version synchronization, testing, and release workflows across multiple submodules.

## Glossary

- **Submoduler**: A git submodule management tool for monorepo environments
- **Gemspec**: A Ruby specification file defining gem metadata, dependencies, and included files
- **RubyGems**: The Ruby community's gem hosting service at rubygems.org
- **Gem Package**: A distributable .gem file containing the packaged library
- **Executable**: A command-line script installed to the user's PATH when the gem is installed
- **API Key**: Authentication credential for publishing gems to RubyGems.org

- **SubmoduleParent**: git repo with .gitmodules and .submoduler file
    with [default] submodule_parent=true
- **SubmoduleChild**: git repo with .gitmodules and .submoduler file
    with [default] submodule_child=true


├── lib
│   └── submoduler
│       ├── base_command.rb
│       ├── bundle_command.rb
│       ├── cli.rb
│       ├── configuration_report_formatter.rb
│       ├── dirty_validator.rb
│       ├── gem_version_detector.rb
│       ├── gem_version_updater.rb
│       ├── git_add_command.rb
│       ├── git_commit_command.rb
│       ├── git_executor.rb
│       ├── git_modules_parser.rb
│       ├── git_status_command.rb
│       ├── ini_file_parser.rb
│       ├── init_validator.rb
│       ├── output_formatter.rb
│       ├── path_validator.rb
│       ├── push_command.rb
│       ├── release_command.rb
│       ├── repo_status_checker.rb
│       ├── repo_status.rb
│       ├── report_command.rb
│       ├── report_formatter.rb
│       ├── submodule_entry.rb
│       ├── submoduler_ini_parser.rb
│       ├── test_command.rb
│       ├── test_formatter.rb
│       ├── test_runner.rb
│       ├── unpushed_validator.rb
│       ├── validation_result.rb
│       ├── version_command.rb
│       ├── version_formatter.rb
│       └── version.rb
├── submodules
│   └── core
│       ├── submoduler_child
│       │   ├── CHANGELOG.md
│       │   ├── lib
│       │   │   ├── submoduler_child
│       │   │   │   └── version.rb
│       │   │   └── submoduler_child.rb
│       │   ├── LICENSE
│       │   ├── README.md
│       │   ├── submoduler_child-0.2.0.gem
│       │   └── submoduler_child.gemspec
│       └── submoduler_parent
│           ├── CHANGELOG.md
│           ├── lib
│           │   ├── submoduler_parent
│           │   │   └── version.rb
│           │   └── submoduler_parent.rb
│           ├── LICENSE
│           ├── README.md
│           ├── submoduler_parent-0.2.0.gem
│           └── submoduler_parent.gemspec
└── test
    ├── integration
    │   ├── test_cli.rb
    │   ├── test_defaults_end_to_end.rb
    │   └── test_report_command.rb
    ├── submoduler
    │   ├── test_configuration_report_formatter.rb
    │   ├── test_git_modules_parser.rb
    │   ├── test_init_validator.rb
    │   ├── test_path_validator.rb
    │   ├── test_report_formatter.rb
    │   ├── test_submodule_entry.rb
    │   ├── test_submoduler_ini_parser_defaults.rb
    │   └── test_test_command_require_test.rb
    └── test_helper.rb
## Requirements
.
└── specs
    ├── dependency
    │   └── requirements.md
    ├── documents
    │   └── requirements.md
    ├── executable
    │   └── requirements.md
    ├── gem_publish
    │   └── requirements.md
    ├── gemspec
    │   └── requirements.md
    └── version
        └── requirements.md
    └── test
        └── requirements.md








