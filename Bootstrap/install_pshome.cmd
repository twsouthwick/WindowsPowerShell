:: Add git to path (for this script)
SET PATH=%PATH%;C:\Program Files (x86)\Git\bin;C:\Program Files\Git\bin

:: Setup PS environment
git clone https://github.com/twsouthwick/WindowsPowerShell %USERPROFILE%\Documents\WindowsPowerShell

:: Run setup
call %USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\setup_user.cmd

del /Q "C:\Users\Public\Desktop\setup.cmd"