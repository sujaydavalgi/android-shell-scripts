#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for configuring the machine to run the scripts
#
# Usage: ". ./library/apkOperations.sh" within other scripts

#===================================================================================================
#--- where it will store the bugreports, logcats, screenshots, pulled videos/images
if [ ! -d "$myLogs" ]; then
	`mkdir -p ${myLogs}`
fi

#--- from where it will search for the general apps
if [ ! -d "$myAppDir" ]; then
	`mkdir -p ${myAppDir}`
fi

#--- from where it will search for the @Home apps folder
if [ ! -d "$myAAHDir" ]; then
	`mkdir -p ${myAAHDir}`
	#myAAHDir="`pwd`/AAH/apps"
fi

#--- from where it will search for the ClockWorks apps folder
if [ ! -d "$myACWDir" ]; then
	`mkdir -p ${myACWDir}`
	#myACWDir="`pwd`/ACW/apps"
fi

#--- from where it will search for the Music apps folder
if [ ! -d "$myGPMDir" ]; then
	`mkdir -p ${myGPMDir}`
	#myACWDir="`pwd`/ACW/apps"
fi

#--- to backup the files from NFS directory to local storage
if [ ! -d "$myLocal" ]; then
	checkMyOsType
	if [[ "$myOS" == "linux" ]]; then
		`mkdir -p ${myLocal}`
	fi
fi
#===================================================================================================

