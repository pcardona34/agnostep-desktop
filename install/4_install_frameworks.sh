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

echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi

THERE=`pwd`
_PWD=`pwd`
SPIN='/-\|'
. /etc/os-release
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
SLEEP=2
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_LIBRARY)
INSTALL_DIR=${INSTALL_DIR}/Frameworks

if [ ! -d $INSTALL_DIR ];then
	sudo mkdir -p $INSTALL_DIR
fi

################################
### Include functions

. SCRIPTS/log.sh
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
### Deps
################################

clear
STR="Frameworks"
titulo

LIST="apps" && install_deps || exit 1
ok "$STR Dependencies: done"
sleep $SLEEP;clear


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
install_webservices
install_steptalk
install_dbuskit
install_popplerkit

####################################

sudo ldconfig

MSG="All was done for the Frameworks. \nThe Core Desktop has been set. \n\nIt is time to install Core Apps..."
echo "$MSG" >>$LOG
info "$MSG"
sleep 2


