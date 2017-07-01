#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for functions related to network-related operations on device
#
# Usage: ". ./library/networkOperations.sh" within other scripts

#===================================================================================================

function buildIpAddress() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local let i=0
		local line

		isWifiUp="false"
		isWifiIP="false"
		wifiIP="0.0.0.0"
		isEthUp="false"
		isEthIP="false"
		ethIP="0.0.0.0"

		while read line
		do
			interface="`echo $line | awk '{print $1}'`"
			upDown="`echo $line | awk '{print $2}'#`"
			ipAddress="`echo $line | awk '{print $3}' | cut -d"/" -f1`"
			ipPort="`echo $line | awk '{print $3}' | cut -d"/" -f2`"

			if [[ "$interface" == "wlan0" && "$upDown" == "UP" ]]; then
				isWifiUp="true"
			elif [[ "$interface" == "wlan0" && "$upDown" == "DOWN" ]]; then
				isWifiUp="false"
			fi

			if [[ "$interface" == "wlan0" && "$ipAddress" != "0.0.0.0" && "$ipAddress" != "127.0.0.1" ]]; then
				isWifiIP="true"
				wifiIP="$ipAddress"
				wifiPort="$ipPort"
			fi

			if [[ "$interface" == "eth0" && "$upDown" == "UP" ]]; then
				isEthUp="true"
			elif [[ "$interface" == "eth0" && "$upDown" == "DOWN" ]]; then
				isEthUp="false"
			fi

			if [[ "$interface" == "eth0" && "$ipAddress" != "0.0.0.0" && "$ipAddress" != "127.0.0.1" ]]; then
				isEthIP="true"
				ethIP="$ipAddress"
				ethPort="$ipPort"
			fi

		done < <(adb -s $1 wait-for-device shell netcfg)
    fi
}

#---- Check if WiFi is UP and Connected
function checkWifi() {
#$return - 
	if [[ "$isWifiIP" == "true" && "$isWifiUp" == "true" ]]; then
		echo -e -n "true"
	else
		echo -e -n "false"
	fi
}

#---- Check if Ehternet is UP and Connected
function checkEth() {
#$return - 
	if [[ "$isEthIP" == "true" && "$isEthUp" == "true" ]]; then
		echo -e -n "true"
	else
		echo -e -n "false"
	fi
}

#---- Check if the connectiong is Ehternet/WiFi/Both/None
function checkEthWifi(){
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		buildIpAddress $1

		if [[ "$( checkWifi )" == "true" && "$( checkEth )" == "true" ]]; then
			echo -e -n "Both"
		elif [[ "$( checkWifi )" == "true" && "$( checkEth )" == "false" ]]; then
			echo -e -n "WiFi"
		elif [[ "$( checkWifi )" == "false" && "$( checkEth )" == "true" ]]; then
			echo -e -n "Ethernet"
		elif [[ "$( checkWifi )" == "false" && "$( checkEth )" == "false" ]]; then
			echo -e -n "None"
		fi

#        case

	fi
}

#---- Get the IP address if connected
function getMyIP() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		buildIpAddress $1

        case "$( checkEthWifi $1 )" in
            "Both")
                echo -e -n "$ethIP"
                ;;
            "WiFi")
                echo -e -n "$wifiIP"
                ;;
            "Ethernet")
                echo -e -n "$ethIP"
                ;;
            "None")
                echo -e -n "None"
                ;;
        esac
	fi
}

function getDeviceIP() {
#$1 - device serial
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local deviceIP=$(adb -s $1 wait-for-device shell ip route | awk '{print $9}')
		#local deviceIP=$(adb -s $1 wait-for-device ip addr show wlan0 | grep "inet\s" | awk '{print $2}' | awk -F'/' '{print $1}')
		echo -e -n "${deviceIP}"
	fi
}
#===================================================================================================