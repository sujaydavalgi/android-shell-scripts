#!/bin/bash

#
# Created by Sujay Davalgi
#
# display the input events to the system
#
# Usage: ./deviceEvents.sh [<Device Serial>]
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
	if [ "$( isDeviceBuildDevKey $deviceSerial )" == "true" ]; then	
		adb -s $deviceSerial wait-for-device root
		adb -s $deviceSerial wait-for-device shell getevent -l
	else
		echo -e -n " Device doesnot support root access\n"
	fi
else
	echo " Device is not in 'adb' mode"
fi