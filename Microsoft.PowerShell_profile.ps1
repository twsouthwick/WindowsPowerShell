﻿Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

function Get-Checksum
{
    Param (
        [string]$File=$(throw("You must specify a filename to get the checksum of.")),
        [ValidateSet("sha1","md5")]
        [string]$Algorithm="sha1"
    )

    $fs = new-object System.IO.FileStream $File, "Open", "Read"
    $algo = [type]"System.Security.Cryptography.$Algorithm"
	$crypto = $algo::Create()
    $hash = [BitConverter]::ToString($crypto.ComputeHash($fs)).Replace("-", "")
    $fs.Close()
    $hash
}

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
Import-Module posh-git
#Import-Module PsGet
Import-Module pscx -force -arg @{CD_EchoNewLocation = $false; ModulesToImport = @{Wmi = $false}}
Import-Module Invoke-ElevatedCommand
Import-Module ProjectN

Set-Alias  Out-Clipboard $env:SystemRoot\system32\clip.exe
function Copy-Location  { (Get-Location).Path | Out-Clipboard }
Set-Alias -Name loc -Value Copy-Location

Set-Alias -Name npp -Value "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias -Name sudo -Value Invoke-ElevatedCommand
# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
	$p = $pwd.ProviderPath.Split([System.IO.Path]::DirectorySeparatorChar)
	$dir = $p[$p.Length-1]
	
	if($dir -eq ""){
		$dir = "\"
	}
	
	if($pwd.Path -eq (resolve-path ~).Path){
		$dir = "~"
	}
	$j=$pwd.Path.Split("::")
	if($j[0].StartsWith("Microsoft.PowerShell.Core\FileSystem")){
		$root = "\\" + $j[2].Split("\")[2]
	} else {
		$root = $pwd.Drive.Root
	}
    Write-Host ("[$root] $dir" ) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return " $ "
}

Enable-GitColors

Pop-Location

#Start-SshAgent -Quiet

$GitPromptSettings.WorkingForegroundColor="Red"
$GitPromptSettings.UntrackedForegroundColor="Red"

# Include Other script files
$path = $PSCommandPath | Split-Path -Parent

. $path\SetupVSEnvironment.ps1
. $path\Logs.ps1
