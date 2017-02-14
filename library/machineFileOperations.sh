#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for functions releated to file operations on machine
#
# Usage: ". ./library/machineFileOperations.sh" within other scripts

#===================================================================================================

#----- Check if the folder exist in the base folder for the specified sub-folder
function checkMachineSubFolder() {
#$1 - main folder absolute path
#$2 - subfolder
#$return - 
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [ -d "$1/$2" ]; then # if there is a subfolder with the specified name
			appInstallPath="$appInstallPath/$2"
		else # if there is no subfolder with the specified name, check if the user wants to search the default folder
			local useDefaultFolderOption
			
			echo -e -n " ${txtBld}$2${txtRst} folder doesnot exists in $1 ...\n\n Do you want to install from ${txtPur}${txtBld}$1${txtRst} instead [y/n]: "
			stty -echo && read -n 1 useDefaultFolderOption && stty echo
			formatYesNoOption $useDefaultFolderOption

			if [ "$( checkYesNoOption $useDefaultFolderOption )" == "yes" ]; then # if the user wants to use the default folder
				echo ""
			elif [ "$( checkYesNoOption $useDefaultFolderOption )" == "no" ]; then # if the user does not want to use the default folder
				echo ""
				exit 1
			fi
		fi
	fi
}

#----- Check if the Folder exist in the specified path
function checkMachineFolderExist() {
#$1 - Complete Folder path
#return - "yes" | "no"
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No 1 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		[[ -d "${1}" ]] && echo -e -n "yes" || echo -e -n "no" #check if the directory exist and reply "yes" or "no"
	fi
}

#----- Check if the File exist in the specified path
function checkMachineFileExist() {
#$1 - folder path
#return - "yes" | "no"
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		#if [ -f "${1}" ]; then 	# if the file exist
		#	echo -e -n "yes"
		#else					# if the file does not exist
		#	echo -e -n "no"
		#fi
		[[ -f "${1}" ]] && echo -e -n "yes" || echo -e -n "no"
	fi
}

