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

SPIN='/-\|'
GS_ERRORS=0
. /etc/os-release
GSBUILD="../build/GNUstep_Build"
### If it was Modern ABI
GSSYS=/lib/GNUstep
### If it was Legacy
SYSTEM=/System
LOCAL=/Local
ABI="LEGACY"

### We keep working directory
pushd .

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

#########################
### Logs

clear_logs
reset_log

clear
STR="Prepare the GNUstep installation"
titulo

##########################################
### DEPENDENCIES

popd
LIST="gnustep" && install_deps

################################

STR="Installing all GNUstep libs and Tools"
titulo

STR="Sweep out previous installation"
subtitulo

for GS_DIR in $SYSTEM $LOCAL $GSSYS
do
    if [ -d $GS_DIR ];then
        echo -e "\tDeleting $GS_DIR..." && sudo rm -fR $GS_DIR
    fi
done
echo "GNUstep previous dirs were deleted."

ok -e "\n(i) Sweep out done.\n"

# Create clean build directory

sudo rm -fR ${GSBUILD}
mkdir -p ${GSBUILD}

#################################################
# What stability?

#STR="Stable or Up to date?";subtitulo
#
#echo -n "Do you want a <s>table old release or one more <u>p to date? "
#read UTD
#if [ -z "$UTD" ] || [ "$UTD" == "u" ];then
#    export UTD="u"
#else
#    export UTD="s"
#fi

STR="Legacy or Modern";subtitulo

echo -n "Do you want libobjc2 (modern ABI) or GNUstep Legacy?"
echo -e "\n\t Legacy: <1>"
echo -e "\t Modern libobjc2: <2>"
echo -n "Your choice: "
read REP
if [ $REP -eq 2 ];then
    export ABI="MODERN"
    if [ -f SCRIPTS/env_modern.txt ];then
        mv SCRIPTS/env_modern.txt SCRIPTS/env_modern.sh
    fi
else
    if [ -f SCRIPTS/env_modern.sh ];then
        mv SCRIPTS/env_modern.sh SCRIPTS/env_modern.txt
    fi
fi

#################################################
# Checkout sources

export GSBUILD

pushd .

cd ${GSBUILD} || exit 1

if [ "$ABI" == "MODERN" ];then
    fetch_gcd
    fetch_libobjc2
fi

### Other sources: tools-make, base, gui and back
fetch_sources

popd

#################################################
### install libobjc2
if [  "$ABI" == "MODERN" ];then
    ### Dependencies
    STR="Dependencies for libobjc2";subtitulo
    LIST="libobjc2" && install_deps
    sleep 3
    clear

    ### Setting Compiler
    . SCRIPTS/env_modern.sh
    ### Building gcd
    pushd .
    cd ${GSBUILD} || exit 1
    install_gcd
    popd

    ### Effective building of libobjc2
    pushd .
    cd ${GSBUILD} || exit 1
    install_libobjc2
    popd
fi

#################################################
### Install Make

pushd .
cd ${GSBUILD} || exit 1
install_make
popd

GS_SCRIPT=$(gnustep-config --variable=GNUSTEP_MAKEFILES)/GNUstep.sh

if [ -f $GS_SCRIPT ];then
	. $GS_SCRIPT
else
	alert "The path of GNUstep Makefiles is badly set."
	exit 1
fi

grep -e "$GS_SCRIPT" ~/.bashrc &>/dev/null
if [ $? -ne 0 ];then
	echo ". $GS_SCRIPT" >> ~/.bashrc
fi

#################################################
## Build GNUstep base

. $GS_SCRIPT

pushd .
cd ${GSBUILD} || exit 1
install_base
popd

sudo ldconfig

# Checking...
is_log_ok "$BASE" || exit 1

#################################################
## Build GNUstep GUI

. $GS_SCRIPT

pushd .
cd ${GSBUILD} || exit 1
install_gui
popd

sudo ldconfig

# Checking...
is_log_ok "$GUI" || exit 1

#################################################
## Build GNUstep back

. $GS_SCRIPT

pushd .
cd ${GSBUILD} || exit 1
install_back
popd

sudo ldconfig

# Checking...
is_log_ok "BACK" || exit 1

ok "Building of GNUstep was successfully done. You can go forward with stage 3: Window Manager."
sleep 5
