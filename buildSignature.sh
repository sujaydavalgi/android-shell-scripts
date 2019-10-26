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
  echo -e -n " Build ID: "
	adb -s $deviceSerial wait-for-device shell getprop ro.build.id
  echo -e -n " Device Baseband: "
	adb -s $deviceSerial wait-for-device shell getprop ro.baseband
  echo -e -n " Bootloader version: "
	adb -s $deviceSerial wait-for-device shell getprop ro.boot.bootloader
  echo -e -n " Build description: "
	adb -s $deviceSerial wait-for-device shell getprop ro.build.description
  echo -e -n " Build Android version: "
	adb -s $deviceSerial wait-for-device shell getprop ro.build.version.release
  echo -e -n " Build fingerprint: "
	adb -s $deviceSerial wait-for-device shell getprop ro.build.fingerprint
  echo -e -n " Build SDK Version: "
	adb -s $deviceSerial wait-for-device shell getprop ro.build.version.sdk
  echo -e -n " Build signature: "
	adb -s $deviceSerial wait-for-device shell cat /proc/version

	echo ""
else
	echo " Device is not in 'adb' mode"
fi
