#!/bin/bash

# Created by Sujay Davalgi
#
# Searches and prompts to chose among all the matching apk
# And clears the app data
#
# Usage: ./clearApkData.sh [<apk name>]
# Command line Arguments (Optional):
#	$1 - File name to be saved as
#		If apk name not specified, it will later prompt to provide

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
