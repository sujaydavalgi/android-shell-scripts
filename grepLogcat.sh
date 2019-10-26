#!/bin/bash

# Created by: Sujay Davalgi
#
# Displays the logcat in the terminal
# If argument was provided while initiating the command, it will also save the output in a specified file
#
# Usage: ./grepLogcat.sh [<grep string>]
# Arguments (Optional):
#	$1 - String to be searched/grep'ed from the logcat.
#		If grep-string is not provided, it will work as normal logcat

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	adb -s $deviceSerial logcat -v threadtime | grep -i "$1"
else
	echo " Device is not in 'adb' mode"
fi
