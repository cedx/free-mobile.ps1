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
	hidden [pscredential] $Credential

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
	Client([pscredential] $Credential, [string] $BaseUrl) {
		$this.BaseUrl = $BaseUrl.EndsWith("/") ? $BaseUrl : "$BaseUrl/"
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
		Invoke-WebRequest ([uri]::new($this.BaseUrl, "sendmsg")) -Body @{
			msg = $trimmedText.Length -gt 160 ? $trimmedText[0..159] : $trimmedText
			pass = ConvertFrom-SecureString $this.Credential.Password -AsPlainText
			user = $this.Credential.UserName
		}
	}
}
