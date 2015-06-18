:: Install packages
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/twsouthwick/WindowsPowerShell/master/Bootstrap/install_packages.ps1'))"

:: Add setup to public
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Invoke-WebRequest 'https://raw.githubusercontent.com/twsouthwick/WindowsPowerShell/master/Bootstrap/install_pshome.cmd' -OutFile '%PUBLIC%\Desktop\setup.cmd'"

:: Setup RemoteSigned
@powershell -NoProfile -Command "Set-ExecutionPolicy RemoteSigned"
