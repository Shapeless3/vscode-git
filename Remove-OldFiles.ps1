#Script has a default limit and path.  Change for deployment in automation.

[cmdletbinding()]
param(
    [Parameter()]
    [int]$daysold = 45,
    [Parameter()]
    $path = 'C:\Temp'
)

begin {
    $limit = (Get-Date).AddDays( - $daysold)
}

process {
    # Delete files older than the $limit.  First line uses creation date, second uses last modified date.
    #Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force -WhatIf
    Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $limit } | Remove-Item -Force -WhatIf

    # Delete any empty directories left behind after deleting the old files.
    Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse -WhatIf
}

end
{}
