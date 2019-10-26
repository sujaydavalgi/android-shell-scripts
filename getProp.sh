#!/bin/bash

# Created by: Sujay Davalgi
#
# Displays the getProp details of the selected device
#
# Usage: ./getProp.sh [<deviceSerial>]
# Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	adb -s $deviceSerial shell getprop | grep -i "$1"
else
	echo " Device is not in 'adb' mode"
fi
