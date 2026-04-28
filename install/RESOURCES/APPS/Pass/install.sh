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
### Install Pass
################################

################################
### VARS
STR="${PWD##*/}"
APP="${STR}"
HERE=`pwd`
DEP="pass"

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

STR="Dependencies";subtitulo
sudo apt -y install ${DEP}
ok "Done"
sleep 2;clear

STR="Purge old release";subtitulo
remove_ifx_app ${APP}

STR="Building and installing ${PWD##*/}";subtitulo
cd ${HERE} || exit 1

make clean &>/dev/null
make && ok "Build done"
sudo -E env PATH="$PATH:/System/Tools" make install && ok "Install done"

check "${APP}"
make clean &>/dev/null
sleep 2
