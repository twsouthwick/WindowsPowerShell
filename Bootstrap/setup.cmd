:: Install packages
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/twsouthwick/WindowsPowerShell/master/Bootstrap/install_packages.ps1'))"

:: Setup RemoteSigned
@powershell -NoProfile -Command "Set-ExecutionPolicy RemoteSigned"
