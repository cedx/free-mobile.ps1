Write-Output "Publishing the package..."
$version = (Import-PowerShellDataFile "FreeMobile.psd1").ModuleVersion
git tag "v$version"
git push origin "v$version"
