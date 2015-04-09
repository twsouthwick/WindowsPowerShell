# This needs to be run after PSHome is cloned (such as with setup.cmd)

Import-Module OneGet

# Get PS components
Register-PSRepository -Name tws-ps -SourceLocation https://www.myget.org/F/tws-ps/ -InstallationPolicy Trusted

Find-Package poshgit2 -Source tws-ps | Install-Package -Scope CurrentUser -Force
Find-Package Pscx -Source PSGallery | Install-Package -Scope CurrentUser -Force

# Get tools - None exist right now
#Register-PackageSource -Name tws-tools -Location https://www.myget.org/F/tws-tools/ -Trusted  -ProviderName Chocolatey