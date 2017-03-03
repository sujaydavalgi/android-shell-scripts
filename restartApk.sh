#!/bin/bash

# Created by Sujay Davalgi
#
# Gives the installed path and binding name of the apk being searched in the selected device
#
# Usage: ./apkVersion.sh [<search app string>]
# Command line Arguments (Optional):
#	$1 - Input the apk search string
#		If the string is not provided, it will prompt the enter the apk string to search

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/deviceFileOperations.sh
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
	apkOperations $deviceSerial ${APKname} "restart"
else
	echo -e " Device is not in 'adb' mode"
fi

echo ""