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
apkFileVersion.sh
appVersion.sh
autoDesktopHeadUnit.sh
backupToGitHubFolder.sh
bugreport.sh
bugreportScreenshot.sh
buildID.sh
buildSignature.sh
clearApkData.sh
clearCloudData.sh
clearLogcat.sh
commands.sh
connectIP.sh
createHomeLinks.sh
deviceEvents.sh
displayReset.sh
dpadEvents.sh
findMyIp.sh
grepLogcat.sh
info.sh
inputEvents.sh
installApk.sh
installApkFromPath.sh
logcat.sh
monkey.sh
myDevices.sh
myOS.sh
pullApks.sh
pullCameraImagesVideos.sh
pullFiles.sh
pullRecordedVideo.sh
pullScreenshots.sh
rebootBootloader.sh
rebootDevice.sh
rebootRecovery.sh
restartApk.sh
restartDevice.sh
screenCapture.sh
screenRecord.sh
screenRecordNpull.sh
searchAPK.sh
startApk.sh
stopApk.sh
textInput.sh
uninstallApks.sh
uninstallAppUpdates.sh
weather.sh
wipeDevice.sh
)

#library files
libraryFiles=(
apkOperations.sh
configureMachine.sh
deviceFileOperations.sh
deviceOperations.sh
keycodeEvents.sh
logFunctions.sh
machineFileOperations.sh
machineOs.sh
mainFunctions.sh
myFunctions_legacy.sh
mySetup.txt
networkOperations.sh
test_functions.sh
textFormatting.sh
)

#TODO
function backupUpdatedFiles(){
	#$1
	#$2
	#$3
	echo
	
}

echo -e -n " Checking Script Files ...\n"
#run the loop for script files
sourceFolder=`echo ${myScripts}`
destFolder=`echo ~/Setup/GitHub/scripts`
scriptFilesCount=${#scriptFiles[@]}	#scriptFiles array length

for ((i=0; i<$scriptFilesCount; i++))
do
	if [[ -d "${sourceFolder}" ]]; then 	# check if the source folder exist
		if [[ -f "${sourceFolder}/${scriptFiles[i]}" ]]; then 	# check if the source file exist
			# compare source and destination folder for the file
			compareFileStatus=$( compareMachineFiles "${sourceFolder}/${scriptFiles[i]}" "${destFolder}/${scriptFiles[i]}" )
			
			# If same, do nothing. If Diff, copy to destination
			if [[ "$compareFileStatus" == "diff" || "$compareFileStatus" == "NoDst" ]]; then
				echo -e -n " Copying ${sourceFolder}/${scriptFiles[i]}\n"
				cp "${sourceFolder}/${scriptFiles[i]}" "${destFolder}/${scriptFiles[i]}"
			elif [ "$compareFileStatus" == "NoSrc" ]; then
				echo -e -n " Source file not found: ${sourceFolder}/${scriptFiles[i]}"
			fi
		else
			echo -e -n " ${scriptFiles[i]} file not found in source directory\n"
		fi
	else
		echo -e -n " Source folder not found: $sourceFolder\n"
	fi
done
echo -e -n " Done checking Script Files\n"

echo -e -n " Checking Library Files ...\n"
#run the loop for library files
sourceFolder=`echo ${libraryFolder}`
destFolder=`echo ~/Setup/GitHub/scripts/library`
libraryFilesCount=${#libraryFiles[@]} 	#libraryFile array length

for ((i=0; i<$libraryFilesCount; i++))
do
	if [[ -d "${sourceFolder}" ]]; then 	# check if the source folder exist
		if [[ -f "${sourceFolder}/${libraryFiles[i]}" ]]; then 	# check if the source file exist
			# compare source and destination folder for the file
			compareFileStatus=$( compareMachineFiles "${sourceFolder}/${libraryFiles[i]}" "${destFolder}/${libraryFiles[i]}" )
			
			# If same, do nothing
			if [ "$compareFileStatus" == "diff" ]; then
				echo -e -n " Copying ${sourceFolder}/${libraryFiles[i]}\n"
				cp "${sourceFolder}/${libraryFiles[i]}" "${destFolder}/${libraryFiles[i]}"
			fi
		else
			echo -e -n " ${libraryFiles[i]} file not found in source directory\n"
		fi
	else
		echo -e -n " Source folder not found: $sourceFolder\n"
	fi
done
echo -e -n " Done checking Library Files\n"