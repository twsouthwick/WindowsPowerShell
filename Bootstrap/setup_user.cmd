:: Add git to path (for this script)
SET PATH=%PATH%;C:\Program Files (x86)\Git\bin

:: Setup PS environment
git clone https://github.com/twsouthwick/WindowsPowerShell %USERPROFILE%\Documents\WindowsPowerShell

:: Move _vimrc
xcopy %USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\_vimrc %USERPROFILE% /y

:: Setup git config
%USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\git_config_setup.cmd

:: THIS IS NOT NON-INTERACTIVE YET
:: @powershell -NoProfile -Command "& $env:USERPROFILE\Documents\WindowsPowerShell\Bootstrap\InitialSetup.ps1"
