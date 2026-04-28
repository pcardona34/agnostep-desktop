#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### AGNOstep native apps in purpose: First install
####################################################

################################
### ENV

_PWD=`pwd`
echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)

### End of VARS
################################

################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/spinner.sh

### End of Include functions
################################

clear
STR="A G N o S t e p  -  Native Apps in Purpose"
titulo

################################
### Is there a APPS Folder?

APPS=RESOURCES/APPS
cd ${APPS} || exit 1

################################
### Is there a LOCAL APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	exit 1
fi

for NATIVE in AgnostepManager Birthday Dico Launcher Meteo Mixer OpenDisk Pass Printer SaveLink ScreenLock Sound Updater UpMem
do
cd $NATIVE || exit 1
./install.sh
cd ..
done

cd ${_PWD}

printf "Linking... please wait...\n"
sudo ldconfig &>/dev/null &
PID=$!
spinner
ok "\rDone"

printf "Updating services: please wait...\n"
make_services &>/dev/null &
PID=$!
spinner
ok "\rDone"
