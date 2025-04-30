## Cross-Platform PowerShell System Inventory Module

## Goal
 Produce a reusable PowerShell module containing a primary function that performs a read-only system inventory across Windows, macOS, and Linux, leveraging GitHub Copilot for development assistance.


## Description
Develop a PowerShell module named SystemInventory that gathers basic system information from Windows, macOS, and Linux machines using PowerShell. The module should collect data such as operating system details, running processes, services/daemons, installed packages/applications, and basic directory statistics for specified paths. On Windows, it should additionally attempt to retrieve installed Windows Features and specific registry key values. The collected data must be structured using PowerShell classes, and the final output should be exportable as a single JSON file. The entire module, including classes and functions, must be well-documented using comments and standard PowerShell comment-based help. GitHub Copilot should be utilized throughout the development lifecycle for tasks like planning, code generation, implementing platform-specific logic, error handling, documentation, and module packaging.

## Requirements

### Functional Requirements
1. **Cross-Platform Support**
   - Must run on Windows, macOS, and Linux
   - Recommended PowerShell 7+
   - Must detect and adapt to the operating system

2. **Data Collection**
   - **All Platforms**
     - Operating system details (Cmdlets like Get-ComputerInfo or platform-specific commands/files might be needed).
     - Running processes (name, ID, CPU/memory usage)
     - Services/daemons (name, status, startup type)
     - Installed packages/applications (name, version, install date if available)
     - Directory statistics (size, file count, last modified date) for specified paths
   
   - **Windows-Specific**
     - Installed Windows Features
     - Registry key values (configurable paths)

3. **Output**
   - Structured data using PowerShell classes
   - JSON export functionality
   - Option to display formatted results to console

### Technical Requirements
1. **Module Structure**
   - Properly organized PowerShell module (PSM1, PSD1 files)
   - Clear separation of platform-specific code
   - Class-based data structures
   - A module manifest file
   - Only the main inventory function should be explicitly exported

2. **Error Handling**
   - Graceful handling of permissions issues
   - Platform-specific fallbacks when commands aren't available
   - Detailed error reporting without terminating execution

3. **Performance**
   - Efficient execution on systems with limited resources
   - Progress indicators for long-running operations

4. **Testing - Optional**
   - Implement Pester tests for all functions
   - Include unit tests for class methods and properties
   - Mock external dependencies for consistent test results

### Documentation Requirements
1. **Code Documentation**
   - Comment-based help for all functions
   - Class and property documentation
   - Parameter validation descriptions

2. **User Documentation**
   - Installation instructions
   - Usage examples for each platform
   - Troubleshooting guide

### Constraints

- Operations must be strictly read-only and non-destructive. Avoid cmdlets that modify system state. Use -WhatIf cautiously only for exploration, not in the final script.
- GitHub Copilot (via VS Code extension or other integrations) must be actively used throughout the development process.
- Target platform is the participant's own laptop (Windows, macOS, or Linux). No assumptions about VMs or specific pre-configured environments.
- Error handling should be implemented gracefully (e.g., use try/catch blocks around platform-specific commands or external process calls, write warnings on failure using Write-Warning, and return empty collections or null values rather than crashing).

## Implementation Phases

### Phase 1: Planning and Task breakdown (Using Copilot Chat/Agent)

Decompose the main backlog item into smaller, logical tasks

Utilize Copilot Chat for structured task generation. Agent mode, if available, might offer a more automated planning approach

**Use Copilot to identify the further implementation phases.**

### Optional Phase: Test-Driven Development with Pester and GitHub Copilot

1. **Initial Test Setup**
   - Use Copilot to generate a basic Pester test structure
   - Set up test folder organization mirroring the module structure
   - Create test fixtures and mock data with Copilot's assistance

2. **Unit Test Development**
   - Leverage Copilot to generate test cases for each function
   - Use Copilot to suggest different test scenarios and edge cases
   - Implement mocks for external commands and platform-specific functionality

## Notes

- Leverage the [copilot-instructions](../.github/copilot-instructions.md) file to describe any additional information such as coding practices, preferred technologies.

- You can also configure custom instructions for code generation and test generation in your VS Code. One such example file can be found in the **instructions** folder. These instructions can be defined in your VS Code settings through *`settings.json`* file.

   ```json
   "github.copilot.chat.codeGeneration.instructions": [
      {
         "text": "Always add a comment: 'Generated by Copilot'."
      },
      {
         "file": "./instructions/code-style.md"
      }
   ]
   ```