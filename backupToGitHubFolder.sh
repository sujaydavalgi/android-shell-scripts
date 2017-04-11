#!/bin/bash

# Created by Sujay Davalgi
#
# Backup all the sharable scripts into GitHub folder
#
# Usage: ./backupToGitHubFolder.sh

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/machineFileOperations.sh

#get the list of files in a folder and create the array
function buildFilesList() {
#$1 - complete folder path
#$2 - search for type of file
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local filesNameList=$(find "${1}" -type f -iname "$2" | sort | tr -d " " | rev | cut -f1 -d "/" | rev)
		echo -e -n "$filesNameList"
	fi
}

function compareAndCopyFiles(){
#$1 - source folder
#$2 - dest folder
#$3 - files types to filter

	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local srcFolder="${1}"
		local dstFolder="${2}"
		local searchFileExtension="${3}"

		local filesArray=($(buildFilesList "$srcFolder" "${searchFileExtension}"))

		local compareFileStatus=""
		local copySelectedFiles=""

		for ((i=0; i<${#filesArray[@]}; i++))
		do
			if [[ -d "${srcFolder}" ]]; then 	# check if the source folder exist
				if [[ -f "${srcFolder}/${filesArray[i]}" ]]; then 	# check if the source file exist
					# compare source and destination folder for the file
					compareFileStatus=$( compareMachineFiles "${srcFolder}/${filesArray[i]}" "${dstFolder}/${filesArray[i]}" )
					
					# If files are "same", do nothing

					#If they are "diff", copy the file to destination
					if [ "$compareFileStatus" == "diff" ]; then
						echo -e -n " ${filesArray[i]} ${txtGrn}has changed${txtRst}. Copying to ${dstFolder}...\n"
						#cp "${srcFolder}/${filesArray[i]}" "${dstFolder}/${filesArray[i]}"
						copySelectedFiles="$copySelectedFiles ${filesArray[i]}"	
					#If the file is not present in the destination, confirm and copy the file to destination
					elif [ "$compareFileStatus" == "NoDst" ]; then
						echo -e -n " ${filesArray[i]} ${txtRed}not found${txtRst} in destination directory. Do you want to copy ? [y/n] : "

						# ------ Have commented the block temporiarily. Uncomment whenever necessary
						#stty -echo && read -n 1 copyFileOption && stty echo
						#formatYesNoOption $copyFileOption
						#
						#if [ "$( checkYesNoOption $copyFileOption )" == "yes" ]; then
						#	copySelectedFiles="$copySelectedFiles ${filesArray[i]}"
						#fi
						# ------ Have commented the block temporiarily. Uncomment whenever necessary

						echo # ------ remove this line when you uncomment the above block
					elif [ "$compareFileStatus" == "NoSrc" ]; then
						echo -e -n " Source file ${srcFolder}/${filesArray[i]} not found\n"
					#else
					#	echo -e -n " Unknown file compare status\n"
					fi
				#else
				#	echo -e -n " ${filesArray[i]} file not found in ${txtRed}Source${txtRst} directory\n"
				fi
			else
				echo -e -n " Source folder not found: $srcFolder\n"
			fi
		done

		copyFilesListToDestination "${srcFolder}" "${dstFolder}" "copySelectedFiles[@]" #IMP: notice how the array "scriptFiles" is passed as a parameter

	fi
}

function copyFilesListToDestination(){
#$1 - Source
#$2 - Destination
#$3 - FileListArray
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		local srcFolder="${1}"
		local dstFolder="${2}"
		local filesArray=("${!3}")  #IMP: notice how the array is received (which was passed as argument)

		if [[ ${#filesArray[*]} -gt 0 && ${filesArray} != "" ]]; then
			echo -e -n "\n Copying...\n"
			local j=1

			for i in ${filesArray[@]}
			do
				echo -e -n " $j. $i\n"
				cp "${srcFolder}/${i}" "${dstFolder}/${i}"
				let j=j+1
			done
			echo
		fi
	fi
}

echo -e -n ">> Checking Library Files ...\n"
sourceFolder=`echo "${libraryFolder}"`
destFolder=`echo "${gitHubFolder}/scripts/library"`
compareAndCopyFiles "${sourceFolder}" "${destFolder}" "*.*"
echo -e -n ">> Done checking Library Files\n"

echo

echo -e -n ">> Checking Script Files ...\n"
sourceFolder=`echo "${myScripts}"`
destFolder=`echo "${gitHubFolder}/scripts"`
compareAndCopyFiles "${sourceFolder}" "${destFolder}" "*.*"
echo -e -n ">> Done checking Script Files\n"

echo