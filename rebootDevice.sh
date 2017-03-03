#!/bin/bash

# Created by Sujay Davalgi
#
# Reboots the selected device
#
# Usage: ./rebootDevice.sh [<Device Serial>]
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

if [[ "$( isAdbDevice $deviceSerial )" == "true" || "$( isRecoveryDevice $deviceSerial )" == "true" ]]; then
	adb -s $deviceSerial reboot
elif [ "$( isFastbootDevice $deviceSerial )" == "true" ]; then
	fastboot -s $deviceSerial reboot
fi