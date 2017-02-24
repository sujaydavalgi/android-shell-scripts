#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for functions related to operations on device
#
# Usage: ". ./library/deviceOperations.sh" within other scripts

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
		
		if [[ "$( checkOfflineDevice $1 )" == "true" || "$( checkUnauthorizedDevice $1 )" == "true" ]]; then
			formatMessage " - Device is offline/Unauthorised. Cannot do anything with it\n\n" "E"
			exit 1
		else
			#formatMessage "\n Selected device : "
			#formatMessage "$1" "C" "C"
		
			if [ "$( checkAdbDevice ${1} )" == "true" ]; then
				
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
#----- Get the device Name
function getDeviceName() {
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		#local deviceName=`adb -s $1 wait-for-device shell getprop ro.product.name | tr -d "\r\n"`
		echo -e -n `adb -s $1 wait-for-device shell getprop ro.product.device | tr -d "\r\n"`  #Returns "shamu"
	fi
}

function getProductName(){
#$1 - 
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceName=`adb -s $1 wait-for-device shell getprop ro.product.name | tr -d "\r\n"`
		echo -e -n $deviceName #Returns "shamuf"
	fi
}

function getDeviceBuildFlavor() {
#$1 - 
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuildFlavor=`adb -s $1 wait-for-device shell getprop ro.build.flavor | tr -d "\r\n"`
		echo -e -n $deviceBuildFlavor #Returns "shamu-userdebug"
	fi
}

#----- Get the Device Build
function getDeviceBuild() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuild=`adb -s $1 wait-for-device shell getprop ro.build.description | cut -f3 -d" " | tr -d "\r\n"`

		if [ "$deviceBuild" == "MASTER" ]; then 
			deviceBuildNo=`adb -s $1 wait-for-device shell getprop ro.build.description | cut -f4 -d" " | tr -d "\r\n"`
			deviceBuild="$deviceBuild"-"$deviceBuildNo"
		fi
		
		echo -e -n "$deviceBuild" #Returns "LRX22C"
	fi
}

function getDeviceBuild2() {
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuild=`adb -s $1 wait-for-device shell getprop ro.build.id | tr -d "\r\n"`
		echo -e -n $deviceBuild #Returns "LRX22C"
	fi
}

function getDeviceBuildVersion(){
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuildVersion=`adb -s $1 wait-for-device shell getprop ro.build.version.release | tr -d "\r\n"`
		echo -e -n $deviceBuildVersion #Returns "5.0"
	fi
}

function getDeviceSdkVersion() {
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuildVersion=`adb -s $1 wait-for-device shell getprop ro.build.version.sdk | tr -d "\r\n"`
		echo -e -n $deviceBuildVersion #Returns "23"
	fi
}

function getDeviceBuildType2() {
# $1 - device serial number
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuildType=`adb -s $1 wait-for-device shell getprop ro.build.description | cut -d" " -f1 | cut -d"-" -f2 | tr -d "\r\n"`
		echo -e -n "$deviceBuildType" #Returns "userdebug" or "user"
	fi
}

function getDeviceBuildType(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuildType=`adb -s $1 wait-for-device shell getprop ro.build.type | tr -d "\r\n"`
		echo -e -n $deviceBuildType #Returns "userdebug" or "user"
	fi
}

function getDeviceKeys2() {
#$1 - device serial number
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceKeys=`adb -s $1 wait-for-device shell getprop ro.build.description | rev | cut -f1 -d" " | rev | tr -d "\r\n"`
		echo -e -n "$deviceKeys" #Returns "release-keys" or "dev-keys" or "test-keys"
	fi
}

function getDeviceKeys(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceKeys=`adb -s $1 wait-for-device shell getprop ro.build.tags | tr -d "\r\n"`
		echo -e -n $deviceKeys #Returns "release-keys" or "dev-keys" or "test-keys"
	fi
}

#----- get the device manufacturer
function getDeviceManufacturer(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceManufacturer=`adb -s $1 wait-for-device shell getprop ro.product.manufacturer | tr -d "\r\n"`
		echo -e -n $deviceManufacturer #Returns "motorola" or "LG" or "Asus" or "Samsung" or "htc"
	fi
}

function getDeviceHardwareName(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceManufacturer=`adb -s $1 wait-for-device shell getprop ro.hardware | tr -d "\r\n"`
		echo -e -n $deviceManufacturer #Returns "motorola" or "LG" or "Asus" or "Samsung" or "htc"
	fi
}

#----- get the device model
function getDeviceModel(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceModel=`adb -s $1 wait-for-device shell getprop ro.product.model | tr -d "\r\n"`
		echo -e -n $deviceModel #Returns "Nexus 6" or "Nexus Player"
	fi
}

