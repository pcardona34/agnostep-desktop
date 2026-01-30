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

### End of vars
####################################################

####################################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/size.sh

clear

is_hw_rpi
if [ $RPI -eq 0 ];then
	. SCRIPTS/inst_rpi_tools.sh
fi

which -s GWorkspace
if [ $? -ne 0 ];then
	. SCRIPTS/first_inst_core_apps.sh
	. SCRIPTS/inst_wrappers.sh
else
	. SCRIPTS/inst_core_apps.sh
fi
