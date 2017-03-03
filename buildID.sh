#!/bin/bash

# Created by Sujay Davalgi
#
# Displays the Build ID of the device
#
# Usage: ./buildID.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		IF the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh

if [ $# -lt 1 ]; then
    getDeviceChoice
else
    buildDeviceSnArray
    deviceSerial="$1"
fi

displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
    echo -e -n " `adb -s $deviceSerial wait-for-device shell getprop ro.build.description` \n\n"
    #echo ""
else
    echo " Device is not in 'adb' mode"
fi


