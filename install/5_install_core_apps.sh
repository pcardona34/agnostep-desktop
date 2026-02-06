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
### Install core apps and wrappers
####################################################

####################################################
### Vars

_PWD=`pwd`
RPI=1
CHECK=YES
SLEEP=2

### End of vars
####################################################

####################################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/size.sh

echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi

GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh

APPS_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)

clear

###############################
### RPI case?
is_hw_rpi
if [ $RPI -eq 0 ];then
	. SCRIPTS/inst_rpi_tools.sh
fi

###############################
### First time?

if [ ! -d $APPS_DIR/GWorkspace.app ];then
	. SCRIPTS/first_inst_core_apps.sh
	. SCRIPTS/inst_wrappers.sh
else
	. SCRIPTS/inst_core_apps.sh
fi
