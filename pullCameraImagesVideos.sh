#!/bin/bash

# Created by Sujay Davalgi
#
# Displays the list of files (Images & Videos captured from camera) from device and saves the selected file to the bugs folder
#
# Usage: ./pullCameraImagesVideos.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/deviceFileOperations.sh

SearchForFile="*.{jpg,mp4}"

if [ $# -lt 2 ]; then
	
	if [ $# -lt 1 ]; then
	    getDeviceChoice
	else
	    buildDeviceSnArray
	    deviceSerial="$1"
		SearchForFile="*.{jpg,mp4}"
	fi

	displaySelectedDevice $deviceSerial
	
	#if [ $# -lt 1 ]; then
	#    getDeviceChoice
	#    displaySelectedDevice $deviceSerial
	#else
	#    buildDeviceSnArray
	#    deviceSerial="$1"
	#    displaySelectedDevice $deviceSerial
	#	 SearchForFile="*.{jpg,mp4}"
	#fi
else
	deviceSerial="$1"
	SearchForFile="${2}"
fi

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	if [ $( isAtHomeDevice $deviceSerial ) == "true" ]; then
		echo -e " ${txtRed}There is no camera folder in @Home device${txtRst}\n"
	else
		searchNpullDeviceFilesFrmFldr $deviceSerial "${deviceCameraFolder}" "${SearchForFile}"
	fi
else
	echo -e -n " Device is not in 'adb' mode\n"
fi