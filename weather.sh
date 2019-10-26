#!/bin/bash

# Created by Sujay Davalgi
#
# Displays the weather information in the terminal
#
# Usage: ./weather.sh [<apk name>]
# Command line Arguments (Optional):
#	$1 - City name

if [ $# -lt 1 ]; then
	echo -e -n " Enter the CITY name : "
	read cityName
else
	cityName="${1}"
fi

curl -4 http://wttr.in/"${cityName}"
