#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

#####################################
### Install Developer Applications
#####################################

################################
### ENV

_PWD=`pwd`
echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT
SLEEP=2

### End of VARS
################################

################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/misc_info.sh
. SCRIPTS/functions_remove_app.sh
. SCRIPTS/functions_inst_devel.sh
. SCRIPTS/std_build.sh

### End of Include functions
################################

clear
STR="A G N o S t e p  -  Devel applications and Tools"
echo "$STR" >> $LOG
date >> $LOG

################################
### Is there a Build Folder?

if ! [ -d ../build ];then
	mkdir -p ../build
fi

################################
### Is there a LOCAL APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	sudo mkdir -p $INSTALL_DIR
fi

#################################################

function devel_apps_menu
{
dialog --clear --no-shadow --backtitle "${STR:0:15}" --title "${STR:20:28}" \
--ok-label "OK"  \
--checklist "
The list below contains the devel apps.

Check (space bar) the Applications you want to (re)install." 16 70 6 \
"EasyDiff" "A Diff application" off \
"Emacs" "The GNU Editor" off \
"Gemas" "GNUstep Devel Editor" off \
"Gorm" "GNUstep Interface Builder" off \
"ProjectCenter" "GNUstep Project Builder" off \
"Thematic" "A Theme Editor for GNUstep" off 2> $TEMPFILE

clear

# 0 if [OK] button was pushed;
# otherwise, exit the script.
if [ $? = 0 ];then
for i in `cat $TEMPFILE`
do
case "$i" in
"EasyDiff")
	APP=EasyDiff
	printf "You chose ${APP}\n"
	remove_ifx_app "${APP}"
	install_easydiff
	update_info_plist "${APP}";;
"Emacs")
	printf "You chose Emacs\n"
	remove_ifx_app "Emacs"
	install_emacs
	update_info_plist "Emacs";;
"Gemas")
	printf "You chose Gemas\n"
	remove_ifx_app "Gemas"
	install_gemas
	update_info_plist "Gemas";;
"Gorm")
	printf "You chose Gorm\n"
	remove_ifx_app "Gorm"
	install_gorm
	update_info_plist "Gorm";;
"ProjectCenter")
	printf "You chose ProjectCenter\n"
	remove_ifx_app "ProjectCenter"
	install_pc
	update_info_plist "ProjectCenter";;
"Thematic")
	printf "You chose Thematic\n"
	remove_ifx_app "Thematic"
	install_thematic
	update_info_plist "Thematic";;
esac
done
else exit 0
fi
}
#################################################

devel_apps_menu

#################################################

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



