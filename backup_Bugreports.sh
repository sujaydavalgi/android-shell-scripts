#!/bin/bash

# Created by Sujay Davalgi
#
# Backup the Bugreport & Screenshot files from NAS drive folder to local HDD folder
#
# Usage: ./backup_Bugreports.sh

. ./library/mainFunctions.sh
. ./library/textFormatting.sh

if [ "$myLogs" == "$myLocal" ]; then
	echo -e " You are already using the local drive. No need to backup\n"
else
	if [ "$(ls $myLogs)" ]; then
		echo -e "\n Moving From : $myLogs"
		echo -e " Moving To   : $myLocal"
		echo -e -n "\n Started moving..."

		mv `echo $myLogs/`* `echo $myLocal/`

		echo -e "${txtGrn}${txtBld} Done ${txtRst}\n"
	else
		echo -e "\n There are no files in the folder $myLogs\n"
	fi
fi