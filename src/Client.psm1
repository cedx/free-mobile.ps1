<#
.SYNOPSIS
	Sends messages by SMS to a [FreeMobile](https://mobile.free.fr) account.
#>
class Client {

	<#
	.SYNOPSIS
		The Free Mobile account.
	#>
	[ValidateNotNullOrWhiteSpace()] [string] $Account

	<#
	.SYNOPSIS
		The Free Mobile API key.
	#>
	[ValidateNotNullOrWhiteSpace()] [string] $ApiKey

	<#
	.SYNOPSIS
		The base URL of the remote API endpoint.
	#>
	[ValidateNotNull()] [uri] $BaseUrl

	<#
	.SYNOPSIS
		Creates a new client.
	.PARAMETER Account
		The Free Mobile account.
	.PARAMETER ApiKey
		The Free Mobile API key.
	#>
	Client([string] $Account, [string] $ApiKey) {
		$this.Account = $Account
		$this.ApiKey = $ApiKey
		$this.BaseUrl = "https://smsapi.free-mobile.fr/"
	}

	<#
	.SYNOPSIS
		Creates a new client.
	.PARAMETER Account
		The Free Mobile account.
	.PARAMETER ApiKey
		The Free Mobile API key.
	.PARAMETER BaseUrl
		The base URL of the remote API endpoint.
	#>
	Client([string] $Account, [string] $ApiKey, [string] $BaseUrl) {
		$this.Account = $Account
		$this.ApiKey = $ApiKey
		$this.BaseUrl = $BaseUrl.EndsWith("/") ? $BaseUrl : "$BaseUrl/"
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
			pass = $this.ApiKey
			user = $this.Account
		}
	}
}
