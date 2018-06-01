# Install the latest version

Always install the latest version if you can, look into how to get a
fresh ISO from Microsoft or from some website.  It's a lot easier than
waiting for hours for Windows Update to finish!

# Caps Lock as Ctrl

    Windows Registry Editor Version 5.00
    
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
    "Scancode Map"=hex:00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00

# Non-accelerating mouse

Turn off "increase mouse precision" under advanced settings of the mouse.

# Windows Subsystem for Linux

Enable Developer mode, wait for install.

Then open powershell in admin mode and type: `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
`

Then open Windows Store and install "Debian GNU/Linux".

Then you can run `bash` from the start menu.

# Disable Windows Store stupidity

Open Windows Store, go to Settings, disable all automatic downloads
and updates and stuff.

# Small disk size: turn off hibernate and page file (swap)

In an admin cmd:

    powercfg.exe /hibernate off

Page file: system -> settings -> advanced -> super advanced -> and somewhere there.
