# The official update channel for dArkOSen.


Use 'Update' in your System folder to update.

Download the latest fully updated image here: [dArkOSen Releases](https://github.com/djparentx/dArkOSen-R36S/releases)

---

# 07272026 Change Log
## Boot & Startup

- DTB SELECTOR.apk (for Android) added to /boot (thanks u/Jason_2x!)
- SELECT MODEL MAC_OSX.sh (for Mac) added to /boot (thanks to moroboshi69)

## System Utilities

- added 'Dave's Retro Shaders v1.7' back, got missed in last update somehow
- added 'Adjust Gamma' to the System folder (thanks to u/southozfps for the reference materials)
- added back full screen Files viewer for 1024x768 screens (dropped by accident in the first release)
- restored 'Remove ._ Files' to the System folder (for our Mac users)
- added 'PSP - CHD to ISO' to the Advanced Folder
- added 'Convert GIF to MP4' to the Advanced folder
	- run to convert and crop /roms/launchimages/loading.gif to /roms/launchimages/loading.mp4
- added 'Convert Loading Animations' to the Advanced folder
	- run to convert and crop /roms/launchimages/loading.gif or /roms/launchimages/loading.mp4 to a format readable by ES/FCAMOD
	- added sample gif and mp4s to /launchimages

## Hotkeys

- NEW HOTKEYS! More functions added:

	- repeat-on--hold key presses are active
	- Fn or R3 (right joystick press) both act as the hotkey
	- HOTKEY + D-pad up or down adjusts brightness
	- HOTKEY + Volume up or down adjusts brightness
	- HOTKEY + D-pad left or right adjusts volume
	- HOTKEY + L or R triggers adjust volume
	- HOTKEY + L2 or R2 triggers adjust gamma
	- HOTKEY + Power button for instant safe shutdown
	- HOTKEY + L3 toggles mute
	- SELECT + R3 speaks battery percentage
	- SELECT + L trigger toggles wifi
	- SELECT + R trigger toggles bluetooth

## Emulation & Gaming

- installed mame-tools, ffmpeg, and libvulkan1 to enable game and video conversion on the console
- fixed Retrorun and Retrorun32 no controls and wrong display for R36H and R45H boards
- fixed Retrorun32 had no audio
- fixed PPSSPP-2021 not saving games

## Connectivity

- added Italian language support to EmulationStation (thanks u/Jason_2x!)
- added Bluetooth controller support to BT Manager
- added automatic detection of SD2 for samba sharing to Wi-Fi Manager

## Device Support

- fixed 'rg351mp-uboot.dtb' for R36S-Plus-V20 2025-03-18 2551

---

# 07202026 Change Log
## Boot & Startup

- everyone gets new boot logos! (1024x768 and 720x720 supported)
- new dArkOSen loading images
- fixed boot logo for 1024x768 devices, everyone uses the same image/build now
- added Recovery boot service
	- '/boot/recovery.sh' is called before ES loads
	- 'recovery.sh' can be anything, allowing to fix an unbootable system
	- system loads as normal if 'recovery.sh' not present
- hostname and hosts changed to 'MYDEVICE'
- updater changed to 'Update-dArkOSen.sh'
- fixed ownership of root folder
- fixed fstab to prevent boot failure with 2 SD cards

## Kernel & Hardware

- added new dArkOSen OC kernel (a heatsink is recommended if using overclocking)
- USB gadget (ECM/RNDIS/EEM + mass storage) enabled in kernel
- all dtbs for genuine R36S models are patched for accurate battery reporting
- new dtbs added to selector:
	- R36S-Plus-V20 2025-03-18 2551
	- R36S-V22 2024-12-18 2534
	- HL-R45H-V20 2025-11-18

## Networking

- added NetworkManager dispatcher to disable IPV6 for faster PC connections
- fixed missing battery and bluetooth icons
- updated Wi-Fi Manager and BT Manager

## System Utilities

- updated 'Switch to SD2 for ROMs' to copy '/roms/tools' to '/roms2/tools' during setup
- added R36 Tuner to the System folder (thanks to u/z3nmode-adri)
- added R36 Boot Volume to the System folder (default set to 60%)
- added Kodi Remover to the Advanced folder
- added dArkOSen_dtb_patcher_v1.1 to the Advanced folder
	- if you added your own dtb run dtb patcher to access overclocking

## Audio

- added more delay to volume-resume-fix, raised to 0.65s as some buffer pops were still leaking in ES

## Themes & Graphics

- major update to Gameboy and NGP overlays in Retro Shaders 
- updated R36 Theme Patcher

---

# How the Overclock Works
- Chips get a factory "grade" based on quality — lower-grade chips get told to stay slow
- Unlocked new speed steps (1368–1512MHz) in the DTB that didn't exist before
- Kernel now pretends the chip has a top-tier grade when `max_cpufreq=1512` is set — without this, clock *reports* higher but real performance stays capped

## Risk
- Not measuring the actual chip's real quality — just assuming top-tier and running top-tier voltage
- If a specific chip isn't actually top-tier: possible instability, crashes, or faster long-term wear (over years not hours)

## Safeguards Still in Place
- DTB voltage ceiling (1.4V) — hard cap, can't be exceeded regardless of cmdline
- `boot_cpufreq` floor (1296MHz default) — always boots safe, only ramps up if userspace raises it
- Requests above the DTB ceiling get rejected

---

