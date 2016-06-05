#!/bin/bash

if [ $# -lt 1 ]; then
    deviceSerial="NP5B2A0506"
else
    deviceSerial="$1"
fi

deviceName=`adb -s $deviceSerial wait-for-device shell getprop ro.product.model | tr -d "\r\n"`
logPath=`echo ~/Projects/bugs/SysHealth/Run4`
numberOfIterations=10

#create the defined logs folder if not already present
if [ ! -d "$logPath" ]; then
	`mkdir -p ${logPath}`
fi

#Become root or su on DUT
echo -e -n "\nInitiate root : "
adb -s $deviceSerial wait-for-device root >/dev/null 2>&1
echo -e -n " Done\n"

#<stop app>
echo -e -n "Stop the Music app : "	
adb -s $deviceSerial wait-for-device shell am force-stop "com.google.android.music" >/dev/null 2>&1
echo -e -n " Done\n"

echo -e -n " Reset battery stats : "
adb -s $deviceSerial shell dumpsys batterystats --reset >/dev/null 2>&1
echo -e -n " Done\n"

i=0
while [ $i -lt $numberOfIterations ] ; do
	echo -e -n "\n***** Iteration : $i *****\n\n"
	
	#<start app>
	echo -e -n " - Start the Music app : "
	adb -s $deviceSerial wait-for-device shell am start "com.google.android.music" >/dev/null 2>&1
	echo -e -n " Done\n"
	
	#<clear cache>
	echo -e -n " - Clear the Music app CACHE: "
	adb -s $deviceSerial wait-for-device shell am startservice -a com.google.android.music.download.cache.CacheService.CLEAR_CACHE com.google.android.music/.download.cache.TrackCacheService >/dev/null 2>&1
	echo -e -n " Done\n"
	
	echo -e -n " - Sleep for 10 seconds : "
	sleep 10
	echo -e -n " Done\n"
	
	#<play a radio>
	echo -e -n " - Start playing music : "
	#adb -s $deviceSerial wait-for-device shell input keyevent KEYCODE_MEDIA_PLAY_PAUSE
	adb -s $deviceSerial wait-for-device shell am start -a android.media.action.MEDIA_PLAY_FROM_SEARCH -c android.intent.category.DEFAULT -n com.google.android.music/.VoiceActionsActivity
	echo -e -n " Done\n"
	
	#<wait 30s>
	echo -e -n " - Sleep for 30s : "
	sleep 30
	echo -e -n " Done\n"	
	
	#<take dump>
	echo -e -n " - Take meminfo of Music app : "
	adb -s $deviceSerial wait-for-device shell dumpsys meminfo com.google.android.music:main > $logPath/$i-memdump_main-$deviceName-foreground.txt
	adb -s $deviceSerial wait-for-device shell dumpsys meminfo com.google.android.music:ui > $logPath/$i-memdump_ui-$deviceName-foreground.txt
	echo -e -n " Done\n"
	
	echo -e -n " - Take batterystats of Music app : "
	adb -s $deviceSerial wait-for-device shell dumpsys batterystats com.google.android.music > $logPath/$i-batdump_music-$deviceName-foreground.txt
	adb -s $deviceSerial wait-for-device shell dumpsys batterystats > $logPath/$i-batdump_all-$deviceName-foreground.txt
	echo -e -n " Done\n"
	
	#<background the app>
	echo -e -n " - Background the Music app (Home key) : "
	adb -s $deviceSerial wait-for-device shell input keyevent KEYCODE_HOME
	echo -e -n " Done\n"
	
	#<wait 15s>
	echo -e -n " - Sleep for 15s : "
	sleep 15
	echo -e -n " Done\n"
	
	#<take dump>
	echo -e -n " - Take meminfo of Music app : "
	adb -s $deviceSerial wait-for-device shell dumpsys meminfo com.google.android.music:main > $logPath/$i-memdump_main-$deviceName-background.txt
	adb -s $deviceSerial wait-for-device shell dumpsys meminfo com.google.android.music:ui > $logPath/$i-memdump_ui-$deviceName-background.txt
	echo -e -n " Done\n"
	
	echo -e -n " - Take batterystats of Music app : "
	adb -s $deviceSerial wait-for-device shell dumpsys batterystats com.google.android.music > $logPath/$i-batdump_music-$deviceName-background.txt
	adb -s $deviceSerial wait-for-device shell dumpsys batterystats > $logPath/$i-batdump_all-$deviceName-background.txt
	echo -e -n " Done\n"
	
	#<stop music>
	echo -e -n " - Stop/Pause playing music : "	
	adb -s $deviceSerial wait-for-device shell input keyevent KEYCODE_MEDIA_PLAY_PAUSE
	echo -e -n " Done\n"
	
	#<clear cache>
	echo -e -n " - Clear the Music app CACHE: "	
	adb -s $deviceSerial wait-for-device shell am startservice -a com.google.android.music.download.cache.CacheService.CLEAR_CACHE com.google.android.music/.download.cache.TrackCacheService >/dev/null 2>&1
	echo -e -n " Done\n"

	echo -e -n " - Sleep for 10s : "	
	sleep 10
	echo -e -n " Done\n"
	
	#<stop app>
	echo -e -n " - Stop the Music app : "	
	adb -s $deviceSerial wait-for-device shell am force-stop "com.google.android.music" >/dev/null 2>&1
	echo -e -n " Done\n"
	
	echo -e -n " - Reset battery stats : "
	adb -s $deviceSerial shell dumpsys batterystats --reset >/dev/null 2>&1
	echo -e -n " Done\n"
	
	let i=$i+1
done

echo -e -n "\n#### Done with all the iterations ####\n\n"
