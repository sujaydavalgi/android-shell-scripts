#!/bin/bash

# Created by Sujay Davalgi
#
# Send d-Pad events to the selcted device
#
# Usage: ./findMyIp.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/keycodeEvents.sh

if [ $# -lt 1 ]; then
    getDeviceChoice
else
    buildDeviceSnArray
    deviceSerial="$1"
fi

displaySelectedDevice $deviceSerial

inputevent="null"

while [ "$inputevent" != "n" ]
do
	#echo -e -n " Do you want to input text : [y/n] "
	#stty -echo && read -n 1 inputevent && stty echo
	#formatYesNoOption $inputevent

	#case "$inputevent" in
	#	[yY])
			echo -e -n " --> Enter the text you want to input : "
			read inputtext
			adb -s $deviceSerial shell input text "${inputtext}"
	#		;;
	#	[nN])
	#		exit 1 ;;
	#esac
done

echo ""