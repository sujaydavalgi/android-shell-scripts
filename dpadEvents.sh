#!/bin/bash

# Created by Sujay Davalgi
#
# Send d-Pad events to the selcted device
#
# Usage: ./findMyIp.sh [<Device Serial>]
# Command line Arguments (Optional):
#	$1 - Input the device serial
#		If the serial number is not provided, it will display the list of attached devices to pick from

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/keycodeEvents.sh

if [ $# -lt 1 ]; then
    getDeviceChoice
else
    buildDeviceSnArray
    deviceSerial="$1"
fi

displaySelectedDevice $deviceSerial

inputevent="null"

while [ "$inputevent" != "x" ]
do

	echo -e -n " (u)p (d)own (l)eft (r)ight (c)enter (b)ack (h)ome (e)nter (D)el (t)ext (a)ccessory-button (p)ower e(x)it : "
	#read inputevent
	stty -echo && read -n 1 inputevent && stty echo
	echo -e $inputevent

	case "$inputevent" in
		[uU]) #up elif [ "$inputevent" == "u" ]; then
			keycodeDpadUp $deviceSerial ;;
		[d]) #down elif [ "$inputevent" == "d" ]; then
			keycodeDpadDown $deviceSerial ;;
		[lL]) #left elif [ "$inputevent" == "l" ]; then		
			keycodeDpadLeft $deviceSerial ;;
		[rR]) #right elif [ "$inputevent" == "r" ]; then
			keycodeDpadRight $deviceSerial ;;
		[cC]) #center elif [ "$inputevent" == "c" ]; then
			keycodeDpadCenter $deviceSerial ;;
		[bB]) #back elif [ "$inputevent" == "b" ]; then
			keycodeBacklash $deviceSerial ;;
		[hH]) #home elif [ "$inputevent" == "h" ]; then
			keycodeHome $deviceSerial ;;
		[eE]) #enter elif [ "$inputevent" == "e" ]; then
			keycodeEnter $deviceSerial ;;
		[D]) #del elif [ "$inputevent" == "D" ]; then
			keycodeDel $deviceSerial ;;
		[aA]) #accessory button elif [ "$inputevent" == "a" ]; then
			accessoryButton $deviceSerial ;;
		[pP]) #power button
			keycodePower $deviceSerial ;;
		[tT]) #text elif [ "$inputevent" == "t" ]; then
			echo -e -n " Enter the text you want to input : "
			read inputtext
			#inputtext=`echo -e -n "\""$inputtext"\""`
			#echo -e $inputtext
			adb -s $deviceSerial shell input text "${inputtext}"
			;;
	esac

	#let $inputevent="null"

done
