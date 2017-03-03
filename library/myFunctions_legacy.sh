#!/bin/bash

# Created by Sujay Davalgi
#
# {legacy} Common functions-library for other scripts {legacy}
#
# Usage: ".  ./library/myFunctions_legacy.sh" within other scripts

#===========================================================================================================================================

deviceSerial=""
#build=""
#choice=""
#bgName=""
#cmd=""
#opt=""

fileName="test"

appInstallPath=""
RecordFolder="/sdcard"
SearchForFile="*.*"
devicedeviceCameraFolder="/sdcard/DCIM/Camera"

nowTime=$(date +'%H%M%S')
nowDate=$(date +'%Y%m%d')
nowDateTime=$(date +'%Y%m%d%H%M%S')

#declare -r TRUE=0
#declare -r FALSE=1

#===========================================================================================================================================

. mySetup.txt

#===========================================================================================================================================
#----- Convert all the supplied string to lowercase
function lowercase() {
# $1 - takes the input string to be converted to lowercase
	echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

#----- Detect the OS platform
function checkMyOsType() {
	myOS=`lowercase \`uname\``
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

			myOS=`lowercase $myOS`
			myOsDistroBasedOn=`lowercase $myOsDistroBasedOn`
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

	checkMyOsType

	echo "OS: $myOS"
	echo "DIST: $myOsDIST"
	echo "PSUEDONAME: $myOsPSUEDONAME"
	echo "REV: $myOsREV"
	echo "DistroBasedOn: $myOsDistroBasedOn"
	echo "KERNEL: $myOsKERNEL"
	echo "MACH: $myOsMACH"
}
#===========================================================================================================================================
#------------ to change the text COLOR
txtRed=$(tput setaf 1) # Red
txtGrn=$(tput setaf 2) # Green
txtYlw=$(tput setaf 3) # Yellow
txtBlu=$(tput setaf 4) # Blue
txtPur=$(tput setaf 5) # Purple
txtCyn=$(tput setaf 6) # Cyan
txtWht=$(tput setaf 7) # White
txtRst=$(tput sgr0)    # Reset all attributes

#------------ to change the text BACKGROUND
bgRed=$(tput setab 1) # Red
bgGrn=$(tput setab 2) # Green
bgYlw=$(tput setab 3) # Yellow
bgBlu=$(tput setab 4) # Blue
bgPur=$(tput setab 5) # Purple
bgCyn=$(tput setab 6) # Cyan
bgWht=$(tput setab 7) # White

#------------ to change the text MODE
txtBld=$(tput bold)   # Set Bold mode
txtDim=$(tput dim)    # Turn-On half-bright mode
txtSul=$(tput smul)   # start underline mode
txtEul=$(tput rmul)   # end underline mode
txtRev=$(tput rev)    # Turn-On reverse mode
txtSmso=$(tput smso)  # enter standout mode
txtRmso=$(tput rmso)  # exit standout mode
txtBlnk=$(tput blink) # blink the text

function pbold() {
# $@ - takes all the input strings passed
	#tput bold
	echo -n -e ${txtBld} $@ ${txtRst}
	#tput sgr0
}

function txtBlink() {
# $@ - takes all the input strings passed
	echo -n -e "\033[5m$@\033[0m"
	tput blink
	echo -n -e "$@"
	tput sgr0
}

#------------ Clear and Insert Capabilities
clrscr=$(tput clear)  # clear screen and home cursor
clrescr=$(tput ed)    # clear to end of screen
clreln=$(tput el)     # clear to end of line
clrsln=$(tput el1)    # clear to begining of lines

function eraseCharN() {
# $1 - takes the number of characters to be erased
	tput ech "$1"     # Erase N characters
}

function insertCharN() {
# $1 - takes the number of characters to be inserted
	tput ich "$1"     # insert N characters (moves rest of line forward!)
}

function insertLnN() {
# $1 - takes the number of lines to be inserted
	tput il "$1"      # insert N lines
}

#------------ Cursor Movement Capabilities
curPosSav=$(tput sc)   # Save the cursor position
curPosRes=$(tput rc)   # Restore the cursor position
terNumLn=$(tput lines) # Output the number of lines of the terminal
terNumCl=$(tput cols)  # Output the number of columns of the terminal
curMovLft=$(tput cub1) # move left one space
curMovRgt=$(tput cuf1) # non-destructive space (move right one space)
curLstLn=$(tput ll)    # last line, first column (if no cup)
curUpLn=$(tput cuu1)   # up one line

function curGoToXY() {
# $1 - X position
# $2 - Y position
	tput cup "$2" "$1" # Move cursor to screen location X,Y (top left is 0,0)
}

function curMovLftN() {
# $1 - takes the number of characters to move left
	tput cub "$1"      # Move N characters left
}

function curMovRgtN() {
# $1 - takes the number of characters to move right
	tput cuf "$1"      # Move N characters right
}

#examples to use text color modes
#echo “Welcome to ${txtRed} www.google.com ${txtRst}!”
#===========================================================================================================================================
#--- where it will store the bugreports, logcats, screenshots, pulled videos/images
#myLogs=`echo ~/android/bugs`
if [ ! -d "$myLogs" ]; then
	`mkdir -p ${myLogs}`
fi

#--- from where it will search for the general apps
#myAppDir=`echo ~/android/apps`
if [ ! -d "$myAppDir" ]; then
	`mkdir -p ${myAppDir}`
fi

#--- from where it will search for the @Home apps folder
#myAAHDir=`echo ~/android/AAH/apps`
if [ ! -d "$myAAHDir" ]; then
	`mkdir -p ${myAAHDir}`
	#myAAHDir="`pwd`/AAH/apps"
fi

#--- from where it will search for the ClockWorks apps folder
#myACWDir=`echo ~/android/ACW/apps`
if [ ! -d "$myACWDir" ]; then
	`mkdir -p ${myACWDir}`
	#myACWDir="`pwd`/ACW/apps"
fi

#--- to backup the files from NFS directory to local storage
#myLocal="/usr/local/google/users/<username>/android/bugs"
if [ ! -d "$myLocal" ]; then
	checkMyOsType
	if [[ "$myOS" == "linux" ]]; then
		`mkdir -p ${myLocal}`
	fi
fi
#===========================================================================================================================================
#----- format entered option
function formatYesNoOption() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to formatYesNoOption()"
		exit 1
	else
#		if [[ "$1" == [yY] || "$1" == [yY][eE][sS] ]]; then
#			echo -e "${txtGrn}${txtBld}$1${txtRst}"
#		elif [[ "$1" == [nN] || "$1" == [nN][oO] ]]; then
#			echo -e "${txtRed}${txtBld}$1${txtRst}"
#		fi

		case "$1" in
			[yY]|[yY][eE][sS])
				echo -e "${txtGrn}${txtBld}$1${txtRst}"
				;;
			[nN]|[nN][oO])
				echo -e "${txtRed}${txtBld}$1${txtRst}"
				;;
		esac
	fi
}
#===========================================================================================================================================
#----- build the array for list of devices recognised in "ADB / Fastboot"
function buildDeviceSnArray() {
	#----------------^^^^ Legacy code ^^^^--------------
	#	# Build an array of connected devices by serial number
	#	adbDEVICES="$( adb devices )"
	#	adbDEVICES=${adbDEVICES:25}
	#	if [[ $adbDEVICES != "" ]]; then
	#		adbDEVICES=${adbDEVICES//device}
	#		DEVICE_ARRAY=( $adbDEVICES )
	#		DEVICE_COUNT=${#DEVICE_ARRAY[*]}
	#	else
	#		echo -e "\n${txtWht}${txtBld}${bgRed} There are no devices attached to USB.${txtRst}\n"
	#		exit
	#	fi
	#----------------^^^^ Legacy code ^^^^--------------

	local let i=0
	local line
	
	# build the array of device serial and its status, which are in adb mode
	while read line
	do
		# $1 - the device serial number
		# $2 - the status: device/fastboot/recovery/offline/unauthorized
		adbDEVICEstatus="`echo $line | awk '{print $2}' `"

#		if [ -n "$line" ] && [[ "$adbDEVICEstatus" == "device" || "$adbDEVICEstatus" == "recovery" || "$adbDEVICEstatus" == "unauthorized" || "$adbDEVICEstatus" == "offline" ]]
#       then
#            adbDEVICEsn="`echo $line | awk '{print $1}' `"
#            DEVICE_ARRAY[i]="$adbDEVICEsn"
#            if [[ "$adbDEVICEstatus" == "device" ]]; then
#                DEVICE_ARRAY_STATUS[i]=`echo "adb"`
#            else
#                DEVICE_ARRAY_STATUS[i]="$adbDEVICEstatus"
#            fi
#            let i=$i+1
#		fi

        if [ -n "$line" ]
        then
            case "$adbDEVICEstatus" in
                "device"|"recovery"|"unauthorized"|"offline")
                    adbDEVICEsn="`echo $line | awk '{print $1}' `"
                    DEVICE_ARRAY[i]="$adbDEVICEsn"
                    if [[ "$adbDEVICEstatus" == "device" ]]; then
                        DEVICE_ARRAY_STATUS[i]=`echo "adb"`
                    else
                        DEVICE_ARRAY_STATUS[i]="$adbDEVICEstatus"
                    fi
                    let i=$i+1
            esac
        fi

	done < <(adb devices)

	# build the array of device serial and its status, which are in fastboot mode
	while read line
	do
		# $1 - the device serial number
		# $2 - the status: device/fastboot/recovery/offline/unauthorized
		fastbootDEVICEstatus="`echo $line | awk '{print $2}' `"
		if [ -n "$line" ] && [ "$fastbootDEVICEstatus" == "fastboot" ]
		then
			adbDEVICEsn="`echo $line | awk '{print $1}' `"
			DEVICE_ARRAY[i]="$adbDEVICEsn"
			DEVICE_ARRAY_STATUS[i]="$fastbootDEVICEstatus"
			let i=$i+1
		fi
	done < <(fastboot devices)
	
	DEVICE_COUNT=${#DEVICE_ARRAY[*]}
}

