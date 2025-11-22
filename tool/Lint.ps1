"Performing the static analysis of source code..."
Import-Module PSScriptAnalyzer
Invoke-ScriptAnalyzer $PSScriptRoot -Recurse
Invoke-ScriptAnalyzer src -Recurse
Test-ModuleManifest FreeMobile.psd1 | Out-Null
Invoke-ScriptAnalyzer test -ExcludeRule PSAvoidUsingConvertToSecureStringWithPlainText -Recurse
