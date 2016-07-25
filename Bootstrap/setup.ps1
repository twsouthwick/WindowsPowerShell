param([switch]$installApps)

if((Get-ExecutionPolicy) -ne "RemoteSigned")
{
  Write-Verbose "Setting execution policy to 'RemoteSigned'"
  Set-ExecutionPolicy RemoteSigned
}

# Ensure git is available
if(!(Get-Command git -ErrorAction Ignore))
{
	Write-Verbose "Installing git"
	Install-Package git -Force
	Set-Alias -Name git -Value 'C:\Program Files (x86)\Git\bin\git.exe'
}

# Clone repo
$profile = "${env:\USERPROFILE}\Documents\WindowsPowerShell"

if(-Not (Test-Path $profile))
{
  Write-Verbose "Cloning repository"
  git clone https://github.com/twsouthwick/WindowsPowerShell $profile
}

## Get PS components
Write-Verbose "Registering package sources"
if(-Not (Get-PSRepository -Name poshgit2 -ErrorAction Ignore)){
  Register-PackageSource -Name poshgit2 -Location https://www.myget.org/F/poshgit2/api/v2 -Trusted -ProviderName PowerShellGet
}

Write-Verbose "Installing PS Modules"
Install-Package poshgit2,PScx -Scope CurrentUser -Force

# Setup vim stuff
Write-Verbose "Copy VIM config"
Copy-Item $profile\bootstrap\_vimrc ${env:\USERPROFILE}
New-Item ${env:USERPROFILE}\.vim\_backups -ItemType Directory -Force -ErrorAction Ignore | Out-Null
New-Item ${env:USERPROFILE}\.vim\_swaps -ItemType Directory -Force -ErrorAction Ignore | Out-Null

# Setup git config
Write-Verbose "Set up git config"
git config --global alias.co checkout 
git config --global alias.ci commit 
git config --global alias.st status 
git config --global alias.br branch 
git config --global alias.hist "log --decorate --stat --graph --pretty=format:'%d %Cgreen%h%Creset %s [%ar - %Cred%an%Creset]%n'" 
git config --global hub.protocol https 

if($installApps)
{
  Write-Verbose "Install applications"
  . $profile\bootstrap\install_packages.ps1
}

