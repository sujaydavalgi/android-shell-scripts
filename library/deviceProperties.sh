#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for functions related to get the properties of the device
#
# Usage: ". ./library/deviceProperties.sh" within other scripts

#===================================================================================================

#----- get the state of the device
function getDeviceEmulatorState() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceState=`adb -s $1 wait-for-device get-state | tr -d "\r\n"`
		echo -e -n $deviceState #Returns "device" or "emulator"
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

function getDeviceBuildSdkVersion() {
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

function getDeviceBuildHost(){
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuildHost=`adb -s $1 wait-for-device shell getprop ro.build.host | tr -d "\r\n"`
		echo -e -n $deviceBuildHost #Returns "vpbs9.mtv.corp.google.com"
	fi
}

function getDeviceBuildDate(){
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBuildDate=`adb -s $1 wait-for-device shell getprop ro.build.date | tr -d "\r\n"`
		echo -e -n $deviceBuildDate #Returns "Wed Nov 11 22:48:40 UTC 2015"
	fi
}

function getDeviceBootloader(){
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBootloader=`adb -s $1 wait-for-device shell getprop ro.boot.bootloader | tr -d "\r\n"`
		echo -e -n $deviceBootloader #Returns "moto-apq8084-71.15"
	fi
}

function getDeviceExpectedBootloader(){
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceExpectedBootloader=`adb -s $1 wait-for-device shell getprop "ro.build.expect.bootloader" | tr -d "\r\n"`
		echo -e -n $deviceExpectedBootloader #Returns "moto-apq8084-71.15"
	fi
}

function getDeviceBasebandVersion(){
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBasebandVersion=`adb -s $1 wait-for-device shell getprop ro.boot.version.baseband | tr -d "\r\n"`
		echo -e -n $deviceBasebandVersion #Returns "D4.01-9625-05.32+FSG-9625-02.109"
	fi
}

function getDeviceExpectedBasebandVersion() {
#$1 - device serial number
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceExpectedBasebandVersion=`adb -s $1 wait-for-device shell getprop "ro.build.expect.baseband" | tr -d "\r\n"`
		echo -e -n $deviceExpectedBasebandVersion #Returns "D4.01-9625-05.32+FSG-9625-02.109"
	fi
}


#[ro.bootloader]: [moto-apq8084-71.15]
#===================================================================================================
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
#===================================================================================================
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

function getDeviceSecureBootloaderState(){
	#$1 - device serial
	#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceSecureBootloaderState=`adb -s $1 wait-for-device shell getprop ro.boot.secure_hardware | tr -d "\r\n"`
		echo -e -n $deviceSecureBootloaderState #Returns "1" or "null"
	fi
}

function getDeviceOemUnlockAllowedState(){
	#$1 - device serial
	#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceOemUnlockAllowedState=`adb -s $1 wait-for-device shell getprop sys.oem_unlock_allowed | tr -d "\r\n"`
		echo -e -n $deviceOemUnlockAllowedState #Returns "0" or "1"
	fi
}

#[drm.service.enabled]: [true]
#===================================================================================================
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

function isDeviceFusedSDcard(){
#$1 - device serial
#$return - true, false
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceFusedSDCard=`adb -s $1 wait-for-device shell getprop ro.crypto.fuse_sdcard | tr -d "\r\n"`
		echo -e -n $deviceFusedSDCard #Returns "true" or "false"
	fi
}
#===================================================================================================
function getDeviceBootCompleteState(){
#$1 - device serial
#$return - true, false
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBootCompleteState=`adb -s $1 wait-for-device shell getprop sys.boot_completed | tr -d "\r\n"`
		echo $deviceBootCompleteState #Returns "1" for success or nothing if its not yet booted
	fi
}

function getDeviceBootAnimationState() {
#$1 - device serial
#$return - running, stopped
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBootAnimationState=`adb -s $1 wait-for-device shell getprop init.svc.bootanim | tr -d "\r\n"`
		echo -e -n $deviceBootAnimationState #Returns "[stopped]" or "[running]"
	fi
}

function getDeviceBootAnimationState() {
#$1 - device serial
#$return - true, false
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceBootAnimation=`adb -s $1 wait-for-device shell getprop init.svc.bootanim | tr -d "\r\n"`
		echo -e -n $deviceBootAnimation #Returns "[stopped]" or "[running]"
	fi
}

function getDeviceRebootReason() {
#$1 - device serial
#$return - kernel_panic, reboot
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceRebootReason=`adb -s $1 wait-for-device shell getprop ro.boot.bootreason | tr -d "\r\n"`
		echo -e -n $deviceRebootReason #Returns "kernel_panic" "reboot"
	fi
}

#[ro.boot.mode]: [normal]
#[ro.bootmode]: [normal]
#[ro.boot.bl_state]: [2]
#===================================================================================================
function getDeviceGsmNetworkType() {
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

#[gsm.operator.alpha]: [AT&T]
#[gsm.operator.iso-country]: [us]
#[gsm.sim.operator.iso-country]: [us]
#[gsm.operator.isroaming]: [false]
#[gsm.operator.isroaming]: [false]
#[ro.com.android.dataroaming]: [false]
#===================================================================================================
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

function getDeviceWifiInterface() {
#$1 - device serial
#$return - wlan0
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceNetworkType=`adb -s $1 wait-for-device shell getprop wifi.interface | tr -d "\r\n"`
		echo -e -n $deviceNetworkType #Returns "wlan0"
	fi
}

function getDeviceWifiStatus() {
#$1 - device serial
#$return - ok
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceNetworkType=`adb -s $1 wait-for-device shell getprop wlan.driver.status | tr -d "\r\n"`
		echo -e -n $deviceNetworkType #Returns "ok"
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

#[init.svc.bdAddrLoader]: [stopped]
#[dhcp.wlan0.ipaddress]: [192.168.1.147]
#[net.bt.name]: [Android]
#[net.change]: [net.dns1]
#[net.dns1]: [192.168.1.1]

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
#===================================================================================================

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

#===================================================================================================

#[persist.sys.country]: [US]
#[persist.sys.language]: [en]
#[persist.sys.usb.config]: [mtp,adb]

#===================================================================================================