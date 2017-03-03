#!/bin/bash

# Created by Sujay Davalgi
#
# Records the activities in the screen of the selected device and stores them in the device sd-card
#
# Usage: ./recordVideo.sh [<filename>]
# Command line Arguments (Optional):
#	$1 - Input the file name
#		If the filename is not provided, it will prompt to enter the filename

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh

if [ $# -lt 1 ]; then
	pbold "\n Enter the Video File name : "
	read fileName
else
	fileName="$1"
fi

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
	#if [ "$( isDeviceBuildDevKey $deviceSerial )" == "true" ]; then
		fileName=`echo $( getFormatedFileName $deviceSerial ${fileName} )`

		echo -e -n " Your video will be saved in ${RecordFolder} as : ${fileName}.mp4\n\n"

		#adb -s $deviceSerial wait-for-device root
		#sleep 1s
		recordDeviceVideo $deviceSerial ${RecordFolder} ${fileName}
	#else
	#	echo -e -n " Device doesnot support root access\n"
	#fi
else
	echo -e -n " Device is not in adb mode\n"
fi