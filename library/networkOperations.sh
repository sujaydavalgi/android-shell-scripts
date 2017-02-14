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
		echo "true"
	else
		echo "false"
	fi
}

#---- Check if Ehternet is UP and Connected
function checkEth() {
#$return - 
	if [[ "$isEthIP" == "true" && "$isEthUp" == "true" ]]; then
		echo "true"
	else
		echo "false"
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
			echo "Both"
		elif [[ "$( checkWifi )" == "true" && "$( checkEth )" == "false" ]]; then
			echo "WiFi"
		elif [[ "$( checkWifi )" == "false" && "$( checkEth )" == "true" ]]; then
			echo "Ethernet"
		elif [[ "$( checkWifi )" == "false" && "$( checkEth )" == "false" ]]; then
			echo "None"
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
                echo "$ethIP"
                ;;
            "WiFi")
                echo "$wifiIP"
                ;;
            "Ethernet")
                echo "$ethIP"
                ;;
            "None")
                echo "None"
                ;;
        esac
	fi
}
#===================================================================================================