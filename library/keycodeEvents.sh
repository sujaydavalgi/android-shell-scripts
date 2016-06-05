#!/bin/bash

# Created by Sujay Davalgi
#
# Common functions-library for sending keycode events to device related functions
#
# Usage: ". ./library/machineFileOperations.sh" within other scripts

#===================================================================================================

function keycodeUnknown() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_UNKNOWN #0
	fi
}
#====================================== Android ===================================================
function keycodeHome() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_HOME #3
	fi
}

function keycodeBack() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BACK #4
	fi
}

function keycodeMenu() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MENU #82
	fi
}

function keycodeAppSwitch() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_APP_SWITCH #187
	fi
}

function keycodeVolumeUp() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_VOLUME_UP #24
	fi
}

function keycodeVolumeDown() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_VOLUME_DOWN #25
	fi
}

function keycodePower() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_POWER #26
	fi
}

function accessoryButton() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell am start -n com.google.android.canvas.settings/.accessories.AddAccessoryActivity
	fi
}

function keycodeSleep() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SLEEP #223
	fi
}

function keycodeWakeup() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_WAKEUP #224
	fi
}

function keycodePairing() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PAIRING #225
	fi
}

function keycodeBrightnessDown() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BRIGHTNESS_DOWN #220
	fi
}

function keycodeBrightnessUp() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BRIGHTNESS_UP #221
	fi
}
#====================================== Camera ====================================================
function keycodeCamera() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CAMERA #27
	fi
}

function keycodeFocus() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_FOCUS #80
	fi
}
#====================================== Phone =====================================================
function keycodeCall() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CALL #5
	fi
}

function keycodeEndCall() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ENDCALL #6
	fi
}

function keycodeStar() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_STAR #17
	fi
}

function keycodePound() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_POUND #18
	fi
}

function keycode0() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_0 #7
	fi
}

function keycode1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_1 #8
	fi
}

function keycode2() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_2 #9
	fi
}

function keycode3() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_3 #10
	fi
}

function keycode4() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_4 #11
	fi
}

function keycode5() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_5 #12
	fi
}

function keycode6() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_6 #13
	fi
}

function keycode7() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_7 #14
	fi
}

function keycode8() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_8 #15
	fi
}

function keycode9() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_9 #16
	fi
}

function keycode11() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_11 #227
	fi
}

function keycode12() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_12 #228
	fi
}
#====================================== D-Pad =====================================================
function keycodeDpadUp() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_DPAD_UP #19
	fi
}

function keycodeDpadDown() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_DPAD_DOWN #20
	fi
}

function keycodeDpadLeft() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_DPAD_LEFT #21
	fi
}

function keycodeDpadRight() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_DPAD_RIGHT #22
	fi
}

function keycodeDpadCenter() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_DPAD_CENTER #23
	fi
}
#==================================================================================================

function keycodeSoftLeft() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SOFT_LEFT #1
	fi
}

function keycodeSoftRight() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SOFT_RIGHT #2
	fi
}

function keycodeClear() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CLEAR #28
	fi
}

function keycodeA() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_A #29
	fi
}

function keycodeB() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_B #30
	fi
}

function keycodeC() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_C #31
	fi
}

function keycodeD() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_D #32
	fi
}

function keycodeE() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_E #33
	fi
}

function keycodeF() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F #34
	fi
}

function keycodeG() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_G #35
	fi
}

function keycodeH() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_H #36
	fi
}

function keycodeI() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_I #37
	fi
}

function keycodeJ() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_J #38
	fi
}

function keycodeK() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_K #39
	fi
}

function keycodeL() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_L #40
	fi
}

function keycodeM() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_M #41
	fi
}

function keycodeN() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_N #42
	fi
}

function keycodeO() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_O #43
	fi
}

function keycodeP() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_P #44
	fi
}

function keycodeQ() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_Q #45
	fi
}

function keycodeR() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_R #46
	fi
}

function keycodeS() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_S #47
	fi
}

function keycodeT() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_T #48
	fi
}

function keycodeU() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_U #49
	fi
}

function keycodeV() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_V #50
	fi
}

function keycodeW() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_W #51
	fi
}

function keycodeX() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_X #52
	fi
}

function keycodeY() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_Y #53
	fi
}

function keycodeZ() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_Z #54
	fi
}

function keycodeComma() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_COMMA #55
	fi
}

function keycodePeriod() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PERIOD #56
	fi
}

function keycodeAltLeft() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ALT_LEFT #57
	fi
}

function keycodeAltRight() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ALT_RIGHT #58
	fi
}

