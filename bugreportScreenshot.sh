#!/bin/bash

# Created by Sujay Davalgi
#
# Captures the screenshot and bugreport and saves them in the bugs folder setup
#
# Usage: ./bugreportScreenshot.sh [<file name>]
# Command line Arguments (Optional):
#	$1 - File name to be saved as
#		If file name not specified, it will later prompt to provide the filename
#		No need to give the extension for the screenshot and bugreport

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then

	if [ $# -lt 1 ]; then
		echo -e -n "${txtBld} Enter the File name : ${txtRst}"
		read fileName
		echo
	else
		fileName="$1"
	fi

	fileName="`echo $( getFormatedFileName $deviceSerial ${fileName} )`"

	echo -e " Your files will be saved in folder :  ${myLogs}"

	getScreenshot $deviceSerial ${fileName}

	getBugreport $deviceSerial ${fileName}
else
	echo -e -n " Device is not in 'adb' mode\n\n"
fi