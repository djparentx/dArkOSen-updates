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

if [ ! -f "/home/ark/.config/.dArkOSen-update08312026" ]; then
	printf "\nInstalling update 08312026\n" >> "$LOG_FILE" 2>&1
	sleep 2
	if [ -f "/opt/system/Tools/dArkOSen-update08312026.zip" ]; then	
		# unzip
		unzip -X -o /opt/system/Tools/dArkOSen-update08312026.zip -d / | tee -a "$LOG_FILE"
		sleep 1
		# run update script
		bash /tmp/08312026.sh
	else
		printf "\nThe update couldn't complete because the package did not download correctly.\nPlease retry the update again." >> "$LOG_FILE" 2>&1
		rm -fv /opt/system/Tools/dArkOSen-update08312026.zip | tee -a "$LOG_FILE"
		sleep 3
		echo $c_brightness > /sys/class/backlight/backlight/brightness
		exit 1
	fi	
	
	rm -f /opt/system/Tools/dArkOSen-update08312026.zip
	rm -v -- "$0" | tee -a "$LOG_FILE"
	printf "\033c" >> /dev/tty1
	msgbox "Updates have been completed.  System will now restart after you hit the A button to continue.  If the system doesn't restart after pressing A, just restart the system manually."
	echo $c_brightness > /sys/class/backlight/backlight/brightness
	reboot
	exit 187

fi
