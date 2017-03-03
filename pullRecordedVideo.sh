#!/bin/bash

# Created by Sujay Davalgi
#
# Displays the list of Videos (recorded using ./recordVideo.sh script) from device and saves the selected file to the bugs folder
#
# Usage: ./pullRecordedVideos.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/deviceFileOperations.sh

SearchForFile="*.mp4"

if [ $# -lt 1 ]; then
    getDeviceChoice
else
    buildDeviceSnArray
    deviceSerial="$1"
fi

displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then	
	searchNpullDeviceFilesFrmFldr $deviceSerial "${RecordFolder}" "${SearchForFile}"
else
	echo -e -n " Device is not in 'adb' mode\n"
fi