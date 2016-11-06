#!/bin/bash

#  Created by Sujay Davalgi
#
# Captures the bugreport from the selected device and saves the file (using specified filename)
# in the specified bugs folder
#
# Usage: ./myBR.sh [<filename>] 
# Arguments (Optional):
#	$1 - File name to be saved as.
#		No necessary to give the extension, by default it will save as ".txt"
#		If not mentioned, it will prompt you later.

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh

getDeviceChoice
displaySelectedDevice $deviceSerial

if [ $( checkAdbDevice $deviceSerial ) == "true" ]; then
	if [ $# -lt 1 ]; then
		echo -e -n "${txtBld} Enter the Bugreport File name : ${txtRst}"
		read fileName
	else
		fileName="$1"
	fi
	
	fileName="`echo $( getFormatedFileName $deviceSerial $fileName )`"
	#TODO let us pass the completed file name w/ the extension as parameter to avoid discrepencies between displaying the message and actually saving the file extension type
	echo -e -n " Your file will be saved in folder : $myLogs as : $fileName.zip\n\n"
	takeBugreport $deviceSerial $fileName
	echo -e -n "\n Done\n"
else
	echo -e -n " Device is not in 'adb' mode\n"
fi

echo -e -n "\n"