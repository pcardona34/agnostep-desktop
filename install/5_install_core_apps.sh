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
### Install core apps
### List renewed and simplified
### since release 3.x
####################################################

####################################################
### Vars

### We keep working directory
pushd .
CHECK=YES
export SLEEP=2

### End of vars
####################################################

####################################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/size.sh
. SCRIPTS/functions_remove_app.sh

GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh

APPS_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)

clear

###############################
### First time?

if [ ! -d $APPS_DIR/GWorkspace.app ];then
	. SCRIPTS/first_inst_core_apps.sh
else
	. SCRIPTS/inst_core_apps.sh
fi

info "Core Apps have been installed. You should now execute next stage: Settings"
popd
