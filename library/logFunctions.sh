#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for functions releated to logging on machine
#
# Usage: ". ./library/logFunctions.sh" within other scripts

#===================================================================================================
#. ./library/machineOs.sh
#===================================================================================================

# Pre-M (<6.0) txt, M (=6.0) txt, Post-M (>=7.0) zip
newBugreportSdkVersion="7.0"

#===================================================================================================

#----- file name format
function getFormatedFileName() {
#$1 is device serial number
#$2 is filename
#$return - 
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else

        if [ "$( isGoogleDevice $1 )" == "true" ]; then
            #echo -e -n "$( getDeviceName $1)_$( getDeviceBuild $1)_${2}_${nowTime}"
            echo -e -n "$( getDeviceName $1)_${2}_${nowTime}"
        else
            echo -e -n "${2}_${nowTime}"
        fi
	fi
}

#===================================================================================================

function takeBugreport() {
#$1 is device serial number
#$2 is filename
#$return - take bugreport
#https://android.googlesource.com/platform/frameworks/native/+/master/cmds/dumpstate/bugreport-format.md
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		#TODO check the device version and then choose which file extension type to use
		# Pre-M (<6.0) txt, M (=6.0) txt, Post-M (>=7.0) zip

		local compareBuildVersionStatus=$( compareDeviceBuildVersion ${1} ${newBugreportSdkVersion} )

		if [[ ${compareBuildVersionStatus} == "same" || ${compareBuildVersionStatus} == "greater" ]]; then
			adb -s "$1" wait-for-device bugreport `echo ${myLogs}/`${2}.${bugreport2Extension}
			#echo -e -n " zip"
		else
			adb -s "$1" wait-for-device bugreport > `echo ${myLogs}/`${2}.${bugreportExtension}
			#echo -e -n " txt"
		fi

	fi
}

function getBugreport() {
#1 - device serial number
#2 - filename
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		echo -e -n "\n Taking Bugreport... "

		local compareBuildVersionStatus=$( compareDeviceBuildVersion ${1} ${newBugreportSdkVersion} )
			
		if [[ ${compareBuildVersionStatus} == "same" || ${compareBuildVersionStatus} == "greater" ]]; then
			echo -e -n " ${2}.${bugreport2Extension}\n\n"
		else
			echo -e -n " ${2}.${bugreportExtension}\n\n"
		fi

		takeBugreport ${1} ${2}

		echo -e -n " ...Done\n"
	fi
}

function saveLogcat() {
#$1 is device serial number
#$2 is filename
#$return - 
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s "$1" logcat -v threadtime | tee `echo ${myLogs}/`${2}-logcat.${logcatExtension}
	fi
}

function clearLogcat() {
#$1 is device serial number
#$2 is filename
#$return - 
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
#$return - 
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		myOS="`echo $( getMyOs )`"
		#echo -e -n " You are using ${myOS} machine\n"
		
		#TODO this logic is not always working. The screencap command is behaving differently on different OS, based on the device version
		#adb -s "$1" wait-for-device shell screencap -p > `echo ${myLogs}/`${2}.${screenshotExtension}

		#if [ ${myOS} == "linux" ]; then
		#      adb -s "$1" wait-for-device shell screencap -p | sed 's/\r$//' > `echo ${myLogs}/`${2}.${screenshotExtension}
		#elif [ ${myOS} == "mac" ]; then
		#      adb -s "$1" wait-for-device shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > `echo ${myLogs}/`${2}.${screenshotExtension}
		#      #adb -s "$1" wait-for-device shell screencap -p | perl -pe 'BEGIN { $/="\cM\cJ"; $\="\cJ"; } chomp;' > `echo ${myLogs}/`${2}.${screenshotExtension}
		#else
		#	adb -s "$1" wait-for-device shell screencap -p > `echo ${myLogs}/`${2}.${screenshotExtension}
		#fi

		#Trying to take the screenshot in the device sdcard itself
		#adb -s "$1" wait-for-device shell screencap ${deviceScreenshotFolder}/${2}.${screenshotExtension}

		#Trying to use exec-out instead of shell
		#IMP: check how we use exec-out instead of shell
		adb -s "$1" wait-for-device exec-out screencap -p > `echo ${myLogs}/`${2}.${screenshotExtension}
	fi
}

function getScreenshot() {
#$1 is device serial number
#$2 is filename
#$return - 
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		echo -e -n "\n Taking Screenshot... "
		echo -e -n " ${2}.${screenshotExtension}"
		takeScreenshot ${1} ${2}
		
		# use this if we are saving the screenshot file in the sdcard itself (in function takeScreenshot)
		#pullDeviceSingleFileFrmFldr ${1} ${deviceScreenshotFolder} "${2}.${screenshotExtension}"
		
		echo -e -n "\n ...Done\n"
	fi
}

function recordDeviceVideo() {
#$1 is device serial number
#$2 is foldername
#$3 is filename
#$return - 
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 3 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s "$1" wait-for-device shell "screenrecord --verbose --bit-rate 4000000 ${2}/${3}.${screenrecordExtension}" # <- 4 Mbps
		#adb -s $1 wait-for-device shell "screenrecord --verbose --bit-rate 8000000 $2/${3}.${screenrecordExtension}" # <- 8 Mbps
	fi
}

#===================================================================================================