#!/bin/bash

# Created by Sujay Davalgi
#
# Backup all the sharable scripts into GitHub folder
#
# Usage: ./backupToGitHubFolder.sh

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/machineFileOperations.sh

echo -e -n ">> Checking Library Files ...\n"
sourceFolder=`echo "${myScripts}/library"`
destFolder=`echo "${gitHubFolder}/scripts/library"`
echo -e -n " Source: ${sourceFolder}\n"
echo -e -n " Destination: ${destFolder}\n"
if [ ! -d "$destFolder" ]; then
	`mkdir -p ${destFolder}`
fi
compareAndCopyMachineFiles "${sourceFolder}" "${destFolder}" "*.*"
echo -e -n ">> Done checking Library Files\n"

echo

echo -e -n ">> Checking Script Files ...\n"
sourceFolder=`echo "${myScripts}"`
destFolder=`echo "${gitHubFolder}/scripts"`
echo -e -n " Source: ${sourceFolder}\n"
echo -e -n " Destination: ${destFolder}\n"
if [ ! -d "$destFolder" ]; then
	`mkdir -p ${destFolder}`
fi
compareAndCopyMachineFiles "${sourceFolder}" "${destFolder}" "*.*"
echo -e -n ">> Done checking Script Files\n"

echo