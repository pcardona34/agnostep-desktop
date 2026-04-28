#!/bin/bash

echo "$0 is launched"

APPNAME=AgnostepManager
APPS_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
RES=$APPS_DIR/${APPNAME}.app/Resources

if [ ! -d $HOME/SOURCES/agnostep-desktop ];then
	stexec $RES/alert_missing.st
	#TITLE="Recovering"
	#APP=$APPS_DIR/$TOOLS/${APPNAME}.app/Recover
	#xterm -T "${TITLE}" -e "$APP" &
else
	cd $HOME/SOURCES/agnostep-desktop
     pwd
     echo "Running agnostep..."
	./agnostep.sh
fi
