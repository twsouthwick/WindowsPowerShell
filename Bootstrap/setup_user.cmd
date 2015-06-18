:: Add git to path (for this script)
SET PATH=%PATH%;C:\Program Files (x86)\Git\bin;C:\Program Files\Git\bin

:: Setup PS environment
git clone https://github.com/twsouthwick/WindowsPowerShell %USERPROFILE%\Documents\WindowsPowerShell

:: Move _vimrc
xcopy %USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\_vimrc %USERPROFILE% /y
mkdir %USERPROFILE%\.vim\_backups
mkdir %USERPROFILE%\.vim\_swaps

:: Setup git config
call %USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\git_config_setup.cmd

REM :: Download PSModules.  NOTE: This seems to stall on recent Win10 builds
:: powershell -NoProfile -ExecutionPolicy unrestricted -Command "& $env:USERPROFILE\Documents\WindowsPowerShell\Bootstrap\install_psmodules.ps1"
