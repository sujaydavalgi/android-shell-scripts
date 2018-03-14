#!/bin/bash

# Created by Sujay Davalgi
#
# Backup all the sharable scripts into GitHub folder
#
# Usage: ./backupToGitHubFolder.sh

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

echo -e -n ">> Checking Library Files ...\n"
sourceFolder=`echo "${myScripts}/library"`
destFolder=`echo "${gitHubFolder}/scripts/library"`
backupFiles "${sourceFolder}" "${destFolder}"
echo -e -n ">> Done checking Library Files\n"

echo

echo -e -n ">> Checking Script Files ...\n"
sourceFolder=`echo "${myScripts}"`
destFolder=`echo "${gitHubFolder}/scripts"`
backupFiles "${sourceFolder}" "${destFolder}"
echo -e -n ">> Done checking Script Files\n"

echo