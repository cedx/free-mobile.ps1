<#
.SYNOPSIS
	Sends an SMS notification.
#>
Import-Module FreeMobile

$password = ConvertTo-SecureString "Your API key" -AsPlainText
Send-FreeMobileMessage "Hello World from PowerShell!" -UserName "Your account identifier" -Password $password

Write-Output "The message was sent successfully."
