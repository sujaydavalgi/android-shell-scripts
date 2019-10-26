#!/bin/bash

#  Created by Sujay Davalgi
#
# Installs the apks from the default configured folder
# Will prompt to install apks if there are multiple apks
#
# Usage: ./installApkFromPath.sh [<filename>]
# Arguments (Optional):
#	$1 - Complete path to the APK file.

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
		pathName="${1}"
	fi



	if [ -d "${pathName}" ]; then
		installFromPath $deviceSerial "${pathName}" "*.apk"
	elif [ -f "${pathName}" ]; then
		adb -s $deviceSerial wait-for-device install -r -d "${pathName}"
	else
		echo -e -n " Could not verify the Path type as Directory/File.\n"
	fi
else
	echo -e -n " Device is not in 'adb' mode\n"
fi

echo -e -n "\n"
