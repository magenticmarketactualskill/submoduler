# Requirements Document - Gem Packaging and Publishing

## Introduction

This document consolidates the requirements for packaging and publishing the Submoduler Ruby gem. It references detailed requirements in subdirectories for specific features.

Submoduler is a command-line tool for managing git submodules in monorepo environments, providing features like status reporting, version synchronization, testing, and release workflows across multiple submodules.

## Glossary

- **Submoduler**: A git submodule management tool for monorepo environments
- **Gemspec**: A Ruby specification file defining gem metadata, dependencies, and included files
- **RubyGems**: The Ruby community's gem hosting service at rubygems.org
- **Gem Package**: A distributable .gem file containing the packaged library
- **Executable**: A command-line script installed to the user's PATH when the gem is installed
- **API Key**: Authentication credential for publishing gems to RubyGems.org
- **SubmoduleParent**: A git repository with .gitmodules and .submoduler.ini file where [default] submodule_parent=true
- **SubmoduleChild**: A git repository with .gitmodules and .submoduler.ini file where [default] submodule_child=true
- **Semantic Versioning**: A versioning scheme using MAJOR.MINOR.PATCH format

## Project Structure

```
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
└── test
    ├── integration
    │   ├── test_cli.rb
    │   ├── test_defaults_end_to_end.rb
    │   └── test_report_command.rb
    └── submoduler
        ├── test_configuration_report_formatter.rb
        ├── test_git_modules_parser.rb
        ├── test_init_validator.rb
        ├── test_path_validator.rb
        ├── test_report_formatter.rb
        ├── test_submodule_entry.rb
        ├── test_submoduler_ini_parser_defaults.rb
        └── test_test_command_require_test.rb
```

## Requirements Overview

Detailed requirements are organized in the following subdirectories:

- **defaults/** - Default configuration system requirements
- **dependency/** - Dependency management requirements
- **documents/** - Documentation file requirements
- **examles_ex/** - Example project structure requirements
- **executable/** - Executable installation requirements
- **gem_publish/** - Gem publishing requirements
- **gemfile/** - Gemfile generation requirements
- **gemspec/** - Gemspec creation requirements
- **init/** - Project initialization requirements
- **symlink/** - Symlink generation requirements
- **test/** - Local installation testing requirements
- **validate/** - Project validation requirements
- **version/** - Version management requirements