#----- Check if the two files in a give source and destination are same or not
function compareMachineFolderAndFiles(){
#$1 - Foolder-1 complete path
#$2 - File-1 name
#$3 - Folder-2 complete path
#$4 - File-2 name
#return - "same" | "diff"
	if [ $# -lt 4 ]; then
		writeToLogsFile "@@ No 4 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		#TODO check for folder-1, file-1, folder-2, file-2 existance
		if [[ $( checkMachineFolderExist ${1} ) == "yes" && $( checkMachineFileExist "${1}/${2}" ) == "yes" && $( checkMachineFolderExist "${3}" ) == "yes" && $( checkMachineFileExist "${3}/${4}" ) == "yes" ]]; then
			[[ "${1}/${2}" -ef "${3}/${4}" ]] && echo -e -n "same" || echo -e -n "diff"
		else
			writeToLogsFile "${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} ) did not have the valid Folder or File argument passed"
		fi
	fi
}

#----- Check if the two files are same or not
function compareMachineFiles(){
#$1 - File-1 complete path
#$2 - File-2 complete path
#return - "diff" | "same" | "NoSrc" | "NoDst"
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 4 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [[ $( checkMachineFileExist "${1}" ) == "yes" && $( checkMachineFileExist "${2}") == "yes" ]]; then
			#check if files are same or diff. If SAME, it will return blank. If DIFF, it will diff status
			#diffResult=`diff -q "${1}" "${2}" | rev | cut -d" " -f1 | rev | tr -d "\r\n"`
			diffResult=`diff -q "${1}" "${2}"`
			
			if [ -n "${diffResult}" ]; then
				diffStatus="diff"	
			else
				diffStatus="same"
			fi
		else
			if [ $( checkMachineFileExist "${1}" ) == "no" ]; then
				diffStatus="NoSrc"
			elif [ $( checkMachineFileExist "${2}" ) == "no" ]; then
				diffStatus="NoDst"
			fi
		fi

		echo -e -n "${diffStatus}"
	fi
}

#===================================================================================================

#----- build the array for list of files
function buildMachineFilesArray() {
#$1 - main folder absolute path
#$2 - search string
#return - set machineFiles_array & machineFiles_count
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		machineFiles=""
		machineFiles_count=0
		
		#machineFiles="$( ls -F "$1" | grep -v "\/" | tr -d '\r' | tr -d '*')"
		machineFiles="$( find $1 -type f -iname "*$2*" | sort )"
		
		if [[ $machineFiles != "" || -n $machineFiles ]]; then
			machineFiles_array=( $machineFiles )
			machineFiles_count=${#machineFiles_array[*]}
		fi
	fi
}

#----- build the list of files to install
function buildMachineInstallFileArray() {
#return - set installAppsSelected, installApps_Array, installaApps_Count
	local i=0
	local installAppsSelected=""
	local installAppOption="n"
	local appName=""
	
	for i in ${machineFiles_array[@]}
	do
		appName=${i##*/}
		formatMessage " Do you want to install [y/n] - " "Q"
		formatMessage "$appName : "
		#formatMessage "$i : "
		stty -echo && read -n 1 installAppOption && stty echo
		formatYesNoOption $installAppOption

		if [ "$( checkYesNoOption $installAppOption )" == "yes" ]; then
			installAppsSelected="$installAppsSelected $i"		
		fi
	done
	
	installApps_Array=( $installAppsSelected )
	installApps_Count=${#installApps_Array[*]}
}

#===================================================================================================

function getMachineApkApplicationName() {
#$1 - apk file complete path in machine
#return - application name: "Google Play Music"
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [[ "$( checkYesNoOption $( checkMachineFileExist ${1} ) )" == "yes"  ]]; then
			local applicationName=`aapt dump badging ${1} | grep -i "application-label-en-GB:" | cut -f2 -d":" | cut -f2 -d"'" | tr -d "\r"`
			echo -e -n "${applicationName}"
		else
			writeToLogsFile "'${1}' File Not Found - ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
			echo ""
			exit 1
		fi
	fi
}

function getMachineApkPackageName() {
#$1 - apk file complete path in machine
#return - application package name: "com.google.android.music"
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [[ "$( checkYesNoOption $( checkMachineFileExist ${1} ) )" == "yes"  ]]; then
			local machineApkPackageName=`aapt dump badging "${1}" | awk '/package/{gsub("name=|'"'"'","");  print $2}'` 
			echo -e -n ${machineApkPackageName} # returns 'com.google.android.music'
		else
			writeToLogsFile "'${1}' File Not Found - ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
			echo ""
			exit 1
		fi
	fi
}

function getMachineApkVersion() {
#$1 - apk file complete path in machine
#return - application version: "6.15.3518-0.H.3311787"
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [[ "$( checkYesNoOption $( checkMachineFileExist ${1} ) )" == "yes"  ]]; then
			local machineApkVersion=`aapt dump badging "${1}" | grep -i versionname | cut -f4 -d"=" | cut -f1 -d" " | cut -f2 -d"'" | tr -d "\r"`
			echo -e -n ${machineApkVersion} # returns "6.15.3518-0.H.3311787"
		else
			writeToLogsFile "'${1}' File Not Found - ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
			echo ""
			exit 1
		fi

	fi
}

function getMachineApkCompleteVersionName() {
#$1 - apk file complete path in machine
#return - apk version "6.15.3518-0.H.3311787"
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [[ "$( checkYesNoOption $( checkMachineFileExist ${1} ) )" == "yes"  ]]; then
			local machineApkVersion=`aapt dump badging "${1}" | grep -i versionname | cut -f4 -d"=" | cut -f2 -d"'" | tr -d "\r"`
			echo -e -n ${machineApkVersion}
		else
			writeToLogsFile "'${1}' File Not Found - ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
			echo ""
			exit 1
		fi
	fi
}

function getDeviceApkVersion() {
#$1 - deviceSerial
#$2 - apk file complete path in machine
#return - application version "6.15.3518-0.H.3311787"
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local i=0
		
		local machineApkPackageName=`getMachineApkPackageName ${2}`
		
		while read line
		do
			if [ -n "$line" ]; then
				deviceApkVersion[i]="$line"
				let i=$i+1
			fi
		done < <(adb -s ${1} wait-for-device shell dumpsys package ${machineApkPackageName} | grep -i versionname | cut -f2 -d"=" | tr -d "\r")
		
		echo -e -n ${deviceApkVersion[0]}
	fi
}

function displayApkCompleteVersion() {
#$1 - complete apk file path in machine

	local machineApkVersion=`getMachineApkCompleteVersionName ${1}`
	formatMessage " Apk Version : ${machineApkVersion}\n" "I"
}

#===================================================================================================

function forceInstallApk() {
#$1 - deviceSerial
#$2 - apk file complete path in machine
#return - 
	output=$(adb -s $1 wait-for-device install -r -d "$2")

	status=`echo ${output} | cut -f3 -d" " | tr -d "\r"`

	if [ ${status} == "Success" ]; then
		echo -e -n " Status : ${txtGrn}$status${txtRst}"
	elif [ ${status} == "Failure" ]; then
		reason=`echo ${output} | cut -f4 -d" " | cut -f2 -d"[" | cut -f1 -d"]" | tr -d "\r"`
		echo -e -n " Status : ${txtRed}$status${txtRst} - ${reason}"
	else
		echo -e -n " Status : $status"
	fi
}

function installApk() {
#$1 - deviceSerial
#$2 - apk file complete path in machine
#return - 
	#TODO work on capturing the output of adb command based on adb version and device version
	#local output=$( adb -s $1 wait-for-device install -r "$2" )  #<---- temporary solution
	local output=$( adb -s $1 wait-for-device install -r -d "$2" ) #<---- temporary solution
	local status=`echo ${output} | cut -f3 -d" " | tr -d "\r"`

	#installApkStatusReason "$1" "$2" "$output" "$status"	#<---- temporary solution
}

function installApkReinstall() {
#$1 - deviceSerial
#$2 - apk file complete path in machine
#return - 
	local machineApkApplicationName=`getMachineApkApplicationName ${2}`

	formatMessage " - The application '${machineApkApplicationName}' is already installed in your device" "E"
	formatMessage "\n\n Do you still want to reinstall? [y/n] : " "Q"
	
	stty -echo && read -n 1 reinstallApkChoice && stty echo
	formatYesNoOption $reinstallApkChoice
	echo ""

	if [ "$( checkYesNoOption $reinstallApkChoice )" == "yes" ]; then
		local output=$( adb -s $1 wait-for-device install -r "$2" )
		local status=`echo ${output} | cut -f3 -d" " | tr -d "\r"`
		
		installApkStatusReason "$1" "$2" "$output" "$status"

	elif [ "$( checkYesNoOption $reinstallApkChoice )" == "no" ]; then
		#echo -e -n "\n"
		exit 1
	fi
	
}

function installApkDowngrade() {
#$1 - deviceSerial
#$2 - apk file complete path in machine
#return - 
	local machineApkPackageName=`getMachineApkPackageName ${2}`
	local machineApkVersion=`getMachineApkVersion ${2}`
	local deviceApkVersion=`getDeviceApkVersion ${1} ${2}`
	
	formatMessage " - There is a higher version currently installed in your device" "E"
	echo -e -n "\n\n Installed in Device - ${deviceApkVersion}"
	echo -e -n "\n About to install - ${machineApkVersion}\n"
	formatMessage "\n Do you still want to install? [y/n] : " "Q"
	
	stty -echo && read -n 1 downgradeApkChoice && stty echo
	formatYesNoOption $downgradeApkChoice
	echo ""

	if [ "$( checkYesNoOption $downgradeApkChoice )" == "yes" ]; then
		
		if [ $( getDeviceBuildVersion $1 ) > "4.1" ]; then
			local output=$( adb -s $1 wait-for-device install -r -d "$2" )
		else
			local output=$( adb -s $1 wait-for-device install -r "$2" )
		fi
		
		local status=`echo ${output} | cut -f3 -d" " | tr -d "\r"`
		
		installApkStatusReason "$1" "$2" "$output" "$status"

	elif [ "$( checkYesNoOption $downgradeApkChoice )" == "no" ]; then
		#echo -e -n "\n"
		exit 1
	fi
}

function installApkStatusReason() {
#$1 - deviceSerial
#$2 - apk file complete path in machine
#$3 - complete output of adb install command
#$4 - status of adb install command [Success / Failure]
#return - 
	if [ "${4}" == "Success" ]; then
		echo -e -n " Status : ${txtGrn}$status${txtRst}"
		echo ""
	elif [ "${4}" == "Failure" ]; then
		echo -e -n " Status : ${txtRed}$status${txtRst}"
		
		local reason=`echo ${3} | cut -f4 -d" " | cut -f2 -d"[" | cut -f1 -d"]" | tr -d "\r"`
		
		case "$reason" in
			"INSTALL_FAILED_ALREADY_EXISTS")
				installApkReinstall $1 "$2"
				;;
			"INSTALL_FAILED_VERSION_DOWNGRADE")
				installApkDowngrade $1 "$2"
				;;
			"INSTALL_FAILED_UPDATE_INCOMPATIBLE" | "INSTALL_PARSE_FAILED_INCONSISTENT_CERTIFICATES")
				formatMessage " - Certificate version mismatch with the existing installed apk\n\n" "E"
				exit 1
				;;
			*)
				echo -e -n " - ${reason}\n"
				exit 1
				;;
		esac
		
	else
		formatMessage " Status : $status\n"
	fi
}

