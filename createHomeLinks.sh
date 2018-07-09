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

if [ -d "${myShellScripts}" ]; then
	if [ -f "${myShellScripts}/*.*~" ]; then
		 find ${myShellScripts}/*.*~ -delete
	fi
fi

presentDirectory=`pwd`
homeFolder=`echo ~`

if [ ! -d  "${myShellScripts}" ] & [ "${presentDirectory}" != "${homeFolder}" ]; then
	myShellScripts="${presentDirectory}"
fi

chmod +x "${myShellScripts}"/*.sh

ln -s "${myShellScripts}"/*.sh ~/
ln -s "${myShellScripts}/mySetup.txt" ~/
ln -s "${myShellScripts}/library" ~/library