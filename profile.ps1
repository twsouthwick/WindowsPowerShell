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

#############################################
## Import modules                          ##
#############################################
if($host.Name -eq 'ConsoleHost')
{
  Set-PSReadlineOption -EditMode Vi
  Set-PSReadlineKeyHandler -Key Tab -Function Complete
  Set-PSReadlineOption -BellStyle Visual
  Set-PSReadlineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory -ViMode Insert
  Set-PSReadlineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory -ViMode Command

  # Coloring gets off because we set colors in the startup script
  Set-PSReadlineOption -ResetTokenColors
}

Import-Module poshgit2

function IsAdmin {
	$wid = [System.Security.Principal.WindowsIdentity]::GetCurrent() 
	$prp = New-Object System.Security.Principal.WindowsPrincipal($wid)
	$adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator

	return $prp.IsInRole($adm)  
}

#############################################
## Setup prompt                            ##
#############################################
function prompt {
	$dir = $pwd.Path.Replace("Microsoft.PowerShell.Core\FileSystem::", "");

	if ($dir.StartsWith($env:USERPROFILE))
	{
		$dir = $dir.Replace($env:USERPROFILE, "~");
	}

	$status = Get-RepositoryStatus -VT100
	$esc = [char]0x1b

	$now = [System.DateTime]::Now
	$date = $now.ToShortDateString()
	$time = $now.ToShortTimeString()
	$reset = "${esc}[0m";
	$admin = if(IsAdmin) { "${esc}[1,33mADMIN :: " } else { "" }
	
	return "`n$admin${esc}[1;32;3m[$dir] ${esc}[0;32;2m$date $time ${reset}$status`n$ "
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
Set-Alias -Name vim -Value "$programFiles\Vim\vim80\vim.exe"

function Copy-Location  { (Get-Location).Path | Out-Clipboard }

# Set path to profile
$PROFILE = $PSCommandPath

# Results will be stored in the $0 variables
$PSDefaultParameterValues["Out-Default:OutVariable"] = "0" 

# Clean up variables
Remove-Item variable:programFiles
