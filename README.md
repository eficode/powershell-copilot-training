# PowerShell Prompt Engineering with GitHub Copilot

### Prerequisites

- GitHub Copilot
- GitHub Copilot Chat
- PowerShell 7.x (recommended)
- VS Code with PowerShell extension

## Prompting Best Practices

- **Provide references**: Improve relevance by providing examples and context
- **Write clear instructions**: Be specific about PowerShell features, versions, and modules needed
- **Split up big tasks**: Break complex scripts into manageable parts
- **Allow GitHub Copilot time to think**: Request step-by-step solutions for complex PowerShell logic
- **Test changes systematically**: Validate scripts with proper error handling

## Exercises

You can create separate files to practice the following prompting exercises.

#### Zero-shot
```
Write me a script to list all running processes and export them to a CSV file.
```
```
Create a script that monitors a directory for new files and logs them.
```
```
Write a function that includes proper error handling and logging.
```
#### One-Shot

Provide examples / the language you want to use / any sort of sample outputs that can be useful

```
Write me a script to list all running processes and export them to a CSV file. Try adding additioanl information here
```
```
Create a PowerShell script that monitors a directory for new files and logs them. 
Try adding additioanl information here
```
```
Write a PowerShell function that includes proper error handling and logging. Try adding additioanl information here
```

#### Few-shot Example
```
Create a PowerShell module with functions to manage system services with proper parameter validation, help documentation, and pipeline support.
```

## Cornerstone of PowerShell Prompting

- **Context**: Provide module names, cmdlet examples, and PowerShell version
- **Intent**: Clearly state automation goals and output expectations
- **Clarity**: Use proper PowerShell naming conventions and style
- **Specificity**: Define parameter types, validation, and error handling requirements

# GitHub Copilot PowerShell Exercises

Each exercise focuses on a different aspect of Copilot functionality to enhance your PowerShell development workflow.

## Exercise 1: Autocompleting Cmdlets and Parameters

**Feature Focus: Inline Suggestions and Tab Completion**

### Instructions

1. Open `Exercise1.ps1`
2. Follow the numbered tasks in the comments
3. For each task:
   - Begin typing the command as instructed
   - Watch for Copilot's gray inline suggestions
   - Press `Tab` to accept a suggestion when it appears
   - Use the suggested parameters or modify them as needed

## Tips
- Copilot learns from context, so suggestions improve as you write more code
- If you don't see a suggestion immediately, wait a moment or continue typing
- Sometimes multiple suggestions are available
- Pay attention to how Copilot suggests common parameter values based on context

## Exercise 2: Generating PowerShell Snippets

**Feature Focus: Code Generation from Natural Language**

### Instructions

1. Open `Exercise2.ps1`
2. Open Copilot Chat
3. For each task in the exercise file:
   - Copy the task description into Copilot Chat
   - Review the generated code
   - Explore options to transfer the code to your file
   - Review and modify the code as needed
   - Add comments explaining what the code does

### Example Prompts
- "Generate PowerShell code to get the current date and time in yyyy-MM-dd format"
- "Write a PowerShell function to calculate factorial of a number"
- "Create PowerShell code to check if a specific service is running"

## Exercise 3: Understanding PowerShell Code

**Feature Focus: Code Explanation with `/explain`**

### Instructions

1. Open `Exercise3.ps1`
2. For each code snippet:
   - Select the code in the editor
   - Either:
     - Right-click and select "Copilot" > "Explain This"
     - Open Copilot Chat and type `/explain` with the code selected
   - Read and understand Copilot's explanation
   - Add your own comments to the code based on what you learned
   - Try selecting smaller parts of complex snippets for more targeted explanations
3. Try and explore the other options available with `/help`

## Exercise 4: Fixing PowerShell Code with Copilot

**Feature Focus: Code Fixing with `/fix`**


### Instructions

1. Open `Exercise4.ps1`
2. For each code snippet with errors:
   - Select the code in the editor
   - Either:
     - Right-click and select "Copilot" > "Fix This"
     - Open Copilot Chat and type `/fix` with the code selected
   - Review Copilot's suggested fixes
   - Implement the fixes and run the code to confirm it works
   - Add comments explaining what was wrong and how it was fixed