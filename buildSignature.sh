#!/bin/bash

# Created by Sujay Davalgi
#
# Displays all the required parameters to test the Build Signature
#
# Usage: ./buildSignature.sh [<Device Serial>]
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

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	adb -s $deviceSerial wait-for-device shell getprop | grep -i "ro.build.id"
	adb -s $deviceSerial wait-for-device shell getprop | grep -i "ro.baseband"
	adb -s $deviceSerial wait-for-device shell getprop | grep -i "ro.boot.bootloader"
	adb -s $deviceSerial wait-for-device shell getprop | grep -i "ro.build.description"
	adb -s $deviceSerial wait-for-device shell getprop | grep -i "ro.build.version.release"
	adb -s $deviceSerial wait-for-device shell getprop | grep -i "ro.build.fingerprint"
	adb -s $deviceSerial wait-for-device shell cat /proc/version

	echo ""
else
	echo " Device is not in 'adb' mode"
fi