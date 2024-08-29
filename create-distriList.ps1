<#
Name: John Asare
Date: 08/29/2024

Des: Read more about this code from https://github.com/asarejohn001/add-members-to-distroList
#>

# Install module if not already
Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber

# Import the exchangeonline module
Import-Module ExchangeOnlineManagement

# Fucntion to log output
function Get-Log {
    param (
        [string]$LogFilePath,
        [string]$LogMessage
    )

    # Create the log entry with the current date and time
    $logEntry = "{0} - {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $LogMessage

    # Append the log entry to the log file
    Add-Content -Path $LogFilePath -Value $logEntry
}

# Define the log file path
$logFilePath = ".\log.txt"

# Connect to EXO
try {
    # Attempt to connect to Exchange Online
    Connect-ExchangeOnline -UserPrincipalName 'enter your email to connect' -ErrorAction Stop
    Get-Log -LogFilePath $logFilePath -LogMessage "Successfully connected to Exchange Online."
    
} catch {
    # Handle the error if connection fails
    Get-Log -LogFilePath $logFilePath -LogMessage "Failed to connect to Exchange Online. Exiting script. Error details: $_"
    Write-Host "Couldn't connect to EXO. Check log file"
    exit
}

# Define the path to your CSV file
$csvPath = "C:\Path\To\Your\CSV\members.csv"

# Import the CSV file
$members = Import-Csv -Path $csvPath

# Specify the alias or email address of the distribution group
$distributionGroup = "YourDistributionGroup@domain.com"

# Signal script in progress
Write-Host 'Script is now in-progress...'

# Loop through each member and try to add them to the distribution group
foreach ($member in $members) {
    $emailAddress = $member.EmailAddress

    try {
        # Attempt to add the member to the distribution group
        Add-DistributionGroupMember -Identity $distributionGroup -Member $emailAddress -ErrorAction Stop
        Get-Log -LogFilePath $logFilePath -LogMessage "Successfully added $emailAddress to $distributionGroup"
    }
    catch {
        # If an error occurs, output the error message
        Get-Log -LogFilePath $logFilePath -LogMessage "Failed to add $emailAddress to $distributionGroup. Error: $_"
    }
}

# Signal completion of script
Write-Host 'script is done, check log file.'

# Disconnect from Exchange Online
Disconnect-ExchangeOnline -Confirm:$false

