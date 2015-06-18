# Install packages
Invoke-WebRequest 'https://raw.githubusercontent.com/twsouthwick/WindowsPowerShell/master/Bootstrap/install_packages.ps1' | Invoke-Expression

# Add setup to public
Write-Host "Adding shortcut to desktop to simplify powershell home cloning"
Invoke-WebRequest 'https://raw.githubusercontent.com/twsouthwick/WindowsPowerShell/master/Bootstrap/install_pshome.cmd' -OutFile '$env:PUBLIC\Desktop\setup.cmd'

Set-ExecutionPolicy RemoteSigned
