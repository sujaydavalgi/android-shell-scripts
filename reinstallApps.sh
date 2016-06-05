#!/bin/bash

# Created by Sujay Davalgi
#
# Uninstalls and reinstalls the @Home apps in the selected non-@Home companion device
#
# Usage: ./reinstallApps.sh [<Folder name>]
# Command line Arguments (Optional):
#	$1 - Input the folder name to install the app from
#		If the folder name is not provided, it will prompt to enter the folder name

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/myFunctions_legacy.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $# -lt 1 ]; then
	pbold "\n Enter the Folder name (Case-sensitive) : "
	read build
else
	build="$1"
fi	

checkSubFolder $build
	
if [ $( checkAdbDevice $deviceSerial ) == "true" ]; then
	if [ $( checkAtHomeDevice $deviceSerial ) == "true" ]; then
		echo -e " Installing Apps is not allowed in @Home device ...\n"
	else
		unInstallAPKs $deviceSerial
		reInstallAPKs $deviceSerial
	fi
else
	echo -e " Device is not in adb mode"	
fi