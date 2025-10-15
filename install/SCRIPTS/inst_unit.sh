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
### inst_unit.sh: install one app
### Usefull to update the project
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
LOG="$HOME/AGNOSTEP_BUILD_UNIT.log"
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
. SCRIPTS/functions_inst_apps.sh
. SCRIPTS/functions_inst_extra.sh
. SCRIPTS/functions_inst_devel.sh
. SCRIPTS/functions_inst_games.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/functions_inst_wrappers.sh
. SCRIPTS/std_build.sh

### End of Include functions
################################

clear
title "A G N o S t e p  -  Install apps one by one"

################################
### Is there a Build Folder?

if ! [ -d ../build ];then
	mkdir -p ../build
fi

################################
### Is there a USER APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	exit 1
fi

#################################################
### New LOG

echo "$0" >$LOG

##############################################
## If you want some app to be installed
## Just uncomment the relevant line, below,
## save and run...
##############################################

#install_systempreferences
#install_gworkspace
#install_helpviewer
#install_textedit
#install_openup
#install_addressmanager
#install_gnumail
#install_grr
install_agenda
#install_terminal
#install_gspdf
#install_imageviewer
#install_cynthiune
#install_player
#install_librarian
#install_innerspace
#install_scanimage
#install_screenshot
#install_volumecontrol
#install_ink
#install_wrappers

##################
### Removed
#install_affiche
#install_timemon
##################

sudo ldconfig
make_services
