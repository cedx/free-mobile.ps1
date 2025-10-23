using module ../src/Client.psm1

<#
.SYNOPSIS
	Tests the features of the `Client` module.
#>
Describe "Client" {
	Context "SendMessage" {
		It "should throw an exception if a network error occurred" {
			$client = [Client]::new("anonymous", "secret", "http://localhost:666")
			{ $client.SendMessage("Hello World!") } | Should -Throw
		}

		It "should throw a `HttpRequestException` if the credentials are invalid" {
			$client = [Client]::new("anonymous", "secret")
			{ $client.SendMessage("Hello World!") } | Should -Throw
		}

		It "should send SMS messages if the credentials are valid" {
			$client = [Client]::new($Env:FREEMOBILE_ACCOUNT, $Env:FREEMOBILE_API_KEY)
			{ $client.SendMessage("Hello Cédric, from PowerShell!") } | Should -Not -Throw
		}
	}
}
