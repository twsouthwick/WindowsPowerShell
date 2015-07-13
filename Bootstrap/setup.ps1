param([switch]$installApps)

if((Get-ExecutionPolicy) -ne "RemoteSigned")
{
  Set-ExecutionPolicy RemoteSigned
}

# Ensure git is available
Install-Package git -Force
Set-Alias -Name git -Value 'C:\Program Files (x86)\Git\bin\git.exe'

# Clone repo
$profile = "${env:\USERPROFILE}\Documents\WindowsPowerShell"

if(-Not (Test-Path $profile))
{
  git clone https://github.com/twsouthwick/WindowsPowerShell $profile
}

## Get PS components
if(-Not (Get-PSRepository -Name poshgit2 -ErrorAction Ignore)){
  Register-PackageSource -Name poshgit2 -Location https://www.myget.org/F/poshgit2/api/v2 -Trusted -ProviderName PSModule
}

Install-Package poshgit2,PScx -Scope CurrentUser -Force

# Setup vim stuff
Copy-Item $profile\bootstrap\_vimrc ${env:\USERPROFILE}
New-Item ${env:USERPROFILE}\.vim\_backups -ErrorAction Ignore | Out-Null
New-Item ${env:USERPROFILE}\.vim\_swaps -ErrorAction Ignore | Out-Null

# Setup DNX
Invoke-WebRequest 'https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.ps1' | Invoke-Expression
 
# Setup git config
git config --global alias.co checkout 
git config --global alias.ci commit 
git config --global alias.st status 
git config --global alias.br branch 
git config --global alias.hist "log --decorate --stat --graph --pretty=format:'%d %Cgreen%h%Creset %s [%ar - %Cred%an%Creset]%n'" 
git config --global hub.protocol https 

if($installApps)
{
  . $profile\bootstrap\install_packages.ps1
}

