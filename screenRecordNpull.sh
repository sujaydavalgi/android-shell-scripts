# Created by Sujay Davalgi
#
# Records the activities in the screen of the selected device and stores them in the device sd-card
# then pulls the saved file to the "Bugs" folder
#
# Usage: ./recordNpullVideo.sh [<filename>]
# Command line Arguments (Optional):
#       $1 - Input the file name
#               If the filename is not provided, it will prompt to enter the filename

. ./library/mainFunctions.sh
. ./library/textFormatting.sh
. ./library/deviceOperations.sh
. ./library/logFunctions.sh

SearchForFile="*.mp4"

if [ $# -lt 1 ]; then
        pbold "\n Enter the Video File name : "
        read fileName
else
        fileName="$1"
fi

getDeviceChoice
displaySelectedDevice $deviceSerial

function pullRecordedVideo(){
	#searchNpullDeviceFilesFrmFldr $deviceSerial ${RecordFolder} ${SearchForFile}
	echo -e -n "\n\n Pulling the device file ${RecordFolder}/${fileName}.mp4 to ${myLogs}\n\n"
	sleep 1s
	adb -s $deviceSerial wait-for-device pull "${RecordFolder}/${fileName}.mp4" "${myLogs}"
}

if [ $( isAdbDevice $deviceSerial ) == "true" ]; then
        #if [[ "$( isDeviceBuildDevKey $deviceSerial )" == "true" || "$( isDeviceBuildTestKey $deviceSerial )" == "true" ]]; then
                fileName=`echo $( getFormatedFileName $deviceSerial ${fileName} )`

                echo -e -n " Your video will be saved in device folder ${RecordFolder} as : ${fileName}.mp4\n\n"

                #adb -s $deviceSerial wait-for-device root
                #sleep 1s
                trap pullRecordedVideo SIGINT
                recordDeviceVideo $deviceSerial ${RecordFolder} ${fileName}
                removeSingleFileFromFolder $deviceSerial ${RecordFolder} "${fileName}.mp4"
        #else
        #        echo -e -n " Device doesnot support root access\n"
        #fi
else
        echo -e -n " Device is not in adb mode\n"
fi
