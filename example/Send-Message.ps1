<#
.SYNOPSIS
	Sends an SMS notification.
#>
Import-Module FreeMobile

$password = ConvertTo-SecureString "Your API key" -AsPlainText
"Hello World from PowerShell!" | Send-FreeMobileMessage -UserName "Your account identifier" -Password $password

Write-Output "The message was sent successfully."
