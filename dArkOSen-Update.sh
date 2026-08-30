#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    exec sudo -- "$0" "$@"
fi

clear
UPDATE_DATE="08312026"
LOG_FILE="/home/ark/dArkOSen-update$UPDATE_DATE.log"
UPDATE_DONE="/home/ark/.config/.dArkOSen-update$UPDATE_DATE"

if [ -f "$UPDATE_DONE" ] || [ -z "$UPDATE_DONE" ]; then
	msgbox "No more updates available.  Check back later."
	rm -- "$0"
	exit 187
fi

if [ -f "$LOG_FILE" ]; then
	rm "$LOG_FILE"
fi

LOCATION="https://raw.githubusercontent.com/djparentx/dArkOSen-updates/main"

msgbox "ONCE YOU PROCEED WITH THIS UPDATE SCRIPT, DO NOT STOP THIS SCRIPT UNTIL IT IS COMPLETED OR THIS DISTRIBUTION MAY BE LEFT IN A STATE OF UNUSABILITY.  Make sure you've created a backup of this sd card as a precaution in case something goes very wrong with this process.  You've been warned!  Type OK in the next screen to proceed."
my_var=`osk "Enter OK here to proceed." | tail -n 1`

echo "$my_var" | tee -a "$LOG_FILE"
sleep 1

if [ "$my_var" != "OK" ] && [ "$my_var" != "ok" ]; then
	msgbox "You didn't type OK.  This script will exit now and no changes have been made from this process."
	printf "You didn't type OK.  This script will exit now and no changes have been made from this process." | tee -a "$LOG_FILE"
	rm -- "$0"
	exit 187
fi

c_brightness="$(cat /sys/class/backlight/backlight/brightness)"
chmod 666 /dev/tty1
echo 255 > /sys/class/backlight/backlight/brightness
touch $LOG_FILE
tail -f $LOG_FILE >> /dev/tty1 &

