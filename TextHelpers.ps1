function ReplaceText($fileInfo, $old, $new)
{
    if( $_.GetType().Name -ne 'FileInfo')
    {
        # i.e. reject DirectoryInfo and other types
         return
    }
	
    (Get-Content $fileInfo.FullName) | % {$_.Replace($old, $new)} | Set-Content -path $fileInfo.FullName
    "Processed: " + $fileInfo.FullName
}