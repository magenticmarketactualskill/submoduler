# Requirements Document - Default Configuration

## Introduction

This document specifies the requirements for the Submoduler default configuration system, which defines the behavior and settings stored in .submoduler.ini files.

## Glossary

- **Submoduler**: A git submodule management tool for monorepo environments
- **SubmoduleParent**: A git repository with .gitmodules and .submoduler.ini file where [default] submodule_parent=true
- **SubmoduleChild**: A git repository with .gitmodules and .submoduler.ini file where [default] submodule_child=true
- **Configuration File**: The .submoduler.ini file containing project settings and defaults
- **SubmoduleTree**: The hierarchical structure of parent and child submodules in a project
- **Published Repository**: A git repository with a remote URL that can be accessed by others

## Requirements

### Requirement 1: Define Repository Type

**User Story:** As a developer, I want to specify whether a repository is a parent or child, so that Submoduler can apply appropriate behaviors

#### Acceptance Criteria

1. THE Submoduler SHALL support a submodule_parent configuration value in the [default] section
2. THE Submoduler SHALL support a submodule_child configuration value in the [default] section
3. WHEN submodule_parent=true, THE Submoduler SHALL treat the repository as a SubmoduleParent
4. WHEN submodule_child=true, THE Submoduler SHALL treat the repository as a SubmoduleChild
5. THE Submoduler SHALL allow both submodule_parent and submodule_child to be false for standalone repositories

### Requirement 2: Configure Test Requirements

**User Story:** As a developer, I want to control whether tests must pass before pushing, so that I can enforce quality gates

#### Acceptance Criteria

1. THE Submoduler SHALL support a require_tests_pass configuration value in the [default] section
2. WHEN require_tests_pass=true, THE Submoduler SHALL block push operations if tests fail in the module
3. WHEN require_tests_pass=false, THE Submoduler SHALL allow push operations even if tests fail in the module
4. WHILE require_tests_pass=true, THE Submoduler SHALL execute tests before any push operation in the SubmoduleTree
5. IF tests fail and require_tests_pass=true, THEN THE Submoduler SHALL display test failure details and abort the push

### Requirement 3: Configure Repository Publication Status

**User Story:** As a developer, I want to specify whether a repository is published separately, so that Submoduler can handle dependencies correctly

#### Acceptance Criteria

1. THE Submoduler SHALL support a separate_repo configuration value in the [default] section
2. WHEN separate_repo=true, THE Submoduler SHALL expect the repository to have a remote URL
3. WHEN separate_repo=false, THE Submoduler SHALL treat the repository as existing only within the parent structure
4. THE Submoduler SHALL validate remote URL existence when separate_repo=true
5. WHILE separate_repo=true, THE Submoduler SHALL enable independent versioning and publishing workflows

### Requirement 4: Parse Configuration File

**User Story:** As a developer, I want Submoduler to read my .submoduler.ini file, so that my configuration is applied automatically

#### Acceptance Criteria

1. WHEN Submoduler executes any command, THE Submoduler SHALL read the .submoduler.ini file from the current directory
2. THE Submoduler SHALL parse the [default] section for configuration values
3. THE Submoduler SHALL use boolean values (true/false) for all configuration flags
4. IF the .submoduler.ini file is malformed, THEN THE Submoduler SHALL report a parsing error with the line number
5. THE Submoduler SHALL apply default values for any missing configuration keys

### Requirement 5: Provide Configuration Defaults

**User Story:** As a developer, I want sensible default values, so that I can use Submoduler with minimal configuration

#### Acceptance Criteria

1. WHEN submodule_parent is not specified, THE Submoduler SHALL default to false
2. WHEN submodule_child is not specified, THE Submoduler SHALL default to false
3. WHEN require_tests_pass is not specified, THE Submoduler SHALL default to true
4. WHEN separate_repo is not specified, THE Submoduler SHALL default to true
5. THE Submoduler SHALL document all default values in the initialization output