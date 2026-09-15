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
### W  A  R  N  I  N  G !
### We install GNUstep with the GNU Runtime
####################################################

####################################################
### Installation of GNUstep Core
####################################################

####################################################
### Vars

THERE=`pwd`
SPIN='/-\|'
GS_ERRORS=0
. /etc/os-release
GSBUILD="../build/GNUstep_Build"
GS_SCRIPT=/System/Library/Makefiles/GNUstep.sh
SYSTEM=/System
LOCAL=/Local

#set -v #For debugging the script only

### End of vars
####################################################

####################################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/fetcher.sh
. SCRIPTS/functions_install_gnustep.sh

### End of include functions
####################################################

clear
STR="Prepare the GNUstep installation"
titulo

##########################################
### DEPENDENCIES

cd $THERE
LIST="gnustep" && install_deps

################################

STR="Installing all GNUstep libs and Tools"
titulo

STR="Sweep out previous installation"
subtitulo

for GS_DIR in $SYSTEM $LOCAL
do
    if [ -d $GS_DIR ];then
        echo -e "\tDeleting $GS_DIR..." && sudo rm -fR $GS_DIR
    fi
done

ok "Sweep out done"

# Create build directory

cd ${THERE}

sudo rm -fR ${GSBUILD}
mkdir -p ${GSBUILD}

#################################################
# What stability?
STR="Stable or Up to date?";subtitulo

echo -n "Do you want a <s>table old release or one more <u>p to date? "
read UTD
if [ -z "$UTD" ] || [ "$UTD" == "u" ];then
    export UTD="u"
else
    export UTD="s"
fi

#################################################
# Checkout sources
export GSBUILD

cd ${GSBUILD} || exit 1
fetch_sources
cd ${THERE}

#################################################
### Install Make (1)

cd ${GSBUILD} || exit 1
install_make
cd ${THERE}

if [ -f $GS_SCRIPT ];then
	. $GS_SCRIPT
else
	alert "The path of GNUstep Makefiles is badly set."
	exit 1
fi

grep -e "$GS_SCRIPT" ~/.bashrc &>/dev/null
if [ $? -ne 0 ];then
#	echo "export PATH=/System/Tools:$PATH" >> ~/.bashrc
	echo ". $GS_SCRIPT" >> ~/.bashrc
fi

#################################################
## Build GNUstep base

. $GS_SCRIPT

cd ${GSBUILD} || exit 1
install_base
cd $THERE

sudo ldconfig

# Checking...
is_log_ok "$BASE" || exit 1

#################################################
## Build GNUstep GUI

. $GS_SCRIPT

cd ${GSBUILD} || exit 1
install_gui
cd $THERE

sudo ldconfig

# Checking...
is_log_ok "$GUI" || exit 1

#################################################
## Build GNUstep back

. $GS_SCRIPT

cd ${GSBUILD} || exit 1
install_back
cd $THERE

sudo ldconfig

# Checking...
is_log_ok "BACK" || exit 1

ok "Building of GNUstep was successfully done."
