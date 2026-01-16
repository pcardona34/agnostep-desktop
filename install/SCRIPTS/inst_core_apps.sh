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
### GNUstep-apps: Core apps for AGNoStep Desktop
####################################################

### Install Applications: Preferences, GWorkspace, etc
### See RELEASE for a complete list
### N.B.: Developer apps are divided into inst_devel.sh

################################
### ENV

_PWD=`pwd`
echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
LOG="$HOME/AGNOSTEP_BUILD_CORE_APPS.log"
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT

#INSTALL_ARGS="GNUSTEP_INSTALLATION_DOMAIN=LOCAL"
### End of VARS
################################

################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_inst_core_apps.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/std_build.sh

### End of Include functions
################################

clear
STR="A G N o S t e p  -  Main applications and Tools"
titulo

################################
### Is there a Build Folder?

if ! [ -d ../build ];then
	mkdir -p ../build
fi

################################
### Is there a LOCAL APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	exit 1
fi

function remove_if_present
{
APP="$1"
if [ -d $INSTALL_DIR/${APP}.app ];then
	sudo rm -fR $INSTALL_DIR/${APP}.app
fi
printf "The previous installation of ${APP} has been removed.\n"
}

###########################################
function core_apps_menu
{
dialog --no-shadow --backtitle "${STR:0:15}" --title "${STR:20:27}" \
--ok-label "OK"  \
--checklist "
The list below contains the core apps.

Check (space bar) the Applications you want to reinstall." 22 70 14 \
"AClock" "Analogic Clock for the Classic Flavour" off \
"AddressManager" "Manage the Persons: email, birthdate..." off \
"BatMon" "Monitoring the Battery on Laptops" off \
"GNUMail" "The GNUstep Mail User Agent" off \
"GWorkspace" "The NeXT like Workspace Manager" off \
"InnerSpace" "The GNUstep Screensaver" off \
"SimpleAgenda" "A Simple Agenda to manage Events and Tasks" off \
"SystemPreferences" "Preferences of the GNUstep System" off \
"Terminal" "The GNUstep Terminal Emulator" off \
"TextEdit" "The Raw and Rich Text Editor" off \
"TimeMon" "The CPU Load Monitor ported from OPENSTEP" off \
"VolumeControl" "The Sound Level Controller" off 2> $TEMPFILE

# 0 if [OK] button was pushed;
# otherwise, exit the script.
if [ $? = 0 ];then
for i in `cat $TEMPFILE`
do
case "$i" in
"AClock")
	printf "You chose AClock\n"
	remove_if_present "AClock"
	install_aclock;;
"AddressManager")
	printf "You chose AddressManager\n"
	remove_if_present "AddressManager"
install_addressmanager;;
"BatMon")
	printf "You chose BatMon\n"
	remove_if_present "batmon"
	install_batmon;;
"GNUMail")
	printf "You chose GNUMail\n"
	remove_if_present "GNUMail"
	install_gnumail_svn;;
"GWorkspace")
	printf "You chose GWorkspace\n"
	if [ $DISPLAY ];then
		alert "You must logout and update GWorkspace within a TTY env.";exit
	fi
	remove_if_present "GWorkspace"
	remove_if_present "MDFinder"
	install_gworkspace;;
"InnerSpace")
	printf "You chose InnerSpace\n"
	remove_if_present "InnerSpace"
	install_innerspace;;
"SimpleAgenda")
	printf "You chose SimpleAgenda\n"
	remove_if_present "SimpleAgenda"
	install_simpleagenda;;
"SystemPreferences")
	printf "You chose SystemPreferences\n"
	remove_if_present "SystemPreferences"
	install_systempreferences;;
"Terminal")
	printf "The GNUstep Terminal Emulator\n"
	remove_if_present "Terminal"
	install_terminal;;
"TextEdit")
	printf "You chose TextEdit\n"
	remove_if_present "TextEdit"
	install_textedit;;
"TimeMon")
	printf "You chose TimeMon\n"
	remove_if_present "TimeMon"
	install_timemon;;
"VolumeControl")
	printf "You chose VolumeControl\n"
	remove_if_present "VolumeControl"
	install_volumecontrol;;
esac
done
else exit 0
fi
}
#########################################

core_apps_menu

printf "Linking and making services: please wait...\n"

sudo ldconfig
make_services

print_size
