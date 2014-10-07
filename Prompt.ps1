# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
	$realLASTEXITCODE = $LASTEXITCODE

	# Reset color, which can be messed up by Enable-GitColors
	$Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

	$dir = $pwd.Path.Replace("Microsoft.PowerShell.Core\FileSystem::", "");

	Write-Host ("`n[$dir]") -nonewline -ForegroundColor DarkGreen

	Write-VcsStatus

	$global:LASTEXITCODE = $realLASTEXITCODE

	return "`n$ "
}

Enable-GitColors

$GitPromptSettings.WorkingForegroundColor="Red"
$GitPromptSettings.UntrackedForegroundColor="Red"
