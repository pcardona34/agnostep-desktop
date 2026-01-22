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
### Frameworks
################################

################################
### VARS

#echo "PATH (0) is: $PATH";sleep 5

echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
LOG=$HOME/AGNOSTEP_BUILD_FW.log
THERE=`pwd`
_PWD=`pwd`
SPIN='/-\|'
. /etc/os-release
#. SCRIPTS/environ.sh
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
#echo "GSMAKE is: $GSMAKE";sleep 5
. ${GSMAKE}/GNUstep.sh
#|| alert "No $GSMAKE found";exit 1

#echo "PATH (1) is: $PATH";sleep 5

INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_LIBRARY)
INSTALL_DIR=${INSTALL_DIR}/Frameworks

#echo "INSTALL_DIR is: $INSTALL_DIR";sleep 5

if [ ! -d $INSTALL_DIR ];then
	sudo mkdir -p $INSTALL_DIR
fi

################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/std_build.sh
. SCRIPTS/check_app.sh
. SCRIPTS/patch_with_quilt
. SCRIPTS/functions_inst_frameworks.sh

### End of Include functions
################################
################################
### Deps
################################

clear
STR="Frameworks"
titulo

LIST="apps" && install_deps || exit 1

if ! [ -d ../build ];then
	mkdir -p ../build
fi

install_pdfkit
install_fw_addresses
install_fw_addressview
install_pantomime
install_SWK
install_rsskit
install_hlkit
install_hkthemes
install_renaissance
install_performance
#install_webservices # removed: connection timed out on 10.18.0.6 port 10091
install_steptalk
install_dbuskit
#install_popplerkit # removed due to poppler-splash dep issue

####################################

sudo ldconfig

MSG="All is done for the Frameworks."
echo "$MSG" >>$LOG
info "$MSG"
sleep 2


