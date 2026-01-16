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

RPI=1

### End of vars
####################################################

####################################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/size.sh


is_hw_rpi
if [ $RPI -eq 0 ];then
	. SCRIPTS/inst_rpi_tools.sh
fi

. SCRIPTS/first_inst_core_apps.sh
. SCRIPTS/inst_wrappers.sh


### Space available ?
print_size

