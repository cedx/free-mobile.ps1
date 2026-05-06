using namespace System.Diagnostics.CodeAnalysis
using namespace System.Management.Automation
using module ../Client.psm1

<#
.SYNOPSIS
	Creates a new Free Mobile client.
.INPUTS
	The Free Mobile user name and password.
.OUTPUTS
	The newly created client.
#>
function New-FreeMobileClient {
	[CmdletBinding()]
	[OutputType([Client])]
	[SuppressMessage("PSUseShouldProcessForStateChangingFunctions", "")]
	param (
		# The Free Mobile user name and password.
		[Parameter(Mandatory, Position = 0, ValueFromPipeline)]
		[Credential()]
		[pscredential] $Credential,

		# The base URL of the remote API endpoint.
		[uri] $Uri = "https://smsapi.free-mobile.fr/"
	)

	process {
		[Client]::new($Credential, $Uri)
	}
}
