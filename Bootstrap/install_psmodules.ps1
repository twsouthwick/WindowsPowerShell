Import-Module OneGet

# Get PS components
if(-Not (Get-PSRepository -Name tws-ps -ErrorAction Ignore)){
	Register-PSRepository -Name tws-ps -SourceLocation https://www.myget.org/F/tws-ps/ -InstallationPolicy Trusted
}

Find-Package posh-git2 -Source tws-ps | Install-Package -Scope CurrentUser -Force
Find-Package Pscx -Source PSGallery | Install-Package -Scope CurrentUser -Force

# Get tools - None exist right now
#Register-PackageSource -Name tws-tools -Location https://www.myget.org/F/tws-tools/ -Trusted  -ProviderName Chocolatey