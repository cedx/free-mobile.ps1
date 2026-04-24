@{
	DefaultCommandPrefix = "FreeMobile"
	ModuleVersion = "1.0.0"
	PowerShellVersion = "7.6"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	Description = "Send SMS messages to your Free Mobile device."
	GUID = "8a16d600-a064-4037-9147-d13059c6abf7"

	AliasesToExport = @()
	CmdletsToExport = @()
	VariablesToExport = @()

	FunctionsToExport = @(
		"New-Client"
		"Send-Message"
	)

	NestedModules = @(
		"src/Cmdlets/New-Client.psm1"
		"src/Cmdlets/Send-Message.psm1"
	)

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://github.com/cedx/free-mobile.ps1/blob/main/License.md"
			ProjectUri = "https://github.com/cedx/free-mobile.net"
			ReleaseNotes = "https://github.com/cedx/free-mobile.ps1/releases"
			Tags = "api", "client", "free", "mobile", "sms"
		}
	}
}
