### Requirement 2: Executable Installation

**User Story:** As a user, I want a "submoduler" command available after installation, so that I can run the tool from anywhere

#### Acceptance Criteria

1. THE Submoduler SHALL provide an executable file named "submoduler" in the bin directory
2. WHEN a user installs the gem, THE Submoduler SHALL make the "submoduler" command available in the user's PATH
3. WHEN the user runs "submoduler --version", THE Submoduler SHALL display the current version number
4. THE Submoduler SHALL invoke the CLI interface when the executable is run
5. THE Submoduler SHALL pass all command-line arguments to the CLI handler