#!/bin/bash

#  Created by Sujay Davalgi
#
# Displays the list of devices connected to host machine
#
# Usage: ./myDevices.sh

. ./library/mainFunctions.sh

buildDeviceSnArray
displayDeviceList
echo " "
