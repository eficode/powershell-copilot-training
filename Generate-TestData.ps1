# filepath: c:\learning\demos\powershell-copilot-training\Generate-TestData.ps1
<#
.SYNOPSIS
    Generates test data files in a directory structure with customizable properties.

.DESCRIPTION
    This script creates a random directory structure with test files of various types and sizes.
    It's useful for generating test data for development, testing, or demonstrations.
    The script creates random directories and populates them with files that have random names,
    extensions, and content to simulate a realistic file system.

.PARAMETER TargetDirectory
    Specifies the root directory where test data will be generated.
    If the directory doesn't exist, it will be created.
    Default value is ".\TestData" (relative to the current directory).

.PARAMETER MaxFiles
    Specifies the maximum number of files to generate across all directories.
    Default value is 100 files.

.PARAMETER MaxDirectoryDepth
    Specifies the maximum depth of the directory structure.
    Default value is 5 levels deep.

.PARAMETER MaxFileSize
    Specifies the maximum size of generated files in bytes.
    Default value is 2MB (2 megabytes).
    Must be greater than zero.

.EXAMPLE
    .\Generate-TestData.ps1
    
    Generates 100 files with a maximum size of 2MB in a directory structure up to 5 levels deep 
    in the ".\TestData" directory.

.EXAMPLE
    .\Generate-TestData.ps1 -TargetDirectory "C:\Temp\MyTestData" -MaxFiles 50
    
    Generates 50 files with a maximum size of 2MB in the "C:\Temp\MyTestData" directory.

.EXAMPLE
    .\Generate-TestData.ps1 -MaxFiles 200 -MaxFileSize 5MB -MaxDirectoryDepth 3
    
    Generates 200 files with a maximum size of 5MB in a directory structure up to 3 levels deep 
    in the ".\TestData" directory.

.EXAMPLE
    .\Generate-TestData.ps1 -Verbose
    
    Generates files with additional verbose output during the generation process.

.NOTES
    File Name      : Generate-TestData.ps1
    Author         : System Administrator
    Prerequisite   : PowerShell 5.0 or later
    Copyright      : (c) 2025 Your Organization
    License        : MIT
    Version        : 1.0
    
    The script will display statistics about the generated test data upon completion,
    including total size, file count by extension, and the largest files created.
#>

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [string]$TargetDirectory = ".\TestData",

    [Parameter(Position = 1)]
    [int]$MaxFiles = 100,

    [Parameter(Position = 2)]
    [int]$MaxDirectoryDepth = 5,

    [Parameter(Position = 3)]
    [ValidateScript({$_ -gt 0})]
    [long]$MaxFileSize = 2MB
)

function Write-Log {
    param (
        [string]$Message,
        [ValidateSet("Info", "Warning", "Error")]
        [string]$Level = "Info"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] [$Level] $Message"
}

function New-RandomSubdirectory {
    param (
        [string]$BasePath,
        [int]$CurrentDepth = 1,
        [int]$MaxDepth = 5
    )

    if ($CurrentDepth -gt $MaxDepth) {
        return $null
    }

    # Generate a random subdirectory name - human readable combination of letters and numbers
    $words = @("Data", "Files", "Documents", "Archive", "Backup", "Project", "Work", "Personal", "Important", "Temp")
    $randomWord = $words | Get-Random
    $randomNumber = Get-Random -Minimum 1 -Maximum 1000
    $dirName = "$randomWord$randomNumber"
    $dirPath = Join-Path -Path $BasePath -ChildPath $dirName

    # Create the directory
    if (!(Test-Path -Path $dirPath)) {
        New-Item -Path $dirPath -ItemType Directory -Force | Out-Null
        Write-Log "Created directory: $dirPath"
    }

    return $dirPath
}

function Get-RandomFileExtension {
    # Common file types found on office/home computers
    $fileTypes = @{
        "Documents" = @(".docx", ".xlsx", ".pptx", ".pdf", ".txt", ".rtf", ".md")
        "Images"    = @(".jpg", ".png", ".gif", ".bmp", ".tiff", ".svg")
        "Audio"     = @(".mp3", ".wav", ".aac", ".flac", ".ogg")
        "Video"     = @(".mp4", ".avi", ".mov", ".wmv", ".mkv")
        "Archives"  = @(".zip", ".rar", ".7z", ".tar", ".gz")
        "Code"      = @(".ps1", ".js", ".html", ".css", ".py", ".java", ".cs")
        "Data"      = @(".csv", ".xml", ".json", ".sql", ".dat")
    }

    # First select a random category, then a random extension from that category
    $category = $fileTypes.Keys | Get-Random
    $extension = $fileTypes[$category] | Get-Random

    return $extension
}

