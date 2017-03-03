#!/bin/bash

#  Created by Sujay Davalgi
#
# Install the apps on a selected device from the specified sub folder within the configured folder
# If you have multiple apk files in the folder, it will prompt to check to install for each apk
#
# Usage: ./installApps.sh [<sub-folder name>]
# Arguments [Optional]:
#	$1 - Sub-Folder name to be searched within the Apps defined folder
#		If not mentioned, it will prompt you later. You can give any input for that.
#		If the provided sub-folder does not exist, it will prompt the option to check in default folder

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/machineFileOperations.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	#if [[ $( isClockWorkDevice $deviceSerial ) == "true" || $( isAtHomeDevice $deviceSerial ) == "true" ]]; then
	#	echo -e " ${txtRed}You are not allowed to install apps in @Home or ClockWork device${txtRst}\n"
	#else
		if [ $# -lt 1 ]; then
			echo -e -n "${txtBld} Enter the Folder name (Case-sensitive) : ${txtRst}"
			read subFolder
		else
			if [ $# -ge 2 ]; then
				searchString="$2"
			else
				searchString="apk"
			fi
			subFolder="$1"
		fi	
		
		installMachineFiles $deviceSerial ${myAppDir} ${subFolder} "$searchString"
	#fi
else
	echo " Device not in 'adb' mode"
fi