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

### We keep working directory
pushd .

CHECK=YES
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT

### End of VARS
################################

################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/std_build.sh
. SCRIPTS/patch_with_quilt.sh
. SCRIPTS/misc_info.sh
. SCRIPTS/functions_remove_app.sh
. SCRIPTS/fetcher.sh
. SCRIPTS/functions_inst_core_apps.sh

### End of Include functions
################################

clear_logs
reset_log
echo "$0" >>$LOG

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

###########################################
function core_apps_menu
{
dialog --no-shadow --backtitle "${STR:0:15}" --title "${STR:20:27}" \
--ok-label "OK"  \
--checklist "
The list below contains the core apps.

Check (space bar) the Main Applications you want to reinstall." 22 70 14 \
"Finder" "A FileViewer alternative" off \
"GWorkspace" "The NeXT like Workspace Manager" off \
"SystemPreferences" "Preferences of the GNUstep System" off \
"Terminal" "The GNUstep Terminal Emulator" off 2> $TEMPFILE

# 0 if [OK] button was pushed;
# otherwise, exit the script.

clear

if [ $? = 0 ];then
for i in `cat $TEMPFILE`
do
case "$i" in
"Finder")
	printf "You chose Finder FileViewer\n"
	remove_ifx_app "FileViewer"
	install_finder
	update_info_plist "FileViewer";;
"GWorkspace")
	printf "You chose GWorkspace\n"
	if [ $DISPLAY ];then
		alert "You must logout and update GWorkspace within a TTY console.";sleep 10;exit
	fi
	remove_ifx_app "GWorkspace"
	#remove_ifx_app "MDFinder"
	install_gworkspace
	update_info_plist "GWorkspace";;
"SystemPreferences")
	printf "You chose SystemPreferences\n"
	remove_ifx_app "SystemPreferences"
	install_systempreferences
	update_info_plist "SystemPreferences";;
"Terminal")
	printf "The GNUstep Terminal Emulator\n"
	remove_ifx_app "Terminal"
	install_terminal
	update_info_plist "Terminal";;
esac
done
else exit 0
fi
}
#########################################

#echo -n "Do you want <s>table old releases or more <u>p to date ones? "
#read REP
#
#if [ "$REP" == "u" ];then
#    export UTD=u
#else
#    export UTD=s
#fi

core_apps_menu

#########################################

printf "Linking: wait please...\n"
sudo ldconfig &>/dev/null &
PID=$!
spinner
ok "\rDone"

printf "Updating the services...\n"
make_services
ok "Done"

print_size
sleep 2

popd
