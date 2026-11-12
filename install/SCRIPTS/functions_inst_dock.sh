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
### We try to make and install
### an alternate Dock
### to replace wmaker's:
### it is a fork of gcasa  apps-dock
#####################################################

####################################################
### Functions for inst_dock
####################################################

#############################################
### Dependencies on a debian system
#############################################
function dock_deps
{
if [ -f SCRIPTS/env_modern.sh ];then
    echo "We use modern GNUstep ABI.\n"
else
    echo "You should not use with Legacy. Use instead wmaker's dock.\n"
    exit 1
fi

STR="Dependencies";titulo

### Checking if GNUstep base is already set
STR="Checking GNUstep base";subtitulo
LOCAL_LIBS=$(gnustep-config --variable=GNUSTEP_LOCAL_LIBRARIES)
GSBASE=${LOCAL_LIBS}/libgnustep-base.so

if [ ! -f ${GSBASE} ];then
    alert "GNUstep libs-base was not found! You must install GNUstep system first."
    exit 1
else
    ok "Base was found"
    sleep 2
fi
STR="XCBKit";subtitulo
pushd .
LIST="gswm" && install_deps
sleep 2
clear
popd
}

#############################################
### Fetching
#############################################

function install_dock
{

if [ -f SCRIPTS/env_modern.sh ];then
    echo "We use modern GNUstep ABI.\n"
else
    echo "You should  not use with Legacy. Use instead wmaker's dock.\n"
    exit 1
fi

clear
pushd .
cd ../build || exit 1

HUB="https://github.com"
OWNER="pcardona34" # We use a fork of pkgdemon's.
APPNAME="apps-dock"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ ! -d $APPNAME ];then
	git clone ${HUB}/${OWNER}/${APPNAME}
fi

cd $APPNAME || exit 1
git switch main
git pull

clear
subtitulo
ok "${APPNAME}: Fetched"

_build
sleep 2

popd
}
