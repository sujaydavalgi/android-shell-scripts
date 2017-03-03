#!/bin/bash

#  Created by Sujay Davalgi
#
# Installs the apks from the default configured folder
# Will prompt to install apks if there are multiple apks
#
# Usage: ./installApk.sh [<filename>]
# Arguments (Optional):
#	$1 - File name to be saved as.
#		No necessary to give the extension, by default it will save as ".txt"
#		If not mentioned, it will prompt you later.

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/machineFileOperations.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	if [ $# -lt 1 ]; then
		echo -e -n "${txtbld} Enter the Full Path : ${txtrst}"
		read pathName
	else
		pathName="$1"
	fi
	
	if [ -d $1 ]; then 
		installFromPath $deviceSerial $pathName
	elif [ -f $1 ]; then
		adb -s $deviceSerial wait-for-device install -r -d $pathName
	fi
else
	echo -e -n " Device is not in 'adb' mode\n"
fi

echo -e -n "\n"