function getDeviceSimStatus(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local simStatus=`adb -s $1 wait-for-device shell getprop gsm.sim.state | tr -d "\r\n"`
		echo -e -n $simStatus #Returns "ABSENT" OR "READY"
	fi
}

function isDeviceSimReady(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local simStatus=`adb -s $1 wait-for-device shell getprop gsm.sim.state | tr -d "\r\n"`
		#echo -e -n $simStatus #Returns "ABSENT" OR "READY"
		case "$simStatus" in
			"READY")
				echo -e -n "true" ;;
			"ABSENT")
				echo -e -n "false" ;;
		esac
	fi
}

function getDeviceBuildCharacteristics(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuildChar=`adb -s $1 wait-for-device shell getprop ro.build.characteristics | tr -d "\r\n"`
		echo -e -n $deviceBuildChar #Returns "nosdcard"
	fi
}

function getDeviceEncryptState() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceEncryptState=`adb -s $1 wait-for-device shell getprop ro.crypto.state | tr -d "\r\n"`
		echo -e -n $deviceEncryptState #Returns "encrypted" or "unencrypted"
	fi
}

function isDeviceEncrypted(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceEncrypted=`adb -s $1 wait-for-device shell getprop ro.crypto.state | tr -d "\r\n"`
		#echo $deviceKeys #Returns "encrypted" or "unencrypted"
		case "$deviceEncrypted" in
			"encrypted")
				echo -e -n "true" ;;
			"unencrypted")
				echo -e -n "false" ;;
		esac
	fi
}

function isDeviceFusedSDcard(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceFusedSDCard=`adb -s $1 wait-for-device shell getprop ro.crypto.fuse_sdcard | tr -d "\r\n"`
		echo -e -n $deviceFusedSDCard #Returns "true" or "false"
	fi
}

function isDeviceBootComplete(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBootComplete=`adb -s $1 wait-for-device shell getprop sys.boot_completed | tr -d "\r\n"`
		#echo $deviceBootComplete #Returns "1" for success or nothing if its not yet booted
		case "$deviceBootComplete" in
			"1")
				echo -e -n "true" ;;
			"*")
				echo -e -n "false" ;;
		esac
	fi
}

function getDeviceBootAnimationState() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBootAnimationState=`adb -s $1 wait-for-device shell getprop init.svc.bootanim | tr -d "\r\n"`
		echo $deviceBootAnimationState #Returns "[stopped]" or "[running]"
	fi
}

function isDeviceBootAnimationComplete() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBootAnimation=`adb -s $1 wait-for-device shell getprop init.svc.bootanim | tr -d "\r\n"`
		#echo $deviceBootAnimation #Returns "[stopped]" or "[running]"
		case "$deviceBootAnimation" in
			"running")
				echo -e -n "false" ;;
			"stopped")
				echo -e -n "true" ;;
		esac
	fi
}

#----- get the state of the device
function getDeviceEmulatorState() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceState=`adb -s $1 get-state | tr -d "\r\n"`
		echo -e -n $deviceState #Returns "device" or "emulator"
	fi
}

function getDeviceNetworkType() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceNetworkType=`adb -s $1 wait-for-device shell getprop gsm.network.type | tr -d "\r\n"`
		echo -e -n $deviceNetworkType #Returns "LTE"
	fi
}

function isDeviceOperatorRoaming() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceOperatorRoaming=`adb -s $1 wait-for-device shell getprop gsm.operator.isroaming | tr -d "\r\n"`
		echo -e -n $deviceOperatorRoaming #Returns "true" "false"
	fi
}

function getBluetoothAddress() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBluetoothAddress=`adb -s $1 wait-for-device shell getprop persist.service.bdroid.bdaddr | tr -d "\r\n"`
		echo -e -n $deviceBluetoothAddress #Returns "80:6C:1B:96:5F:AE" "F8:CF:C5:D2:64:98"
	fi
}

function getBtMacAddress() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBtMacAddress=`adb -s $1 wait-for-device shell getprop ro.boot.btmacaddr | tr -d "\r\n"`
		echo -e -n $deviceBtMacAddress #Returns "80:6C:1B:96:5F:AE" "F8:CF:C5:D2:64:98"
	fi
}

function getWifiMacAddress() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceWifiMacAddress=`adb -s $1 wait-for-device shell getprop ro.boot.wifimacaddr | tr -d "\r\n"`
		echo -e -n $deviceWifiMacAddress #Returns "F8:CF:C5:D2:64:99"
	fi
}

