Set-Alias  Out-Clipboard $env:SystemRoot\system32\clip.exe
Set-Alias -Name loc -Value Copy-Location

Set-Alias -Name npp -Value "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias -Name sudo -Value Invoke-ElevatedCommand

Set-Alias -Name vim -Value "C:\Program Files (x86)\Vim\vim74\vim.exe"

Set-Alias -Name git -Value "C:\Program Files (x86)\Git\bin\Git.exe"
function Copy-Location  { (Get-Location).Path | Out-Clipboard }