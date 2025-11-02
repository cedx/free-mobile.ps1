<#
.SYNOPSIS
	Sends an SMS notification.
#>
Import-Module FreeMobile
$password = ConvertTo-SecureString "your API key" -AsPlainText
Send-FreeMobileMessage "Hello World from PowerShell!" -UserName "your account identifier" -Password $password
Write-Output "The message was sent successfully."