#----- append the build info of each devices in the list
function appendBuildInfo() {
# $1 - device serial number
# Append the build info (at display time)
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to appendBuildInfo()"
		exit 1
	else
		BUILD_INFO="$( adb -s $1 wait-for-device shell getprop ro.build.description )"
		#echo -e "$LIST_ID""$1" "\t" "$BUILD_INFO"
		echo -e -n "$BUILD_INFO"
	fi
}

#----- display the list of devices
function displayDeviceList() {
	echo ""

	local let i=0
	local let j=0

	#----------------^^^^ Legacy code ^^^^--------------
	#	DEVICE_CHOICE_NUMBER=1
	#	for i in ${DEVICE_ARRAY[@]}
	#		do
	#			LIST_ID="${DEVICE_CHOICE_NUMBER}."
	#			#DEVICE_SN=$i
	#			#getDeviceName $DEVICE_SN
	#			#appendBuildInfo $DEVICE_SN   #<----- Uncomment this line and comment the next line, if you want to display the build info
	#			#echo -e "$LIST_ID$deviceName\t$i"       #<----- Comment this line and uncomment the previous line if you want to display the device name
	#			echo -e " $LIST_ID $i"
	#			let "DEVICE_CHOICE_NUMBER = $DEVICE_CHOICE_NUMBER + 1"
	#		done
	#----------------^^^^ Legacy code ^^^^--------------

	for (( i=0; i<$DEVICE_COUNT; i++ ))
	do
		let j=$i+1
		echo -e -n " $j. ${DEVICE_ARRAY[i]}"

#		if [[ "${DEVICE_ARRAY_STATUS[i]}" == "recovery" || "${DEVICE_ARRAY_STATUS[i]}" == "fastboot" || "${DEVICE_ARRAY_STATUS[i]}" == "offline" || "${DEVICE_ARRAY_STATUS[i]}" == "unauthorized"  ]];then
#			echo  -e -n " - ${txtBld}${txtRed}${DEVICE_ARRAY_STATUS[i]}${txtRst}"
#		fi

        case "${DEVICE_ARRAY_STATUS[i]}" in
            "recovery"|"fastboot"|"offline"|"unauthorized")
                echo  -e -n " - ${txtBld}${txtRed}${DEVICE_ARRAY_STATUS[i]}${txtRst}"
                ;;
        esac

		echo ""
	done
}

#----- check if the item # for the device selection was valid
function checkDeviceChoiceValidity() {
# $1 - takes the choice number entered
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to checkDeviceChoiceValidity()"
		exit 1
	else
		if echo "$1" | grep "^[0-9]*$">aux; then

			if [[ "$1" -gt "$DEVICE_COUNT" || "$1" -lt "1" ]]; then
				echo -e " ${txtBld}Dude '$1' is not a device in this list and you know it. Come on.${txtRst}"
				#exit
				getDeviceChoice
			else
				DEVICE_ARRAY_INDEX="$1"
				let "DEVICE_ARRAY_INDEX = $DEVICE_ARRAY_INDEX - 1"
			fi
		else
			echo -e " ${txtBld}Come on Dude, pick a number. '$1' is not a number.${txtRst}"
			getDeviceChoice
		fi
	fi
}

#----- read the item # from the device list
function getDeviceChoice() {

	buildDeviceSnArray
	
	local DEVICE_CHOICE="0"

	if [ $DEVICE_COUNT -gt 0 ]; then

		if [ $DEVICE_COUNT -gt 1 ]; then #<-- if there are more than 1 device
			displayDeviceList
			echo -e -n "\n${txtBld} Enter Choice : ${txtRst}"
			read DEVICE_CHOICE;
			checkDeviceChoiceValidity $DEVICE_CHOICE

			deviceSerial=${DEVICE_ARRAY[${DEVICE_ARRAY_INDEX}]}
	
		else  #<-- if there is only 1 device connected
			echo -e "\n${txtYlw} There is only 1 device connected to the USB.${txtRst}"
		 	deviceSerial=${DEVICE_ARRAY[0]}      
		fi
				
	else #<-- if the device count is less than zero, i.e., there is no device connected
		echo -e "\n${txtRed} There are no devices connected to the USB.${txtRst}\n"
		exit 1
	fi
}
#===========================================================================================================================================
#----- Get the device Name
function getDeviceName() {
#$1 - device serial number
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to getDeviceName()"
		exit 1
	else
		#local deviceName=`adb -s $1 wait-for-device shell getprop ro.product.name | tr -d "\r\n"`
		#echo -e -n $deviceName
		echo -e -n `adb -s $1 wait-for-device shell getprop ro.product.name | tr -d "\r\n"`
	fi
}

