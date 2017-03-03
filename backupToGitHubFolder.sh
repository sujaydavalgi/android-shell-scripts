#!/bin/bash

# Created by Sujay Davalgi
#
# Backup all the sharable scripts into GitHub folder
#
# Usage: ./backupToGitHubFolder.sh

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/machineFileOperations.sh

# create a list of sharable files

# script files
scriptFiles=(
"apkFileVersion.sh"
"appVersion.sh"
"autoDesktopHeadUnit.sh"
"backupToGitHubFolder.sh"
"bugreport.sh"
"bugreportScreenshot.sh"
"buildID.sh"
"buildSignature.sh"
"clearApkData.sh"
"clearLogcat.sh"
"commands.sh"
"connectIP.sh"
"createHomeLinks.sh"
"deviceEvents.sh"
"displayReset.sh"
"dpadEvents.sh"
"findMyIp.sh"
"grepLogcat.sh"
"info.sh"
"inputEvents.sh"
"installApk.sh"
"installApkFromPath.sh"
"logcat.sh"
"monkey.sh"
"myDevices.sh"
"myOS.sh"
"pullApks.sh"
"pullCameraImagesVideos.sh"
"pullFiles.sh"
"pullRecordedVideo.sh"
"pullScreenshots.sh"
"rebootBootloader.sh"
"rebootDevice.sh"
"rebootRecovery.sh"
"restartApk.sh"
"restartDevice.sh"
"screenCapture.sh"
"screenRecord.sh"
"screenRecordNpull.sh"
"searchAPK.sh"
"startApk.sh"
"stopApk.sh"
"textInput.sh"
"uninstallApks.sh"
"uninstallAppUpdates.sh"
"weather.sh"
"wipeDevice.sh"
)

#library files
libraryFiles=(
"apkOperations.sh"
"configureMachine.sh"
"deviceFileOperations.sh"
"deviceOperations.sh"
"deviceProperties.sh"
"keycodeEvents.sh"
"logFunctions.sh"
"machineFileOperations.sh"
"machineOs.sh"
"mainFunctions.sh"
"myFunctions_legacy.sh"
"mySetup.txt"
"networkOperations.sh"
"test_functions.sh"
"textFormatting.sh"
)

#TODO
#Check the source and destination folder and check if you want to copy the files that not present `in backup

function backupUpdatedFiles(){
#$1 - source folder
#$2 - dest folder
#$3 - files array list

	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local srcFolder="${1}"
		local dstFolder="${2}"
		local filesArray=("${!3}") #IMP: notice how the array is received (passed as argument)

		local j=1

		for ((i=0; i<${#filesArray[@]}; i++))
		do
			if [[ -d "${srcFolder}" ]]; then 	# check if the source folder exist
				if [[ -f "${srcFolder}/${filesArray[i]}" ]]; then 	# check if the source file exist
					# compare source and destination folder for the file
					compareFileStatus=$( compareMachineFiles "${srcFolder}/${filesArray[i]}" "${dstFolder}/${filesArray[i]}" )
					
					# If files are "same", do nothing. If they are "diff" or not present in the destination, copy the file to destination
					if [[ "$compareFileStatus" == "diff" || "$compareFileStatus" == "NoDst" ]]; then
						echo -e -n "   $j.Copying ${srcFolder}/${filesArray[i]}\n"
						cp "${srcFolder}/${filesArray[i]}" "${dstFolder}/${filesArray[i]}"
						let j=j+1
					elif [ "$compareFileStatus" == "NoSrc" ]; then
						echo -e -n " Source file not found: ${srcFolder}/${filesArray[i]}"
					fi
				else
					echo -e -n " ${filesArray[i]} file not found in source directory\n"
				fi
			else
				echo -e -n " Source folder not found: $srcFolder\n"
			fi
		done
	fi
}

echo -e -n " >> Checking Library Files ...\n"
sourceFolder=`echo ${libraryFolder}`
destFolder=`echo ~/Setup/GitHub/scripts/library`
backupUpdatedFiles "${sourceFolder}" "${destFolder}" "libraryFiles[@]"
echo -e -n " >> Done checking Library Files\n"

echo

echo -e -n " >> Checking Script Files ...\n"
sourceFolder=`echo ${myScripts}`
destFolder=`echo ~/Setup/GitHub/scripts`
backupUpdatedFiles "${sourceFolder}" "${destFolder}" "scriptFiles[@]" #IMP: notice how the array "scriptFiles" is passed as a parameter
echo -e -n " >> Done checking Script Files\n"

