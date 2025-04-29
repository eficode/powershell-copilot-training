# Workshop 2:

Refer to the details of the project implementation in this [backlog](./project/backlog.md) file.

# Workshop 1:

# Module 1: PowerShell Prompt Engineering with GitHub Copilot

### Prerequisites

- Visual Studio Code
   - [GitHub Copilot extension](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
   - [GitHub Copilot Chat extension](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)
   - [PowerShell extension](https://marketplace.visualstudio.com/items/?itemName=ms-vscode.PowerShell)
- PowerShell 5, but 7.x recommended

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

# Module 2: GitHub Copilot PowerShell Exercises

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
4. You can also experiment with using inline chat for Code generation (Default: `Cmd+I` / `Ctrl+I`), often used for quick explanations or edits on selected code.

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
3. Try documenting the code with Copilot 
4. Try and explore the other options available with `/help`

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

## Exercise 5: Advanced Test Data Generation with Caching and Structure

**Feature Focus: Refactoring, Code Generation, Optimisation (Caching), File System Structure, Statistics, Documentation**

**Goal:** Significantly enhance the basic `Exercise5.ps1` script to include parameterisation, a nested directory structure, varied file extensions, an optimised content caching mechanism, final statistics reporting, and **comprehensive PowerShell comment-based help**. The aim is to create a flexible, efficient, and well-documented test data generator.

### Instructions

1. **Open `Exercise5.ps1`** This script currently creates a fixed number of simple text files with random character content in a single directory  
2. **Understand the optimisation goal:** Generating random content character-by-character for every file is slow. We'll implement "caching": generate a large block of diverse "source" text *once* (on the fly when needed) and store it in a variable. Then, for each file, we'll reuse a random portion (slice) of that source text. This avoids repeated, slow generation  
3. **Refactor `Exercise5.ps1` using Copilot (Step-by-Step):**  
   * **Parameterise:** Ask Copilot to add parameters:  
      * `-TargetDirectory` (string, default 'TestData')  
      * `-MaxFiles` (int, default 100)  
      * `-MaxFileSize` (long, default 2MB, validate > 0)  
      * `-MaxDirectoryDepth` (int, default 5)  
      * *Example prompt: "Add parameters -TargetDirectory, -MaxFiles, -MaxFileSize, and -MaxDirectoryDepth to this script. Add validation for MaxFileSize"*  
   * **Directory structure:** Ask Copilot to help create logic to generate random subdirectories within the `-TargetDirectory`, up to the specified `-MaxDirectoryDepth`. You'll need a way to choose a random directory (from the ones already created) to place each new file or subdirectory  
      * *Example prompt: "Write a function New-RandomSubdirectory that takes a base path and depth, creates a subdirectory with a random name (e.g., 'Data123', 'Archive456'), and returns the path. Ensure it doesn't exceed MaxDirectoryDepth"*  
      * *Example prompt: "Modify the main loop to randomly select an existing directory from a list and potentially create a new subdirectory within it before creating a file"*  
   * **Random file extensions:** Ask Copilot to create a function `Get-RandomFileExtension` that returns a random extension (like `.txt`, `.log`, `.dat`, `.tmp`, `.docx`, `.jpg`) from a predefined list or hashtable. Use this function when naming files  
      * *Example prompt: "Create a function Get-RandomFileExtension that returns a random extension from a list like .txt, .log, .dat, .tmp"*  
      * *Example prompt: "Modify the file creation logic to use Get-RandomFileExtension for the file name"*  
   * **Content generation function:** Ask Copilot to refactor the content generation logic into a function `Get-RandomContent` that takes a desired content length  
      * *Example prompt: "Refactor the content generation part into a function called Get-RandomContent that takes a length parameter"*  
   * **Implement caching:** Modify `Get-RandomContent` to implement caching  
      * Use a script-scoped variable (e.g., `$script:ContentSource`) to store the cached text  
      * Inside the function, check if `$script:ContentSource` is empty or not large enough for `-MaxFileSize`  
      * If needed, generate a large source string *once*. **Enhancement:** Ask Copilot to include not just letters/numbers but also some punctuation, line breaks, and maybe even some characters that *look* like binary data (e.g., from a wider ASCII range) to make the source more varied. Store this in `$script:ContentSource`  
      * *Example prompt: "Modify Get-RandomContent to use a script-scoped variable $script:ContentSource for caching. Generate the source content once if it's empty or too small. Include varied characters in the source"*  
      * Instead of generating new random characters, get the desired `$contentLength` and extract a random substring (slice) of that length from `$script:ContentSource`  
      * *Example prompt: "Inside Get-RandomContent, after ensuring the cache exists, how can I get a random substring of length $contentLength from $script:ContentSource"*  
   * **Integrate:** Ensure your main loop calls the updated `Get-RandomContent` function and places the file in a randomly chosen directory from your structure  
4. **Add statistics:** After the file generation loop, ask Copilot to help create a function (e.g., `Show-TestDataStatistics`) that
   * Recursively gets all generated files (`Get-ChildItem -Recurse -File`)
   * Calculates and displays the total number of files and total size (use `Measure-Object`)
   * Groups files by extension (`Group-Object Extension`) and shows the count and total size for each extension  
   * (Optional) Shows the top 5 largest files
   * *Example prompt: "Create a function Show-TestDataStatistics that takes the target directory, finds all files, calculates total size, groups by extension showing count/size per extension, and displays this information"*  
   * Call this function at the end of the script  
5. **Add Documentation:** Ask Copilot to help you add comprehensive PowerShell comment-based help to the *top* of your script  
   * Ensure it includes `.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER` descriptions for *each* parameter you added, and at least two `.EXAMPLE` sections showing how to run the script with different parameters  
   * *Example prompt: "Add comment-based help to this script, including synopsis, description, parameter help for TargetDirectory, MaxFiles, MaxFileSize, and MaxDirectoryDepth, and two examples"*  
   * Review and refine the generated help content for clarity and accuracy  
6. **Test:** Run your script with different parameters (e.g., `-MaxFiles 500 -MaxFileSize 1MB -MaxDirectoryDepth 4`). Observe the directory structure, file types, and the final statistics report. Use `Get-Help .\YourScriptName.ps1 -Full` to view your documentation. Note the performance improvement due to caching  

### Tips

*   Tackle one bullet point under "Refactor" at a time. Use Copilot Chat for each step.
*   Use `/explain` in Chat to understand complex code snippets Copilot provides (like directory recursion or caching logic)
*   Be specific: "Create a function..." is better than "Do this...". Mention PowerShell cmdlets you think might be relevant (e.g., `Get-Random`, `Join-Path`, `New-Item`, `Get-ChildItem`, `Group-Object`, `Measure-Object`).
*   Remember that static lists for things like directory name parts or file extensions are perfectly fine for this exercise
*   Good documentation is crucial for reusable scripts!