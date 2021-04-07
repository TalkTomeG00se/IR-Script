# Global Variables and Initial Menu
$userName = ""
$userID = ""
$userEmail = ""
$userHosts = ""
$IP = ""
$hostName = ""
$userInfo = ""
$RedactedScriptLocation = ""

$myADusername = $Env:USERNAME
$mywincred = Read-Host "Enter your AD password" -AsSecureString

Write-Host "---------------------------"
Write-Host "Welcome To the IR-EZ Script" -ForegroundColor Blue
Write-Host "---------------------------`n"


# Menu Display Functions
function showMainMenu(){

    Write-Host "---------------------------"
    Write-Host "Main Menu" -ForegroundColor Green
    Write-Host "---------------------------"
    $menuString = "" + 
        "1. Resolve an IP to a host name`n" +
        "2. Get user ID from username`n" +
        "3. Get systems that are assigned to a user`n" +
        "4. Check the AD status of a user`n" +
        "5. Check USB excemption status of user`n" +
        "6. Check if user is on CTI watchlist`n" +
        "7. Deploy *Redacted* servlet (for memory / drive acquisition)`n" + # software name to deploy redacted
        "Enter q or Q to exit`n`n" +
        "Enter your selection"


    $option = Read-Host $menuString
    $option = $option -replace "Q", "q"

    Switch($option){

        "1"{
            # need to check if user didn't enter anything
            $IP = Read-Host "Enter an IP address"

            if ([string]::IsNullOrEmpty($IP)) {
                
                Write-Host "Empty value entered. Please enter a IP address" -ForegroundColor Red

                showMainMenu
                
            } else {

                checkIP($IP)
            }

        }

        "2"{ 
            # Get ID from username

            $userName = Read-Host "Enter user name"

            if ([string]::IsNullOrEmpty($userName)) {
                
                Write-Host "Empty value entered. Please enter a user name" -ForegroundColor Red

                showMainMenu
                
            } else {

                getUserID($userName)
            }

        }

        "3"{
                
            $userInfo = Read-Host "Enter a username or ID"

            if ([string]::IsNullOrEmpty($userInfo)) {
                
                Write-Host "Empty value entered. Please enter a user name or ID" -ForegroundColor Red

                showMainMenu
                
            } else {

                getUserSystems($userInfo)

            }

        }

        "4"{

            $userInfo = Read-Host "Enter a username or user ID"

            if ([string]::IsNullOrEmpty($userInfo)) {
                
                Write-Host "Empty value entered. Please enter a user name or ID" -ForegroundColor Red

                showMainMenu
                
            } else {

                getADStatus($userInfo)

            }

        }

        "5"{

            $userInfo = Read-Host "Enter a username ONLY"

            if ([string]::IsNullOrEmpty($userInfo)) {
                
                Write-Host "Empty value entered. Please enter a user name." -ForegroundColor Red

                showMainMenu
                
            } else {

                getUSBStatus($userInfo)

            }

        }

        "6"{

            $userInfo = Read-Host "Enter a username ONLY"

            if ([string]::IsNullOrEmpty($userInfo)) {
                
                Write-Host "Empty value entered. Please enter a user name" -ForegroundColor Red

                showMainMenu
                
            } else {

                isOnWatchlist($userInfo)

            }

        }

        "7"{ # deploys on current user system
            $adminPass = Read-Host "Please enter admin password"

            try {

                $tempSystem = Read-Host "Enter the host to deploy servlet to"

                Write-Host "Deploying *Redacted* servlet to $tempSystem" # deployed software name redacted

                LaunchExternalScript -scriptPath $RedactedScriptLocation -runAsUser $adminPass -argument $tempSystem # script location redacted for confidential purposes
            } catch {

                Write-Host "Error occurred deploying servlet"

                showMainMenu
            }

        }

        "q"{
            Exit
        }

        default{

            Write-Host "Command not recognized. Please try again.`n" -ForegroundColor Red
            showMainMenu
        }
    }
}

# Checks if the IP is valid. Converts to system.net.ipaddress then to boolean to return true/false
function checkIP($IP){

    $isValid = $IP -as [ipaddress] -as [bool]

    if($isValid){

        getHostName($IP)
        $IP = ""
        showMainMenu

    } else {
        Write-Host "IP was found to be invalid. Please try again" - -ForegroundColor Red
        $IP = ""
        showMainMenu
    }



    return $isValid
}

# Function that resolves an IP to a host
function getHostName($IP){

    try {

        $hostName = Resolve-DnsName $IP -ErrorAction Stop| select -ExpandProperty NameHost
        Write-Host "`nIP $IP resolves to the following host: $hostname`n" -ForegroundColor Cyan

    } catch {
        Write-Host "`n"
        Write-Warning -Message "Record not found for $IP`n"
    }

}

