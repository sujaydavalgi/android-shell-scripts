#!/bin/bash

# Created by Sujay Davalgi
#
# Reboots the selected device
#
# Usage: ./rebootDevice.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh

voiceSearchString="test"

if [ $# -lt 1 ]; then
	echo -e -n "\n Enter the search string : "
	read voiceSearchString
else
	voiceSearchString="$1"
fi

getDeviceChoice
displaySelectedDevice $deviceSerial

if [[ "$( checkAdbDevice $deviceSerial )" == "true" || "$( checkRecoveryDevice $deviceSerial )" == "true" ]]; then
	adb -s $deviceSerial wait-for-device shell am start -a android.media.action.MEDIA_PLAY_FROM_SEARCH -n com.google.android.music/.VoiceActionsActivity --es "query" "${voiceSearchString}"
fi