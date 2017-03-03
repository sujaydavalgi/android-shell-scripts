#!/bin/bash

# Created by Sujay Davalgi
#
# Displays the list of Videos (recorded using ./recordVideo.sh script) from device and saves the selected file to the bugs folder
#
# Usage: ./pullFiles.sh [<Device Path>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the path is not provided, it will take the root folder

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/deviceFileOperations.sh

searchForFile="*.*"

if [ $# -lt 2 ]; then
	if [ $# -lt 1 ]; then
	    searchFolder=""
		searchForFile="*.*"
	else
	    searchFolder="${1}"
	fi
else
	searchFolder="${1}"
	searchForFile="${2}"
fi
	
getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	searchNpullDeviceFilesFrmFldr $deviceSerial "${searchFolder}" "${searchForFile}"
else
	echo -e -n " Device is not in 'adb' mode\n"
fi