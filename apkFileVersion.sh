#!/bin/bash

# Created by Sujay Davalgi
#
# Gives the version number, package name and other details of the apk
#
# Usage: ./apkVersion.sh [<File path>]
# Command line Arguments (Optional):
#	$1 - Input the File complete path
#		If the string is not provided, it will prompt to enter the file path

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

echo ""

if [[ "$( checkYesNoOption $( checkMachineFileExist ${APKpath} ) )" == "yes"  ]]; then
	echo -e -n " Name    : $( getMachineApkApplicationName "${APKpath}" )\n"
	echo -e -n " Package : $( getMachineApkPackageName "${APKpath}" )\n"
	echo -e -n " Version : $( getMachineApkCompleteVersionName "${APKpath}" )\n"
else
	writeToLogsFile "@@ '${APKpath}' File Not Found - called from $( basename ${0} )"
	echo -e -n " '${1}' File Not Found\n\n"
	exit 1
fi

echo ""
