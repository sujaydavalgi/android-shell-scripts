#!/bin/bash

#. ./library/mainFunctions.sh
#. ./library/textFormatting.sh
#. ./library/deviceOperations.sh

#if [ $# -lt 1 ]; then
#    getDeviceChoice
#    displaySelectedDevice $deviceSerial
#else
#    buildDeviceSnArray
#    deviceSerial="$1"
#    displaySelectedDevice $deviceSerial
#fi

if [ $# -lt 1 ]; then
    deviceSerial="ZX1G22FHZS"
else
    deviceSerial="$1"
fi

logsPath=`echo ~/Projects/bugs/battery/Run4`
numberOfDaysToRun=2
voiceSearchString="Play some music"

#create the defined logs folder if not already present
if [ ! -d "$logPath" ]; then
	`mkdir -p ${logPath}`
fi

echo -e -n "\n********** Starting test $(date +'%Y/%m/%d-%H:%M:%S') **********\n" | tee -a $logsPath/scriptLogs.txt

#musicVersion=`adb -s $deviceSerial wait-for-device shell dumpsys package "com.google.android.music" | grep -i versionname | cut -f2 -d"=" | tr -d "\r"`

echo -e -n " - deviceSerial : $deviceSerial\n" | tee -a $logsPath/scriptLogs.txt
#echo -e -n " - Music: $musicVersion\n" | tee -a $logsPath/scriptLogs.txt

echo -e -n " - numberOfDaysToRun : $numberOfDaysToRun\n" | tee -a $logsPath/scriptLogs.txt

echo -e -n " - logsPath : $logsPath\n" | tee -a $logsPath/scriptLogs.txt

nowTime=$(date +'%Y%m%d%H%M%S')
let bugreportTriggerTime=$nowTime+1000000 #1000000 is for adding one day to the current date

#Become root or su on DUT
echo -e -n "\n Initiate root : " | tee -a $logsPath/scriptLogs.txt
adb -s $deviceSerial wait-for-device root >/dev/null 2>&1
echo -e -n "Done\n" | tee -a $logsPath/scriptLogs.txt

#start logcat
echo -e -n " Start logcat ($nowTime) : " | tee -a $logsPath/scriptLogs.txt
adb -s $deviceSerial wait-for-device logcat > $logsPath/logcat_batterystats_$nowTime.txt &
echo -e -n "Started\n" | tee -a $logsPath/scriptLogs.txt

echo -e -n " Start dumpsys ($nowTime): " | tee -a $logsPath/scriptLogs.txt
adb -s $deviceSerial wait-for-device shell dumpsys batterystats > $logsPath/batterystats_all_$nowTime.txt
adb -s $deviceSerial wait-for-device shell dumpsys batterystats com.google.android.music > $logsPath/batterystats_music_$nowTime.txt
echo -e -n "Done\n\n" | tee -a $logsPath/scriptLogs.txt

echo -e -n " Start Playing music ($nowTime): " | tee -a $logsPath/scriptLogs.txt
adb -s $deviceSerial wait-for-device shell am start -a android.media.action.MEDIA_PLAY_FROM_SEARCH -n com.google.android.music/.VoiceActionsActivity -c android.intent.category.DEFAULT >/dev/null 2>&1
#adb -s $deviceSerial wait-for-device shell am start -a android.media.action.MEDIA_PLAY_FROM_SEARCH -n com.google.android.music/.VoiceActionsActivity -c android.intent.category.DEFAULT --es "query" "${voiceSearchString}" >/dev/null 2>&1
echo -e -n "Done\n\n" | tee -a $logsPath/scriptLogs.txt

i=0
while [ $i -lt $numberOfDaysToRun ] ; do
	nowTime=$(date +'%Y%m%d%H%M%S')
	if [ $nowTime -ge $bugreportTriggerTime ] ; then
		let bugreportTriggerTime=$nowTime+1000000
		echo -e -n " Starting dumpsys $i at $nowTime, next dumpsys will be after $bugreportTriggerTime : " | tee -a $logsPath/scriptLogs.txt
		adb -s $deviceSerial wait-for-device shell dumpsys batterystats > $logsPath/batterystats_all_$nowTime.txt
		adb -s $deviceSerial wait-for-device shell dumpsys batterystats com.google.android.music > $logsPath/batterystats_music_$nowTime.txt
		echo -e -n "Done\n" | tee -a $logsPath/scriptLogs.txt
		let i=$i+1
	fi
	echo -e -n " Waiting for 60 min ($(date +'%Y%m%d_%H%M%S')) : " | tee -a $logsPath/scriptLogs.txt
	sleep 60m
	echo -e -n "Done ($(date +'%Y%m%d_%H%M%S'))\n" | tee -a $logsPath/scriptLogs.txt
done

echo -e -n " Done with the test. Waiting for 5 min before rebooting the device.\n" | tee -a $logsPath/scriptLogs.txt
sleep 5m
echo -e -n " Rebooting the device.\n\n" | tee -a $logsPath/scriptLogs.txt

adb -s $deviceSerial wait-for-device reboot