function Get-RandomContent {
    param (
        [int]$MinBytes = 100,
        [int]$MaxBytes = 2MB
    )

    # Static source of data - we'll just generate a large string once and then take portions of it
    if (-not $script:ContentSource -or $MaxBytes -gt $script:ContentSourceSize) {
        Write-Log "Generating content source for size up to $([math]::Round($MaxBytes / 1MB, 2)) MB..." -Level Info
        
        # Create a content source large enough to handle our max file size
        # Ensure source is at least 20% larger than the max file size
        $sourceSize = [Math]::Max($MaxBytes * 1.2, 5MB)
        $script:ContentSource = [System.Text.StringBuilder]::new($sourceSize)
        $script:ContentSourceSize = $sourceSize
        
        # Add some text content
        $loremIpsum = @'
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
'@ * 1000
        [void]$script:ContentSource.Append($loremIpsum)
        
        # Add some binary-looking content
        $binarySize = [Math]::Min(100000, $sourceSize / 10)
        for ($i = 0; $i -lt $binarySize; $i++) {
            [void]$script:ContentSource.Append([char](Get-Random -Minimum 32 -Maximum 126))
        }
        
        # Add some code-like content
        $codeSample = @'
function Test-Function {
    param(
        [string]$Parameter1,
        [int]$Parameter2 = 42
    )
    
    $result = $null
    
    for ($i = 0; $i -lt $Parameter2; $i++) {
        $result += "$Parameter1 - $i`n"
    }
    
    return $result
}

$data = @{
    "Key1" = "Value1"
    "Key2" = 123
    "Key3" = @(1, 2, 3, 4, 5)
}

foreach ($item in $data.Keys) {
    Write-Output "$item = $($data[$item])"
}

# This is a sample JSON structure
$jsonContent = @"
{
    "name": "Test Object",
    "properties": {
        "id": 12345,
        "enabled": true,
        "tags": ["tag1", "tag2", "tag3"],
        "metadata": {
            "created": "2023-01-01T00:00:00Z",
            "modified": "2023-02-15T12:30:45Z"
        }
    }
}
"@
'@ * 50
        [void]$script:ContentSource.Append($codeSample)
        
        # If we need more content to reach our target size, repeat the content
        while ($script:ContentSource.Length -lt $sourceSize * 0.8) {
            [void]$script:ContentSource.Append($script:ContentSource.ToString())
        }
        
        Write-Log "Content source generated with size: $([Math]::Round($script:ContentSource.Length / 1MB, 2)) MB" -Level Info
    }

    # Calculate a random size within our bounds - but cap it at content source length
    $maxContentSize = [Math]::Min($MaxBytes, $script:ContentSource.Length - 100)
    $contentSize = Get-Random -Minimum $MinBytes -Maximum $maxContentSize

    # Make sure content size isn't larger than our source
    if ($contentSize -gt $script:ContentSource.Length) {
        $contentSize = $script:ContentSource.Length - 100
    }

    # Take a random slice of the content source with the desired length
    $maxStartPos = $script:ContentSource.Length - $contentSize
    if ($maxStartPos -lt 1) { $maxStartPos = 1 }
    
    $startPos = Get-Random -Minimum 0 -Maximum $maxStartPos
    $endPos = $startPos + $contentSize
    
    # Double check bounds
    if ($endPos -gt $script:ContentSource.Length) { $endPos = $script:ContentSource.Length }

    $actualLength = $endPos - $startPos
    return $script:ContentSource.ToString().Substring($startPos, $actualLength)
}

function New-TestFile {
    param (
        [string]$Directory,
        [string]$Extension = $null,
        [long]$MaxBytes = $MaxFileSize
    )

    # Generate a random file name
    $adjectives = @("Red", "Blue", "Green", "Yellow", "Purple", "Orange", "White", "Black", "Fast", "Slow", "Big", "Small", "Heavy", "Light")
    $nouns = @("Car", "Book", "Computer", "Phone", "Table", "Chair", "Window", "Door", "Paper", "Pencil", "Box", "Cup", "Dog", "Cat")
    
    $randomAdjective = $adjectives | Get-Random
    $randomNoun = $nouns | Get-Random
    $randomNumber = Get-Random -Minimum 1 -Maximum 1000
    
    # Always ensure we have a valid extension
    if ([string]::IsNullOrEmpty($Extension)) {
        $Extension = Get-RandomFileExtension
    }
    
    # Make sure extension starts with a dot
    if (-not $Extension.StartsWith('.')) {
        $Extension = ".$Extension"
    }

    $fileName = "$randomAdjective$randomNoun$randomNumber$Extension"
    Write-Verbose "Creating file with name: $fileName including extension: $Extension"
    $filePath = Join-Path -Path $Directory -ChildPath $fileName

    # Generate random file content
    $content = Get-RandomContent -MinBytes 100 -MaxBytes $MaxBytes

    # Create the file
    try {
        Set-Content -Path $filePath -Value $content -Force -NoNewline
        $fileSize = (Get-Item -Path $filePath).Length
        Write-Log "Created file: $filePath ($([math]::Round($fileSize / 1KB, 2)) KB)"
        return $true
    }
    catch {
        Write-Log "Failed to create file $filePath. Error: $($_.Exception.Message)" -Level Error
        return $false
    }
}

