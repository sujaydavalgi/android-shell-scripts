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

buildDeviceSnArray
displayDeviceList

echo ""
