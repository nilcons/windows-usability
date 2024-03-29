# Install the latest version

Always install the latest version if you can, look into how to get a
fresh ISO from Microsoft or from some website.  It's a lot easier than
waiting for hours for Windows Update to finish!

# BIOS time in UTC

This is needed only if you are dual booting a GNU/Linux you want in
UTC and a Windows.  Not needed for VMs.

In an elevated powershell:

```
Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation -Name RealTimeIsUniversal -Type QWORD -Value 1
```

Disable automatic time sync in the settings, Linux NTP is enough.

# Caps Lock as Ctrl

    Windows Registry Editor Version 5.00
    
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
    "Scancode Map"=hex:00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00

# Non-accelerating mouse

Turn off "increase mouse precision" under advanced settings of the mouse.

# Windows Subsystem for Linux

Enable Developer mode, wait for install.

Then open powershell in admin mode and type: `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`

Installing Debian after the restart:

```
curl.exe -L -o debian.appx https://aka.ms/wsl-debian-gnulinux
Add-AppxPackage debian.appx
```

Then once we have to run `Debian` from the start menu to initialize.

Then you can run `bash` from the start menu.

More info: https://learn.microsoft.com/en-us/windows/wsl/install-manual#downloading-distributions

# Disable Windows Store stupidity

Open Windows Store, go to Settings, disable all automatic downloads
and updates and stuff.

# Small disk size: turn off hibernate and page file (swap)

In an admin cmd:

    powercfg.exe /hibernate off

Page file: system -> settings -> advanced -> super advanced -> and somewhere there.

# Bitlocker without TPM

`gpedit.exe`, then local computer policy -> computer configuration -> administrative -> windows components -> bitlocker -> operating system drives -> require additional authentication at startup.

Set require password checkbox and "do not allow TPM" at startup.
