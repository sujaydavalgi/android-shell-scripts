#!/bin/bash

# Created by: Sujay Davalgi
#
# Clears the previous logcat of the selected device
#
# Usage: ./clearLogcat.sh [<deviceSerial>]
# Arguments (Optional):
#	$1 - Device serial

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh

if [ $# -lt 1 ]; then
    getDeviceChoice
else
    buildDeviceSnArray
    deviceSerial="$1"
fi

displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	formatMessage " Clearing Logcat... " "M"
	adb -s $deviceSerial wait-for-device logcat -c
	formatMessage "Done \n\n" "M"
else
	echo " Device is not in 'adb' mode"
fi
