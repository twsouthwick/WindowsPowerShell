Import-Module OneGet

# Get PS components
Register-PSRepository -Name tws-ps -SourceLocation https://www.myget.org/F/tws-ps/ -InstallationPolicy Trusted

Find-Package -Source tws-ps | Install-Package -Scope CurrentUser
Find-Package Pscx -Source PSGallery | Install-Package -Scope CurrentUser

# Get tools
Register-PackageSource -Name tws-tools -Location https://www.myget.org/F/tws-tools/ -Trusted  -ProviderName Chocolatey

# This is broken on build 9926
# Install-Package github-cli -Source tws-tools -AllowPrereleaseVersions -MinimumVersion 2.2.0-rc1
