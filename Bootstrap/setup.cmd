:: Add git to path (for this script)
SET PATH=%PATH%;C:\Program Files (x86)\Git\bin

:: Download Chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

:: Get Chocolatey packages
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/twsouthwick/WindowsPowerShell/master/Bootstrap/choco_packages.cmd'))"

:: Setup DNX
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "&{$Branch='dev';iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.ps1'))}"

:: Setup RemoteSigned
@powershell -NoProfile -Command "Set-ExecutionPolicy RemoteSigned"