function keycodeShiftLeft() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SHIFT_LEFT #59
	fi
}

function keycodeShiftRight() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SHIFT_RIGHT #60
	fi
}

function keycodeTab() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TAB #61
	fi
}

function keycodeSpace() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SPACE #62
	fi
}

function keycodeSym() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SYM #63
	fi
}

function keycodeEnter() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ENTER #66
	fi
}

function keycodeDel() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_DEL #67
	fi
}

function keycodeGrave() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_GRAVE #68
	fi
}

function keycodeMinus() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MINUS #69
	fi
}

function keycodeEquals() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_EQUALS #70
	fi
}

function keycodeLeftBracket() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_LEFT_BRACKET #71
	fi
}

function keycodeRightBracket() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_RIGHT_BRACKET #72
	fi
}

function keycodeBacklash() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BACKSLASH #73
	fi
}

function keycodeSemicolon() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SEMICOLON #74
	fi
}

function keycodeApostrophe() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_APOSTROPHE #75
	fi
}

function keycodeSlash() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SLASH #76
	fi
}

function keycodeAt() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_AT #77
	fi
}

function keycodeNum() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUM #78
	fi
}

function keycodePlus() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PLUS #81
	fi
}

function keycodePageUp() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PAGE_UP #92
	fi
}

function keycodePageDown() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PAGE_DOWN #93
	fi
}

function keycodeEscape() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ESCAPE #111
	fi
}

function keycodeForwardDel() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_FORWARD_DEL #112
	fi
}

function keycodeCtrlLeft() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CTRL_LEFT #113
	fi
}

function keycodeCtrlRight() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CTRL_RIGHT #114
	fi
}

function keycodeCapsLock() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CAPS_LOCK #115
	fi
}

function keycodeScrollLock() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SCROLL_LOCK #116
	fi
}

function keycodeMetaLeft() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_META_LEFT #117
	fi
}

function keycodeMetaRight() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_META_RIGHT #118
	fi
}

function keycodeFunction() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_FUNCTION #119
	fi
}

function keycodeSysRq() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SYSRQ #120
	fi
}

function keycodeBreak() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BREAK #121
	fi
}

function keycodeMoveHome() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MOVE_HOME #122
	fi
}

function keycodeMoveEnd() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MOVE_END #123
	fi
}

function keycodeInsert() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_INSERT #124
	fi
}

function keycodeF1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F1 #131
	fi
}

function keycodeF2() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F2 #132
	fi
}

function keycodeF3() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F3 #133
	fi
}

function keycodeF4() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F4 #134
	fi
}

function keycodeF5() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F5 #135
	fi
}

function keycodeF6() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F6 #136
	fi
}

function keycodeF7() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F7 #137
	fi
}

function keycodeF8() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F8 #138
	fi
}

function keycodeF9() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F9 #139
	fi
}

function keycodeF10() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F10 #140
	fi
}

function keycodeF11() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F11 #141
	fi
}

function keycodeF12() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_F12 #142
	fi
}

function keycodeNumLock() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUM_LOCK #143
	fi
}

function keycodeNumpad0() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_0 #144
	fi
}

function keycodeNumpad1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_1 #145
	fi
}

function keycodeNumpad2() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_2 #146
	fi
}

function keycodeNumpad3() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_3 #147
	fi
}

function keycodeNumpad4() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_4 #148
	fi
}

function keycodeNumpad5() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_5 #149
	fi
}

function keycodeNumpad6() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_6 #150
	fi
}

function keycodeNumpad7() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_7 #151
	fi
}

function keycodeNumpad8() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_8 #152
	fi
}

function keycodeNumpad9() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_9 #153
	fi
}

function keycodeNumpadDivide() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_DIVIDE #154
	fi
}

function keycodeNumpadMultiply() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_MULTIPLY #155
	fi
}

function keycodeNumpadSubtract() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_SUBTRACT #156
	fi
}

function keycodeNumpadAdd() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_ADD #157
	fi
}

function keycodeNumpadDot() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_DOT #158
	fi
}

function keycodeNumpadComma() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_COMMA #159
	fi
}

function keycodeNumpadEnter() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_ENTER #160
	fi
}

function keycodeNumpadEquals() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_EQUALS #161
	fi
}

function keycodeNumpadLeftParen() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_LEFT_PAREN #162
	fi
}

function keycodeNumpadRightParen() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NUMPAD_RIGHT_PAREN #163
	fi
}

function keycodeNotification() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_NOTIFICATION #83
	fi
}

function keycodeSearch() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SEARCH #84
	fi
}

