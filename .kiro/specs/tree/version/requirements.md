### Requirement 7: Version Management

**User Story:** As a gem maintainer, I want version numbers managed consistently, so that releases follow semantic versioning

#### Acceptance Criteria

1. THE Submoduler SHALL define the version in lib/submoduler/version.rb as a constant
2. THE Submoduler SHALL use semantic versioning format (MAJOR.MINOR.PATCH)
3. THE Submoduler SHALL reference the version constant from the gemspec
4. WHEN the version is updated, THE Submoduler SHALL require changes only to the version.rb file
5. THE Submoduler SHALL display the version when the user runs "submoduler --version"