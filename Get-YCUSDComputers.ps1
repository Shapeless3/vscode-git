function Get-YCUSDComputers {
    [cmdletbinding()]
    Param (
        #Use paramater set to have a mandatory first paramater - workstation or server?
        $ComputerName = '*'
        
    )

}

Get-YCUSDComputers -



Get-ADComputer -Filter {OperatingSystem -like "*server*"} -Properties * | Where-Object {$_.ipv4address} |
    Select-Object name, ipv4address, operatingsystem | Sort-Object -Property name | Export-Csv "$PSScriptRoot\Serverlist.csv" -NoTypeInformation -Force