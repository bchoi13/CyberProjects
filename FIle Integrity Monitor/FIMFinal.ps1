Write-Host ""
Write-Host "What would you like to do?"
Write-Host "A) Collect new Baseline?"
Write-Host "B) Begin Monitoring Files with saved Baseline?"
Write-Host ""

$response = Read-Host -Prompt "Please enter 'A' or 'B'"
Write-Host ""

# Function to calculate the hash of a file
Function Calculate-File-Hash($filepath) {
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $filehash
}

# Function to erase the existing baseline file
Function Erase-Baseline-If-Already-Exists() {
    $baselineExists = Test-Path -Path .\baseline.txt
    if ($baselineExists) {
        Remove-Item -Path .\baseline.txt
    }
}

if ($response -eq "A".ToUpper()) {
    # Delete baseline.txt if it already exists
    Erase-Baseline-If-Already-Exists

    # Collect all files in the target folder
    $files = Get-ChildItem -Path .\Files

    # Calculate hash for each file and save to baseline.txt
    foreach ($f in $files) {
        $hash = Calculate-File-Hash $f.FullName
        "$($hash.Path) | $($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append
    }

    Write-Host "New baseline has been created!" -ForegroundColor Green
}

elseif ($response -eq "B".ToUpper()) {
    # Load the baseline data into a dictionary
    $fileHashDictionary = @{}
    $filePathsAndHashes = Get-Content -Path .\baseline.txt

    foreach ($f in $filePathsAndHashes) {
        $pathAndHash = $f.Split("|")
        $fileHashDictionary[$pathAndHash[0].Trim()] = $pathAndHash[1].Trim()
    }

    # Monitor files continuously
    while ($true) {
        Start-Sleep -Seconds 1

        $files = Get-ChildItem -Path .\Files

        foreach ($f in $files) {
            # Skip monitoring of baseline.txt to prevent self-detection
            if ($f.Name -eq "baseline.txt") {
                continue
            }

            # Calculate the current file's hash
            $hash = Calculate-File-Hash $f.FullName

            # Check if it's a new file
            if (-Not $fileHashDictionary.ContainsKey($hash.Path)) {
                Write-Host "$($hash.Path) has been created!" -ForegroundColor Green
                $fileHashDictionary[$hash.Path] = $hash.Hash
            }
            # Check if the file has changed
            elseif ($fileHashDictionary[$hash.Path] -ne $hash.Hash) {
                Write-Host "$($hash.Path) has changed!" -ForegroundColor Yellow
                $fileHashDictionary[$hash.Path] = $hash.Hash
            }
        }

        # Check for deleted files
        foreach ($key in $fileHashDictionary.Keys) {
            $baselineFileStillExists = Test-Path -Path $key
            if (-Not $baselineFileStillExists) {
                Write-Host "$($key) has been deleted!" -ForegroundColor DarkRed
                $fileHashDictionary.Remove($key)
            }
        }
    }
}