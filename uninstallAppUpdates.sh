#!/bin/bash

# Created by Sujay Davalgi
#
# Uninstalls the apk mentioned (if present)
#
# Usage: ./unInstallApks.sh [<apk name>]
# Command line Arguments (Optional):
#	$1 - Input the APK name
#		If the APK name is not provided, it will prompt to enter the name

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/apkOperations.sh

if [ $# -lt 1 ]; then
	pbold "\n Enter the apk string to search : "
	read APKname
else
	APKname="$1"
fi

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ "$( isAdbDevice $deviceSerial )" == "true" ]; then
	apkOperations $deviceSerial ${APKname} "uninstallupdates"
else
	echo " Device is not in 'adb' mode"
fi