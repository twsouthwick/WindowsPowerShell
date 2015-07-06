$apps = @(
  "fiddler4", 
  "git",
  "git-credential-winstore",
  "vim",
  "dotpeek",
  "Devbox-RapidEE",
  "notepadplusplus",
  "7zip",
  "putty",
  "keepass",
  "googlechrome",
  "beyondcompare",
  "speccy",
  "rdcman",
  "lockhunter",
  "ilspy",
  "procmon"
  )

$apps | % { Install-Package $_ -Force }

# Set git-credential-winstore
if($env:PROCESSOR_ARCHITECTURE -eq "amd64"){
  $programFiles = ${env:ProgramFiles(x86)}
} else {
  $programFiles = ${env:ProgramFiles}
}

$env:Path = "$env:Path;$programFiles\git\bin"
$winstorePackage = Get-Package git-credential-winstore
$winstore = Resolve-Path "$($winstorePackage.Source)\..\lib\net40-Client\git-credential-winstore.exe"

& $winstore -s

# This is not publicly listed
Install-Package github-hub -MinimumVersion 2.2.1
