#!/bin/bash

# Created by: Sujay Davalgi
#
# Displays the logcat in the terminal
# If argument was provided while initiating the command, it will also save the output in a specified file
#
# Usage: ./clearLogcat.sh [<deviceSerial>]
# Arguments (Optional):
#	$1 - File name to be saved as.
#		No necessary to give the extension, by default it will save as ".txt"
#		If, filename is not provided, it will only display the logcat and not save the output to a file

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