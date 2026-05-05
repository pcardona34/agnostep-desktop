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
### Install Dico
### A French Lookup Dictionary
################################

################################
### VARS
STR="${PWD##*/}"
APP="${STR}"
HERE=`pwd`
DEP="surf" # Suckless Web Browser

################################
### include functions
. ../../../SCRIPTS/colors.sh
. ../../../SCRIPTS/log.sh
. ../../../SCRIPTS/find_app.sh
. ../../../SCRIPTS/check_app.sh
. ../../../SCRIPTS/functions_remove_app.sh

################################
### You must be superuser to install
sudo -v

titulo

STR="Dependency...";subtitulo
sudo apt -y install ${DEP}

sleep 2
clear

STR="Purge old release";subtitulo
remove_ifx_app ${APP}

STR="Building and installing ${APP}";subtitulo
cd ${HERE} || exit 1

make clean &>/dev/null
make && ok "Build done"
sudo -E env PATH="$PATH:/System/Tools" make install && ok "Install done"

check "${APP}"
make clean &>/dev/null
sleep 2

#################################################
### Service
SERVICE="openWithDico"
STR="Service: $SERVICE"
subtitulo
printf "Fetching ${SERVICE}...\n"

if [ -z "$_PWD" ];then
    cd ../../.. || exit 1
else
    cd $_PWD
fi

SRC_DIR=RESOURCES/SERVICES/${SERVICE}
cd ${SRC_DIR} || exit 1
ok "$SERVICE fetched"

STR="Building and installing service ${SERVICE}";subtitulo
make clean &>/dev/null
make && ok "Build done"
sudo -E env PATH="$PATH:/System/Tools" make install && ok "Install done"
make clean &>/dev/null
sleep 2

### Default CSS for surf
if [ -z "$_PWD" ];then
    cd ../../.. || exit 1
else
    cd $_PWD
fi

STR="Default Style Sheet";subtitulo
SRC_CSS=RESOURCES/CONF/surf_default.css
DIR_DEST=$HOME/.surf/styles
if [ ! -d $DIR_DEST ];then
     mkdir -p $DIR_DEST
fi
cp --verbose --update ${SRC_CSS} ${DIR_DEST}/default.css
ok "Done"
ok "All was done for Dico app and its service"
sleep 3
