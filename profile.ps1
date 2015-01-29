$env:GIT="C:\Program Files (x86)\git\bin\git.exe"
$env:PATH="$env:PATH;c:\ProgramData\chocolatey\bin\"

$path = Join-Path $PSCommandPath ".."

if($host.Name -eq 'ConsoleHost')
{
  Import-Module PSReadLine-vim

  Set-PSReadlineOption -EditMode Vi
  Set-PSReadlineKeyHandler -Key Tab -Function Complete
  Set-PSReadlineOption -BellStyle Visual
}

Import-Module posh-git2
Import-Module Pscx -force -arg @{CD_EchoNewLocation = $false}
Import-Module Invoke-ElevatedCommand

. $path\Logs.ps1
. $path\Prompt.ps1
. $path\SetupAliases.ps1

$PROFILE = Join-Path $path "profile.ps1"

$PSDefaultParameterValues["Out-Default:OutVariable"] = "0" 
