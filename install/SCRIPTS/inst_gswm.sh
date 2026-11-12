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

#export DEBUG=yes

gswm_deps || exit 1

#export DLOG="./Debug_gs_wm.log"
install_gswm

popd
