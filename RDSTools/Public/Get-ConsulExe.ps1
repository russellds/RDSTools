function Get-ConsulExe {
    [CmdletBinding()]
    param(
        [string]$Destination = "$($env:SystemDrive)\Tools"
    )
    [System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3")
    $downloadInfo = Invoke-WebRequest -Uri https://www.consul.io/downloads.html

    $downloadUrl = ($downloadInfo.Links | where { $_.href -like "*windows_amd64*" }).href

    New-Download -Url $downloadUrl
}