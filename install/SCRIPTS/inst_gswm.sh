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
### gnustep-windowmanager
### a fork of Gershwin-Windowmanager by Joseph Maloney
####################################################

################################
### ENV

_PWD=`pwd`
CHECK=NO
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

#INSTALL_ARGS="GNUSTEP_INSTALLATION_DOMAIN=LOCAL"
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
. SCRIPTS/functions_inst_gswm.sh

### End of Include functions
################################

clear
STR="A G N o S t e p  -  GNUstep Window Manager"
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

wm_deps || exit 1
export DEBUG=yes
#export DLOG="./Debug_gs_wm.log"
#install_wm

#########################################

if [ "$DEBUG" == "yes" ];then
    printf "\nNot linking too..."
else
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
fi
sleep 2
