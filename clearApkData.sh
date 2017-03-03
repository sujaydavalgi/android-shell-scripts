#!/bin/bash

# Created by Sujay Davalgi
#
# Searches and prompts to chose among all the matching apk
# And pulls the selected apk from device and stored in the local folder configured
#
# Usage: ./clearApkData.sh [<apk name>]
# Command line Arguments (Optional):
#	$1 - File name to be saved as
#		If file name not specified, it will later prompt to provide the filename
#		No need to give the extension for the screenshot and bugreport

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/apkOperations.sh

if [ $# -lt 1 ]; then
	pbold "\n Enter the APK name : "
	read APKname
else
	APKname="$1"
fi

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ "$( isAdbDevice $deviceSerial )" == "true" ]; then
	apkOperations $deviceSerial ${APKname} "clear"
else
	echo " Device is not in 'adb' mode"
fi