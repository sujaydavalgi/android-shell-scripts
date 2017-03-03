#!/bin/bash

# Created by Sujay Davalgi
#
# Pass the commands to adb / fastboot
#
# Usage: ./commands.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh

if [ $# -lt 1 ]; then
    echo -e -n "Enter the command : "
    read commands
else
    commands="$@"
fi

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ "$( isAdbDevice $deviceSerial )" == "true" ]; then
	echo " Device is in 'adb' mode"
	`adb -s $deviceSerial  wait-for-device ${commands}`
elif [[ "$( isFastbootDevice $deviceSerial )" == "true" || "$( isRecoveryDevice $deviceSerial )" == "true" ]]; then
	echo " Device is in 'fastboot' mode"
	`fastboot -s $deviceSerial ${commands}`
else
	echo " Device is not in 'adb' mode or 'fastboot' mode"
fi