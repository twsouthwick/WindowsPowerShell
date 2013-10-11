$variable:preference:log:path = "C:\PSLogs"

function Get-Log { Get-ChildItem $variable:preference:log:path\*.log }
function Search-Log([string] $text)
{
	function convert-date([string] $date)
	{
		[System.DateTime]::ParseExact($date.Replace(".log",""), "yyyyMMdd-HHmmss", [System.Globalization.CultureInfo]::InvariantCulture)
	}
	Get-Log | Select-String $text | Select FileName, LineNumber | Group-Object FileName | Select Name, Count, Group | % { New-Object PSObject -Property @{Date=convert-date($_.Name); FileName="$variable:preference:log:path\"+$_.Name; Line= $_.Group | % {$_.LineNumber}; Count = $_.Count} } | Sort -Descending -Property Date | Format-List
}

if(!(Test-Path $variable:preference:log:path))
{
	New-Item -ItemType Directory -Path $variable:preference:log:path
}

$pathName = "$variable:preference:log:path\" + ([System.DateTime]::Now.ToString("yyyyMMdd-HHmmss")) + ".log"

try
{
	Start-Transcript -Path $pathName
	Write-Host ""
}
catch [Exception]
{ }

Remove-Variable pathName
