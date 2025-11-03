<#
.SYNOPSIS
	Tests the features of the `Main` module.
#>
Describe "Main" {
	BeforeAll {
		Import-Module ./FreeMobile.psd1
	}

	Context "Send-Message" {
		It "should throw an exception if a network error occurred" {
			$password = ConvertTo-SecureString "secret" -AsPlainText
			{ "Hello World!" | Send-FreeMobileMessage -UserName "anonymous" -Password $password -Uri "http://localhost:666" } | Should -Throw
		}

		It "should throw a [HttpRequestException] if the credentials are invalid" {
			$password = ConvertTo-SecureString "secret" -AsPlainText
			{ "Hello World!" | Send-FreeMobileMessage -UserName "anonymous" -Password $password } | Should -Throw
		}

		It "should send SMS messages if the credentials are valid" {
			$password = ConvertTo-SecureString $Env:FREEMOBILE_API_KEY -AsPlainText
			{ "Hello Cédric, from PowerShell!" | Send-FreeMobileMessage -UserName $Env:FREEMOBILE_ACCOUNT -Password $password } | Should -Not -Throw
		}
	}
}
