#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Install the Window Manager
################################
### ENV

### We keep working directory
pushd .
SPIN='/-\|'
. /etc/os-release

### End of VARS
################################

################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/fetcher.sh

### End of Include functions
################################

################################

clear_logs
reset_log
echo "$0" >>$LOG

clear
STR="Window Manager"
titulo

echo -n "Choose your Window Manager"
echo -e "\n\tClassic for a daily use: Window Maker: <w>"
echo -e "\tModern and experimental: Gnustep Window Manager: <g>"
read -p "Your choice: " REP
case "$REP" in

"w")

########### !!! We do not build ############
#. SCRIPTS/functions_inst_wmaker.sh
#LIST="wmaker" && install_deps
#check_LD_LIB_PATH
#install_wmaker || exit 1
############################################

### But We install regular deb #################
sudo apt -y install wmaker wmaker-utils;;

"g")

if [ ! -f SCRIPTS/env_modern.sh ];then
    alert "You must install GNUstep System with a modern ABI (libobjc2). Aborting."
    exit 1
fi

. SCRIPTS/inst_gswm.sh
. SCRIPTS/inst_dock.sh

esac

ok "Done"
popd
