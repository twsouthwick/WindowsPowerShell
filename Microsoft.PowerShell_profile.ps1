$path="$env:userprofile\Documents\WindowsPowerShell\Modules"
$pscxpath="C:\Program Files (x86)\PowerShell Community Extensions\Pscx3"

Import-Module $path\posh-git
#Import-Module PsGet
Import-Module $pscxpath\pscx -force -arg @{CD_EchoNewLocation = $false}
Import-Module $path\Invoke-ElevatedCommand
Import-Module $path\ProjectN

# Include Other script files
$path = Join-Path $PSCommandPath ".."

. $path\SetupVSEnvironment.ps1
. $path\Logs.ps1
. $path\Prompt.ps1
. $path\SetupAliases.ps1
. $path\Get-Checksum.ps1
. $path\TextHelpers.ps1

