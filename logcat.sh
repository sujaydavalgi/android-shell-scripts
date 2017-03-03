#!/bin/bash

# Created by: Sujay Davalgi
#
# Displays the logcat in the terminal
# If argument was provided while initiating the command, it will also save the output in a specified file
#
# Usage: ./myLC.sh [<filename>]
# Arguments (Optional):
#	$1 - File name to be saved as.
#		No necessary to give the extension, by default it will save as ".txt"
#		If, filename is not provided, it will only display the logcat and not save the output to a file

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	if [ $# -lt 1 ]; then
		adb -s $deviceSerial logcat -v threadtime
	else
		fileName="`echo $( getFormatedFileName $deviceSerial "$1" )`"
		echo -e " Your file will be saved in folder : ${myLogs} as : ${fileName}-logcat.txt \n"
		saveLogcat $deviceSerial ${fileName}
	fi
else
	echo " Device is not in 'adb' mode"
fi