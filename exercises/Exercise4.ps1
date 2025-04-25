# Exercise 4: PowerShell Code with Errors to Fix

#=======================================================
# Example 1: Syntax Error
# This function has a syntax error - use /fix to correct it
function Get-SystemInfo {
    param(
        [string]$ComputerName
    
    # Missing closing parenthesis and bracket
    $osInfo = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ComputerName
    return $osInfo
}

#=======================================================
# Example 2: Logic Error
# This script has a logic error in the loop - use /fix to correct it
$numbers = 1..10
$sum = 0
for ($i = 0; $i <= $numbers.Length; $i++) {
    $sum += $numbers[$i]
}
Write-Output "Sum of numbers: $sum"

#=======================================================
# Example 3: Parameter Validation Error
# This function's parameter validation is incorrect - use /fix to correct it
function Get-FileContent {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_})]
        [string]$Path,
        
        [Parameter(Mandatory=$true)]
        [ValidateSet("ASCII", "Unicode", "UTF8", "UTF7")]
        [string]$Encoding = "UTF8"
    )
    
    Get-Content -Path $Path -Encoding $Encoding
}

#=======================================================
# Example 4: Performance Issue
# This code works but has performance issues - use /fix to optimize it
function Find-LargeFiles {
    param(
        [string]$FolderPath,
        [int]$MinimumSizeMB = 100
    )
    
    $allFiles = Get-ChildItem -Path $FolderPath -Recurse
    $results = @()
    
    foreach ($file in $allFiles) {
        if (-not $file.PSIsContainer) {
            $sizeInMB = $file.Length / 1MB
            if ($sizeInMB -ge $MinimumSizeMB) {
                $results += $file
            }
        }
    }
    
    return $results
}

#=======================================================
# Example 5: Error Handling Issue
# This code doesn't handle errors properly - use /fix to add proper error handling
function Connect-ToServer {
    param(
        [string]$ServerName,
        [int]$Port = 443
    )
    
    $client = New-Object System.Net.Sockets.TcpClient
    $client.Connect($ServerName, $Port)
    
    if ($client.Connected) {
        Write-Output "Successfully connected to $ServerName on port $Port"
    }
    else {
        Write-Output "Failed to connect to $ServerName on port $Port"
    }
    
    $client.Close()
}
