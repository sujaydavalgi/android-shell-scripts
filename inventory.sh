#!/bin/bash

# Created by Sujay Davalgi
#
# Gets all the device details to be recorded in inventory list
#
# Usage: ./inventory.sh [<Device Serial>]
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
	echo -e -n " Device Type : "
	adb -s $deviceSerial wait-for-device shell getprop "gsm.current.phone-type"
	echo -e -n " Serial : "
	adb -s $deviceSerial wait-for-device get-serialno
	echo -e -n " Manufacturer : "
	adb -s $deviceSerial wait-for-device shell getprop "ro.product.manufacturer"
	echo -e -n " Model : "
	adb -s $deviceSerial wait-for-device shell getprop "ro.product.model"
	echo -e -n " Android Version : "
	adb -s $deviceSerial wait-for-device shell getprop "ro.build.version.release"
	echo -e -n " Android Build : "
	adb -s $deviceSerial wait-for-device shell getprop "ro.build.id"
	echo -e -n " IMEI : "
	adb -s $deviceSerial wait-for-device shell getprop "ro.gsm.imei"
	echo ""
else
	echo " Device is not in 'adb' mode"
fi