#----- Get the Device Build
function getDeviceBuild() {
#$1 - device serial number
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to getDeviceBuild()"
		exit 1
	else
		local deviceBuild=`adb -s $1 wait-for-device shell getprop ro.build.description | cut -f3 -d" " | tr -d "\r\n"`

		if [ "$deviceBuild" == "MASTER" ]; then 
			deviceBuildNo=`adb -s $1 wait-for-device shell getprop ro.build.description | cut -f4 -d" " | tr -d "\r\n"`
			deviceBuild="$deviceBuild"-"$deviceBuildNo"
		fi
		
		echo -e -n "$deviceBuild"
	fi
}

function getDeviceBuildType() {
# $1 - device serial number
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to getDeviceBuild()"
		exit 1
	else
		local deviceBuildType=`adb -s $1 wait-for-device shell getprop ro.build.description | cut -d " " -f 1 | cut -d "-" -f 2 | tr -d "\r\n"`
		echo -e -n "$deviceBuildType"
	fi
}

function getDeviceKeys() {
#$1 - device serial number
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to getDeviceBuild()"
		exit 1
	else
		local deviceKeys=`adb -s $1 wait-for-device shell getprop ro.build.description | rev | cut -f1 -d" " | rev | tr -d "\r\n"`
		echo -e -n "$deviceKeys"
	fi
}

#----- Display the selected Device details
function displaySelectedDevice() {
#$1 - device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to displaySelectedDevice()"
		exit 1
	else
		if [[ "$( isDeviceOffline $1 )" == "true" || "$( isDeviceUnauthorized $1 )" == "true" ]]; then
			echo " Device is offline/Unauthorised. Cannot do anything with it"
			exit 1
		else
		
			echo -e -n "\n Selected device : ${txtCyn}$1"
		
			if [ "$( isAdbDevice $1 )" == "true" ]; then
				deviceName="$( getDeviceName $1 )"
				deviceBuild="$( getDeviceBuild $1 )"
				echo -e "${txtRst} - ${txtBld}${txtPur}$deviceName ($deviceBuild)${txtRst}\n"
			else
				echo -e "${txtRst}\n"
			fi
			
			echo -e " $( date ) ($nowTime)\n"
		fi
	fi
}
#===========================================================================================================================================
function buildIpAddress() {
#$1 - device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to buildIpAddress()"
		exit 1
	else
		local let i=0
		local line

		isWifiUp="false"
		isWifiIP="false"
		wifiIP="0.0.0.0"
		isEthUp="false"
		isEthIP="false"
		ethIP="0.0.0.0"

		while read line
		do
			interface="`echo $line | awk '{print $1}'`"
			upDown="`echo $line | awk '{print $2}'#`"
			ipAddress="`echo $line | awk '{print $3}' | cut -d"/" -f1`"
			ipPort="`echo $line | awk '{print $3}' | cut -d"/" -f2`"

			#echo -e -n "$interface - $upDown - $ipAddress - $ipPort - $ipAddress\n"

			if [[ "$interface" == "wlan0" && "$upDown" == "UP" ]]; then
				isWifiUp="true"
			elif [[ "$interface" == "wlan0" && "$upDown" == "DOWN" ]]; then
				isWifiUp="false"
			fi

			if [[ "$interface" == "wlan0" && "$ipAddress" != "0.0.0.0" && "$ipAddress" != "127.0.0.1" ]]; then
				isWifiIP="true"
				wifiIP="$ipAddress"
				wifiPort="$ipPort"
			fi

			if [[ "$interface" == "eth0" && "$upDown" == "UP" ]]; then
				isEthUp="true"
			elif [[ "$interface" == "eth0" && "$upDown" == "DOWN" ]]; then
				isEthUp="false"
			fi

			if [[ "$interface" == "eth0" && "$ipAddress" != "0.0.0.0" && "$ipAddress" != "127.0.0.1" ]]; then
				isEthIP="true"
				ethIP="$ipAddress"
				ethPort="$ipPort"
			fi

		done < <(adb -s $1 wait-for-device shell netcfg)
    fi
}

#---- Check if WiFi is UP and Connected
function checkWifi() {
	if [[ "$isWifiIP" == "true" && "$isWifiUp" == "true" ]]; then
		echo "true"
	else
		echo "false"
	fi
}

#---- Check if Ehternet is UP and Connected
function checkEth() {
	if [[ "$isEthIP" == "true" && "$isEthUp" == "true" ]]; then
		echo "true"
	else
		echo "false"
	fi
}

#---- Check if the connectiong is Ehternet/WiFi/Both/None
function checkEthWifi(){
#$1 - device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to checkEthWifi()"
		exit 1
	else
		buildIpAddress $1

		if [[ "$( checkWifi )" == "true" && "$( checkEth )" == "true" ]]; then
			echo "Both"
		elif [[ "$( checkWifi )" == "true" && "$( checkEth )" == "false" ]]; then
			echo "WiFi"
		elif [[ "$( checkWifi )" == "false" && "$( checkEth )" == "true" ]]; then
			echo "Ethernet"
		elif [[ "$( checkWifi )" == "false" && "$( checkEth )" == "false" ]]; then
			echo "None"
		fi

#        case

	fi
}

#---- Get the IP address if connected
function getMyIP() {
#$1 - device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to buildIpAddress()"
		exit 1
	else
		buildIpAddress $1

#		if [[ "$( checkEthWifi $1 )" == "Both" ]]; then
#			echo "$ethIP"
#		elif [[ "$( checkEthWifi $1 )" == "WiFi" ]]; then
#			echo "$wifiIP"
#		elif [[ "$( checkEthWifi $1 )" == "Ethernet" ]]; then
#			echo "$ethIP"
#		elif [[ "$( checkEthWifi $1 )" == "None" ]]; then
#			echo "None"
#		fi

        case "$( checkEthWifi $1 )" in
            "Both")
                echo "$ethIP"
                ;;
            "WiFi")
                echo "$wifiIP"
                ;;
            "Ethernet")
                echo "$ethIP"
                ;;
            "None")
                echo "None"
                ;;
        esac
	fi
}
#===========================================================================================================================================
#----- file name format
function getFormatedFileName() {
#$1 is device serial number
#$2 is filename
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to getFormatedFileName()"
		exit 1
	else
		#deviceName="$( getDeviceName $1)"
		#deviceBuild="$( getDeviceBuild $1)"
		#echo -e -n "${deviceName}_${deviceBuild}_${1}_${2}_${nowTime}"
		#echo -e -n "$deviceName_$deviceBuild_$1_$2_$nowTime"
		#echo -e -n "$( getDeviceName $1)_$( getDeviceBuild $1)_${1}_${2}_${nowTime}"

        if [ "$( isGoogleDevice $1 )" == "true" ]; then
            echo -e -n "$( getDeviceName $1)_$( getDeviceBuild $1)_${2}_${nowTime}"
        else
            echo -e -n "${2}_${nowTime}"
        fi
	fi
}
#===========================================================================================================================================
function takeBugreport() {
#$1 is device serial number
#$2 is filename
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to takeBugreport()"
		exit 1
	else
		adb -s "$1" wait-for-device bugreport > `echo ${myLogs}/`${2}.txt
	fi
}