function Get-HumanReadableSize {
    param (
        [Parameter(Mandatory = $true)]
        [long]$SizeInBytes
    )
    
    $sizes = @('B', 'KB', 'MB', 'GB', 'TB')
    $order = 0
    
    while ($SizeInBytes -ge 1024 -and $order -lt $sizes.Count - 1) {
        $SizeInBytes /= 1024
        $order++    }
    
    return "{0:N2} {1}" -f $SizeInBytes, $sizes[$order]
}

function Show-TestDataStatistics {
    param (
        [Parameter(Mandatory = $true)]
        [string]$TargetDirectory
    )
    
    Write-Log "Calculating statistics for test data..." -Level Info
    
    # Get all files recursively
    $files = Get-ChildItem -Path $TargetDirectory -Recurse -File
    
    if (-not $files -or $files.Count -eq 0) {
        Write-Log "No files found in $TargetDirectory" -Level Warning
        return
    }
    
    # Calculate total size
    $totalSize = ($files | Measure-Object -Property Length -Sum).Sum
    $totalSizeHuman = Get-HumanReadableSize -SizeInBytes $totalSize
    
    Write-Log "Total size of all files: $totalSizeHuman ($($files.Count) files)" -Level Info
    
    # Group by extension and calculate size for each
    $extensionStats = $files | 
        Group-Object -Property Extension | 
        ForEach-Object {
            $extSize = ($_.Group | Measure-Object -Property Length -Sum).Sum
            $extSizeHuman = Get-HumanReadableSize -SizeInBytes $extSize
            
            [PSCustomObject]@{
                Extension = if ($_.Name) { $_.Name } else { "(no extension)" }
                Count = $_.Count
                Size = $extSize
                SizeHuman = $extSizeHuman
                PercentOfTotal = [math]::Round(($extSize / $totalSize) * 100, 2)
            }
        } | 
        Sort-Object -Property Size -Descending
    
    # Display statistics by extension
    Write-Log "File size by extension:" -Level Info
    
    $extensionStats | ForEach-Object {
        Write-Log ("  {0,-8} {1,6} files, {2,10}, {3,5}%" -f 
            $_.Extension, $_.Count, $_.SizeHuman, $_.PercentOfTotal) -Level Info
    }
    
    # Show largest files
    $largestFiles = $files | 
        Sort-Object -Property Length -Descending | 
        Select-Object -First 5
    
    Write-Log "Largest files:" -Level Info
    $largestFiles | ForEach-Object {
        $sizeHuman = Get-HumanReadableSize -SizeInBytes $_.Length
        Write-Log ("  {0,-50} {1,10}" -f $_.Name, $sizeHuman) -Level Info
    }
}

# Main script execution starts here
Write-Log "Starting test data generation"

# Resolve the target directory to an absolute path
$absoluteTargetPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($TargetDirectory)
Write-Log "Target directory: $absoluteTargetPath"

# Create the root directory if it doesn't exist
if (!(Test-Path -Path $absoluteTargetPath)) {
    New-Item -Path $absoluteTargetPath -ItemType Directory -Force | Out-Null
    Write-Log "Created root directory: $absoluteTargetPath"
}

# Create a directory structure
$directories = @($absoluteTargetPath)
$dirCount = Get-Random -Minimum 5 -Maximum 25
Write-Log "Generating approximately $dirCount directories with max depth of $MaxDirectoryDepth"

for ($i = 0; $i -lt $dirCount; $i++) {
    $parentDir = $directories | Get-Random
    $depth = (($parentDir.Split([IO.Path]::DirectorySeparatorChar)).Length - ($absoluteTargetPath.Split([IO.Path]::DirectorySeparatorChar)).Length) + 1
    
    if ($depth -lt $MaxDirectoryDepth) {
        $newDir = New-RandomSubdirectory -BasePath $parentDir -CurrentDepth $depth -MaxDepth $MaxDirectoryDepth
        if ($newDir) {
            $directories += $newDir
        }
    }
}

Write-Log "Created $($directories.Count) directories in total"
Write-Log "Generating up to $MaxFiles files across directories"

# Create random files across the directories
$fileCount = 0
while ($fileCount -lt $MaxFiles) {
    $targetDir = $directories | Get-Random
    if (New-TestFile -Directory $targetDir) {
        $fileCount++
        
        # Show progress every 10 files
        if ($fileCount % 10 -eq 0) {
            $percentComplete = [math]::Round(($fileCount / $MaxFiles) * 100)
            Write-Log "Progress: $fileCount of $MaxFiles files created ($percentComplete%)"
        }
    }
}

Write-Log "Test data generation complete. Created $fileCount files across $($directories.Count) directories."
Write-Log "Test data location: $absoluteTargetPath"

# Show statistics about the generated test data
Show-TestDataStatistics -TargetDirectory $absoluteTargetPath