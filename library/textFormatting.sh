#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for text formating related functions
#
# Usage: ". ./library/textFormatting.sh" within other scripts

#===================================================================================================

#----- Convert all the supplied string to lowercase
function toLowercase () {
#$1 - takes the input string to be converted to lowercase
#$return - 
	echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

#----- Convert all the supplied string to lowercase
function toUppercase () {
#$1 - takes the input string to be converted to lowercase
#$return - 
	echo "$1" | sed "y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/"
}

#===================================================================================================

#examples to use text color modes
#echo “Welcome to ${txtRed} www.google.com ${txtRst}!”
#echo -e -n "${txtBlu}blue ${txtRed}red ${txtRst}etc...."

#===================================================================================================

#------------ to change the text COLOR
txtRst=$(tput sgr0)    	# Reset all attributes
txtBla=$(tput setaf 0) 	# Black
txtRed=$(tput setaf 1) 	# Red
txtGrn=$(tput setaf 2) 	# Green
txtYlw=$(tput setaf 3) 	# Yellow
txtBlu=$(tput setaf 4) 	# Blue
txtPur=$(tput setaf 5) 	# Purple
txtCyn=$(tput setaf 6) 	# Cyan
txtWht=$(tput setaf 7) 	# White
txtPbl=$(tput setaf 153) # Powder Blue
txtOrg=$(tput setaf 172) # Orange
txtLyl=$(tput setaf 190) # Lime Yellow

#------------ to change the text BACKGROUND
bgRed=$(tput setab 1) # Red
bgGrn=$(tput setab 2) # Green
bgYlw=$(tput setab 3) # Yellow
bgBlu=$(tput setab 4) # Blue
bgPur=$(tput setab 5) # Purple
bgCyn=$(tput setab 6) # Cyan
bgWht=$(tput setab 7) # White

#===================================================================================================

#------------ Regular
Bla='\e[0;30m'
Red='\e[0;31m'
Gre='\e[0;32m'
Yel='\e[0;33m'
Blu='\e[0;34m'
Pur='\e[0;35m'
Cya='\e[0;36m'
Whi='\e[0;37m'

#------------ Bold
BBla='\e[1;30m'
BRed='\e[1;31m'
BGre='\e[1;32m'
BYel='\e[1;33m'
BBlu='\e[1;34m'
BPur='\e[1;35m'
BCya='\e[1;36m'
BWhi='\e[1;37m'

#------------ Underline
UBla='\e[4;30m'
URed='\e[4;31m'
UGre='\e[4;32m'
UYel='\e[4;33m'
UBlu='\e[4;34m'
UPur='\e[4;35m'
UCya='\e[4;36m'
UWhi='\e[4;37m'

#------------ High Intensity
IBla='\e[0;90m'
IRed='\e[0;91m'
IGre='\e[0;92m'
IYel='\e[0;93m'
IBlu='\e[0;94m'
IPur='\e[0;95m'
ICya='\e[0;96m'
IWhi='\e[0;97m'

#------------ Bold High Intensity
BIBla='\e[1;90m'
BIRed='\e[1;91m'
BIGre='\e[1;92m'
BIYel='\e[1;93m'
BIBlu='\e[1;94m'
BIPur='\e[1;95m'
BICya='\e[1;96m'
BIWhi='\e[1;97m'

#------------ Background
BgBla='\e[40m'
bgRed='\e[41m'
BgGre='\e[42m'
BgYel='\e[43m'
bgBlu='\e[44m'
bgPur='\e[45m'
BgCya='\e[46m'
BgWhi='\e[47m'

#------------ High Intensity Backgrounds
IBgBla='\e[0;100m'
IbgRed='\e[0;101m'
IBgGre='\e[0;102m'
IBgYel='\e[0;103m'
IbgBlu='\e[0;104m'
IbgPur='\e[0;105m'
IBgCya='\e[0;106m'
IBgWhi='\e[0;107m'

#===================================================================================================

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
#$return - 
	#tput bold
	echo -n -e ${txtBld} $@ ${txtRst}
	#tput sgr0
}

