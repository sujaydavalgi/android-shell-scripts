#!/bin/bash

# Created by Sujay Davalgi
#
# Displays the Bluetooth dumpsys status
#
# Usage: ./btStatus.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh

if [ $# -lt 1 ]; then
    getDeviceChoice
else
    buildDeviceSnArray
    deviceSerial="$1"
fi

displaySelectedDevice $deviceSerial

if [ $( checkAdbDevice $deviceSerial ) == "true" ]; then
	adb -s $deviceSerial wait-for-device shell dumpsys bluetooth
else
	echo " Device in not in 'adb' mode"
fi