#!/bin/sh
#
#  device-screenshot   dab 3/10/09  (based on dab@ device-screenshot)
#
# Useful script for taking screen shots from an Android device which I then need to send
# to other people, or include in a bug report.
#
# This script takes a "keyword" argument (intended to be a description of the screenshot
# you're taking), runs a command to take the screenshot, and saves the resulting PNG file
# in a directory under your "~/www" directory (see SCREENSHOTPATH below) with a filename
# based on the current date/time and the specified keyword.
#
# It also prints out a URL (under www.corp.google.com) that other people on the corp
# network can use to view that screenshot.  (Note 1: This will only work if your
# screenshot directory is world-readable.  Note 2: After writing a screenshot file, it can
# take a minute or so before www.corp can see it.)
#


NAME=`basename $0`
ARGS=2
usage () { 
cat << EOF
  Usage:  $NAME name <device_id>
          Takes a screenshot of the currently-running device or emulator and saves the
          resulting image as a PNG with a filename based on the current date and the
          specified name (an arbitrary keyword), then prints out the URL where the image
          can be found at www.corp.google.com.
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

# Directory under "~/www" where screenshots should be saved
SCREENSHOTDIR="screenshot"
FILENAME=`date "+%y%m%d-$1.png"`
SCREENSHOTPATH="/google/data/rw/users/${USER:0:2}/$USER/www/$SCREENSHOTDIR"
#SCREENSHOTPATH="$HOME/logs/$SCREENSHOTDIR"  # local directory
if [ ! -d "$SCREENSHOTPATH" ]; then
  mkdir -p $SCREENSHOTPATH
  chmod a+r $SCREENSHOTPATH
fi
SCREENSHOTPATH="$SCREENSHOTPATH/$FILENAME"
if [ -e "$SCREENSHOTPATH" ]; then
  error_exit "File $SCREENSHOTPATH already exists!  Use a different keyword."
fi

# Ok, capture the screenshot...

# Approach #1: Depends on having a "screenshot2" executable, but works on all platforms.
#
# Note you need to have the "screenshot2" shell script in your path.
# (As of late 2012 / early 2013, you can run "m screenshot2" in a master tree
# to build it.  As of March 2013, it's in prebuilts/devtools/tools in master.)

#screenshot2 $SCREENSHOTPATH

#
# Approach #2: doesn't require the "screenshot2" host tool, but depends on
# "adb shell screencap" which is only ICS(?) and later.
#
#   adb shell screencap -p | sed 's/\r$//' > $SCREENSHOTPATH
#
# Or, if the line endings cause trouble and the above "sed" command doesn't help,
# just do:
$ADB shell screencap -p /sdcard/screen.png
$ADB pull /sdcard/screen.png $SCREENSHOTPATH
#

# umask seems to default to 0027 under Goobuntu, so need to manually make the file
# world-readable (so that the www.corp web server can read it.)  Note that SCREENSHOTDIR
# itself must also be world-readable so that the www.corp web server can read its files.
chmod a+r $SCREENSHOTPATH

echo
URL="https://x20web.corp.google.com/~$USER/$SCREENSHOTDIR/$FILENAME"
echo "==> Screenshot is available here:    $URL"
echo
