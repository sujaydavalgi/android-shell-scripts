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
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh

if [ $# -lt 1 ]; then
	pbold "\n Enter the Screenshot File name : "
	read fileName
else
	fileName="$1"
fi

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ "$( checkAdbDevice $deviceSerial )" == "true" ]; then
	fileName="`echo $( getFormatedFileName $deviceSerial ${fileName} )`"
	echo -e " Your file will be saved in folder : " ${myLogs} " as : " ${fileName}.png "\n"

	takeScreenshot $deviceSerial ${fileName}
else
	echo -e " Device is not in adb mode"
fi