#===================================================================================================

#----- install APK's from the specified path
function installFromPath(){
#$1 - device serial
#$2 - folder absolute path
#$3 - search string
#return - 
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 2 arguments passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else	
		appInstallPath=${2}
		buildMachineFilesArray "$appInstallPath" "$3"

		if [ $machineFiles_count -gt 0 ]; then
			
			if [ $machineFiles_count -gt 1 ]; then #<-- if there is more than 1 file
				formatMessage " There are $machineFiles_count matching files in the folder : " "I"
				formatMessage "$appInstallPath\n\n"
				
				buildMachineInstallFileArray
				
				for i in ${installApps_Array[@]}
				do
					formatMessage "\n Installing - " "I"
					formatMessage "$i ... \n" "M"
					
					displayApkCompleteVersion ${i}

					#adb -s $1 wait-for-device install -r "$appInstallPath/$i"
					
					#adb -s $1 wait-for-device install -r -d "$i"
					installApk $1 "$i"
				done
				
			else  #<-- if there is only 1 file
				local installAppOption="n"
				formatMessage " There is only 1 matching file in : " "W"
				formatMessage "$appInstallPath\n\n"
			 	formatMessage " Do you want to install [y/n] - " "Q"
			 	
			 	local appName=${machineFiles_array[0]##*/}
				formatMessage "$appName : "
			 	#formatMessage "${machineFiles_array[0]} : "
			 	
				stty -echo && read -n 1 installAppOption && stty echo
				formatYesNoOption $installAppOption

				if [ "$( checkYesNoOption $installAppOption )" == "yes" ]; then
					#adb -s $1 wait-for-device install -r "$appInstallPath/${machineFiles_array[0]}"
					formatMessage "\n Installing - " "I"
					formatMessage "${machineFiles_array[0]} ... \n" "M"
					
					displayApkCompleteVersion ${machineFiles_array[0]}
					
					#adb -s $1 wait-for-device install -r -d "${machineFiles_array[0]}"
					installApk $1 "${machineFiles_array[0]}"
				fi
			fi
			
			echo ""
			
		else #<-- if the file count is less than zero, i.e., there is no files
			formatMessage " There are no matching files in the directory : " "E"
			formatMessage "$appInstallPath\n\n"
#			exit 1
		fi
	fi
}

#----- read the item # from the device file list
function installMachineFiles() {
#$1 - device serial
#$2 - main folder absolute path
#$3 - sub folder
#$4 - search string
#$return - 
	if [ $# -lt 4 ]; then
		writeToLogsFile "@@ No 4 arguments passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else	
		appInstallPath=${2}
		checkMachineSubFolder $2 $3

		installFromPath $1 $appInstallPath $4
	fi
}

#===================================================================================================
#----- Check if there is an existing TIF folder
function checkTifFolder() {
#$1 - main folder absolute path
#$2 - Sub Folder
#$return -
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [ "$2" == "latest" ]; then

			local tifLatestFolder=${1}/latest
	#		local tifAssetFolder=${tifLatestFolder}/asset

			if [[ -d "${tifLatestFolder}"  ]]; then
				echo -e -n "\n ${txtBld}$2${txtRst} folder already exist in ${txtBld}$1${txtRst}.\n\n"
				formatMessage " Do you want to backup and create a new one ? [y/n] : " "Q"
				stty -echo && read -n 1 createLatestFolderChoice && stty echo
				formatYesNoOption $createLatestFolderChoice

				if [ "$( checkYesNoOption $createLatestFolderChoice )" == "yes" ]; then
						tifLatestFolderNew="${tifLatestFolder}"_"${nowDateTime}"

						echo -e -n "\n"

						formatMessage " Moving ${tifLatestFolder} to... ${tifLatestFolderNew}\n"
						mv "${tifLatestFolder}" "${tifLatestFolderNew}"
				fi
			fi

			if [ "$( checkYesNoOption $createLatestFolderChoice )" == "yes" ]; then
				echo -e -n "\n"
				formatMessage " Creating folder... " "I"
				formatMessage "${tifLatestFolder}\n"
				mkdir -p ${tifLatestFolder}

	#			echo -e -n " Creating folder... ${tifAssetFolder}\n"
	#			mkdir -p ${tifAssetFolder}

				#prodaccess

				cp -rf "$tifTeamFolder/latest/" "${1}"
	#			cp "$tifTeamFolder/asset" "$tifAssetFolder"

				echo -e -n "\n"
			fi
		fi
	fi
}