function saveLogcat() {
#$1 is device serial number
#$2 is filename
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to saveLogcat()"
		exit 1
	else
		adb -s "$1" logcat -v threadtime | tee `echo ${myLogs}/`${2}-logcat.txt
	fi
}

function takeScreenshot() {
#$1 is device serial number
#$2 is filename
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to takeScreenshot()"
		exit 1
	else
		adb -s "$1" wait-for-device shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > `echo ${myLogs}/`${2}.png
	fi
}

function recordDeviceVideo() {
#$1 is device serial number
#$2 is foldername
#$3 is filename
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 3 argument passed to recordDeviceVideo()"
		exit 1
	else
		adb -s "$1" wait-for-device shell "screenrecord --verbose --bit-rate 4000000 ${2}/${3}.mp4" # <- 4 Mbps
		#adb -s $1 wait-for-device shell "screenrecord --verbose --bit-rate 8000000 $2/${3}.mp4" # <- 8 Mbps
	fi
}

function writeToLogsFile() {
#$1 - Message to write
	if [ $# -lt 1 ]; then
		echo -e -n "@@ No argument passed to writeToLogsFile()" >> "$myScriptLogsFile"
		exit 1
	else
		if [ ! -d "$myScriptLogsDir" ]; then
			mkdir -p "$myScriptLogsDir"
		fi

		if [ ! -f "$myScriptLogsFile" ]; then
			touch "$myScriptLogsFile"
		fi

		#echo -e -n "\n********** Please check the log file for more info ********** \n\n"

		echo -e -n "********** $nowTime ********** \n" >> "$myScriptLogsFile"
		echo -e -n "$1\n" >> "$myScriptLogsFile"
	fi

	echo -e -n "\n" >> "$myScriptLogsFile"
}
#===========================================================================================================================================
#----- Check if the folder exist in the base folder for the specified sub-folder
function checkSubFolder() {
#$1 - main folder absolute path
#$2 - subfolder
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to checkBuild()"
		exit 1
	else
	#----------------^^^^ Legacy code ^^^^--------------
		#cd $1
		#buildIs=`echo "${2^^}"`
		#buildIs="$2"
	#----------------^^^^ Legacy code ^^^^--------------
	
		if [ -d "$1/$2" ]; then
		#echo -e " ${txtBld}$2${txtRst} folder exists in $1 ...\n"
		#----------------^^^^ Legacy code ^^^^--------------
			#cd $2
		#----------------^^^^ Legacy code ^^^^--------------
			appInstallPath="$appInstallPath/$2"
		else
			local useDefaultFolderOption
			
			echo -e -n " ${txtBld}$2${txtRst} folder doesnot exists in $1 ...\n\n Do you want to install from ${txtPur}${txtBld}$1${txtRst} instead [y/n]: "
			stty -echo && read -n 1 useDefaultFolderOption && stty echo
			formatYesNoOption $useDefaultFolderOption

			case "$useDefaultFolderOption" in
				[yY]|[yY][eE][sS])
					echo ""
					;;
				[nN]|[nN][oO])
					echo ""
					exit 1
					;;
			esac
		fi
	fi
}
#===========================================================================================================================================
#----- build the array for list of files
function buildDeviceFilesArray() {
#$1 device serial number
#$2 folder to search in device
#$3 type of file to search in the folder
	#----------------^^^^ Legacy code ^^^^--------------
	#	if [ $# -lt 1 ]; then
	#		writeToLogsFile "@@ No argument passed to buildDeviceFilesArray()"
	#		exit 1
	#	else
	#		if [ $# -lt 2 ]; then
	#			writeToLogsFile "@@ No 2nd argument (SearchForFile string) passed to buildDeviceFilesArray()"
	#			exit 1
	#		else
	#			deviceFiles="$( adb -s $deviceSerial wait-for-device shell ls "$1/$2" | tr -d '\r')"
	#			
	#			foundMP4=`echo $deviceFiles | grep -c "*.mp4"`
	#			foundJPG=`echo $deviceFiles | grep -c "*.jpg"`
	#			if [[ -n "$deviceFiles" || $deviceFiles != "" ]] && [[ $foundMP4 = 0 && $foundJPG = 0 ]]
	#			then
	#				deviceFiles_array=( $deviceFiles )
	#				deviceFiles_count=${#deviceFiles_array[*]}
	#			else
	#				echo -e " There are no $2 files in the folder : $1\n"
	#				exit
	#			fi
	#		fi
	#	fi
	#----------------^^^^ Legacy code ^^^^--------------
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to buildDeviceFilesArray()"
		exit 1
	else
		local i=0
		local foundMP4=0
		local foundJPG=0
		deviceFiles_count=0

		while read files
		do
			foundMP4=`echo $files | grep -c "*.mp4"`
			foundJPG=`echo $files | grep -c "*.jpg"`
			if [ -n "$files" ] && [[ $foundMP4 = 0 && $foundJPG = 0 ]]
			then
				deviceFiles_array[i]="$files"
				let i=$i+1
			fi
			
		done < <( adb -s $1 shell ls "$2/$3" | tr -d '\r' )

		deviceFiles_count=${#deviceFiles_array[*]}

	#	if [ $deviceFiles_count -lt 1 ]; then
	#		echo -e " There are no $2 files in the folder : $1\n"
	#		exit
	#	fi
	fi
}

#----- display the list of files in device
function displayDeviceFileList() {

	local let DEVICE_FILE_CHOICE_NUMBER=1
	local let i=0
	
	for i in ${deviceFiles_array[@]}
	do
		DEVICE_FILE_LIST_ID="${DEVICE_FILE_CHOICE_NUMBER}"." "
		echo -e " $DEVICE_FILE_LIST_ID$i"
		let "DEVICE_FILE_CHOICE_NUMBER = $DEVICE_FILE_CHOICE_NUMBER + 1"
	done
}

#----- check if the item # for the file selection was valid
function checkDeviceFileChoiceValidity() {

	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to checkDeviceFileChoiceValidity()"
		exit 1
	else
		if echo $1 | grep "^[0-9]*$">aux; then
			let "deviceFiles_count=$deviceFiles_count+1"
			if [ "$1" -gt "$deviceFiles_count" ]; then
				echo -e "Dude" $1 "is not a file in this list and you know it. Come on."		
				exit
			else
				DEVICE_FILE_ARRAY_INDEX=$1
				let "DEVICE_FILE_ARRAY_INDEX = $DEVICE_FILE_ARRAY_INDEX - 1"
			fi
		else
			echo -e "Come on Dude. Pick a number."
			exit		  
		fi
	fi
}

#----- read the item # from the device file list
function getDeviceFileChoice() {
#$1 device serial number
#$2 folder to search in device
#$3 type of file to search in the folder
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 3 argument passed to getDeviceFileChoice()"
		exit 1
	else
		deviceFileSelected=""
		buildDeviceFilesArray $1 $2 $3

		if [ $deviceFiles_count -gt 0 ]; then
			if [ $deviceFiles_count -gt 1 ]; then #<-- if there are more than 1 file
				displayDeviceFileList
				echo -e -n "\n ${txtBld}Enter Choice : ${txtRst}"
				read DEVICE_FILE_CHOICE;
				checkDeviceFileChoiceValidity $DEVICE_FILE_CHOICE
				deviceFileSelected=${deviceFiles_array[${DEVICE_FILE_ARRAY_INDEX}]}	
			else  #<-- if there is only 1 file connected
				echo -e -n "${txtYlw} There is only 1 file${txtRst} : ${deviceFiles_array[0]}\n"
				echo -e -n " Do you want to pull it ? [y/n] : "
				stty -echo && read -n 1 searchNpullDeviceFilesFrmFldrOption && stty echo
				formatYesNoOption $searchNpullDeviceFilesFrmFldrOption

				case "$searchNpullDeviceFilesFrmFldrOption" in
					[yY]|[yY][eE][sS])
						deviceFileSelected=${deviceFiles_array[0]}
						;;
					[nN]|[nN][oO]|*)
						echo " "
						;;
				esac

			fi
		else #<-- if the file count is less than zero, i.e., there is no files
					echo -e " ${txtRed}${txtBld}There are no $2 files in the device directory :${txtRst} ${1}\n"
					exit 1
		fi
	fi
}

