# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
	$p = $pwd.ProviderPath.Split([System.IO.Path]::DirectorySeparatorChar)
	$dir = $p[$p.Length-1]
	
	if($dir -eq ""){
		$dir = "\"
	}
	
	if($pwd.Path -eq (resolve-path ~).Path){
		$dir = "~"
	}
	$j=$pwd.Path.Split("::")
	if($j[0].StartsWith("Microsoft.PowerShell.Core\FileSystem")){
		$root = "\\" + $j[2].Split("\")[2]
	} else {
		$root = $pwd.Drive.Root
	}
    Write-Host ("[$root] $dir" ) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return " $ "
}

Enable-GitColors

$GitPromptSettings.WorkingForegroundColor="Red"
$GitPromptSettings.UntrackedForegroundColor="Red"