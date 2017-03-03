#!/bin/bash

#  
# Created by Sujay Davalgi
#
# Configures the selected device and connects the adb over IP
# Using this you can connect to the device over network.
# Machine and phone should be in the same sub-net to connect to the device after enabling the adb over IP
#
# Usage: ./connectIP.sh [<Device Serial>]
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

setPort=5555

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then

	deviceIP=`echo $( getMyIP $deviceSerial )`

	if [ $( isAtHomeDevice $deviceSerial ) == "true" ]; then
		#deviceIP="$( adb -s $deviceSerial shell dumpsys activity service BrokerService | grep address: )"
		#deviceIP=`echo $deviceIP| cut -d':' -f 2`
		setPort=`adb -s $deviceSerial wait-for-device shell getprop service.adb.tcp.port`
	else
		adb -s $deviceSerial wait-for-device tcpip ${setPort}
	fi

	adb -s $deviceSerial wait-for-device shell stop adbd 
	adb -s $deviceSerial wait-for-device shell start adbd
	
	echo -e -n " My IP : $deviceIP\n"
	echo -e -n " My port: $setPort\n"
	adb -s $deviceSerial wait-for-device connect `echo $deviceIP:$setPort`

else
	echo " Device is not in 'adb' mode"
fi

echo ""