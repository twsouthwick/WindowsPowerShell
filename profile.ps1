#############################################
## Set background color                    ##
#############################################
& {
  $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
  $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
  
  if ($prp.IsInRole($adm)) {
    $Host.UI.RawUI.Backgroundcolor = "DarkRed"
  }
  else{
    $Host.UI.RawUI.Backgroundcolor = "Black"
  }
}

Clear-Host

#############################################
## Set up variables                        ##
#############################################

$env:GIT="C:\Program Files (x86)\git\bin\git.exe"
$env:PATH="$env:PATH;c:\ProgramData\chocolatey\bin\"

$path = Join-Path $PSCommandPath ".." | Resolve-Path

#############################################
## Import modules                          ##
#############################################
if($host.Name -eq 'ConsoleHost')
{
  Import-Module PSReadLine-vim

  Set-PSReadlineOption -EditMode Vi
  Set-PSReadlineKeyHandler -Key Tab -Function Complete
  Set-PSReadlineOption -BellStyle Visual
}

Import-Module posh-git2
Import-Module Pscx -force -arg @{CD_EchoNewLocation = $false}

#############################################
## Setup prompt                            ##
#############################################
function prompt {
	$realLASTEXITCODE = $LASTEXITCODE

	# Reset color, which can be messed up by Enable-GitColors
	$Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

	$dir = $pwd.Path.Replace("Microsoft.PowerShell.Core\FileSystem::", "");

	Write-Host ("`n[$dir]") -nonewline -ForegroundColor DarkGreen

	Write-VcsStatus

	$global:LASTEXITCODE = $realLASTEXITCODE

	return "`n$ "
}

Enable-GitColors

$GitPromptSettings.EnableWindowTitle = " "
$GitPromptSettings.WorkingForegroundColor = "Red"
$GitPromptSettings.UntrackedForegroundColor = "Red"

#############################################
## Start transcript                        ##
#############################################
$variable:preference:log:path = "C:\PSLogs"
$variable:preference:log:current_log = "$variable:preference:log:path\" + ([System.DateTime]::Now.ToString("yyyyMMdd-HHmmss")) + ".log"

if(!(Test-Path $variable:preference:log:path))
{
	New-Item -ItemType Directory -Path $variable:preference:log:path
}

try
{
	Start-Transcript -Path $variable:preference:log:current_log
	Write-Host ""
}
catch [Exception]
{ }

#############################################
## Setup aliases                           ##
#############################################

Set-Alias -Name loc  -Value Copy-Location
Set-Alias -Name npp  -Value "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias -Name vim  -Value "C:\Program Files (x86)\Vim\vim74\vim.exe"
Set-Alias -Name git  -Value "C:\Program Files (x86)\Git\bin\Git.exe"

function Copy-Location  { (Get-Location).Path | Out-Clipboard }

$PROFILE = Join-Path $path "profile.ps1"
$PSDefaultParameterValues["Out-Default:OutVariable"] = "0" 
