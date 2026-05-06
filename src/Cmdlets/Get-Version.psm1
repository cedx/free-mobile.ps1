<#
.SYNOPSIS
	The cached module version.
#>
[semver] $Version = $null

<#
.SYNOPSIS
	Gets the module version.
.OUTPUTS
	The module version.
#>
function Get-Version {
	[CmdletBinding()]
	[OutputType([semver])]
	param ()

	if ($Script:Version) { return $Script:Version }
	$path = "$PSScriptRoot/../../Belin.FreeMobile.psd1"
	$module = Import-PowerShellDataFile ((Test-Path $path) ? $path : "$PSScriptRoot/../../FreeMobile.psd1")
	($Script:Version = [semver] $module.ModuleVersion)
}
