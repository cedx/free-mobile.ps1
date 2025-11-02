using module ../src/Client.psm1

<#
.SYNOPSIS
	Tests the features of the `Client` module.
#>
Describe "Client" {
	Context "SendMessage" {
		It "should throw an exception if a network error occurred" {
			$credential = [pscredential]::new("anonymous", (ConvertTo-SecureString "secret" -AsPlainText))
			$client = [Client]::new($credential, "http://localhost:666")
			{ $client.SendMessage("Hello World!") } | Should -Throw
		}

		It "should throw a `HttpRequestException` if the credentials are invalid" {
			$credential = [pscredential]::new("anonymous", (ConvertTo-SecureString "secret" -AsPlainText))
			$client = [Client] $credential
			{ $client.SendMessage("Hello World!") } | Should -Throw
		}

		It "should send SMS messages if the credentials are valid" {
			$credential = [pscredential]::new($Env:FREEMOBILE_ACCOUNT, (ConvertTo-SecureString $Env:FREEMOBILE_API_KEY -AsPlainText))
			$client = [Client] $credential
			{ $client.SendMessage("Hello Cédric, from PowerShell!") } | Should -Not -Throw
		}
	}
}
