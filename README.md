[<img width="150" height="50" alt="ChatGPT Image Aug 12, 2026, 02_04_12 PM" img align="right"  src="https://github.com/user-attachments/assets/7eb7b583-5d57-4884-ae90-ad7127d733c4" alt="Right aligned" />](https://ko-fi.com/O8Z424G15Y)

# The official update channel for dArkOSen.


Use 'Update' in your System folder to update.

Download the latest fully updated image here: [dArkOSen Releases](https://github.com/djparentx/dArkOSen-R36S/releases)

---

# 08152026 Change Log

The last update enabled the Safe Shutdown shortcut in the hotkeys. Many of you may have found out, as I did, that it was anything but safe. It had a tendency to corrupt SD2 due to how it was unmounting before shutdown. I have repaired the Safe Shutdown script and also added the new SD Scan and Repair utility for those of you who may not have access to a PC to repair your filesystems. It cannot repair a damaged card, but if you find games were missing or the system is otherwise acting weird after using Safe Shutdown running an SD scan can fix most filesystem issues.

## Documentation & Support

* created the [dArkOSen Wiki](https://github.com/djparentx/dArkOSen-R36S/wiki)

## Boot & System

* fixed 'finish.sh' - no more worry of SD corruption from using the 'Safe Shutdown' hotkey
* fixed 'recovery-check.service' - was loading before /boot was mounted
* updated SYSTEMS Manager to allow moving Tools and Ports back to SD1
* added 'SD Card Scan and Repair' to the System folder

  * runs fsck.fat or btrfs scrub to check for and automatically fix errors
  * unmounts partitions first, reboot may be required
  * detailed logs are created after each scan at /home/ark/sd_scan.log
  * limited to repairing corrupt filesystems, cannot fix a dying card
  * rootfs is limited to simple repairs, if a PC scan is needed it gives instructions

## Emulation

* fixed Retrorun Saturn for non-R36S devices
* fixed conflicting Hotkeys in Mupen64Plus, see Wiki
* added 'Update Retroarch Cheats' to the Advanced folder

  * the most recent Cheats update is included as part of this update
* added 'PSX - CHD to ISO' to the Advanced folder
* changed menu hotkey in Drastic/Advanced Drastic to L3
* added 'Drastic Bilinear Filter Mode' to the Advanced folder

  * use the script to turn bilinear filtering on or off
  * changes settings for Drastic and Advanced Drastic at the same time

## Vulkan & Development Tools

* fixed missing Vulkan support (libmali)
  — registered missing ICD file so Vulkan apps can use the Mali-G31 GPU instead of falling back to software rendering
* installed strace, ltrace, vulkan-tools, usbutils, gdb

## Video Tools

* added 'R36 SD MP4 Video Converter' to the Tools folder

  * converts any selected video in /movies to 640x480, 24fps, 196k audio
  * choice of padding or cropping non-4:3 AR videos
  * takes around 1 minute per minute of video to convert
  * outputs new video with appended filename to /movies folder - does not delete original

## DTB & Hardware

* marked all clone and soysauce dtbs as UNSUPPORTED in PC and macOS DTB SELECTORS to remove ambiguity
* fixed R36S-Plus-V20 2025-03-18 2551 rg351mp-uboot.dtb to properly display the boot logo
* added more DTBs to the selector:

  * HL-R36H-V21 2024-11-18
  * R36S-V21 2024-12-18 2529
  * R36S-V21 2024-12-18 2547
* added 'R36 Joystick Deadzone Adjuster' to the System folder
* updated all dtbs with an improved deadzone value of 384 ADC
* updated 'dArkOSen_dtb_patcher_v1.2' to include adc-deadzone values

## Wi-Fi

* updated to 'Wi-Fi Manager 4.3.7' see repo for changes

---

# 07312026 Change Log
## System Updates

- retore EmulationStation after dArkOS update
- restore dArkOSen system hotkeys after dArkOS update
- removed dArkOS update path
- renamed 'Update-dArkOSen' to 'Update'
- changed hostname to 'dArkOSen-r36'
- fixed fstab device path error

## System Utilities

- added 'BatteryPlus Mode Switcher' to the Advanced folder [BatteryPlus](https://github.com/Mikhailzrick/knubat.components)
- updated R36 Backup and Migration Assistant to apply Retroarch hotkeys
- added 'Restore dArkOSen' to the Advanced folder
	- restores dArkOSen's kernel and ogage (overclock and hotkeys) and @Jason3x's emulationstation

## Emulation & Gaming

- added 'Dave's Retro Shaders 2.0' - major performance updates to the CRT and LCD shaders!
- added Advanced Drastic NDS emulator (lifted from dArkOSRE, thanks go to southoz)
- applied dArkOSRE style Retroarch hotkeys (Reset Retroarch Settings in Advance folder to apply)
- enable single press of Fn button to open Retroarch menu (systemd service)

## Hotkeys


### Retroarch Hotkeys

| FUNCTION | HOTKEY COMBO |
| :--- | :--- |
| Retroarch Menu | Function or Select for 2 seconds |
| Quit Retroarch | Start + Select |
| Pause | Select + R3 |
| Reset Core | Select + R2 |
| Save State | Select + B (Bottom) |
| Load State | Select + A (Right) |
| Prev State | Select + Y (Left) |
| Next State | Select + X (Top) |
| Fast Forward | Select + D-Pad Right |
| Fast Forward Hold | Select + D-Pad Down |
| Rewind | Select + D-Pad Left |
| Frame Advance | Select + D-Pad Up |
| Screenshot | Select + L3 |

### System Hotkeys

- Fn or R3 (right joystick press) both act as the hotkey
- gamma hotkeys switched to D-Pad left and right

| FUNCTION | HOTKEY COMBO |
| :--- | :--- |
| Brightness Up | Hotkey + D-Pad Up |
| Brightness Down | Hotkey + D-Pad Down |
| Gamma Up | Hotkey + D-Pad Right |
| Gamma Down | Hotkey + D-Pad Left |
| Volume Up | Hotkey + R1 |
| Volume Down | Hotkey + L1 |
| Safe Shutdown | Hotkey + Power |
| Mute | Hotkey + L3 |
| Battery Level | Select + R3 |
| Toggle Wifi | Select + L1 |
| Toogle Bluetooth | Select + R1 |

## Performance & Thermal Management

- fixed boot race condition in CPU Manager/ZRAM service

---

# 07272026 Change Log
## Boot & Startup

- DTB SELECTOR.apk (for Android) added to /boot (thanks u/Jason_2x!)
- SELECT MODEL MAC_OSX.sh (for Mac) added to /boot (thanks to moroboshi69)

## System Utilities

- repaired FFMPEG and Libvulkan1 installations
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

- installed mame-tools to enable game and video conversion on the console
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

