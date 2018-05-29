<#
.SYNOPSIS
This will check a users gateway to figure out which folder to save logs to based on their school site
.DESCRIPTION
The script will check the default gateway, using this information we can determine the school site the user and computer are at.  
We setup a log server with the sites as subfolder.  Computer logs and User logs will go into subfolders based on the the hostname and username.
.PARAMETER <paramName>
No parameters are needed 
.EXAMPLE
.\name of script.ps1
#>



$Server = "hawk.eagle.ycusd.k12.ca.us"
$Share = "LearnBrowsingHistory$"
$Date = Get-Date -UFormat "%m-%d-%Y %I-%M-%S %p"

$InternetLogPath = "\\$Server\$Share\$env:USERNAME\$env:COMPUTERNAME"
$InternetLogFile = "$InternetlogPath\$env:USERNAME $Date.csv"

New-Item -Path "$InternetLogPath"  -ItemType directory -ErrorAction SilentlyContinue

& "C:\Scripts\BrowsingHistoryView.exe" /scomma "$InternetLogFile" /sort 'Visit Time' /historysource 2 /visittimefiltertype 1
while ($true) {
    Start-Sleep -Seconds 1
    if (-not (Get-Process -Name BrowsingHistoryView.exe -ErrorAction SilentlyContinue)) {
        break
    }
}

