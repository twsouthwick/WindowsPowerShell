# This needs to be run after git is installed (most likely with BoxStarter)
#
# Launch as Admin:
# http://boxstarter.org/package/nr/url?https://github.com/twsouthwick/WindowsPowerShell/blob/master/BoxStarter.txt
#
# Clone repo:
# & 'C:\Program Files (x86)\Git\bin\git.exe' clone https://github.com/twsouthwick/WindowsPowerShell $env:USERPROFILE\Documents\WindowsPowerShell
#

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

Import-Module OneGet

# Get PS components
Register-PSRepository -Name tws-ps -SourceLocation https://www.myget.org/F/tws-ps/ -InstallationPolicy Trusted

Find-Package -Source tws-ps | Install-Package -Scope CurrentUser -Force
Find-Package Pscx -Source PSGallery | Install-Package -Scope CurrentUser -Force

# Get tools
Register-PackageSource -Name tws-tools -Location https://www.myget.org/F/tws-tools/ -Trusted  -ProviderName Chocolatey

# This is broken on build 9926
# Install-Package github-cli -Source tws-tools -AllowPrereleaseVersions -MinimumVersion 2.2.0-rc1
