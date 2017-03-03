#!/bin/bash

# Created by Sujay Davalgi
#
# Captures the screenshot of the selected device and saves the file in bugs folder
#
# Usage: ./screenshot.sh [<file name>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh
. ./library/deviceFileOperations.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ "$( isAdbDevice $deviceSerial )" == "true" ]; then
	if [ $# -lt 1 ]; then
		echo -e -n "${txtBld} Enter the Screenshot File name : ${txtRst}"
		read fileName
		echo
	else
		fileName="$1"
	fi

	fileName="`echo $( getFormatedFileName $deviceSerial ${fileName} )`"
	echo -e -n " Your file will be saved in folder : ${myLogs}\n"
	getScreenshot $deviceSerial ${fileName}
else
	echo -e -n " Device is not in adb moden\n"
fi