Print text and prompts an input of "A or B"
    
    Write-Host ""
    Write-Host "What would you like to do?"
    Write-Host "A) Collect new Baseline?"
    Write-Host "B) Begin Monitoring Files with saved Baseline?"
    Write-Host ""

    $response = Read-Host -Prompt "Please enter 'A' or 'B'"
    Write-Host ""



Return the hash of the contents within a file

    Function Calculate-FIle-Hash($filepath) {
        $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
        return $filehash 
    }

- Test output and store within variable $hash 

      $hash = Calculate-File-Hash "C:\Users\****\****\****\****\****\****\FIM\a.txt"

      Algorithm       Hash                                                                   Path                                                                                                                                          
      ---------       ----                                                                   ----                                                                                                                                          
      SHA512          1B86355F13A7F0B90C8B6053C0254399994DFBB3843E08D603E292CA13B8F672ED5... C:\Users\bchoi\OneDrive\Documents\Career\Cybersecurity\Projects\FIM\a.txt

Outputs hash content into new file "baseline.txt

    #For each file, calculate the hash, and write to baseline.txt
    foreach ($f in $files) {
        $hash = Calculate-FIle-Hash $f.FullName
        "$($hash.path) | $($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append



![image](https://github.com/user-attachments/assets/4bbeac53-c44c-4511-801d-f6b4017a62d5)



      C:\Users\...\a.txt | 1B86355F13A7F0B90C8B6053C0254399994DFBB3843E08D603E292CA13B8F672ED5E58791C10F3E36DAEC9699CC2FBDC88B4FE116EFA7FCE016938B787043818
      C:\Users\...\b.txt | 9B73D9AA7CEC73BE610B857AB0DB7043E0FAD84C99015037015E0DE1D0AD076F6C838727417E0D77735C978DFC8D05BD3B92DE2D23B810F69FC4316202F201B1
      C:\Users\...\c.txt | 20505A0C374C7D6B0DAB8CF336E56FE953EA2E80253C1E63371D0C3D4F443E716ACF419A63319A88BD01B05C89BFA8977810F65E5B1DCF2D4DA41AEB4E0EAC11




Removes existing baseline.txt file

    Function Erase-Baseline-If-Already-Exists(){
    Test-Path -Path .\baseline.txt
        #Remove existing file
        Remove-Item -Path .\baseline.txt
    }


Create dictionary

    #Load file | hash from baseline.txt and store in dictionary
        $fileHashDictionary = @{}
        $fileHashDictionary.add("path","hash")
        $fileHashDictionary
        $fileHashDictionary["path"]

Split the output of the baseline.txt content

[0] = file path

[1] = hash

       foreach ($f in $filePathsAndHashes) {
            $f.Split("|")[1]
            }


Create dictionary, add baseline.txt content to dictionary in format path | Hash, output dictionary

    #Create Dictionary
        $fileHashDictionary = @{}
        #Load file | hash from baseline.txt and store in dictionary
        $filePathsAndHashes = Get-Content -Path .\baseline.txt

        foreach ($f in $filePathsAndHashes) {
             $fileHashDictionary.add( $f.Split("|")[0], $f.Split("|")[1])
            }

        $fileHashDictionary

Create loop

    #Continuously monitor files with saved baseline
        while ($true) {
        Start-Sleep -Seconds 1
          Write-Host "Checking if files match..." -ForegroundColor Yellow
        }





