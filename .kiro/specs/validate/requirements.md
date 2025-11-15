# Requirements Document - Project Validation

## Introduction

This document specifies the requirements for the Submoduler validation feature, which verifies that projects are properly configured with correct file structure, configuration, and git integration.

## Glossary

- **Submoduler**: A git submodule management tool for monorepo environments
- **SubmoduleParent**: A git repository with .gitmodules and .submoduler.ini file where [default] submodule_parent=true
- **SubmoduleChild**: A git repository with .gitmodules and .submoduler.ini file where [default] submodule_child=true
- **Configuration File**: The .submoduler.ini file containing project settings and defaults
- **Git Modules File**: The .gitmodules file managed by git for submodule tracking
- **Validation Result**: A report indicating pass/fail status with specific error messages

## Requirements

### Requirement 1: Validate Submoduler Structure

**User Story:** As a developer, I want to validate my Submoduler project structure, so that I can identify configuration issues before they cause problems

#### Acceptance Criteria

1. WHEN the developer runs "submoduler validate", THE Submoduler SHALL check for the existence of .submoduler.ini in the project root
2. IF the .submoduler.ini file does not exist, THEN THE Submoduler SHALL report a validation error with the missing file path
3. THE Submoduler SHALL verify that the submodule folder arrangement matches the .submoduler.ini configuration
4. THE Submoduler SHALL check for the existence of required bin directory scripts
5. WHEN validation completes, THE Submoduler SHALL display a summary of all validation results

### Requirement 2: Validate Configuration File Content

**User Story:** As a developer, I want to validate my .submoduler.ini file content, so that I can ensure proper configuration values

#### Acceptance Criteria

1. THE Submoduler SHALL verify that the .submoduler.ini file contains a [default] section
2. THE Submoduler SHALL validate that submodule_parent is set to either true or false
3. THE Submoduler SHALL validate that submodule_child is set to either true or false
4. THE Submoduler SHALL validate that require_tests_pass is set to either true or false
5. THE Submoduler SHALL validate that separate_repo is set to either true or false
6. IF any configuration value is invalid, THEN THE Submoduler SHALL report a validation error with the specific field name

### Requirement 3: Validate Binary Scripts

**User Story:** As a developer, I want to validate that required scripts exist, so that I can ensure all Submoduler functionality is available

#### Acceptance Criteria

1. WHILE submodule_parent=true, THE Submoduler SHALL verify that bin/generate_child_symlinks.rb exists
2. WHILE submodule_child=true, THE Submoduler SHALL verify that bin/generate_parent_symlink.rb exists
3. THE Submoduler SHALL verify that bin/Gemfile.erb exists
4. THE Submoduler SHALL verify that bin/generate_gemfile.rb exists
5. IF any required script is missing, THEN THE Submoduler SHALL report a validation error with the missing script path

### Requirement 4: Validate Git Integration

**User Story:** As a developer, I want to validate git configuration, so that I can ensure proper submodule tracking

#### Acceptance Criteria

1. THE Submoduler SHALL verify that .gitmodules entries match the .submoduler.ini content
2. THE Submoduler SHALL verify that git is functional in the SubmoduleParent repository
3. THE Submoduler SHALL verify that git is functional in all SubmoduleChild repositories
4. WHEN a .gitmodules entry does not match .submoduler.ini, THE Submoduler SHALL report a validation error with the mismatched entry
5. IF git is not functional in any repository, THEN THE Submoduler SHALL report a validation error with the repository path

### Requirement 5: Validate Submodule Directory Structure

**User Story:** As a developer, I want to validate submodule directory structure, so that I can ensure proper organization

#### Acceptance Criteria

1. THE Submoduler SHALL verify that all submodules listed in .submoduler.ini exist as directories
2. THE Submoduler SHALL verify that each SubmoduleChild has its own .submoduler.ini file
3. THE Submoduler SHALL verify that submodule paths in .gitmodules match the directory structure
4. IF a submodule directory is missing, THEN THE Submoduler SHALL report a validation error with the expected path
5. WHEN all validations pass, THE Submoduler SHALL display a success message
