# Free Mobile for PowerShell
Send SMS messages to your [Free Mobile](https://mobile.free.fr) device via any internet-connected device.

For example, you can configure a control panel or storage connected to your home network to send a notification to your mobile phone when an event occurs.

## Quick start
> [!NOTE]
> SMS notifications require an API key. If you are not already registered,
> [sign up for a Free Mobile account](https://mobile.free.fr/subscribe).

### Get an API key
You first need to enable the **SMS notifications** in [your subscriber account](https://mobile.free.fr/account).
This will give you an identification key allowing access to the [Free Mobile](https://mobile.free.fr) API.

![Screenshot](Screenshot.png)

### Get the module
Install the latest version of **Free Mobile for PowerShell**
with [PSResourceGet](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.psresourceget) package manager:

```shell
Install-PSResource Belin.FreeMobile
```

For detailed instructions, see the [installation guide](Installation.md).

## Usage
This module provides the `Send-FreeMobileMessage` cmdlet, which allows you to send SMS notifications to your mobile phone:

```pwsh
Import-Module Belin.FreeMobile

$credential = [pscredential]::new("Your account identifier", (ConvertTo-SecureString "Your API key" -AsPlainText))
Send-FreeMobileMessage "Hello World from PowerShell!" -Credential $credential
Write-Output "The message was sent successfully."
```

> [!WARNING]
> The text of the messages will be automatically truncated to **160** characters:  
> you can't send multipart messages using this mpdule.
