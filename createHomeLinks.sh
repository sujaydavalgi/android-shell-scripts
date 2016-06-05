#!/bin/bash

#  
# Created by Sujay Davalgi
#
# Creates a symbolic links for all the scripts in the folder, in the home folder
# If there are any existing symbolic link files for the scripts, it will delete and create the new one
#
# Usage: ./createHomeLinks.sh

. ./library/mySetup.txt

#rm -rf ~/*.sh
find ~/*.sh -maxdepth 1 -delete
#find -L ~/*.sh
find ~/mySetup.txt -maxdepth 1 -delete
find ~/library -maxdepth 1 -delete

if [ -d "${myScripts}" ]; then
	if [ -f "${myScripts}/*.*~" ]; then
		 find ${myScripts}/*.*~ -delete
	fi
fi

presentDirectory=`pwd`
homeFolder=`echo ~`

if [ ! -d  "${myScripts}" ] & [ "${presentDirectory}" != "${homeFolder}" ]; then
	myScripts="${presentDirectory}"
fi

chmod +x "${myScripts}"/*.sh

ln -s "${myScripts}"/*.sh ~/
ln -s "${myScripts}/mySetup.txt" ~/
ln -s "${myScripts}/library" ~/library