function getUserID($userName){
    try {

        $returnID = Get-ADUser $userName -property EmployeeID -ErrorAction Stop | select -ExpandProperty EmployeeID

        Write-Host "`nThe ID for $userName is $returnID`n"

        showMainMenu

    } catch {

        Write-Host "`n"
        Write-Warning -Message "Record not found for $userName`n"

        showMainMenu
    }
    

    
}

function getUserName($userID){

    try {

        $returnName = Get-ADUser -Filter "EmployeeNumber -eq $userID" | select -ExpandProperty SamAccountName

        Write-Host "`nThe username for $userID is $returnName`n"

        showMainMenu

    } catch { # ID was not found

        Write-Host "`n"
        Write-Warning -Message "Record not found for $userID`n"

        showMainMenu
    }

}

function getADStatus($userInfo){

    $temp = ""

    if($userInfo -match "^\d+$"){ # user ID entered

        try {

            $temp = Get-ADUser -Filter "EmployeeNumber -eq $userInfo" | select -ExpandProperty SamAccountName # get username

            $returnStatus = Get-ADUser $temp -properties employeeType | select -expandProperty employeeType # Get AD Status

            if($returnStatus -eq "Company"){ # if showing as company, it's active AD

                Write-Host "`nUser $temp with ID $userInfo has an active ADStatus`n" -ForegroundColor cyan

                showMainMenu
            } else { # user is not active, but in AD

                Write-Host "`nUser $temp with ID $userInfo does not have an active AD account`n" -ForegroundColor red

                showMainMenu
            }

        } catch { # user not found in the AD

            Write-Host "`n"
            Write-Warning -Message "Record not found for $userInfo`n"
    
            showMainMenu

        }

    } else { # username was entered

        try {

            $returnStatus = Get-ADUser $userInfo -properties employeeType | select -expandProperty employeeType # get AD Status

            if($returnStatus -eq "Company"){ # if showing as company, it's active AD

                Write-Host "`nUser $userInfo has an active ADStatus`n" - -ForegroundColor Cyan

                showMainMenu

            } else { # user is inactive, but in AD

                Write-Host "`nUser $temp with ID $userInfo does not have an active AD account`n" - -ForegroundColor Red

                showMainMenu
            }

        } catch { # username was not found

            Write-Host "`n"
            Write-Warning -Message "Record not found for $userInfo`n"
    
            showMainMenu
        }
    }

}

function getUserSystems($userInfo){ 

    if($userInfo -match "^\d+$"){ # ID entered

        try {

            $temp = Get-ADUser -Filter "EmployeeNumber -eq $userInfo" | select -ExpandProperty SamAccountName # get username

            $return = Invoke-RestMethod https://redactedDomainAndPort/api/lookup/user/$temp -UseDefaultCredentials # Domain and associated port of the API redacted for confidential reasons

            Write-Output $return

            showMainMenu


        } catch {

            Write-Host "`n"
            Write-Warning -Message "Records not found for $userInfo`n"
    
            showMainMenu

        }
    } else { # username entered
        
        try {

            $return = Invoke-RestMethod https://redactedDomainAndPort/api/lookup/user/$userInfo -UseDefaultCredentials # Domain and associated port of the API redacted for confidential reasons

            Write-Output $return

            showMainMenu
            
        } catch {

            Write-Host "`n"
            Write-Warning -Message "Records not found for $userInfo`n"
    
            showMainMenu
        }

    }
}

function getUSBStatus($userInfo) {

try {
    $group = "redacted_group"

    $members = Get-ADGroupMember -Identity $group -Recursive | Select-Object -ExpandProperty name

    if ($members -contains $userInfo) {

        Write-Host "User $userInfo is a member of the $group group." -ForegroundColor Blue

        showMainMenu
    }
    else {

        Write-Host "User $userInfo was not found in the $group group."  -ForegroundColor Red

        showMainMenu
    }
} catch {

    Write-Host "`n"
    Write-Warning -Message "Records not found for $userInfo`n"
    
    showMainMenu
}

}

function isOnWatchlist($userInfo){

    try {
        $NIXcreds = New-Object System.Management.Automation.PSCredential ($myADusername, $mywincred)
       
        $session = New-SSHSession -ComputerName redactedComputerName -Credential $NIXcreds # computer name redacted for confidential purposes

        $currentSession = $session | Select-Object -ExpandProperty SessionID
        
        # Invoke SSH command and capture output as string 

        $output = $(Invoke-SSHCommand -index $currentSession -Command "grep $emp /var/www/html/safeeds/*.csv").Output
        
        if($output) {
            Write-Host "Username is in a watchlist:"
            Write-Host "---------------------------------"
            Write-Host $output
            Write-Host "---------------------------------"
            showMainMenu
        }
        else {
            Write-Host "Username $emp is NOT in a watchlist."
            showMainMenu
        }
        Remove-SSHSession -index $currentSession | Out-Null
       
    }
    catch {
        Write-Host "No dice. Something failed."
        showMainMenu
    }
}
showMainMenu