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
### RPI Tools
#####################################

### Install Wrappers of the RPI Tools

################################
### ENV

_PWD=`pwd`
echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
LG={LANG:0:2}
case "$LG" in
"fr") TOOLS=Utilitaires;;
"en"|*) TOOLS=Utilities;;
esac

### End of VARS
################################

################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_remove_app.sh
. SCRIPTS/functions_inst_tools.sh
. SCRIPTS/functions_inst_wrappers.sh

### End of Include functions
################################

clear
STR="A G N o S t e p  -  RPI Tools"
subtitulo

################################
### Is there a USER APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	exit 1
fi

#################################################
### LOG

echo "$0" >>$LOG

STR="Dependencies of the RPI Tools"
subtitulo

DEPS="rpi-imager rp-bookshelf"
sudo apt -y install ${DEPS}
ok "Done"
sleep 2
clear

##############################################
## If you do not want any app to be installed
## Just comment the relevant line, below,
## save and run...
##############################################

install_rpi_tools

cd $_PWD

printf "Linking... Wait please.\n"
sudo ldconfig &>/dev/null &
PID=$!
spinner
ok "\rDone"


printf "Updating Services... Wait please.\n"
make_services &>/dev/null &
PID=$!
spinner
ok "\rDone"
