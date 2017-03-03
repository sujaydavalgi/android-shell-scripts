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

packageName="com.google.android.music"
numberOfEvents=125000
delayBetweenEvents=200 #ms

echo -e -n "Package = $packageName\n"
echo -e -n "Events  = $numberOfEvents\n"
echo -e -n "Delay   = $delayBetweenEvents\n"

if [ $# -lt 1 ]; then
    getDeviceChoice
else
    buildDeviceSnArray
    deviceSerial="$1"
fi

displaySelectedDevice $deviceSerial

formatMessage " Do you want to Run or Kill the monkey on selected device? [r/k] : " "Q"
read monkeyRunKillChoice

case $monkeyRunKillChoice in
	[r/R]) #run
		if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
		    #adb -s $deviceSerial wait-for-device shell monkey -p $packageName -v $numberOfEvents --throttle $delayBetweenEvents --pct-trackball 0 --pct-syskeys 10
		    adb -s $deviceSerial wait-for-device shell monkey -p $packageName -c android.intent.category.LAUNCHER --ignore-security-exceptions --monitor-native-crashes --throttle $delayBetweenEvents --pct-trackball 0 --pct-syskeys 0 -s 80 -v -v -v $numberOfEvents
		else
		    echo " Device is not in 'adb' mode"
		fi
		;;
	[k/K]) #kill
		adb -s $deviceSerial shell ps | awk '/com\.android\.commands\.monkey/ { system("adb -s $deviceSerial shell kill " $2) }'
		;;
esac