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
### Functions for inst_login
####################################################

#############################################
### Login app: Display Manager fot GNUstep
#############################################

#############################################
### CAUTION! this is unstable yet
### Do not use in prod
#############################################

function install_login
{
DEPS="libpam0g-dev"
STR="Dependencies..."
subtitulo
sudo apt -y install $DEPS
ok "Done"
sleep 2
clear

cd ../build || exit 1

APPNAME="loginpanel"
REPO="system-apps"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching $APPNAME...\n"
if [ -d $APPNAME ];then
	cd $APPNAME
	svn update
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/$REPO/$APPNAME
	cd $APPNAME || exit 1
fi
clear
subtitulo
ok "$APPNAME: Fetched"

CHECK=YES
BUILD_ARGS="have-pam=yes"
_build

sleep $SLEEP
}