function searchNpullDeviceFilesFrmFldr() {
#$1 device serial number
#$2 folder to search in device
#$3 type of file to search in the folder
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 3 arguments passed to searchNpullDeviceFilesFrmFldr()"
		exit 1
	else
		getDeviceFileChoice $1 ${2} ${3}

		if [ "$deviceFileSelected" != "" ]; then
			echo -e "\n Selected file : ${txtCyn}${deviceFileSelected}${txtRst}\n It will be saved in : ${txtPur}${myLogs}${txtRst}\n"
			adb -s "$1" wait-for-device pull "${deviceFileSelected}" "${myLogs}" >/dev/null 2>&1
		fi
	fi
}
#===========================================================================================================================================
#----- build the array for list of files
function buildMachineFilesArray() {
#$1 - main folder absolute path
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to buildFilesArray()"
		exit 1
	else
		machineFiles=""
		machineFiles_count=0
		
		machineFiles="$( ls -F "$1" | grep -v "\/" | tr -d '\r' | tr -d '*')"
		if [[ $machineFiles != "" || -n $machineFiles ]]; then
			machineFiles_array=( $machineFiles )
			machineFiles_count=${#machineFiles_array[*]}
#		else
#			echo -e -n "\n${txtRed} There are no files in the directory :${txtRst} $1\n"
#			exit 1
		fi
	fi
}

#----- build the list of files to install
function buildMachineInstallFileArray() {
	local i=0
	local installAppsSelected=""
	local installAppOption="n"
	
	for i in ${machineFiles_array[@]}
	do
		echo -e -n " Do you want to install [y/n] - $i : "
		stty -echo && read -n 1 installAppOption && stty echo
		formatYesNoOption $installAppOption

		case "$installAppOption" in
			[yY]|[yY][eE][sS])
				installAppsSelected="$installAppsSelected $i"
				;;
		esac

	done
	
	installApps_Array=( $installAppsSelected )
	installApps_Count=${#installApps_Array[*]}
}

#----- read the item # from the device file list
function installMachineFiles() {
#$1 - device serial
#$2 - main folder absolute path
#$3 - sub folder
	if [ $# -lt 3 ]; then
		writeToLogsFile "@@ No 3 arguments passed to installMachineFileChoice()"
		exit 1
	else	
		appInstallPath=$2
		checkSubFolder $2 $3
        #----------------^^^^ Legacy code ^^^^--------------
		#buildIs=`echo "${2^^}"`
        #----------------^^^^ Legacy code ^^^^--------------
		buildMachineFilesArray "$appInstallPath"

		if [ $machineFiles_count -gt 0 ]; then
			if [ $machineFiles_count -gt 1 ]; then #<-- if there are more than 1 file
				buildMachineInstallFileArray
				
				for i in ${installApps_Array[@]}
				do
					echo -e -n " \nInstalling - $i ... \n"
					adb -s $1 wait-for-device install -r "$appInstallPath/$i"
				done
			else  #<-- if there is only 1 file
				local installAppOption="n"
				echo -e -n "${txtYlw} There is only 1 file in :${txtRst} $appInstallPath\n"
			 	echo -e -n " Do you want to install [y/n] - ${machineFiles_array[0]} : "
				stty -echo && read -n 1 installAppOption && stty echo
				formatYesNoOption $installAppOption

				case "$installAppOption" in
					[yY]|[yY][eE][sS])
						adb -s $1 wait-for-device install -r "$appInstallPath/${machineFiles_array[0]}"
						;;
				esac
			fi
			
			echo ""
		else #<-- if the file count is less than zero, i.e., there is no files
			echo -e "${txtRed}${txtBld} There are no files in the directory :${txtRst} $appInstallPath\n"
#			exit 1
		fi
	fi
}
#===========================================================================================================================================
function searchAPK() {
#$1 - device serial
#$2 - apk name
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 arguments passed to searchAPK()"
		exit 1
	else
		local let i=0
		local line

		Search_APK_COUNT=0

		while read line
		do
			if [ -n "$line" ]; then
				APK_ARRAY[i]="$line"
				let i=$i+1
			fi
		done < <(adb -s $1 wait-for-device shell pm list packages -f | grep -i "$2")
		
		Search_APK_COUNT=${#APK_ARRAY[*]}
	fi
}

function displayAPKlist() {
	if [ ${Search_APK_COUNT} -eq 1 ]; then
		echo -e -n " There is only 1 APK/Package with matching string : \n\n"
		echo -e -n " 1. ${APK_ARRAY[0]}\n"
	elif [ ${Search_APK_COUNT} -gt 1 ]; then
		local i=0
		echo -e -n " Following APKs/Packages found : \n\n"
		for (( i=0; i<$Search_APK_COUNT; i++ ))
		do
			let j=$i+1
			echo -e -n " $j. ${APK_ARRAY[i]}\n"
		done
	else
		echo -e -n " No APKs/Packages installed with that name\n"
	fi
}

function checkAPKChoiceValidity() {
#$1 choice number
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to checkAPKChoiceValidity()"
		exit 1
	else
		if echo "$1" | grep "^[0-9]*$">aux; then
			if [[ "$1" -gt "$Search_APK_COUNT" || "$1" -lt "1" ]]; then
				echo -e " ${txtBld}Dude '$1' is not a APK in this list and you know it. Come on.${txtRst}"
				exit 1
			else
				APK_ARRAY_INDEX="$1"
				let "APK_ARRAY_INDEX = $APK_ARRAY_INDEX - 1"
			fi
		else
			echo -e " ${txtBld}Come on Dude, pick a number. '$1' is not a number.${txtRst}"
			exit 1
		fi
	fi
}

#----- Pull
function pullAPK() {
#$1 - device serial
#$2 - apk name
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 arguments passed to pullAPK()"
		exit 1
	else
		searchAPK $1 $2

		local apkPath=""
		local APK_CHOICE
		local pullApkChoice="n"
		local dstFolder="$myAppDir"

		if [ $Search_APK_COUNT -gt 0 ]; then
			displayAPKlist
			
			if [ $Search_APK_COUNT -gt 1 ]; then
				echo -e -n "\n${txtBld} Enter APK Choice : ${txtRst}"
				read APK_CHOICE
				echo " "
				checkAPKChoiceValidity $APK_CHOICE
				apkPath=${APK_ARRAY[$APK_ARRAY_INDEX]}
			elif [ $Search_APK_COUNT -eq 1 ]; then
				echo -e -n "\n Do you want to pull it ? [y/n] : "
				stty -echo && read -n 1 pullApkChoice && stty echo
				formatYesNoOption pullApkChoice

				case "$pullApkChoice" in
					[yY]|[yY][eE][sS])
						echo -e -n "\n"
						apkPath=${APK_ARRAY[0]}
						;;
					[nN]|[nN][oO]|*)
						echo -e -n "\n"
						exit 1
						;;
				esac
			fi
			
			if [ "$( isAtHomeDevice $1 )" == "true" ]; then
				dstFolder="$myAAHDir"
			elif [ "$( isClockWorkDevice $1 )" == "true" ]; then
				dstFolder="$myACWDir"
			elif [ "$( isGedDevice $1 )" == "true" ]; then
				dstFolder="$myAppDir"
			else
				dstFolder="$myAppDir"
			fi
			apkPath=`echo $apkPath | cut -f2 -d":" | cut -f1 -d"=" | tr -d "\r\n"`
		
			echo -e "\n Your files will be saved in folder : $dstFolder"
			echo -e -n "\n Pulling APK..."
		
			if [ "$( isAdbDevice $1 )" == "true" ]; then
				echo -e -n " $apkPath\n"
				echo -e -n " "
				if [ "$( isDeviceBuildDevKey $1 )" == "true" ]; then
					adb -s $1 wait-for-device root >/dev/null 2>&1
					echo -e -n " "
					adb -s $1 wait-for-device pull $apkPath $dstFolder
					echo " "
				else
					echo -e -n "Device doesnot support root access\n"
				fi
			else
				echo -e -n " Device is not in adb mode\n"
			fi
		else
			echo -e -n " No APKs installed with that name\n"
		fi
	fi
}

