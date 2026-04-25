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
	($Script:Version = (Import-PowerShellDataFile "$PSScriptRoot/../../FreeMobile.psd1").ModuleVersion)
}
