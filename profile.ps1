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

if($env:PROCESSOR_ARCHITECTURE -eq "amd64"){
	$programFiles = ${env:ProgramFiles(x86)}
} else {
	$programFiles = ${env:ProgramFiles}
}
$env:poshgit2_seq_server="http://localhost:5341/#/events"
$env:GIT="$programFiles\git\bin\git.exe"
$env:PATH="$env:PATH;c:\ProgramData\chocolatey\bin\"
$env:GIT_SSH="$programFiles\PuTTY\plink.exe"

#############################################
## Import modules                          ##
#############################################
if($host.Name -eq 'ConsoleHost')
{
  #Import-Module PSReadLine-vim

  #Set-PSReadlineOption -EditMode Vi
  Set-PSReadlineKeyHandler -Key Tab -Function Complete
  Set-PSReadlineOption -BellStyle Visual

  # Coloring gets off because we set colors in the startup script
  Set-psreadlineoption -ResetTokenColors  
}

Import-Module posh-git2
Import-Module Pscx -force -arg @{CD_EchoNewLocation = $false}

#############################################
## Setup prompt                            ##
#############################################
function prompt {
	$realLASTEXITCODE = $LASTEXITCODE

	$dir = $pwd.Path.Replace("Microsoft.PowerShell.Core\FileSystem::", "");

	Write-Host ("`n[$dir]") -nonewline -ForegroundColor DarkGreen

	Write-VcsStatus

	$global:LASTEXITCODE = $realLASTEXITCODE

	return "`n$ "
}

$env:TERM = 'cygwin'

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
	New-Item -ItemType Directory -Path $variable:preference:log:path | Out-Null
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
Set-Alias -Name npp  -Value "$programFiles\Notepad++\notepad++.exe"
Set-Alias -Name vim  -Value "$programFiles\Vim\vim74\vim.exe"
Set-Alias -Name git  -Value "$programFiles\Git\bin\Git.exe"
Set-Alias -Name nuget -Value "$env:AppData\..\Local\PackageManagement\ProviderAssemblies\nuget-anycpu.exe" 
Set-Alias -Name kvm -Value "$env:USERPROFILE\.k\bin\kvm.ps1"

# Set up 'git' to point to 'hub' if 'hub' is available
if (Get-Command -Name hub -OutVariable hubcmd -ErrorAction Ignore)
{
	Set-Alias -Name git -Value $hubcmd.Source
}

function Copy-Location  { (Get-Location).Path | Out-Clipboard }

# Create a drive for source code
$repoPath = "$env:USERPROFILE\Source\Repos\"
if(Test-Path $repoPath) {
    New-PSDrive repos FileSystem $repoPath | Out-Null
}

$PROFILE = $PSCommandPath

# Results will be stored in the $0 variables
$PSDefaultParameterValues["Out-Default:OutVariable"] = "0" 
