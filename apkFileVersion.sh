#!/bin/bash

# Created by Sujay Davalgi
#
# Gives the version number & package name of the apk
#
# Usage: ./apkVersion.sh [<search app string>]
# Command line Arguments (Optional):
#	$1 - Input the apk search string
#		If the string is not provided, it will prompt the enter the apk string to search

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/machineFileOperations.sh
. ./library/deviceOperations.sh
#. ./library/deviceFileOperations.sh
#. ./library/apkOperations.sh

if [ $# -lt 1 ]; then
	pbold "\n Enter the apk path : "
	read APKpath
else
	APKpath="$1"
fi

#if [ "$( checkAdbDevice $deviceSerial )" == "true" ]; then
	echo ""
	echo -e -n " Package : "
	getMachineApkPackageName "${APKpath}"
	echo ""
	echo -e -n " Version : "
	getMachineApkCompleteVersionName "${APKpath}"
	echo ""
#else
#	echo -e " Device is not in 'adb' mode"
#fi

echo ""