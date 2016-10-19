if ($profile.Contains("NuGet_profile")) 
{
	return;
}

#############################################
## Set up variables                        ##
#############################################

if($env:PROCESSOR_ARCHITECTURE -eq "amd64"){
	$programFiles = ${env:ProgramFiles(x86)}
} else {
	$programFiles = ${env:ProgramFiles}
}
$env:poshgit2_seq_server="http://localhost:5341/#/events"
$env:PATH="$env:PATH;c:\ProgramData\chocolatey\bin\;C:\Chocolatey\bin"

#############################################
## Import modules                          ##
#############################################
if($host.Name -eq 'ConsoleHost')
{
  Set-PSReadlineOption -EditMode Vi
  Set-PSReadlineKeyHandler -Key Tab -Function Complete
  #Set-PSReadlineOption -BellStyle Visual

  # Coloring gets off because we set colors in the startup script
  #Set-psreadlineoption -ResetTokenColors  
}

Import-Module poshgit2
Import-Module Pscx -arg @{CD_EchoNewLocation = $false}

#############################################
## Setup prompt                            ##
#############################################
function prompt {
	$dir = $pwd.Path.Replace("Microsoft.PowerShell.Core\FileSystem::", "");

	$status = Write-GitStatus -VT100
	$esc = [char]0x1b
	
	return "`n${esc}[0m${esc}[32;3m[$dir]${esc}[0m$status`n$ "
}

$GitPromptSettings = New-Object PSObject -Property `
	@{ 
		WorkingForegroundColor = [System.ConsoleColor]::Red; 
		UntrackedForegroundColor = [System.ConsoleColor]::Red
	}

#############################################
## Setup aliases                           ##
#############################################

Set-Alias -Name npp -Value "$programFiles\Notepad++\notepad++.exe"
Set-Alias -Name vim -Value "$programFiles\Vim\vim74\vim.exe"

function Copy-Location  { (Get-Location).Path | Out-Clipboard }

# Git needs this set to work properly
#$env:TERM="msys"

# Set path to profile
$PROFILE = $PSCommandPath

# Results will be stored in the $0 variables
$PSDefaultParameterValues["Out-Default:OutVariable"] = "0" 

# Clean up variables
Remove-Item variable:programFiles
