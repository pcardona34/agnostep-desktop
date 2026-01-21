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
### Install Frameworks one by one
### For test or update purpose
### To use:
### From 'install' folder:
### bash ./SCRIPTS/ins_unit_FW.sh <FW_name>
################################

################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/std_build.sh
. SCRIPTS/check_app.sh
. SCRIPTS/patch_with_quilt.sh
. SCRIPTS/functions_inst_frameworks.sh


### End of Include functions
################################

################################
### VARS

clear
if [ -n "$1" ];then
        FWTOINST="$1"
        printf "$FWTOINST\n"
else
        info "You must give the name of the frameworks (only small caps) as argument."
        cli "$0 <fw_name>"
        exit 1
fi


#echo "PATH (0) is: $PATH";sleep 5

echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
LOG=$HOME/AGNOSTEP_BUILD_UNIT_FW.log
THERE=`pwd`
_PWD=`pwd`
SPIN='/-\|'
. /etc/os-release
export GNUSTEP_MAKEFILES=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GNUSTEP_MAKEFILES}/GNUstep.sh

INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_LIBRARY)
INSTALL_DIR=${INSTALL_DIR}/Frameworks

if [ ! -d $INSTALL_DIR ];then
	sudo mkdir -p $INSTALL_DIR
fi

################################
### Deps
################################

clear
STR="Frameworks";titulo

LIST="apps" && install_deps || exit 1
sleep 2;clear

titulo
if ! [ -d ../build ];then
	mkdir -p ../build
fi

################################
### This is the list of available FW: do not uncomment!
# pdfkit
# addresses
# addressview
# pantomime
# SWK
# rsskit
# hlkit
# hkthemes
# renaissance
# performance
# webservices
# steptalk
# dbuskit
# netclasses

####################################

install_${FWTOINST}
sudo ldconfig

MSG="All is done for the Frameworks ${FWTOINST}."
echo "$MSG" >>$LOG
info "$MSG"
sleep 1
