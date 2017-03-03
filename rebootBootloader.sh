#!/bin/bash

# Created by Sujay Davalgi
#
# Reboots the selected device in Fastboot/Bootloader mode
#
# Usage: ./rebootBootloader.sh [<Device Serial>]
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

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	adb -s $deviceSerial wait-for-device reboot bootloader
elif [[ "$( isFastbootDevice $deviceSerial )" == "true" ]]; then
	echo " Device is already in 'fastboot' mode"
elif [[ "$( isRecoveryDevice $deviceSerial )" == "true" ]]; then
	fastboot -s $deviceSerial reboot bootloader
else
	echo " Device is not in 'adb' mode"
fi