# Include Other script files
$path = Join-Path $PSCommandPath ".."
$modulepath = Join-Path $path Modules
$pscxpath="C:\Program Files (x86)\PowerShell Community Extensions\Pscx3"

. $path\SetupAliases.ps1

if($host.Name -eq 'ConsoleHost')
{
  #Set-PSReadlineOption -EditMode Vi
  Set-PSReadlineKeyHandler -Key Tab -Function Complete
  Set-PSReadlineOption -BellStyle Visual
}

Import-Module $modulepath\posh-git
#Import-Module PsGet
#Import-Module $pscxpath\pscx -force -arg @{CD_EchoNewLocation = $false}
Import-Module $modulepath\Invoke-ElevatedCommand

. $path\SetupVSEnvironment.ps1
. $path\Logs.ps1
. $path\Prompt.ps1
. $path\TextHelpers.ps1

$PROFILE = Join-Path $path "profile.ps1"

$PSDefaultParameterValues["Out-Default:OutVariable"] = "0" 
