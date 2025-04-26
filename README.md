# How to make Windows bearable

# Install Nix WSL

1. [Nix WSL Installation](https://nix-community.github.io/NixOS-WSL/index.html)

## Windows LTSC

1. In order to get the terminal, you need to install Microsoft Store. That can be done through admin powershell:

```powershell
wsreset -i
```

2. Restore GameBar: https://aka.ms/GamingRepairTool
3. Autologon: https://learn.microsoft.com/en-us/sysinternals/downloads/autologon

## HiDPI fix

`%USERPROFILE%/.wslgconfig`:

```
[system-distro-env]
WESTON_RDP_DEBUG_DESKTOP_SCALING_FACTOR=200
```

## Install Powertoys and remap keyboard

[Powertoys](https://learn.microsoft.com/en-us/windows/powertoys/)

## Disable Cmd+X shortcuts

Admin ps then reboot:

```ps
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies" -Name "Explorer" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" `
    -Name "NoWinKeys" `
    -PropertyType DWord `
    -Value 1 `
    -Force
```

## Fix Linux/Windows time shifts

```
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Value 1 -Type DWord
```

or 

```
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /t REG_DWORD /d 1 /f
```