# 07202026
if [ ! -f "/home/ark/.config/.dArkOSen-update07202026" ]; then
	printf "\nInstalling update 07202026\n" >> "$LOG_FILE" 2>&1
	sleep 2
	rm -rf /dev/shm/*
	wget -t 3 -T 60 --no-check-certificate "$LOCATION"/07202026/dArkOSen-update07202026.zip -O /dev/shm/dArkOSen-update07202026.zip -a "$LOG_FILE" || rm -f /dev/shm/dArkOSen-update07202026.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/dArkOSen-update07202026.zip" ]; then
		# remove old scripts
		rm -f /opt/system/Wi-Fi\ Manager*.sh /opt/system/BT\ Manager*.sh
		# backup old BMPs and JPGs folders
		cp -rf /boot/BMPs /boot/BMPs.old
		cp -rf /roms/launchimages/JPGs /roms/launchimages/JPGs.old
		rm -rf /roms/launchimages/JPGs
		rm -f /boot/low_battery2.bmp /boot/low_battery3.bmp /boot/low_battery4.bmp
		# unzip
		unzip -X -o /dev/shm/dArkOSen-update07202026.zip -d / | tee -a "$LOG_FILE"
		sleep 1
		# update fstab:
		bash /tmp/fix_fstab.sh
		# run dtb battery patch
		bash /tmp/patch_dtb_battery.sh
		# update script
		bash /tmp/07202026.sh
		touch "/home/ark/.config/.dArkOSen-update07202026"
		printf "\nUpdate successful" >> "$LOG_FILE" 2>&1
		# rebuilt uboot for all screen sizes
		bash /tmp/flash_uboot.sh
		sleep 1
		msgbox "A reboot is required, please run Update-dArkOSen again to finish updates.  System will now restart after you hit the A button to continue.  If the system doesn't restart after pressing A, just restart the system manually."		
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		reboot
	else
		printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." >> "$LOG_FILE" 2>&1
		rm -fv /dev/shm/dArkOSen-update07202026.z* | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	fi
fi

# 07272026
if [ ! -f "/home/ark/.config/.dArkOSen-update07272026" ]; then
	printf "\nInstalling update 07272026\n" >> "$LOG_FILE" 2>&1
	sleep 2
	rm -rf /dev/shm/*
	wget -t 3 -T 60 --no-check-certificate "$LOCATION"/07272026/dArkOSen-update07272026.zip -O /dev/shm/dArkOSen-update07272026.zip -a "$LOG_FILE" || rm -f /dev/shm/dArkOSen-update07272026.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/dArkOSen-update07272026.zip" ]; then
		# kill ogage
		systemctl stop ogage.service
		#cleanup
		rm -f /opt/system/Advanced/Restore\ R36H\ hotkeys.sh /opt/system/BT\ Manager*.sh /boot/dtb/r36s/R36S-Plus-V20\ 2025-03-18\ 2551/rg351mp-kernel.dtb
		# unzip update
		unzip -X -o /dev/shm/dArkOSen-update07272026.zip -d / | tee -a "$LOG_FILE"
		sleep 1
		# update script
		bash /tmp/07272026.sh
		touch "/home/ark/.config/.dArkOSen-update07272026"
		printf "\nUpdate successful" >> "$LOG_FILE" 2>&1
	else
		printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." >> "$LOG_FILE" 2>&1
		rm -fv /dev/shm/dArkOSen-update07272026.z* | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	fi
fi

# 07312026
if [ ! -f "/home/ark/.config/.dArkOSen-update07312026" ]; then
	# update dArkOS first
	if [[ ! -f "/home/ark/.config/.update07262026" ]]; then
		msgbox "The system will update dArkOS first, run Update-dArkOSen again after reboot to complete all updates."
		bash /opt/system/System/Update.sh
		exit 1
	fi
	printf "\nInstalling update 07312026\n" >> "$LOG_FILE" 2>&1
	sleep 2
	rm -rf /dev/shm/*
	wget -t 3 -T 60 --no-check-certificate "$LOCATION"/07312026/dArkOSen-update07312026.zip -O /dev/shm/dArkOSen-update07312026.zip -a "$LOG_FILE" || rm -f /dev/shm/dArkOSen-update07312026.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/dArkOSen-update07312026.zip" ]; then
		# kill ogage
		systemctl stop ogage.service
		# unzip update
		unzip -X -o /dev/shm/dArkOSen-update07312026.zip -d / | tee -a "$LOG_FILE"	
		sleep 1
		# run update script
		bash /tmp/07312026.sh
		touch "/home/ark/.config/.dArkOSen-update07312026"
		printf "\nUpdate successful" >> "$LOG_FILE" 2>&1		
	else
		printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." >> "$LOG_FILE" 2>&1
		rm -fv /dev/shm/dArkOSen-update07312026.z* | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	fi	
fi	

# 08152026	
if [ ! -f "/home/ark/.config/.dArkOSen-update08152026" ]; then
	printf "\nInstalling update 08152026\n" >> "$LOG_FILE" 2>&1
	sleep 2
	rm -rf /dev/shm/*
	wget -t 3 -T 60 --no-check-certificate "$LOCATION"/08152026/dArkOSen-update08152026.zip -O /dev/shm/dArkOSen-update08152026.zip -a "$LOG_FILE" || rm -f /dev/shm/dArkOSen-update08152026.zip | tee -a "$LOG_FILE"
	if [ -f "/dev/shm/dArkOSen-update08152026.zip" ]; then	
		# unzip
		unzip -X -o /dev/shm/dArkOSen-update08152026.zip -d / | tee -a "$LOG_FILE"
		sleep 1
		# run update script
		bash /tmp/08152026.sh
		touch "/home/ark/.config/.dArkOSen-update08152026"
		printf "\nUpdate successful" >> "$LOG_FILE" 2>&1
	else
		printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." >> "$LOG_FILE" 2>&1
		rm -fv /dev/shm/dArkOSen-update08152026.z* | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	fi	
fi

# 08312026
if [ ! -f "/home/ark/.config/.dArkOSen-update08312026" ]; then
	printf "\nInstalling update 08312026\n" >> "$LOG_FILE" 2>&1
	sleep 2
	# rm -rf /dev/shm/*
	wget -t 3 -T 60 --no-check-certificate "$LOCATION"/08312026/dArkOSen-update08312026.zip -O /tmp/dArkOSen-update08312026.zip -a "$LOG_FILE" || rm -f /tmp/dArkOSen-update08312026.zip | tee -a "$LOG_FILE"
	if [ -f "/tmp/dArkOSen-update08312026.zip" ]; then	
		# unzip
		unzip -X -o /tmp/dArkOSen-update08312026.zip -d / | tee -a "$LOG_FILE"
		sleep 1
		# run update script
		bash /tmp/08312026.sh
	else
		printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." >> "$LOG_FILE" 2>&1
		rm -fv /tmp/dArkOSen-update08312026.z* | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	fi
	
	rm -v -- "$0" | tee -a "$LOG_FILE"
	printf "\033c" >> /dev/tty1
	msgbox "Updates have been completed.  System will now restart after you hit the A button to continue.  If the system doesn't restart after pressing A, just restart the system manually."
	echo $c_brightness > /sys/class/backlight/backlight/brightness
	reboot
	exit 187

fi