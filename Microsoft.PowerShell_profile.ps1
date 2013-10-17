Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

Import-Module posh-git
#Import-Module PsGet
Import-Module pscx -force -arg @{CD_EchoNewLocation = $false; ModulesToImport = @{Wmi = $false}}
Import-Module Invoke-ElevatedCommand
Import-Module ProjectN

# Include Other script files
$path = Join-Path $PSCommandPath ".."

. $path\SetupVSEnvironment.ps1
. $path\Logs.ps1
. $path\Prompt.ps1
. $path\SetupAliases.ps1
. $path\Get-Checksum.ps1

Pop-Location
