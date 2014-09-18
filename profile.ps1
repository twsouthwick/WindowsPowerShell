# Include Other script files
$path = Join-Path $PSCommandPath ".."
$modulepath = Join-Path $path Modules
$pscxpath="C:\Program Files (x86)\PowerShell Community Extensions\Pscx3"

. $path\SetupAliases.ps1

if($host.Name -eq 'ConsoleHost')
{
	Import-Module $modulepath\PSReadLine\PSReadLine\bin\Release\PSReadLine.psd1
}

Import-Module $modulepath\posh-git
#Import-Module PsGet
Import-Module $pscxpath\pscx -force -arg @{CD_EchoNewLocation = $false}
Import-Module $modulepath\Invoke-ElevatedCommand

. $path\SetupVSEnvironment.ps1
. $path\Logs.ps1
. $path\Prompt.ps1
. $path\Get-Checksum.ps1
. $path\TextHelpers.ps1

$PROFILE = Join-Path $path "profile.ps1"

