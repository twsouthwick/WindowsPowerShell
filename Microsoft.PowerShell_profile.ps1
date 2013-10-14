Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

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

# Include Other script files
$path = $PSCommandPath | Split-Path -Parent

. $path\SetupVSEnvironment.ps1
. $path\Logs.ps1
. $path\Prompt.ps1

Pop-Location
