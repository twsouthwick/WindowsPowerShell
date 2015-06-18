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

# This is not publicly listed.  OneGet does not support tar right now
# Install-Package github-hub -MinimumVersion 2.2.0 -Force
