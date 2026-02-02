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
### GNUstep-apps: First install of all Core apps
####################################################

### Install Applications: Preferences, GWorkspace, etc
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
. SCRIPTS/functions_inst_core_apps.sh


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
### Is there a USER APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	exit 1
fi

function the_apps
{
install_systempreferences
install_gworkspace

install_aclock
install_addressmanager
install_batmon
install_gnumail_svn
install_ink
install_innerspace
install_simpleagenda
install_terminal
install_timemon
install_volumecontrol
}
the_apps

#############################
### Wrapper for Agnostep_Manager

function install_AM
{
. SCRIPTS/functions_inst_wrappers.sh
. SCRIPTS/functions_inst_tools.sh
. SCRIPTS/functions_remove_app.sh

DEP_AM="dialog xterm"
APPNAME="AgnostepManager"
CHECK="YES"
remove_ifx_app "AgnostepManager"
install_wrapper "AgnostepManager" "${DEP_AM}"
move_to_tools "AgnostepManager"
set_conf "xterm"
}
install_AM

#############################

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
