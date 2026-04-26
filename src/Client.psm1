using namespace System.Diagnostics.CodeAnalysis
using namespace System.Net
using module ./Cmdlets/Get-Version.psm1

<#
.SYNOPSIS
	Sends messages by SMS to a [FreeMobile](https://mobile.free.fr) account.
#>
class Client {

	<#
	.SYNOPSIS
		The base URL of the remote API endpoint.
	#>
	[ValidateNotNull()]
	[uri] $BaseUrl

	<#
	.SYNOPSIS
		The Free Mobile user name and password.
	#>
	[ValidateNotNull()]
	[pscredential] $Credential

	<#
	.SYNOPSIS
		The user agent string to use when making requests.
	#>
	[ValidateNotNullOrWhiteSpace()]
	hidden [string] $UserAgent = "PowerShell/$($PSVersionTable.PSVersion) | Belin.FreeMobile/$(Get-Version)"

	<#
	.SYNOPSIS
		Creates a new client.
	.PARAMETER UserName
		The Free Mobile user name.
	.PARAMETER Password
		The Free Mobile password.
	#>
	Client([string] $UserName, [securestring] $Password) {
		$this.BaseUrl = "https://smsapi.free-mobile.fr/"
		$this.Credential = [pscredential]::new($UserName, $Password)
	}

	<#
	.SYNOPSIS
		Creates a new client.
	.PARAMETER UserName
		The Free Mobile user name.
	.PARAMETER Password
		The Free Mobile password.
	.PARAMETER BaseUrl
		The base URL of the remote API endpoint.
	#>
	Client([string] $UserName, [securestring] $Password, [uri] $BaseUrl) {
		$this.BaseUrl = $BaseUrl
		$this.Credential = [pscredential]::new($UserName, $Password)
	}

	<#
	.SYNOPSIS
		Creates a new client.
	.PARAMETER Credential
		The Free Mobile user name and password.
	#>
	Client([pscredential] $Credential) {
		$this.BaseUrl = "https://smsapi.free-mobile.fr/"
		$this.Credential = $Credential
	}

	<#
	.SYNOPSIS
		Creates a new client.
	.PARAMETER Credential
		The Free Mobile user name and password.
	.PARAMETER BaseUrl
		The base URL of the remote API endpoint.
	#>
	Client([pscredential] $Credential, [uri] $BaseUrl) {
		$this.BaseUrl = $BaseUrl
		$this.Credential = $Credential
	}

	<#
	.SYNOPSIS
		Sends an SMS message to the underlying account.
	.PARAMETER Text
		The message text.
	#>
	[void] SendMessage([string] $Text) {
		$trimmedText = $Text.Trim()
		$query = @{
			msg = $trimmedText.Length -gt 160 ? $trimmedText.Substring(0, 160) : $trimmedText
			pass = $this.Credential.GetNetworkCredential().Password
			user = $this.Credential.UserName
		}

		Invoke-WebRequest ([uri]::new($this.BaseUrl, "sendmsg")) -Body $query -UserAgent $this.UserAgent | Out-Null
	}
}
