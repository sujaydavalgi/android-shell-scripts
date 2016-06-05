#!/bin/bash

if [ $# -lt 1 ]; then
	echo -e -n " Enter the CITY name : "
	read cityName
else
	cityName="${1}"
fi

curl -4 http://wttr.in/"${cityName}"