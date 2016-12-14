#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for functions releated to logging on machine
#
# Usage: ". ./library/logFunctions.sh" within other scripts

#===================================================================================================
#. ./library/machineOs.sh
#===================================================================================================

function takeBugreport() {
#$1 is device serial number
#$2 is filename
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		#TODO check the device version and then choose which file extension type to use
		adb -s "$1" wait-for-device bugreport > `echo ${myLogs}/`${2}.txt
		#adb -s "$1" wait-for-device bugreport `echo ${myLogs}/`${2}.zip
	fi
}

function saveLogcat() {
#$1 is device serial number
#$2 is filename
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s "$1" logcat -v threadtime | tee `echo ${myLogs}/`${2}-logcat.txt
	fi
}

function clearLogcat() {
#$1 is device serial number
#$2 is filename
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s "$1" logcat -c
	fi
}

function takeScreenshot() {
#$1 is device serial number
#$2 is filename
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		myOS="`echo $( getMyOs )`"
		#echo -e -n " You are using ${myOS} machine\n"
		
		#TODO this logic is not always working. The screencap command is behaving differently on different OS, based on the device version
		#adb -s "$1" wait-for-device shell screencap -p > `echo ${myLogs}/`${2}.png
		if [ ${myOS} == "linux" ]; then
		      adb -s "$1" wait-for-device shell screencap -p | sed 's/\r$//' > `echo ${myLogs}/`${2}.png
		elif [ ${myOS} == "mac" ]; then
		      adb -s "$1" wait-for-device shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > `echo ${myLogs}/`${2}.png
		fi
	fi
}

function recordDeviceVideo() {
#$1 is device serial number
#$2 is foldername
#$3 is filename
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 3 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s "$1" wait-for-device shell "screenrecord --verbose --bit-rate 4000000 ${2}/${3}.mp4" # <- 4 Mbps
		#adb -s $1 wait-for-device shell "screenrecord --verbose --bit-rate 8000000 $2/${3}.mp4" # <- 8 Mbps
	fi
}
#===================================================================================================

#----- file name format
function getFormatedFileName() {
#$1 is device serial number
#$2 is filename
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else

        if [ "$( checkGoogleDevice $1 )" == "true" ]; then
            #echo -e -n "$( getDeviceName $1)_$( getDeviceBuild $1)_${2}_${nowTime}"
            echo -e -n "$( getDeviceName $1)_${2}_${nowTime}"
        else
            echo -e -n "${2}_${nowTime}"
        fi
	fi
}

#===================================================================================================

