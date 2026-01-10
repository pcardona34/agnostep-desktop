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
### Wrappers
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
LOG="$HOME/AGNOSTEP_BUILD_WRAPPERS.log"
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
#INSTALL_ARGS="GNUSTEP_INSTALLATION_DOMAIN=LOCAL"
### End of VARS
################################

################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_inst_wrappers.sh

### End of Include functions
################################

clear
title "A G N o S t e p  -  Wrappers"

################################

### Declare_deps_wrappers
### Name after DEP_ must follow the wrapper name.
LG=${LANG:0:2}
DEP_Firefox="firefox-esr-l10n-${LG}"
DEP_EBookReader="fbreader"
DEP_Inkscape="inkscape"
DEP_Writer="focuswriter"
DEP_Upgrade="xterm"

################################
### Is there a USER APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	exit 1
fi

#################################################
### New LOG

echo "$0" >$LOG

sudo apt -y update && sudo apt -y upgrade && sudo apt -y autoremove

install_wrapper Firefox "$DEP_Firefox"
install_wrapper EBookReader "$DEP_EBookReader"
install_wrapper Inkscape "$DEP_Inkscape"
install_wrapper Writer "$DEP_Writer"
install_wrapper Upgrade "$DEP_Upgrade"

sudo ldconfig
make_services
