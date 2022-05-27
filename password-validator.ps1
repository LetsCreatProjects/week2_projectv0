#!/usr/bin/env pwsh

#-----------------------
# Global variables
# ----------------------
param($in)
$global:LASTEXITCODE = 1

# checks the user's input in command line
$global:arr_cliHistory = @(Get-History)
# takes last command
$global:str_lastCliCommand = $arr_cliHistory[-1]


# $tmp = Get-History | select-last 1

 Write-Host $in
#-----------------------
# pwValidation // checks validation of the password
# ----------------------
function pwValidation {
    param ($pw)
    # --if greater than 10
    if ($pw.length -gt 9) {
        # -- if contains at least one number
        if ($pw -match '\d') {
            # -- if contains at least one uppercase char
            if ($pw -cmatch “[A-Z]”) {
                # -- if contains at least one lowercase char
                if ($pw -cmatch “[a-z]”) {  
                    Write-Host "The password: $pw is valid." -ForegroundColor Green 
                    $global:LASTEXITCODE = 0
                }
                else { Write-Host "Please include minimum one lower case character in the password.Your input:$pw" -ForegroundColor Red; $global:LASTEXITCODE = 1 }
            }
            else { Write-Host "Please include minimum one capital character in the password.Your input:$pw" -ForegroundColor Red ; $global:LASTEXITCODE = 1 }
        }
        else { Write-Host "Please include minimum one number in the password.Your input:$pw" -ForegroundColor Red ; $global:LASTEXITCODE = 1 } 
    }
    else { Write-Host "Please input password with minimum 10 character length.Your input:$pw" -ForegroundColor Red ; $global:LASTEXITCODE = 1 }  
}

# ---------------------------------------------------------------------------------------------
# Check the option that user has been chosen: a. Password as an input. b. Password inside file
# ---------------------------------------------------------------------------------------------

function checkInputCategory() {
    # --- If chosen option to check password in file.
    if ($global:str_lastCliCommand -like '* -f "/*') {

        # retrieve filepath from input
        $filePathAndName = "$global:str_lastCliCommand".replace('./password-validator.ps1 -f "', '')

        # Delete last char if the value of it is: "
        $filePathAndName = $filePathAndName.Trim().TrimEnd('"')
        $filePathAndName = $filePathAndName.Trim().TrimStart('/')

                if (Test-Path -Path "$filePathAndName") {
                    $pw_from_file = [IO.File]::ReadAllText("$filePathAndName")
            
                    if (!$pw_from_file) { Write-Host 'Please insert the password inside the file: (the password should contain minimum 10 characters, that contains number, small and capital letter.' -ForegroundColor Red ; $global:LASTEXITCODE = 1 } 
                    else {
                        $pw_from_file=cat $filePathAndName  
                        pwValidation "${pw_from_file}"
                    }
                }
                else { Write-Host "The file: $filePathAndName do not exists. Please enter valid file."  -ForegroundColor Red ; $global:LASTEXITCODE = 1 } 
    }
    # --- If chosen option to check password as text.
    elseif (!$in) { Write-Host 'Invalid input. Please insert input in this format: {./password-validator.ps1 "MyPW123"} or {./password-validator.ps1 -f "/mypath/password.txt"}' -ForegroundColor Red ; $global:LASTEXITCODE = 1 } 
    else { pwValidation "$in" }
}
# ---------------------------------------------------------------------------------------------
# init
# ---------------------------------------------------------------------------------------------

checkInputCategory
write-host "exit code---------$global:LASTEXITCODE "