function getDeviceTimeZone() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceTimeZone=`adb -s $1 wait-for-device shell getprop persist.sys.timezone | tr -d "\r\n"`
		echo -e -n $deviceTimeZone #Returns "America/Los_Angeles" "Asia/Calcutta"
	fi
}

function getHostName() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceHostName=`adb -s $1 wait-for-device shell getprop net.hostname | tr -d "\r\n"`
		echo -e -n $deviceHostName #Returns "android-43367b96efe22eaa"
	fi
}

function getDeviceRebootReason() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceRebootReason=`adb -s $1 wait-for-device shell getprop ro.boot.bootreason | tr -d "\r\n"`
		echo -e -n $deviceRebootReason #Returns "kernel_panic" "reboot"
	fi
}

#[init.svc.bdAddrLoader]: [stopped]
#[dhcp.wlan0.ipaddress]: [192.168.1.147]
#[net.bt.name]: [Android]
#[net.change]: [net.dns1]
#[net.dns1]: [192.168.1.1]
#[wifi.interface]: [wlan0]
#[wlan.driver.status]: [ok]

#[persist.sys.country]: [US]
#[persist.sys.language]: [en]
#[persist.sys.usb.config]: [mtp,adb]

#[gsm.operator.alpha]: [AT&T]
#[gsm.operator.iso-country]: [us]
#[gsm.sim.operator.iso-country]: [us]
#[ro.com.android.dataroaming]: [false]

#[drm.service.enabled]: [true]

#[ro.boot.mode]: [normal]
#[ro.bootmode]: [normal]
#[ro.boot.bl_state]: [2]
#[ro.boot.secure_hardware]: [1]
#[sys.oem_unlock_allowed]: [0]

#[ro.build.host]: [vpbs9.mtv.corp.google.com]
#[ro.build.date]: [Wed Nov 11 22:48:40 UTC 2015]

#[ro.boot.bootloader]: [moto-apq8084-71.15]
#[ro.bootloader]: [moto-apq8084-71.15]
#[ro.build.expect.bootloader]: [moto-apq8084-71.15]
#[ro.boot.version-baseband]: [D4.01-9625-05.32+FSG-9625-02.109]
#[ro.build.expect.baseband]: [D4.01-9625-05.32+FSG-9625-02.109]
#===================================================================================================
function compareDeviceBuildVersion() {
#$1 - device serial
#$2 - compare version

		local deviceBuildVersion=$( getDeviceBuildVersion ${1} )
		local compareWithVersion="${2}"
		
		#echo $compareWithVersion
		#echo ${deviceBuildVersion}

		#if (( $(echo "$deviceBuildVersion $compareWithVersion" | awk '{print ($1 = $2)}') )); then #if its equal
		#	echo -e -n "same"
		if (( $(echo "$deviceBuildVersion $compareWithVersion" | awk '{print ($1 > $2)}') )); then #if its greater
			echo -e -n "greater"
		elif (( $(echo "$deviceBuildVersion $compareWithVersion" | awk '{print ($1 < $2)}') )); then #if its smaller
			echo -e -n "smaller"
		else
			echo -e -n "same"
		fi
}


#===================================================================================================
#----- Check if the device is running USER-DEBUG build
function checkUserdebugDevice() {
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
function checkUserDevice() {
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
function checkReleaseKeyDevice() {
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
function checkDevKeyDevice() {
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
function checkTestKeyDevice() {
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
function checkLockedDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
		exit 1
	else
		#if [ "$( checkFastbootDevice $1 )" == "false" ]; then
		writeToLogsFile "@@ Not yet implemented ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
	fi
}

#----- Check if the device is bootloader in UNLOCKED mode
function checkUnlockedDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
		exit 1
	else
		writeToLogsFile "@@ Not yet implemented ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )\n"
	fi
}
#===================================================================================================

#----- Check if its a @Home device
function checkAtHomeDevice () {
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
function checkClockWorkDevice() {
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
function checkGearHeadDevice() {
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

#----- Check if its a GED device
function checkGedDevice() {
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

function checkGpeDevice() {
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
function checkGoogleDevice() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [[ "$( checkAtHomeDevice $1 )" == "true" || "$( checkClockWorkDevice $1 )" == "true" || "$( checkGedDevice $1 )" == "true" ]]; then
			echo -e -n "true"
		else	
			echo -e -n "false"
		fi
	fi
}
#===================================================================================================
#----- Check if the device is in ADB mode
function checkAdbDevice() {
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
function checkRecoveryDevice() {
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
function checkFastbootDevice() {
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
function checkOfflineDevice() {
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
function checkUnauthorizedDevice() {
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
			formatMessage "\n Lost the Device / Device not Found\n" "E"
			exit 1
		fi
	fi
}
#===================================================================================================