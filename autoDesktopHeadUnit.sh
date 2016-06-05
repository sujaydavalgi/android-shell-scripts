#!/bin/bash

# Created by Sujay Davalgi
#
# Start the Android Auto desktop head unit with the selected device
#
# Usage: ./autoDesktopHeadUnit.sh [<deviceSerial>]
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

adb -s $deviceSerial forward tcp:5277 tcp:5277
${mySDK}/extras/google/auto/desktop-head-unit