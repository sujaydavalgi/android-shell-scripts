#!/bin/bash

#  
# Created by Sujay Davalgi
#
# Wipes data on the selected device
#
# Usage: ./wipeDevice.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

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

if [ "$( isAdbDevice $deviceSerial )" == "true" ]; then
	if [ $( isGoogleDevice $deviceSerial ) == "true" ]; then
		echo -n -e " Wait for device to reboot in bootloader..."
		adb -s $deviceSerial wait-for-device reboot bootloader &
#		read waiting
		wait $!
		echo -e " Done"
	else
		echo -e " You are trying to wipe other than Google device. Please check...\n"
	fi
fi

sleep 2s

buildDeviceSnArray

if [ "$( isFastbootDevice $deviceSerial )" == "true" ]; then
	echo -e "\n Wait for the device to complete wipe data and reboot..."
	fastboot -s $deviceSerial oem recovery:wipe_data
	#echo -e "\n Wait for device to reboot and complete the data wipe\n"
	#read waiting
	#fastboot reboot
	echo " "
elif [[ "$( isAdbDevice $deviceSerial )" == "true" || "$( isRecoveryDevice $deviceSerial )" == "true" ]]; then
	echo -e "\n Device is not in Fastboot mode\n"
else
	echo -e "\n Unable to determine the device state \n"
fi

