#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for functions related to operations on device
#
# Usage: ". ./library/deviceOperations.sh" within other scripts

. ./library/deviceProperties.sh

#===================================================================================================
#----- Display the selected Device details
function displaySelectedDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		
		formatMessage "\n Selected device : "
		formatMessage "$1" "C" "C"
		
		if [[ "$( isDeviceOffline $1 )" == "true" || "$( isDeviceUnauthorized $1 )" == "true" ]]; then
			formatMessage " - Device is offline/Unauthorised. Cannot do anything with it\n\n" "E"
			exit 1
		else
			#formatMessage "\n Selected device : "
			#formatMessage "$1" "C" "C"
		
			if [ "$( isAdbDevice ${1} )" == "true" ]; then
				
				echo -e -n " - "
				
				local deviceName="$( getDeviceName $1 )"
				local deviceBuild="$( getDeviceBuild $1 )"
				local deviceModel="$( getDeviceModel $1 )"
				local deviceKeys="$( getDeviceKeys $1 )"
				local deviceBuildVersion="$( getDeviceBuildVersion $1 )"
				#local deviceFlavor="$( getDeviceBuildFlavor $1 )"
				
				formatMessage "${deviceModel} - ${deviceBuildVersion} ${deviceBuild} (${deviceName} ${deviceKeys})\n" "I"
				#formatMessage " $( getDeviceModel $1 ) - $( getDeviceBuild $1 ) ($( getDeviceBuildFlavor $1 ))\n" "I"
				
			else
				echo -e -n "${txtRst}\n"
			fi

			echo -e " $( date ) ($nowTime)\n"
		fi
	fi
}

#===================================================================================================

function compareDeviceBuildVersion() {
#$1 - device serial
#$2 - compare version

		local deviceBuildVersion=$( getDeviceBuildVersion ${1} )
		local compareWithVersion="${2}"
		
		#echo $compareWithVersion
		#echo ${deviceBuildVersion}

		#IMP: Notice how the floating numbers for build versions are compared below
		#if (( $(echo "$deviceBuildVersion $compareWithVersion" | awk '{print ($1 = $2)}') )); then #if its equal
		#	echo -e -n "same"
		if (( $(echo "$deviceBuildVersion $compareWithVersion" | awk '{print ($1 > $2)}') )); then #if its greater
			echo -e -n "greater"
		else
			if (( $(echo "$deviceBuildVersion $compareWithVersion" | awk '{print ($1 < $2)}') )); then #if its smaller
				echo -e -n "smaller"
			else
				echo -e -n "same"
			fi
		fi
}

#===================================================================================================
#----- Check if the device is running USER-DEBUG build
function isDeviceBuildUserdebug() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		#deviceBuildType=$( getDeviceBuildType $1 )
		if [ "$( getDeviceBuildType $1 )" == "userdebug" ]; then
			echo -e -n "true"
		else
			echo -e -n "false"
		fi
	fi
}

#----- Check if the device is running USER build
function isDeviceBuildUser() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		#deviceBuildType=$( getDeviceBuildType $1 )
		if [ "$( getDeviceBuildType $1 )" == "user" ]; then
			echo -e -n "true"
		else
			echo -e -n "false"
		fi
	fi
}

#----- Check if the device is running Release-Key build
function isDeviceBuildReleaseKey() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
		exit 1
	else
		#deviceKeys=$( getDeviceKeys $1 )
		if [ "$( getDeviceKeys $1 )" == "release-keys" ]; then
			echo -e -n "true"
		else
			echo -e -n "false"
		fi
	fi
}

#----- Check if the device is running Dev-Key build
function isDeviceBuildDevKey() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
		exit 1
	else
		#deviceKeys=$( getDeviceKeys $1 )
		if [ "$( getDeviceKeys $1 )" == "dev-keys" ]; then
			echo -e -n "true"
		else
			echo -e -n "false"
		fi
	fi
}

#----- Check if the device is running Test-Key build
function isDeviceBuildTestKey() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
		exit 1
	else
		#deviceKeys=$( getDeviceKeys $1 )
		if [ "$( getDeviceKeys $1 )" == "test-keys" ]; then
			echo -e -n "true"
		else
			echo -e -n "false"
		fi
	fi
}

#----- Check if the device is bootloader in LOCKED mode
function isDeviceLocked() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
		exit 1
	else
		# It is still not implemented
		#if [ "$( isFastbootDevice $1 )" == "false" ]; then
		writeToLogsFile "@@ Not yet implemented ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
	fi
}

#----- Check if the device is bootloader in UNLOCKED mode
function isDeviceUnocked() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
		exit 1
	else
		# It is still not implemented
		writeToLogsFile "@@ Not yet implemented ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
	fi
}

