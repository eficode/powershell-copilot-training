# Exercise 3: Understanding PowerShell Code with Copilot Chat
# GitHub Copilot Feature: Code Explanation with /explain

# INSTRUCTIONS:
# 1. For each code snippet, select it in VS Code
# 2. Either right-click and select "Copilot" > "Explain This" or use Copilot Chat with /explain
# 3. Write your own comments above each snippet explaining what it does, based on Copilot's explanation
# 4. Note any potential improvements or issues with the code

# Snippet 1: Finding and preparing to remove old log files
# Add your explanation here:

Get-ChildItem -Path $env:TEMP -Filter *.log -ErrorAction SilentlyContinue | 
    Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-7)} | 
    ForEach-Object { Remove-Item $_.FullName -Force -WhatIf }

# Snippet 2: Gathering system information
# Add your explanation here:

$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
$operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem
$bios = Get-CimInstance -ClassName Win32_BIOS
$processor = Get-CimInstance -ClassName Win32_Processor

$systemInfo = [PSCustomObject]@{
    ComputerName = $computerSystem.Name
    Manufacturer = $computerSystem.Manufacturer
    Model = $computerSystem.Model
    SerialNumber = $bios.SerialNumber
    OSName = $operatingSystem.Caption
    OSVersion = $operatingSystem.Version
    ProcessorName = $processor.Name
    TotalMemoryGB = [math]::Round($computerSystem.TotalPhysicalMemory / 1GB, 2)
}

$systemInfo | Format-List

# Snippet 3: Advanced function with parameter validation
# Add your explanation here:

function Get-DiskReport {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateScript({Test-Path $_ -PathType 'Container'})]
        [string]$Path,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('Size', 'Name', 'Extension', 'LastModified')]
        [string]$SortBy = 'Size',
        
        [Parameter(Mandatory=$false)]
        [switch]$Descending,
        
        [Parameter(Mandatory=$false)]
        [ValidateRange(1, 1000)]
        [int]$Top = 10
    )
    
    $files = Get-ChildItem -Path $Path -File -Recurse -ErrorAction SilentlyContinue
    
    $sortParams = @{
        Property = switch ($SortBy) {
            'Size' { 'Length' }
            'Name' { 'Name' }
            'Extension' { 'Extension' }
            'LastModified' { 'LastWriteTime' }
        }
        Descending = $Descending
    }
    
    $result = $files | Sort-Object @sortParams | Select-Object -First $Top -Property Name, 
        @{Name='SizeInMB';Expression={[math]::Round($_.Length / 1MB, 2)}},
        Extension, LastWriteTime, FullName
    
    return $result
}

# Snippet 4: Script with error handling and logging
# Add your explanation here:

try {
    $logPath = Join-Path -Path $env:TEMP -ChildPath "script_log_$(Get-Date -Format 'yyyyMMdd').txt"
    Start-Transcript -Path $logPath -Append
    
    Write-Host "Script started at $(Get-Date)" -ForegroundColor Green
    
    $services = Get-Service | Where-Object { $_.Status -eq 'Running' }
    Write-Host "Found $($services.Count) running services." -ForegroundColor Cyan
    
    foreach ($service in $services) {
        if ($service.DisplayName -match 'Windows') {
            Write-Host "Windows service: $($service.DisplayName)" -ForegroundColor Yellow
            # Process Windows services
        } else {
            Write-Host "Other service: $($service.DisplayName)" -ForegroundColor Gray
            # Process other services
        }
    }
} catch {
    Write-Error "An error occurred: $_"
    $errorDetails = @{
        Date = Get-Date
        Error = $_.Exception.Message
        ScriptLine = $_.InvocationInfo.ScriptLineNumber
        Command = $_.InvocationInfo.MyCommand
    }
    Export-Csv -Path "$env:TEMP\script_errors.csv" -InputObject $errorDetails -Append -NoTypeInformation
} finally {
    Write-Host "Script completed at $(Get-Date)" -ForegroundColor Green
    Stop-Transcript
}

# REFLECTION:
# What complex PowerShell concepts did you learn about?
# How helpful was Copilot's explanation compared to reading documentation?
# Could you apply this knowledge to your own PowerShell scripts?
