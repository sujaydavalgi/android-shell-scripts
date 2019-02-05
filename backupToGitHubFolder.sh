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
gitHubFolder_shell="${gitHubFolder}/android-shell-scripts"

echo -e -n ">> Checking Library Files ...\n"
sourceFolder=`echo "${myShellScripts}/library"`
destFolder=`echo "${gitHubFolder_shell}/library"`
backupFiles "${sourceFolder}" "${destFolder}"
echo -e -n ">> Done checking Library Files\n"

echo

echo -e -n ">> Checking Script Files ...\n"
sourceFolder=`echo "${myShellScripts}"`
destFolder=`echo "${gitHubFolder_shell}"`
backupFiles "${sourceFolder}" "${destFolder}"
echo -e -n ">> Done checking Script Files\n"

echo