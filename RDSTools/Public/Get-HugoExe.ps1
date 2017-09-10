function Get-HugoExe {
    [CmdletBinding()]
    param(
        [string]$Destination = "$($env:SystemDrive)\Tools"
    )

    if (-not (Test-Path -Path $Destination)) {
        [void](New-Item -Path $Destination -ItemType Directory)
    }
    
    [System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3")
    $downloadInfo = Invoke-WebRequest -Uri https://github.com/gohugoio/hugo/releases

    $downloadUrl = 'https://github.com' + ($downloadInfo.Links | where { $_.href -like "*Windows-64bit*" })[0].href

    New-Download -Url $downloadUrl -FileRemovalList 'LICENSE.md', 'README.md'
}