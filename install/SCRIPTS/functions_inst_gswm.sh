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
### an alternate window manager
### to replace wmaker:
### it is a fork of gershwin-windowmanger
### as kindly suggested by Joseph Maloney (alias pkgdemon)
#####################################################

####################################################
### Functions for inst_wm
####################################################

#############################################
### Dependencies on a debian system
#############################################
function wm_deps
{
STR="Dependencies";titulo

### Checking if GNUstep base is already set
STR="Checking GNUstep base";subtitulo
GSBASE=/Local/Library/Libraries/libgnustep-base.so

if [ ! -f ${GSBASE} ];then
    alert "GNUstep libs-base was not found! You must install GNUstep system first."
    exit 1
else
    ok "Base was found"
    sleep 2
fi
STR="XCBKit";subtitulo
THERE=${_PWD}
LIST="wm" && install_deps
ok "Done"
sleep 2
clear
}

#############################################
### Fetching
#############################################

function install_wm
{
clear
cd ../build || exit 1

HUB="https://github.com"
OWNER="pcardona34" # We use a fork of pkgdemon's.
APPNAME="gnustep-windowmanager"
CONFIG_ARGS=""
INSTALL_ARGS=""
BRANCH="with-gnustep-legacy"

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $APPNAME ];then
	cd $APPNAME
    git pull
else
	git clone ${HUB}/${OWNER}/${APPNAME}
	cd $APPNAME || exit 1
fi

clear
subtitulo
ok "${APPNAME}: Fetched"

printf "Switching to devel branch: ${BRANCH}"
git switch ${BRANCH}

_build
sleep 2
}
