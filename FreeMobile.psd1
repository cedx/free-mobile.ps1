@{
	DefaultCommandPrefix = "FreeMobile"
	ModuleVersion = "1.0.0"
	PowerShellVersion = "7.4"
	RootModule = "src/Main.psm1"

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
		"src/Client.psm1"
	)

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://raw.githubusercontent.com/cedx/free-mobile.ps1/main/License.md"
			ProjectUri = "https://github.com/cedx/free-mobile.ps1"
			ReleaseNotes = "https://github.com/cedx/free-mobile.ps1/releases"
			Tags = "api", "client", "free", "mobile", "sms"
		}
	}
}