#----- Uninstall the selected APKs
function uninstallSelectedApks() {
#$1 - device serial
#$2 - apk name
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 arguments passed to uninstallSelectedApks()"
		exit 1
	else
		searchAPK $1 $2

		if [ $Search_APK_COUNT -gt 0 ]; then

			local apkPath
			local apkPath1
			local apkPath2
			local APK_CHOICE
			local deleteApkChoice

			displayAPKlist

			if [ $Search_APK_COUNT -gt 1 ]; then
				echo -e -n "\n${txtBld} Enter APK Choice : ${txtRst}"
				read APK_CHOICE
				echo " "
				checkAPKChoiceValidity $APK_CHOICE
				apkPath=${APK_ARRAY[$APK_ARRAY_INDEX]}
			elif [ $Search_APK_COUNT -eq 1 ]; then
				echo -e -n "\n Do you want to delete it ? [y/n] : "
				stty -echo && read -n 1 deleteApkChoice && stty echo
				formatYesNoOption deleteApkChoice

				case "$deleteApkChoice" in
					[yY]|[yY][eE][sS])
						echo -e -n "\n"
						apkPath=${APK_ARRAY[0]}
						;;
					[nN]|[nN][oO]|*)
						echo -e -n "\n"
						exit 1
						;;
				esac
			fi

			apkPath1=`echo $apkPath | cut -f2 -d":" | cut -f1 -d"=" | tr -d "\r\n"`
			apkPath2=`echo $apkPath | cut -f2 -d":" | cut -f2 -d"=" | tr -d "\r\n"`

			echo -e -n "\n Uninstalling APK...\n"

			if [ "$( isAdbDevice $1 )" == "true" ]; then
				echo -e -n " $apkPath1 - $apkPath2\n"
				echo -e -n " adb uninstall - "
				adb -s $1 wait-for-device uninstall $apkPath2
				if [ "$( isDeviceBuildDevKey $1 )" == "true" ]; then
					echo -e -n " adb root - "
					adb -s $1 wait-for-device root
					echo -e -n " adb remount - "
					adb -s $1 wait-for-device remount
					echo -e -n " adb shell rm - "
					adb -s $1 wait-for-device shell rm -rf $apkPath1
					echo -e -n "Done\n\n Rebooting..."
					adb -s $1 wait-for-device reboot
				else
					echo -e -n " Device doesnot support root access\n"
				fi
				echo -e "\n"
			else
				echo " Device is not in adb mode"
			fi
		else
			echo -e " No APKs installed with that name\n"
		fi
	fi
}
#===========================================================================================================================================
#----- Check if there is an existing TIF folder
function checkTifFolder() {
#$1 - main folder absolute path
#$2 - Sub Folder
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to checkTifFolder()"
		exit 1
	else
		if [ "$2" == "latest" ]; then

			local tifLatestFolder=${1}/latest
	#		local tifAssetFolder=${tifLatestFolder}/asset

			if [[ -d "${tifLatestFolder}"  ]]; then
				echo -e -n "\n ${txtBld}$2${txtRst} folder already exist in ${txtBld}$1${txtRst}.\n\n Do you want to backup and create a new one ? [y/n] : "
				stty -echo && read -n 1 createLatestFolderChoice && stty echo
				formatYesNoOption $createLatestFolderChoice

				case "$createLatestFolderChoice" in
					[yY]|[yY][eE][sS])
						tifLatestFolderNew="${tifLatestFolder}"_"${nowDateTime}"

						echo -e -n "\n"

						echo -e -n " Moving ${tifLatestFolder} to... ${tifLatestFolderNew}\n"
						mv "${tifLatestFolder}" "${tifLatestFolderNew}"
						;;
				esac

			fi

			if [[ "$createLatestFolderChoice" == [yY] || "$createLatestFolderChoice" == [yY][eE][sS] || ! -d "${tifLatestFolder}" ]]; then

				echo -e -n "\n"
				echo -e -n " Creating folder... ${tifLatestFolder}\n"
				mkdir -p ${tifLatestFolder}

	#			echo -e -n " Creating folder... ${tifAssetFolder}\n"
	#			mkdir -p ${tifAssetFolder}

				#prodaccess

				cp -rf "/google/data/ro/users/hy/hyungtaekim/tif/latest/" "${1}"
	#			cp "/google/data/ro/users/hy/hyungtaekim/tif/asset" "$tifAssetFolder"

				echo -e -n "\n"
			fi
		fi
	fi
}
#===========================================================================================================================================
#----- get the device manufacturer
function getDeviceManufacturer(){
    if [ $# -lt 1 ]; then
        writeToLogsFile "@@ No argument passed to getDeviceManufacturer()"
        exit 1
    else
        local deviceManufacturer=`adb -s $1 wait-for-device shell getprop | grep -i ro.product.manufacturer | tr -d "\r\n"`
        echo $deviceManufacturer
    fi
}

#----- get the device model
function getDeviceModel(){
    if [ $# -lt 1 ]; then
        writeToLogsFile "@@ No argument passed to getDeviceModel()"
        exit 1
    else
        local deviceModel=`adb -s $1 wait-for-device shell getprop | grep -i ro.product.mode | tr -d "\r\n"`
        echo $deviceModel
    fi
}

#[net.bt.name]: [Android]
#[dhcp.wlan0.ipaddress]: [192.168.1.147]
#[gsm.network.type]: [LTE]
#[gsm.operator.alpha]: [AT&T]
#[gsm.operator.iso-country]: [us]
#[gsm.operator.isroaming]: [false]
#[gsm.sim.operator.iso-country]: [us]
#[gsm.sim.state]: [ABSENT] [READY]
#[init.svc.bdAddrLoader]: [stopped]
#[init.svc.bootanim]: [stopped]
#[persist.service.bdroid.bdaddr]: [80:6C:1B:96:5F:AE]
#[persist.sys.country]: [US]
#[persist.sys.language]: [en]
#[persist.sys.timezone]: [America/Los_Angeles]
#[ro.boot.secure_hardware]: [1]
#[ro.build.characteristics]: [nosdcard]
#[ro.build.tags]: [dev-keys] [release-keys]
#[ro.build.type]: [userdebug] [user]
#[ro.build.version.release]: [5.0]
#[ro.crypto.fuse_sdcard]: [true]
#[ro.crypto.state]: [encrypted]
#[ro.product.name]: [hammerhead]

#===========================================================================================================================================
#----- get the state of the device
function getDeviceState () {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to getDeviceState()"
		exit 1
	else
		local deviceState=`adb -s $1 get-state`
		echo $deviceState
	fi
}

#----- Check if its a @Home device
function isAtHomeDevice () {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isAtHomeDevice()"
		exit 1
	else
		local $deviceName="$( getDeviceName $1)"

#		if [[ "$deviceName" == "tungsten" || "$deviceName" == "cujo" || "$deviceName" == "wolfie" || "$deviceName" == "molly" || "$deviceName" == "fugu" ]]; then
#			echo true
#			#return $TRUE
#		else
#			echo false
#			#return $FALSE
#		fi

        case "$deviceName" in
            "tungsten"|"cujo"|"wolfie"|"molly"|"fugu")
                echo true ;;
            *)
                echo false ;;
        esac

	fi
}

