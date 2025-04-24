$OutputPath = (Join-Path -Path $PSScriptRoot -ChildPath 'TestData')
$NumberOfFiles = 50
$MinLength = 10
$MaxLength = 10000

if (-not (Test-Path -Path $OutputPath -PathType Container)) {
    try {
        New-Item -Path $OutputPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
    }
    catch {
        Write-Error "Failed to create output directory '$OutputPath'. Error: $($_.Exception.Message)"
        return
    }
}

$characterSet = [char[]]((0x61..0x7A) + (0x41..0x5A) + (0x30..0x39) + 0x20)

Write-Host "Generating $NumberOfFiles test files in '$OutputPath'..."

$padWidth = $NumberOfFiles.ToString().Length

for ($i = 1; $i -le $NumberOfFiles; $i++) {
    $fileName = "TestFile{0:D$padWidth}.txt" -f $i
    $filePath = Join-Path -Path $OutputPath -ChildPath $fileName

    $contentLength = Get-Random -Minimum $MinLength -Maximum ($MaxLength + 1)

    $randomChars = 1..$contentLength | ForEach-Object { Get-Random -InputObject $characterSet }
    $randomContent = [System.String]::new($randomChars)

    try {
        Out-File -FilePath $filePath -InputObject $randomContent -Encoding UTF8 -ErrorAction Stop -NoNewline
    }
    catch {
        Write-Error "Failed to write file '$filePath'. Error: $($_.Exception.Message)"
        continue
    }
}

Write-Host "Successfully generated $NumberOfFiles test files in '$OutputPath'."
