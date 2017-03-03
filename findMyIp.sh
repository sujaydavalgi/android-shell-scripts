#!/bin/bash

# Created by Sujay Davalgi
#
# Displays the ip address of the device, if available
#
# Usage: ./findMyIp.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/networkOperations.sh

if [ $# -lt 1 ]; then
    getDeviceChoice
else
    buildDeviceSnArray
    deviceSerial="$1"
fi

displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	myConnection="$( checkEthWifi $deviceSerial )"
	echo -e -n " It is connected to : $myConnection\n"
	if [ "$myConnection" != "None" ]; then
		echo -e -n " IP address is : $( getMyIP $deviceSerial )\n"
	fi
else
	echo -e -n " Device is not in 'adb' mode\n"
fi

echo " "