#----- Check if its a ClockWork device
function isClockWorkDevice() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isClockWorkDevice()"
		exit 1
	else	
		local $deviceName="$( getDeviceName $1)"

#		if [[ "$deviceName" == "sprat" || "$deviceName" == "dorry" || "$deviceName" == "minnow" ]]; then
#			echo true
#		else
#			echo false
#		fi

        case "$deviceName" in
            "sprat"|"dorry"|"minnow")
                echo true ;;
            *)
                echo false ;;
        esac

	fi
}

#----- Check if its a ClockWork device
function isGearHeadDevice() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isGearHeadDevice()"
		exit 1
	else	
		# It is still not implemented
		echo false
	fi
}

#----- Check if its a GED device
function isGedDevice() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isGedDevice()"
		exit 1
	else	
		local $deviceName="$( getDeviceName $1)"

#		if [[ "$deviceName" == "hammerhead" || "$deviceName" == "mako" || "$deviceName" == "nakasi" || "$deviceName" == "flo" || "$deviceName" == "deb" || "$deviceName" == "manta" || "$deviceName" == "shamu" || "$deviceName" == "volantis" ]]; then
#			echo true
#		else
#			echo false
#		fi

        case "$deviceName" in
            "prime"|"hammerhead"|"mako"|"nakasi"|"flo"|"deb"|"manta"|"shamu"|"volantis")
                echo true ;;
            *)
                echo false ;;
        esac
	fi
}

function isGpeDevice() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isGpeDevice()"
		exit 1
	else	
		local $deviceName="$( getDeviceName $1)"

#		if [[ "$deviceName" == "jgedlteue" || "$deviceName" == "-blablabla-" ]]; then
#			echo true
#		else
#			echo false
#		fi

        case "$deviceName" in
            "jgedlteue"|"-blablabla-")
                echo true ;;
            *)
                echo false ;;
        esac

	fi
}

#----- Check if its a Google devices
function isGoogleDevice() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isGoogleDevice()"
		exit 1
	else
		if [[ "$( isAtHomeDevice $1 )" == "true" || "$( isClockWorkDevice $1 )" == "true" || "$( isGedDevice $1 )" == "true" ]]; then
			echo true	
		else	
			echo false
		fi
	fi
}
#===========================================================================================================================================
#----- Check if the device is in ADB mode
function isAdbDevice() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isAdbDevice()"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "adb" ]; then
			echo true
	    		#return $TRUE
		else
			echo false
			#return $FALSE
		fi
	fi
}

#----- Check if the device is in RECOVERY mode
function isRecoveryDevice() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isRecoveryDevice()"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "recovery" ]; then
			echo true
		else
			echo false
		fi
	fi
}

#----- Check if the device is in FASTBOOT mode
function isFastbootDevice() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isFastbootDevice()"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "fastboot" ]; then
			echo true
		else
			echo false
		fi
	fi
}

#----- Check if the device is in OFFLINE mode
function isDeviceOffline() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isDeviceOffline()"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "offline" ]; then
			echo true
		else
			echo false
		fi
	fi
}

#----- Check if the device is in UNAUTHORIZED mode
function isDeviceUnauthorized() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isDeviceOffline()"
		exit 1
	else
		local statusIndex="$( getIndex $1 )"
		if [ "${DEVICE_ARRAY_STATUS[$statusIndex]}" == "unauthorized" ]; then
			echo true
		else
			echo false
		fi
	fi
}

#----- Get the array index # from Device_Array list for the given deviceSerial
function getIndex() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to getIndex()"
		exit 1
	else
		local deviceIndex=0
		while [ "${DEVICE_ARRAY[$deviceIndex]}" != "$1" ] && [ $deviceIndex -lt "${#DEVICE_ARRAY[@]}" ]; do ((deviceIndex++)); done
		if [ $deviceIndex -lt "${#DEVICE_ARRAY[@]}" ]; then
			echo $deviceIndex
		else
			echo "Lost Device / Device not Found"
			exit 1
		fi
	fi
}
#===========================================================================================================================================
#----- Check if the device is running USER-DEBUG build
function isDeviceBuildUserdebug() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isDeviceBuildUserdebug()"
		exit 1
	else
		#deviceBuildType=$( getDeviceBuildType $1 )
		if [ "$( getDeviceBuildType $1 )" == "userdebug" ]; then
			echo true
		else
			echo false
		fi
	fi
}

#----- Check if the device is running USER build
function isDeviceBuildUser() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isDeviceBuildUser()"
		exit 1
	else
		#deviceBuildType=$( getDeviceBuildType $1 )
		if [ "$( getDeviceBuildType $1 )" == "user" ]; then
			echo true
		else
			echo false
		fi
	fi
}

#----- Check if the device is running Release-Key build
function isDeviceBuildReleaseKey() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to checkSignedDevice()\n"
		exit 1
	else
		#deviceDeviceKeys=$( getDeviceKeys $1 )
		if [ "$( getDeviceKeys $1 )" == "release-keys" ]; then
			echo true
		else
			echo false
		fi
	fi
}

#----- Check if the device is running Dev-Key build
function isDeviceBuildDevKey() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to checkSignedDevice()\n"
		exit 1
	else
		#deviceDeviceKeys=$( getDeviceKeys $1 )
		if [ "$( getDeviceKeys $1 )" == "dev-keys" ]; then
			echo true
		else
			echo false
		fi
	fi
}

#----- Check if the device is bootloader in LOCKED mode
function isDeviceLocked() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isDeviceLocked()\n"
		exit 1
	else
		#if [ "$( isFastbootDevice $1 )" == "false" ]; then
		writeToLogsFile "@@ Not implemented yet isDeviceLocked()\n"
	fi
}