function keycodeExplorer() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_EXPLORER #64
	fi
}

function keycodeEnevlope() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ENVELOPE #65
	fi
}

function keycodeContacts() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CONTACTS #207
	fi
}

function keycodeCalendar() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CALENDAR #208
	fi
}

function keycodeMusic() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MUSIC #209
	fi
}

function keycodeCalculator() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CALCULATOR #210
	fi
}

#============================ Media ===============================================================

function keycodeHeadsetHook() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_HEADSETHOOK #79
	fi
}

function keycodeMediaPlayPause() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_PLAY_PAUSE #85
	fi
}

function keycodeMediaStop() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_STOP #86
	fi
}

function keycodeMediaNext() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_NEXT #87
	fi
}

function keycodeMediaPrevious() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_PREVIOUS #88
	fi
}

function keycodeMediaRewind() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_REWIND #89
	fi
}

function keycodeMediaFastForward() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_FAST_FORWARD #90
	fi
}

function keycodeMute() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MUTE #91
	fi
}

function keycodeForward() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_FORWARD #125
	fi
}

function keycodeMediaPlay() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_PLAY #126
	fi
}

function keycodeMediaPause() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_PAUSE #127
	fi
}

function keycodeMediaClose() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_CLOSE #128
	fi
}

function keycodeMediaEject() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_EJECT #129
	fi
}

function keycodeMediaRecord() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_RECORD #130
	fi
}

function keycodeMediaTopMenu() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_TOP_MENU #226
	fi
}

function keycodeMediaAudioTrack() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MEDIA_AUDIO_TRACK #222
	fi
}

#==================================================================================================

function keycodePictSymbols() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PICTSYMBOLS #94
	fi
}

function keycodeSwitchCharset() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SWITCH_CHARSET #95
	fi
}

#============================ Gamepad =============================================================
function keycodeButtonA() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_A #96
	fi
}

function keycodeButtonB() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_B #97
	fi
}

function keycodeButtonC() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_C #98
	fi
}

function keycodeButtonX() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_X #99
	fi
}

function keycodeButtonY() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_Y #100
	fi
}

function keycodeButtonZ() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_Z #101
	fi
}

function keycodeButtonL1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_L1 #102
	fi
}

function keycodeButtonR1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_R1 #103
	fi
}

function keycodeButtonL2() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_L2 #104
	fi
}

function keycodeButtonL2() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_R2 #105
	fi
}

function keycodeButtonThumbL() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_THUMBL #106
	fi
}

function keycodeButtonThumbR() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_THUMBR #107
	fi
}

function keycodeButtonStart() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_START #108
	fi
}

function keycodeButtonSelect() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_SELECT #109
	fi
}

function keycodeButtonMode() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_MODE #110
	fi
}

function keycodeButton1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_1 #188
	fi
}

function keycodeButton2() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_2 #189
	fi
}

function keycodeButton3() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_3 #190
	fi
}

function keycodeButton4() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_4 #191
	fi
}

function keycodeButton5() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_5 #192
	fi
}

function keycodeButton6() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_6 #193
	fi
}

function keycodeButton7() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_7 #194
	fi
}

function keycodeButton8() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_8 #195
	fi
}

function keycodeButton9() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_9 #196
	fi
}

function keycodeButton10() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_10 #197
	fi
}


function keycodeButton11() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_11 #198
	fi
}

function keycodeButton12() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_12 #199
	fi
}

function keycodeButton13() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_13 #200
	fi
}

function keycodeButton14() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_14 #201
	fi
}

function keycodeButton15() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_15 #202
	fi
}

function keycodeButton16() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BUTTON_16 #203
	fi
}
#===================================================================================================
function keycodeLanguageSwitch() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_LANGUAGE_SWITCH #204
	fi
}

function keycodeZenkakuHankaku() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ZENKAKU_HANKAKU #211
	fi
}

function keycodeEisu() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_EISU #212
	fi
}

function keycodeMuhenkan() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MUHENKAN #213
	fi
}

function keycodeHenkan() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_HENKAN #214
	fi
}

function keycodeKatakanaHiragana() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_KATAKANA_HIRAGANA #215
	fi
}

function keycodeYen() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_YEN #216
	fi
}

function keycodeRo() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_RO #217
	fi
}

function keycodeKana() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_KANA #218
	fi
}

function keycodeAssist() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ASSIST #219
	fi
}
#====================================== TV ========================================================
function keycodeTvPower() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_POWER #177
	fi
}

function keycodeVolumeMute() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_VOLUME_MUTE #164
	fi
}

function keycodeChannelUp() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CHANNEL_UP #166
	fi
}

