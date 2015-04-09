REM Download Chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM Get Chocolatey packages
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/twsouthwick/WindowsPowerShell/master/Bootstrap/ChocolateyInstall.ps1'))"

REM Setup DNX
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "&{$Branch='dev';iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.ps1'))}"

REM Setup RemoteSigned
@powershell -NoProfile -Command "Set-ExecutionPolicy RemoteSigned"

REM Setup PS environment
"C:\Program Files (x86)\Git\bin\git.exe" clone https://github.com/twsouthwick/WindowsPowerShell %USERPROFILE%\Documents\WindowsPowerShell

REM Move _vimrc
xcopy %USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\_vimrc %USERPROFILE%\_vimrc /y

REM Setup git config
%USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\SetupGitConfig.cmd

REM THIS IS NOT NON-INTERACTIVE YET
REM @powershell -NoProfile -Command "& $env:USERPROFILE\Documents\WindowsPowerShell\Bootstrap\InitialSetup.ps1"
