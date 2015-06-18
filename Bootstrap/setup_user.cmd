:: Move _vimrc
xcopy %USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\_vimrc %USERPROFILE% /y
mkdir %USERPROFILE%\.vim\_backups
mkdir %USERPROFILE%\.vim\_swaps

:: Setup DNX
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Invoke-WebRequest 'https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.ps1' | Invoke-Expression"

:: Setup git config
call %USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\git_config_setup.cmd

:: Download PSModules
powershell -NoProfile -ExecutionPolicy unrestricted %USERPROFILE%\Documents\WindowsPowerShell\Bootstrap\install_psmodules.ps1
