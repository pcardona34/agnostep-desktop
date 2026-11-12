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

### We keep working directory
pushd .

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
. SCRIPTS/fetcher.sh
. SCRIPTS/functions_prep.sh
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

function the_apps_begin
{
install_systempreferences
install_gworkspace
}

function the_apps_follow
{
install_terminal
}

#echo -n "Do you want <s>table old releases or more <u>p to date ones? "
#read REP
#if [ "$REP" == "u" ];then
#    export UTD=u
#else
#    export UTD=s
#fi

clear_logs
reset_log
echo "$0" >> $LOG

the_apps_begin
is_log_ok "Core apps begin: SystemPreferences and GWorkspace"
sleep 4

the_apps_follow

#############################

printf "Linking... please wait...\n"
sudo ldconfig &>/dev/null &
PID=$!
spinner
ok "\rDone"

printf "Updating services: please wait...\n"
make_services
ok "Done"

popd
