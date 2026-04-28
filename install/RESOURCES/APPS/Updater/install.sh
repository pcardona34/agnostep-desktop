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
### Install Updater
################################

################################
### VARS
STR="${PWD##*/}"
APP="${STR}"
HERE=`pwd`
DEST_BIN=/usr/local/bin
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm $TEMPFILE" EXIT
SCRIPT=upgrade_unit.sh

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

STR="Tools...";subtitulo
printf "Installing the script to perform updates and upgrades in the background...\n"

cd SCRIPTS || exit 1
sudo cp --verbose $SCRIPT ${DEST_BIN}/
### We set with setuid to permit background execution
sudo chmod u+s ${DEST_BIN}/$SCRIPT

printf "Setting root's crontab...\n"
sudo crontab -u root -l > $TEMPFILE
grep "apt --update" $TEMPFILE
if [ $? -ne 0 ];then
    sudo crontab -u root root_crontab.txt
fi

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
