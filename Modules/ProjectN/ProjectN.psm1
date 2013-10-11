Function Invoke-QuickRun(
[string]$TestPath,
[ValidateSet("Desktop","CoreCLR","ProjectN")]
[string]$Type = "Desktop",
[string]$CoreCLRPath)
{
	$temp = [System.IO.Path]::GetTempPath()
	$qa = "c:\ProjectN\src\qa"
	
	if($Type -eq "Desktop")
	{
		& $qa\runtools\QuickRun\QuickRun.exe $TestPath /save /c:Desktop -ILCPath:$temp -MRTPath:$temp
	}
	elseif ($Type -eq "CoreCLR")
	{
		& $qa\runtools\QuickRun\QuickRun.exe $TestPath  -coreclrroot:$CoreCLRPath /save /c:CoreClr -ILCPath:$temp -MRTPath:$temp
	}
	else
	{
		throw "$Type is not supported by this script."
	}
}
