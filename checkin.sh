#!/bin/bash

# Created by Sujay Davalgi
#
# Performs the Force checking of the device
#
# Usage: ./checkin.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		IF the serial number is not provided, it will display the list of attached devices to pick from

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
	#adb -s $deviceSerial wait-for-device shell am broadcast -a android.server.checkin.CHECKIN
	adb -s $deviceSerial wait-for-device shell am broadcast -f 0x10 --ez force TRUE -a android.server.checkin.CHECKIN -n 'com.google.android.gms/.checkin.CheckinService\$TriggerReceiver'
	echo ""
else
	echo " Device is not in 'adb' mode"
fi