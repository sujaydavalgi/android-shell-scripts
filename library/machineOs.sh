#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions library for machine OS related functions
#
# Usage: ". ./library/machineOs.sh" within other scripts

#===================================================================================================

#. ./library/textFormatting.sh

#===================================================================================================

#----- Detect the OS platform
function checkMyOsType() {
#$return - 
	myOS=`toLowercase \`uname\``
	myOsKERNEL=`uname -r`
	myOsMACH=`uname -m`

	if [ "$myOS" == "windowsnt" ]; then
		myOS="windows"
	elif [ "$myOS" == "darwin" ]; then
		myOS="mac"
	else
		myOS=`uname`

		if [ "$myOS" = "SunOS" ]; then
			myOS="Solaris"
			ARCH=`uname -p`
			OSSTR="$myOS ${myOsREV}(${ARCH} `uname -v`)"
		elif [ "$myOS" = "AIX" ]; then
			OSSTR="$myOS `oslevel` (`oslevel -r`)"
		elif [ "$myOS" = "Linux" ] ; then
			if [ -f /etc/redhat-release ]; then
				myOsDistroBasedOn='RedHat'
				myOsDIST=`cat /etc/redhat-release |sed s/\ release.*//`
				myOsPSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
				myOsREV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
			elif [ -f /etc/SuSE-release ]; then
				myOsDistroBasedOn='SuSe'
				myOsPSUEDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
				myOsREV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
			elif [ -f /etc/mandrake-release ]; then
				myOsDistroBasedOn='Mandrake'
				myOsPSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
				myOsREV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
			elif [ -f /etc/debian_version ] ; then
				myOsDistroBasedOn='Debian'
				if [ -f /etc/lsb-release ]; then
			        	myOsDIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
					myOsPSUEDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
					myOsREV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
        			fi
			fi

			if [ -f /etc/UnitedLinux-release ]; then
				myOsDIST="${myOsDIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
			fi

			myOS=`toLowercase $myOS`
			myOsDistroBasedOn=`toLowercase $myOsDistroBasedOn`
			readonly myOS
			readonly myOsDIST
			readonly myOsDistroBasedOn
			readonly myOsPSUEDONAME
			readonly myOsREV
			readonly myOsKERNEL
			readonly myOsMACH
		fi
	fi
}

#----- Display the OS details
function displayOsType() {
#$return - 
	checkMyOsType

	echo "OS: $myOS"
	echo "DIST: $myOsDIST"
	echo "PSUEDONAME: $myOsPSUEDONAME"
	echo "REV: $myOsREV"
	echo "DistroBasedOn: $myOsDistroBasedOn"
	echo "KERNEL: $myOsKERNEL"
	echo "MACH: $myOsMACH"
}

function getMyOs() {
#$return - 
	checkMyOsType
	echo -e -n $myOS
}

function getMyDist() {
#$return - 
	checkMyOsType
	echo -e -n $myOsDIST
}

function getMyPsuedoname() {
#$return - 
	checkMyOsType
	echo -e -n $myOsPSUEDONAME
}

function getMyRev() {
#$return - 
	checkMyOsType
	echo -e -n $myOsREV
}

function getMyDistroBasedOn() {
#$return - 
	checkMyOsType
	echo -e -n $myOsDistroBasedOn
}

function getMyKernel() {
#$return - 
	checkMyOsType
	echo -e -n $myOsKERNEL
}

function getMyMach() {
#$return - 
	checkMyOsType
	echo -e -n $myOsMACH
}