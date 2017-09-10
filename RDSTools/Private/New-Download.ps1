function New-Download {
    [CmdletBinding()]
    param(
        [string]$Url,
        [string]$Destination = "$($env:SystemDrive)\Tools",
        [string[]]$FileRemovalList
    )
    if (-not (Test-Path -Path $Destination)) {
        [void](New-Item -Path $Destination -ItemType Directory)
    }

    $downloadFile = $Url.Substring(($downloadUrl.LastIndexOf('/')+1))
    $downloadPath = Join-Path -Path $env:TEMP -ChildPath $downloadFile

    [System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3")
    Invoke-WebRequest -Uri $Url -OutFile $downloadPath

    Unblock-File -Path $downloadPath
    Expand-Archive -Path $downloadPath -OutputPath $Destination -Force
    Remove-Item -Path $downloadPath

    if ($FileRemovalList) {
        foreach ($file in $FileRemovalList) {
            if (Test-Path -Path (Join-Path -Path $Destination -ChildPath $file)) {
                Remove-Item -Path (Join-Path -Path $Destination -ChildPath $file)
            }
        }
    }
}