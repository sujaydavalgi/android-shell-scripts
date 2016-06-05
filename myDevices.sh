#!/bin/bash

#  Created by Sujay Davalgi
#
# Displays the list of devices connected to host
#
# Usage: ./displayDevices.sh

. ./library/mainFunctions.sh

buildDeviceSnArray
displayDeviceList
echo " "