function txtBlink() {
# $@ - takes all the input strings passed
#$return - 
	echo -n -e "\033[5m$@\033[0m"
	tput blink
	echo -n -e "$@"
	tput sgr0
}

#===================================================================================================

#------------ Clear and Insert Capabilities
clrScr=$(tput clear)  # clear screen and home cursor
clrEscr=$(tput ed)    # clear to end of screen
clrEln=$(tput el)     # clear to end of line
clrSln=$(tput el1)    # clear to begining of lines

function eraseCharN() {
# $1 - takes the number of characters to be erased
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		tput ech "$1"     # Erase N characters
	fi
}

function insertCharN() {
# $1 - takes the number of characters to be inserted
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		tput ich "$1"     # insert N characters (moves rest of line forward!)
	fi
}

function insertLnN() {
# $1 - takes the number of lines to be inserted
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		tput il "$1"      # insert N lines
	fi
}

#===================================================================================================

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
#$return - 
	if [ $# -lt 2 ]; then
		writeToLogsFile "@@ No 2 argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		tput cup "$2" "$1" # Move cursor to screen location X,Y (top left is 0,0)
	fi
}

function curMovLftN() {
# $1 - takes the number of characters to move left
#$return - 	
    if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		tput cub "$1"      # Move N characters left
	fi
}

function curMovRgtN() {
# $1 - takes the number of characters to move right
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		tput cuf "$1"      # Move N characters right
	fi
}

#===================================================================================================

#----- Check y/n option with multiple possibilities
function checkYesNoOption() {
#$1 - Yes/No String
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		case "$1" in
			[yY]|[yY][eE][sS])
				echo -e -n "yes"
				;;
			[nN]|[nN][oO])
				echo -e -n "no"
				;;
			*)
				echo -e -n "$1"
				;;
		esac
	fi
}

#----- format entered option
function formatYesNoOption() {
#$1 - Yes/No String
#$return - 
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		if [ "$( checkYesNoOption $1 )" == "yes" ]; then
			echo -e "${txtGrn}${txtBld}$1${txtRst}"
		elif [ "$( checkYesNoOption $1 )" == "no" ]; then
			echo -e "${txtRed}${txtBld}$1${txtRst}"
		else
			echo -e "${txtBld}$1${txtRst}"
		fi
	fi
}

function formatMessage() {
#$1 - Message strings
#$2 - Message type [optional]
#$3 - Message Color [optional]
#$return - 

# formatMessage "TEST THIS NESSAGE NOW\n" "D"
# formatMessage "TEST THIS NESSAGE NOW\n" "C" "R"

	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		msg="$1"
		defaultMsgType="m"
		#defaultMsgColor=${txtWht}

		if [ $# -lt 2 ]; then
			msgType="$defaultMsgType"
		else
			msgType="$2"
		fi

		case $msgType in
			[mMnN]) #normal message
				echo -e -n ${txtRst};;
			[iI]) #information
				echo -e -n ${txtPur};;
			[wW]) #warning
				echo -e -n ${txtYlw};;
			[eE]) #error
				echo -e -n ${txtRed};;
			[dD]) #debug
				echo -e -n ${txtGrn};;
			[qQ]) #question
				echo -e -n ${txtCyn};;
			[oO]) #option
				echo -e -n ${txtBlu};;
			[cC]) #custom
				if [ $# -lt 3 ]; then
					echo -e -n ${txtWht}
				else
					case $3 in
						[rR]) echo -e -n ${txtRed};;
						[gG]) echo -e -n ${txtGrn};;
						[bB]) echo -e -n ${txtBlu};;
						[yY]) echo -e -n ${txtYlw};;
						[pP]) echo -e -n ${txtPur};;
						[cC]) echo -e -n ${txtCyn};;
						[wW]) echo -e -n ${txtWht};;
						[bB][lL][dD]) echo -e -n ${txtBld};;
						"*")  echo -e -n ${txtWht};;
					esac
				fi
				;;
			"*") #default
				echo -e -n ${txtRst};;
		esac

		echo -e -n "$msg${txtRst}"
		
	fi
}