function isDeviceEncrypted(){
#$1 - device serial
#$return - true, false
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceEncryptedState="$( getDeviceEncryptState ${1} )"
		#echo $deviceKeys #Returns "encrypted" or "unencrypted"
		case "$deviceEncrypted" in
			"encrypted")
				echo -e -n "true" ;;
			"unencrypted")
				echo -e -n "false" ;;
		esac
	fi
}

function isDeviceBootComplete(){
#$1 - device serial
#$return - true, false
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBootComplete="$( getDeviceBootCompleteState ${1} )"
		case "$deviceBootComplete" in
			"1")
				echo -e -n "true" ;;
			"*")
				echo -e -n "false" ;;
		esac
	fi
}

function isDeviceBootAnimationComplete() {
#$1 - device serial
#$return - true, false
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBootAnimation="$( getDeviceBootAnimationState ${1} )"
		case "$deviceBootAnimation" in
			"running")
				echo -e -n "false" ;;
			"stopped")
				echo -e -n "true" ;;
		esac
	fi
}

function isDeviceSimReady(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local simStatus="$( getDeviceSimStatus ${1} )"
		case "$simStatus" in
			"READY")
				echo -e -n "true" ;;
			"ABSENT")
				echo -e -n "false" ;;
		esac
	fi
}

#===================================================================================================

#----- Check if its a @Home device
function isAtHomeDevice () {
#$1 - device serial
#$return - serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceName="$( getDeviceName ${1} )"

		case "$deviceName" in
		    "tungsten"|"cujo"|"wolfie"|"molly"|"fugu")
				echo -e -n "true" ;;
		    *)
				echo -e -n "false" ;;
		esac
	fi
}

#----- Check if its a ClockWork device
function isClockWorkDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else	
		local deviceName="$( getDeviceName $1 )"

		case "$deviceName" in
		    "sprat"|"dorry"|"minnow")
				echo -e -n "true" ;;
		    *)
				echo -e -n "false" ;;
		esac
	fi
}

#----- Check if its a ClockWork device
function isGearHeadDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		# It is still not implemented
		writeToLogsFile "@@ ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} ) is not yet implemented"
		echo -e -n "false"
	fi
}

#===================================================================================================

#----- Check if its a GED device
function isGedDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else	
		local deviceName="$( getDeviceName $1 )"

		case "$deviceName" in
		    "prime"|"hammerhead"|"mako"|"nakasi"|"nakasig"|"flo"|"deb"|"manta"|"mantaray"|"shamu"|"razor"|"razorg"|"volantis"|"volantisg"|"angler"|"bullhead")
				echo -e -n "true" ;;
		    *)
				echo -e -n "false" ;;
		esac
	fi
}

function isGpeDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else	
		local deviceName="$( getDeviceName $1 )"

		case "$deviceName" in
		    "jgedlteue"|"-blablabla-"|"ghost_retail")
				echo -e -n "true" ;;
		    *)
				echo -e -n "false" ;;
		esac
	fi
}

#----- Check if its a Google devices
function isGoogleDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [[ "$( isAtHomeDevice $1 )" == "true" || "$( isClockWorkDevice $1 )" == "true" || "$( isGedDevice $1 )" == "true" ]]; then
			echo -e -n "true"
		else	
			echo -e -n "false"
		fi
	fi
}
#===================================================================================================
#----- Check if the device is in ADB mode
function isAdbDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "adb" ]; then
			echo -e -n "true"
			#return $TRUE
		else
			echo -e -n "false"
			#return $FALSE
		fi
	fi
}

#----- Check if the device is in RECOVERY mode
function isRecoveryDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "recovery" ]; then
			echo -e -n "true"
		else
			echo -e -n "false"
		fi
	fi
}

#----- Check if the device is in FASTBOOT mode
function isFastbootDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "fastboot" ]; then
			echo -e -n "true"
		else
			echo -e -n "false"
		fi
	fi
}

#----- Check if the device is in OFFLINE mode
function isDeviceOffline() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "offline" ]; then
			echo -e -n "true"
		else
			echo -e -n "false"
		fi
	fi
}

#----- Check if the device is in UNAUTHORIZED mode
function isDeviceUnauthorized() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "unauthorized" ]; then
			echo -e -n "true"
		else
			echo -e -n "false"
		fi
	fi
}

#===================================================================================================
#----- Get the array index # from Device_Array list for the given deviceSerial
function getIndex() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceIndex=0
		
		while [ "${DEVICE_ARRAY[$deviceIndex]}" != "$1" ] && [ $deviceIndex -lt "${#DEVICE_ARRAY[@]}" ]
		do 
			((deviceIndex++))
		done
		
		if [ $deviceIndex -lt "${#DEVICE_ARRAY[@]}" ]; then
			echo -e -n $deviceIndex
		else
			formatMessage "\n Lost the Device OR Device not Found\n" "E"
			exit 1
		fi
	fi
}
#===================================================================================================