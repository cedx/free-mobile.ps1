using module ./Client.psm1

<#
.SYNOPSIS
	Creates a new Free Mobile client.
.PARAMETER Credential
	The Free Mobile user name and password.
.PARAMETER UserName
	The Free Mobile user name.
.PARAMETER Password
	The Free Mobile password.
.PARAMETER Uri
	The base URL of the remote API endpoint.
.OUTPUTS
	The newly created Free Mobile client.
#>
function New-Client {
	[CmdletBinding(DefaultParameterSetName = "Credential")]
	[OutputType([Client])]
	param (
		[Parameter(ParameterSetName = "Credential")]
		[pscredential] $Credential,

		[Parameter(Mandatory, ParameterSetName = "UserName", Position = 0)]
		[ValidateNotNullOrWhiteSpace()]
		[string] $UserName,

		[Parameter(Mandatory, ParameterSetName = "UserName", Position = 1)]
		[ValidateNotNull()]
		[securestring] $Password,

		[ValidateNotNull()]
		[uri] $Uri = "https://smsapi.free-mobile.fr/"
	)

	if ($PSCmdlet.ParameterSetName -eq "UserName") {
		$Credential = $Password ? ([pscredential]::new($UserName, $Password)) : (Get-Credential -UserName $UserName)
	}

	if (-not $Credential) { $Credential = Get-Credential }
	[Client]::new($Credential, $Uri)
}

<#
.SYNOPSIS
	Sends an SMS message to the specified Free Mobile account.
.PARAMETER Message
	The message text.
.PARAMETER Client
	The Free Mobile client to use.
.PARAMETER Credential
	The Free Mobile user name and password.
.PARAMETER UserName
	The Free Mobile user name.
.PARAMETER Password
	The Free Mobile password.
.PARAMETER Uri
	The base URL of the remote API endpoint.
#>
function Send-Message {
	[CmdletBinding(DefaultParameterSetName = "Credential")]
	[OutputType([void])]
	param (
		[Parameter(Mandatory, Position = 0, ValueFromPipeline)]
		[ValidateNotNullOrWhiteSpace()]
		[string] $Message,

		[Parameter(ParameterSetName = "Client")]
		[ValidateNotNull()]
		[Client] $Client,

		[Parameter(ParameterSetName = "Credential")]
		[pscredential] $Credential,

		[Parameter(Mandatory, ParameterSetName = "UserName")]
		[ValidateNotNullOrWhiteSpace()]
		[string] $UserName,

		[Parameter(Mandatory, ParameterSetName = "UserName")]
		[ValidateNotNull()]
		[securestring] $Password,

		[Parameter(ParameterSetName = "Credential")]
		[Parameter(ParameterSetName = "UserName")]
		[ValidateNotNull()]
		[uri] $Uri = "https://smsapi.free-mobile.fr/"
	)

	begin {
		switch ($PSCmdlet.ParameterSetName) {
			"Credential" { $Client = New-Client -Credential $Credential -Uri $Uri; break }
			"UserName" { $Client = New-Client -UserName $UserName -Password $Password -Uri $Uri; break }
		}
	}

	process {
		$Client.SendMessage($Message)
	}
}