#----- Check if the device is bootloader in UNLOCKED mode
function isDeviceUnocked() {
#$1 - takes the device serial
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to isDeviceUnocked()\n"
		exit 1
	else
#		if [ "$( isFastbootDevice $1 )" == "false" ]; then
#			adb -s $1 wait-for-device reboot bootloader
#		fi
#		
#		local unlockStatus=`fastboot -s $1 getvar unlocked | cut -d":" -f1`
#	  	if 
#		echo $unlockStatus
		writeToLogsFile "@@ Not implemented yet isDeviceUnocked()\n"
	fi
}
#===========================================================================================================================================
#----- Mock Power button press using adb
function pressPowerButton()
{
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to pressPowerButton()\n"
		exit 1
	else
		adb -s $1 shell input keyevent 26
	fi
}

#----- Mock Unlock screen using adb
function unlockScreen()
{
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to unlockScreen()\n"
		exit 1
	else
		adb -s $1 shell input keyevent 82
	fi
}

function appSwitch()
{
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to appSwitch()\n"
		exit 1
	else
		adb -s $1 shell input keyevent 187
	fi
}
##===========================================================================================================================================
############################################### Legacy Code #################################################################################
##===========================================================================================================================================
##----- Display and get the predefined device options
#function getDisplayList() {
#	if [ $DEVICE_COUNT == 0 ]; then
#		exit
#	elif [ $DEVICE_COUNT == 1 ]; then
#		deviceSerial="${DEVICE_ARRAY[0]}"
#	elif [ $DEVICE_COUNT > 1 ]; then
#		echo -n -e "\n1. List of connected devices\n2. Tungsten\n3. Crespo\n4. Prime-C\n5. Prime-U\n6. Stingray\n(OR) Enter the serial number"
#		echo -e "\n ${txtBld}Enter your choice : ${txtRst}"
#		read choice;
#	fi
#}
#
##----- Select from your list of device in mySetup.txt
#function getDeviceSelected() {
#	if [ $DEVICE_COUNT == 1 ]; then
#		echo -e "\nThere is only 1 device connected to the USB"
#		deviceSerial="${DEVICE_ARRAY[0]}"
#	else
#		case $choice in
#			1)
#				getDeviceChoice
#				deviceSerial=${DEVICE_ARRAY[${DEVICE_ARRAY_INDEX}]}
#				;;
#			2)
#				deviceSerial=$tungsten
#				;;
#			3)
#				deviceSerial=$crespo
#				;;
#			4)
#				deviceSerial=$primeC
#				;;
#			5)
#				deviceSerial=$primeU
#				;;
#			6)
#				deviceSerial=$stingray
#				;;	
#			*)
#				deviceSerial=$choice
#				;;
#		esac
#	fi
#}
##===========================================================================================================================================
##----- Get the options to install different APK's
#function readInstallOptions() {
#	#echo -e -n "* Reinstall Remote ? "
#	#stty -echo && read -n 1 remote && stty echo
#	#echo $remote
#
#	echo -e -n "* Reinstall Nexus-Home ? "
#	stty -echo && read -n 1 home && stty echo
#	echo $home
#	
#	echo -e -n "* Reinstall Emote ? "
#	stty -echo && read -n 1 emote && stty echo
#	echo $emote
#	
#	#echo -e -n "* Reinstall Music ? "
#	#stty -echo && read -n 1 music && stty echo
#	#echo $music
#
#	#echo -e -n "* Reinstall YouTube ? "
#	#stty -echo && read -n 1 youtube && stty echo
#	#echo $youtube
#
#	#echo -e -n "* Reinstall Videos ? "
#	#stty -echo && read -n 1 videos && stty echo
#	#echo $videos
#}
#
##----- UnInstall APK's
#function unInstallAPKs() {
#	#getDeviceName
#	if [ $# -lt 1 ]; then
#		writeToLogsFile "@@ No argument passed to unInstallAPKs()"
#		exit 1
#	else
#		#if [ $deviceName != "tungsten" ]; then  
#		if [ $( isAtHomeDevice ) == "false" ]; then
#		
#			echo -e -n ${txtRed}
#			#if [ $remote == "y" ]; then
#			#	echo -e -n "Uninstalling Remote : "
#				echo -e -n "Uninstalling Nexus Home : "
#				adb -s $1 wait-for-device uninstall com.google.android.setupwarlock
#			#fi
#			
#			#if [ $emote == "y" ]; then
#				echo -e -n "Uninstalling Emote : "
#				adb -s $1 wait-for-device uninstall com.google.android.athome.emote
#			#fi
#			
#			#if [ $home == "y" ]; then
#			#	echo -e -n "Uninstalling Nexus-Home : "
#			#	adb -s $1 wait-for-device uninstall com.google.android.athome.nexushome
#			#fi
#			
#			#if [ $music == "y" ]; then
#				#echo -e -n "Uninstaling Music : "
#				#adb -s $1 wait-for-device uninstall com.google.android.music
#			#fi
#
#			#if [ $youtube == "y" ]; then
#				#echo -e -n "Uninstaling YouTube : "
#				#adb -s $1 wait-for-device uninstall com.google.android.youtube
#			#fi
#
#			#if [ $videos == "y" ]; then
#				#echo -e -n "Uninstaling Videos : "
#				#adb -s $1 wait-for-device uninstall com.google.android.videos
#			#fi
#
#			#if [ $broker == "y" ]; then
#				#echo -e "\n Uninstalling...\n"
#				#echo -n "Broker :"
#				#adb -s $deviceSerial wait-for-device uninstall com.android.athome
#			#fi
#			echo -e -n ${txtRst}
#		fi
#	fi
#}
#
#----- Install the APK's
#function reInstallAPKs() {
#	#getDeviceName
#	if [ $# -lt 1 ]; then
#		writeToLogsFile "@@ No argument passed to reInstallAPKs()"
#		exit 1
#	else
#		if [ $( isAtHomeDevice ) == "false" ]; then
#			echo -e -n ${txtGrn}
#			#if [ $remote == "y" ]; then
#			#	echo -e -n "Installing Remote : "
#			#	adb -s $1 wait-for-device install -r `echo RemoteControl*.apk`
#			#fi
#
#			#if [ $home == "y" ]; then
#				echo -e -n "Installing Nexus-Home : "
#				adb -s $1 wait-for-device install -r `echo NexusHome*.apk`
#			#fi
#			
#			#if [ $emote == "y" ]; then
#				echo -e -n "Installing Emote : "
#				adb -s $1 wait-for-device install -r `echo Emote*.apk`
#			#fi
#			
#			#if [ $music == "y" ]; then
#				#echo -e -n "Installing Music : "
#				#adb -s $1 wait-for-device install -r `echo Music2*.apk`
#			#fi
#
#			#if [ $youtube == "y" ]; then
#				#echo -e -n "Installing YouTube : "
#				#adb -s $1 wait-for-device install -r `echo YouTube*.apk`
#			#fi
#
#			#if [ $videos == "y" ]; then
#				#echo -e -n "Installing Videos : "
#				#adb -s $1 wait-for-device install -r `echo Videos*.apk`
#			#fi
#
#			#if [ $broker == "y" ]; then
#				#echo -e "\n Installing...\n"
#				#echo -n "Broker :"
#				#adb -s $deviceSerial wait-for-device install `echo AndroidAtHomeBroker*.apk`
#			#fi
#			echo -e -n ${txtRst}
#		fi
#	fi
#}
##===========================================================================================================================================
