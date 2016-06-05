#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for functions related to file operations on device
#
# Usage: ". ./library/deviceFileOperations.sh" within other scripts

#===================================================================================================

function checkFolder() {
#1 deviceSerial
#2 folder name with complete path
	adb -s $1 shell "if [ -e "${2}" ]; then echo 1; fi"
	
	#checkDirectory=$(adb -s $deviceSerial shell "if [ -d "${devicePath}" ]; then echo 'exists'; else echo 'not exists';
} 

function checkFile() {
#1
	echo "${1}" | grep -c "No such file or directory"
}

#----- build the array for list of files
function buildDeviceFilesArray() {
#$1 device serial number
#$2 folder to search in device
#$3 type of file to search in the folder
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 3 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		#if [ `adb -s $1 shell "if [ -e "${2}" ]; then echo 1; fi"` ]; then
		if [ $(checkFolder "$1" "${2}") ]; then # check if the ${2} folder exists or not
			
			local i=0
		
			#local foundMP4=0
			#local foundJPG=0
			#local foundPNG=0
			#local foundAll=0
		
			deviceFiles_count=0
			
			local pathToSearch=""
		
			if [ "${3}" = "all" ]; then # if you want to display even the directories within given directory
				pathToSearch="${2}/" 
			else						# if you want to display only the files within given directory
				pathToSearch="${2}/${3}"
			fi

			while read files
			do
				notFoundFiles=`echo $files | grep -c "No such file or directory"` #returns: 0 if not found, 1 if found
			
				#foundMP4=`echo $files | grep -c "*.mp4"`
				#foundJPG=`echo $files | grep -c "*.jpg"`
				#foundPNG=`echo $files | grep -c "*.png"`
				#foundAll=`echo $files | grep -c "*.*"`
				#foundFiles=`echo $files | grep -c "*.{jpg,png,mp4}"`
			
				#if [ -n "$files" ] && [[ $foundMP4 = 0 && $foundJPG = 0 && $foundPNG = 0 && $foundAll = 0 ]]
				if [[ -n "$files" && $notFoundFiles = 0 ]]
				then
					deviceFiles_array[i]="$files"
					let i=$i+1
				fi

			done < <( adb -s $1 shell ls "${pathToSearch}" | tr -d '\r' )
				
			deviceFiles_count=${#deviceFiles_array[*]}

		else #if the ${2} folder does not exists
			formatMessage " Folder '${2}' does not exist in the device\n\n" "E"
			exit 1
		fi
	fi
}

#----- display the list of files in device
function displayDeviceFileList() {

	local let DEVICE_FILE_CHOICE_NUMBER=1
	#local let i=0
	
	for i in ${deviceFiles_array[@]}
	do
		DEVICE_FILE_LIST_ID="${DEVICE_FILE_CHOICE_NUMBER}"." "
		echo -e " $DEVICE_FILE_LIST_ID$i"
		let "DEVICE_FILE_CHOICE_NUMBER = $DEVICE_FILE_CHOICE_NUMBER + 1"
	done
}

#----- check if the item # for the file selection was valid
function checkDeviceFileChoiceValidity() {

	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if echo $1 | grep "^[0-9]*$">aux; then
			let "deviceFiles_count=$deviceFiles_count+1"
			if [ "$1" -gt "$deviceFiles_count" ]; then
				formatMessage " Dude '$1' is not a choice in this list and you know it. Come on!\n" "W"
				exit
			else
				DEVICE_FILE_ARRAY_INDEX=$1
				let "DEVICE_FILE_ARRAY_INDEX = $DEVICE_FILE_ARRAY_INDEX - 1"
			fi
		else
			formatMessage "\n Come on Dude! Pick a number\n\n" "W"
			exit
		fi
	fi
}

#----- read the item # from the device file list
function getDeviceFileChoice() {
#$1 device serial number
#$2 folder to search in device
#$3 type of file to search in the folder
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 3 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		deviceFileSelected=""
		buildDeviceFilesArray ${1} "${2}" "${3}"

		if [ $deviceFiles_count -gt 0 ]; then
			if [ $deviceFiles_count -gt 1 ]; then #<-- if there are more than 1 file
				
				displayDeviceFileList
				
				echo -e -n "\n ${txtBld}Enter Choice : ${txtRst}"
				read DEVICE_FILE_CHOICE;
				checkDeviceFileChoiceValidity $DEVICE_FILE_CHOICE
				
				deviceFileSelected=${deviceFiles_array[${DEVICE_FILE_ARRAY_INDEX}]}	
				
			else  								#<-- if there is only 1 file
				formatMessage " There is only one file in the folder '${2}'\n\n" "W"
				formatMessage " 1. ${deviceFiles_array[0]}\n\n"
				formatMessage " Do you want to pull it ? [y/n] : " "Q"
				stty -echo && read -n 1 pullDeviceFileOption && stty echo
				formatYesNoOption $pullDeviceFileOption

				if [ "$( checkYesNoOption $pullDeviceFileOption )" == "yes" ]; then
					deviceFileSelected=${deviceFiles_array[0]}
				elif [ "$( checkYesNoOption $pullDeviceFileOption )" == "no" ]; then				
					echo " "
				fi
			fi
		else #<-- if the file count is less than zero, i.e., there is no files
			formatMessage " There are no ${3} files in the device directory : " "E"
			formatMessage "${2}\n\n"
			exit 1
		fi
	fi
}

function pullDeviceFile() {
#$1 device serial number
#$2 folder to search in device
#$3 type of file to search in the folder
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 3 arguments passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		getDeviceFileChoice ${1} "${2}" "${3}"

		if [ "$deviceFileSelected" != "" ]; then
			formatMessage "\n Selected file : ${deviceFileSelected}\n"
			formatMessage " will be saved in : ${myLogs}\n"
			adb -s "$1" wait-for-device pull "${deviceFileSelected}" "${myLogs}" >/dev/null 2>&1
			formatMessage "\n Done\n\n"
		fi
	fi
}
#===================================================================================================