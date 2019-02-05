#!/bin/bash

# Created by Sujay Davalgi
#
# Backup all the sharable scripts into GitHub folder
#
# Usage: ./backupToPythonGitHubFolder.sh

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/machineFileOperations.sh

backupFiles(){
	echo -e -n " Source: ${1}\n"
	echo -e -n " Destination: ${2}\n"
	if [ ! -d "$destFolder" ]; then
		`mkdir -p ${2}`
	fi
	compareAndCopyMachineFiles "${1}" "${2}" "*.*"
}

gitHubFolder=`echo ~/Setup/GitHub`
gitHubFolder_python="${gitHubFolder}/android-python-scripts"

echo -e -n ">> Checking Library Files ...\n"
sourceFolder=`echo "${myPythonScripts}/library"`
destFolder=`echo "${gitHubFolder_python}/library"`
backupFiles "${sourceFolder}" "${destFolder}"
echo -e -n ">> Done checking Library Files\n"

echo

echo -e -n ">> Checking Script Files ...\n"
sourceFolder=`echo "${myPythonScripts}"`
destFolder=`echo "${gitHubFolder_python}"`
backupFiles "${sourceFolder}" "${destFolder}"
echo -e -n ">> Done checking Script Files\n"

echo