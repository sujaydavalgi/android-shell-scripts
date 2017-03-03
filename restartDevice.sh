#!/bin/bash

#  
# Created by Sujay Davalgi
#
# Restarts the selected device
#
# Usage: ./restartDevice.sh [<Device Serial>]
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

if [ "$( isAdbDevice $deviceSerial )" == "true" ]; then
	if [ "$( isDeviceBuildDevKey $deviceSerial )" == "true" ]; then
		dummyMsg=`adb -s $deviceSerial wait-for-device root`
		dummyMsg=`adb -s $deviceSerial wait-for-device shell stop`
		dummyMsg=`adb -s $deviceSerial wait-for-device shell start`
	else
		echo -e -n " Device doesnot support root access\n"
	fi
elif [[ "$( isFastbootDevice $deviceSerial )" == "true" || "$( isRecoveryDevice $deviceSerial )" == "true" ]]; then
	fastboot -s $deviceSerial reboot
else
	echo " Device is not in 'adb' or 'fastboot' mode\n"
fi