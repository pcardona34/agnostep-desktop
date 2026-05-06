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
### AGNOstep native apps in purpose: install by menu
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

FICHTEMP=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $FICHTEMP" EXIT

### End of VARS
################################

################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/spinner.sh
. SCRIPTS/size.sh
. SCRIPTS/functions_remove_app.sh
. SCRIPTS/functions_prep.sh

### End of Include functions
################################

clear
STR="A G N o S t e p  -  Native Apps in Purpose"
titulo

################################
### Is there a LOCAL APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	sleep 5;exit 1
fi

### End of VARS
################################

################################
### local functions

function install_native
{
NATIVE="$1"
APPS=RESOURCES/APPS

if [ -n "$1" ];then
    cd ${APPS}/${NATIVE} || exit 1
    ./install.sh
fi
}

function menu
{
# checkbox dialog
dialog --backtitle "$STR" --title "Native Agnostep Apps" \
--ok-label "OK"  \
--checklist "
Check the Apps you want to reinstall." 20 60 10 \
"AgnoManager" "Agnostep Manager" off \
"Birthday" "Family Events reminder" off \
"Dico" "French Dictionary Lookup" off \
"Launcher" "Diplays Applications Folder" off \
"Meteo" "A Weather dockapp" off \
"Mixer" "ALSA simplified Mixer (on RPI)" off \
"OpenDisk" "Content of Removable Disk" off \
"Pass" "Interface for Unix Password Manager" off \
"Printer" "Printer settings with CUPS" off \
"SaveLink" "Internet Shortcuts Manager" off \
"ScreenLock" "Screen Locker" off \
"Sound" "Sound Testing and Setting" off \
"Updater" "Debian Updates Manager" off \
"UpMem" "Uptime and Memory Monitoring" off 2> $FICHTEMP

clear

# 0 : return code of OK button.
# Only O permits to go on.
# Otherwise, script will stop.
if [ $? = 0 ]
then
for i in `cat $FICHTEMP`
do
case "$i" in
"AgnoManager")
	printf "You chose AgnostepManager\n"
	remove_ifx_app "AgnostepManager"
	install_native "AgnostepManager";;
"Birthday")
	printf "You chose Birthday\n"
	remove_ifx_app "Birthday"
	install_native "Birthday";;
"Dico")
	printf "You chose Dico\n"
	remove_ifx_app "Dico"
	install_native "Dico";;
"Launcher")
	printf "You chose Launcher\n"
	remove_ifx_app "Launcher"
	install_native "Launcher";;
"Meteo")
	printf "You chose Meteo\n"
	remove_ifx_app "Meteo"
	install_native "Meteo";;
"Mixer")
	printf "You chose Mixer\n"
	remove_ifx_app "Mixer"
	install_native "Mixer";;
"OpenDisk")
	printf "You chose OpenDisk\n"
	remove_ifx_app "OpenDisk"
	install_native "OpenDisk";;
"Pass")
	printf "You chose Pass\n"
	remove_ifx_app "Pass"
	install_native "Pass";;
"Printer")
	printf "You chose Printer\n"
	remove_ifx_app "Printer"
	install_native "Printer";;
"SaveLink")
	printf "You chose SaveLink\n"
	remove_ifx_app "SaveLink"
	install_native "SaveLink";;
"ScreenLock")
	printf "You chose ScreenLock\n"
	remove_ifx_app "ScreenLock"
	install_native "ScreenLock";;
"Sound")
	printf "You chose Sound\n"
	remove_ifx_app "Sound"
	install_native "Sound";;
"Updater")
	printf "You chose Updater\n"
	remove_ifx_app "Updater"
	install_native "Updater";;
"UpMem")
	printf "You chose UpMem\n"
	remove_ifx_app "UpMem"
	install_native "UpMem";;
esac
done
else exit 0
fi
}

### End of local  functions
################################


#############################################
### Updating debian packages if necessary
sudo apt -y update && sudo apt -y upgrade

menu

#############################################
### Post-install

printf "Linking: wait please...\n"
sudo ldconfig &>/dev/null &
PID=$!
spinner
ok "\rDone"

printf "\nUpdating Services: wait please...\n"
make_services &>/dev/null &
PID=$!
spinner
ok "\rDone"

print_size

sleep 2

cd ${_PWD}