function keycodeChannelDown() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CHANNEL_DOWN #167
	fi
}

function keycodeLastChannel() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_LAST_CHANNEL #229
	fi
}

function keycodeTvNumberEntry() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_NUMBER_ENTRY #234
	fi
}

function keycodeProgRed() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PROG_RED #183
	fi
}

function keycodeProgGreen() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PROG_GREEN #184
	fi
}

function keycodeProgYellow() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PROG_YELLOW #185
	fi
}

function keycodeProgBlue() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_PROG_BLUE #186
	fi
}

function keycodeTvInput() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT #178
	fi
}

function keycodeTv() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV #170
	fi
}

function keycodeTvDataService() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_DATA_SERVICE #230
	fi
}

function keycodeVoiceAssist() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_VOICE_ASSIST #231
	fi
}

function keycodeTvRadioService() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_RADIO_SERVICE #232
	fi
}

function keycodeTvTeletext() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_TELETEXT #233
	fi
}

function keycodeTvTerrestrialAnalog() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_TERRESTRIAL_ANALOG #235
	fi
}

function keycodeTvTerrestrialDigital() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_TERRESTRIAL_DIGITAL #236
	fi
}

function keycodeTvSatellite() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_SATELLITE #237
	fi
}

function keycodeTvSatelliteBS() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_SATELLITE_BS #238
	fi
}

function keycodeTvSatelliteBS() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_SATELLITE_CS #239
	fi
}

function keycodeTvSatelliteService() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_SATELLITE_SERVICE #240
	fi
}

function keycodeTvNetwork() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_NETWORK #241
	fi
}

function keycodeTvAntennaCable() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_ANTENNA_CABLE #242
	fi
}

function keycodeHdmi1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT_HDMI_1 #243
	fi
}

function keycodeHdmi2() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT_HDMI_2 #244
	fi
}

function keycodeHdmi3() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT_HDMI_3 #245
	fi
}

function keycodeHdmi4() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT_HDMI_4 #246
	fi
}

function keycodeTvInputComposite1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT_COMPOSITE_1 #247
	fi
}

function keycodeTvInputComposite2() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT_COMPOSITE_2 #248
	fi
}

function keycodeTvInputComponent1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT_COMPONENT_1 #249
	fi
}

function keycodeTvInputComponent2() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT_COMPONENT_2 #250
	fi
}

function keycodeTvInputVga1() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_INPUT_VGA_1 #251
	fi
}

function keycodeTvAudioDescription() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_AUDIO_DESCRIPTION #252
	fi
}

function keycodeTvAudioDescriptionMixUp() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_AUDIO_DESCRIPTION_MIX_UP #253
	fi
}

function keycodeTvAudioDescriptionMixDown() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_AUDIO_DESCRIPTION_MIX_DOWN #254
	fi
}

function keycodeTvContentsMenu() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_CONTENTS_MENU #256
	fi
}

function keycodeTvMediaContextMenu() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_MEDIA_CONTEXT_MENU #257
	fi
}

function keycodeTvTimerProgramming() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_TIMER_PROGRAMMING #258
	fi
}

function keycodeInfo() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_INFO #165
	fi
}

function keycodeTvZoomMode() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_TV_ZOOM_MODE #255
	fi
}

function keycodeZoomIn() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ZOOM_IN #168
	fi
}

function keycodeZoomOut() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_ZOOM_OUT #169
	fi
}

function keycodeWindow() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_WINDOW #171
	fi
}

function keycodeGuide() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_GUIDE #172
	fi
}

function keycodeDvr() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_DVR #173
	fi
}

function keycodeBookamrk() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_BOOKMARK #174
	fi
}

function keycodeCaptions() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_CAPTIONS #175
	fi
}

function keycodeSettings() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_SETTINGS #176
	fi
}

function keycodeStbPower() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_STB_POWER #179
	fi
}

function keycodeStbInput() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_STB_INPUT #180
	fi
}

function keycodeAvrPower() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_AVR_POWER #181
	fi
}

function keycodeAveInput() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_AVR_INPUT #182
	fi
}

function keycodeMannerMode() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_MANNER_MODE #205
	fi
}

function keycode3dMode() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_3D_MODE #206
	fi
}

function keycodeHelp() {
	if [ $# -lt 1 ]; then
		writeToLogsFile "@@ No argument passed to ${FUNCNAME[0]}() in ${BASH_SOURCE} called from $( basename ${0} )"
		exit 1
	else
		adb -s $1 shell input keyevent KEYCODE_HELP #259
	fi
}
#===================================================================================================
