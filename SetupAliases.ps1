Set-Alias  Out-Clipboard $env:SystemRoot\system32\clip.exe
Set-Alias -Name loc -Value Copy-Location

Set-Alias -Name npp -Value "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias -Name sudo -Value Invoke-ElevatedCommand

function Copy-Location  { (Get-Location).Path | Out-Clipboard }