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
LOG="$HOME/AGNOSTEP_BUILD_DEVEL.log"
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
. SCRIPTS/functions_inst_devel.sh
. SCRIPTS/std_build.sh

### End of Include functions
################################

clear
STR="A G N o S t e p  -  Devel applications and Tools"
titulo

################################
### Is there a Build Folder?

if ! [ -d ../build ];then
	mkdir -p ../build
fi

################################
### Is there a LOCAL APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	mkdir -p $INSTALL_DIR
fi

#################################################

function remove_if_present
{
APP="$1"
if [ -d $INSTALL_DIR/${APP}.app ];then
	sudo rm -fR $INSTALL_DIR/${APP}.app
fi
printf "The previous installation of ${APP} has been removed.\n"
}

##################################################
function info_renaissance
{
dialog --no-shadow --backtitle "Devel applications" --title "Renaissance Framework" \
--sleep 6 --infobox "
The tools associated with the Framework Renaissance has been already installed:
- GSMarkupBrowser.app
- GSMarkupLocalizableStrings.app" 8 60
}

###############

info_renaissance

####################################################
function devel_apps_menu
{
dialog --no-shadow --backtitle "${STR:0:15}" --title "${STR:20:28}" \
--ok-label "OK"  \
--checklist "
The list below contains the devel apps.

Check (space bar) the Applications you want to (re)install." 15 70 8 \
"EasyDiff" "A Diff application" off \
"Emacs" "The GNU Editor" off \
"Gemas" "GNUstep Devel Editor" off \
"Gorm" "GNUstep Interface Builder" off \
"ProjectCenter" "GNUstep Project Builder" off \
"Thematic" "A Theme Editor for GNUstep" off 2> $TEMPFILE

# 0 if [OK] button was pushed;
# otherwise, exit the script.
if [ $? = 0 ];then
for i in `cat $TEMPFILE`
do
case "$i" in
"EasyDiff")
	printf "You chose EasyDiff\n"
	remove_if_present "EasyDiff"
	install_easydiff;;
"Emacs")
	printf "You chose Emacs\n"
	remove_if_present "Emacs"
	install_emacs;;
"Gemas")
	printf "You chose Gemas\n"
	remove_if_present "Gemas"
	install_gemas;;
"Gorm")
	printf "You chose Gorm\n"
	remove_if_present "Gorm"
	install_gorm;;
"ProjectCenter")
	printf "You chose ProjectCenter\n"
	remove_if_present "ProjectCenter"
install_pc;;
"Thematic")
	printf "You chose Thematic\n"
	remove_if_present "Thematic"
install_thematic;;
esac
done
else exit 0
fi
}
#################################################


devel_apps_menu

printf "Linking and making services: wait please...\n"

sudo ldconfig
make_services

print_size

sleep 2
