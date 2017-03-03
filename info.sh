#!/bin/bash

#  
# Created by Sujay Davalgi
#
# Displays the BrokerService info of the device
#
# Usage: ./info.sh [<command info>]
# Command line Arguments (Optional):
#	$1 - 	mIsMaster
#		address:
#		name:
#		placeName:

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	if [ $# -lt 1 ]; then
		adb -s $deviceSerial wait-for-device shell dumpsys activity service BrokerService
	else
		opt="$1"
		case $opt in
			master)
				cmd="mIsMaster"
				;;
			ip)
				cmd="address:"
				;;
			name)
				cmd="name:"
				;;
			palce)
				cmd="placeName:"
				;;
			*)
				echo -e "\n Invalid option in the argument...\n"
				exit 1
				;;
		esac
	
		./adb -s $deviceSerial wait-for-device shell dumpsys  activity service BrokerService | grep ${cmd}
		echo ""
	fi
else
	echo " Device is not in 'adb' mode"
fi

