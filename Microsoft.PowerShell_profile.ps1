# Include Other script files
$path = Join-Path $PSCommandPath ".."
$modulepath = Join-Path $path Modules
$pscxpath="C:\Program Files (x86)\PowerShell Community Extensions\Pscx3"

. $path\SetupAliases.ps1

Import-Module $modulepath\posh-git
#Import-Module PsGet
Import-Module $pscxpath\pscx -force -arg @{CD_EchoNewLocation = $false}
Import-Module $modulepath\Invoke-ElevatedCommand
Import-Module $modulepath\ProjectN

. $path\SetupVSEnvironment.ps1
. $path\Logs.ps1
. $path\Prompt.ps1
. $path\Get-Checksum.ps1
. $path\TextHelpers.ps1

