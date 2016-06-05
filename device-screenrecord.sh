#!/bin/sh
#  device-screenrecord
#
set -e
set -u

NAME=`basename $0`
ARGS=2
usage () { 
cat << EOF
  Usage:  $NAME name <device_id>
          Takes a screenrecord of the currently-running device or emulator and saves the
          resulting to .mp4 with a filename based on the current date and the
          specified name (an arbitrary keyword)
EOF
}
if [ $# -gt $ARGS ]
then
  usage
  exit 1
fi

function error_exit() {
  echo "error: ${1:-'unknown error'}"
  exit 1
}

# make sure we have prodaccess before accessing x20
prodcertstatus -q --check_remaining_hours=0.1 || error_exit "Please run prodaccess."

ADB="adb "
if [ x"${2-}" != "x" ]; then
  ADB="adb -s $2 "
fi

KEYWORD=$1
# TODO: adb get-state to Sprat doesn't work
#STATE=$(eval $ADB get-state)
#if [[ "device" != "$STATE" ]]; then
#  echo "check adb state: $STATE"
#  exit 1
#fi

SCREENSHOTDIR="screenrecord"
FILENAME=`date "+%y%m%d-$1.mp4"`
SCREENSHOTPATH="/google/data/rw/users/${USER:0:2}/$USER/www/$SCREENSHOTDIR"
if [ ! -d "$SCREENSHOTPATH" ]; then
  mkdir -p "$SCREENSHOTPATH"
  chmod a+r "$SCREENSHOTPATH"
fi
SCREENSHOTPATH="$SCREENSHOTPATH/$FILENAME"
if [ -e "$SCREENSHOTPATH" ]; then
  error_exit "File $SCREENSHOTPATH already exists!  Use a different keyword."
fi

# Ok, capture the screenshot...
SDCARDDIR="/sdcard/screenrecord"
$ADB shell mkdir $SDCARDDIR 2>&1 > /dev/null
SDCARDPATH="$SDCARDDIR/$FILENAME"
$ADB shell screenrecord --bugreport "${SDCARDPATH}" &
function get_pid() {
  echo $($ADB shell ps | grep "screenrecord" | awk '{ print $2 }')
}
PID="$(get_pid)"
#echo $PID
if [ -z "$PID" ]; then 
  echo "screenrecord process not found. exit"
  return
fi

# Wait
read -s -p "Press [enter] to stop screenrecord" press_enter

echo
echo "INFO: Waiting for recording to be done..."
#kill -2 $PID
#adb shell kill -2 $PID  # requires root access
$ADB shell su 0 sh -c "kill -2 $PID" >& /dev/null
sleep 3
$ADB pull $SDCARDPATH "$SCREENSHOTPATH"

chmod a+r "$SCREENSHOTPATH"
echo
URL="https://x20web.corp.google.com/~$USER/$SCREENSHOTDIR/$FILENAME"
echo "==> Screenrecord is available here :  $URL"
echo

