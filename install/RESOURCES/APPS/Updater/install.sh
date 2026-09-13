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
if [ -z "$DEBUG" ];then
     DEBUG="no" # values: "yes" to debug | "no" to use clean output
     # Should be set in the parent script
fi
STR="${PWD##*/}"
APP="${STR}"
HERE=`pwd`
DEST_BIN=/usr/local/bin
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm $TEMPFILE" EXIT
SCRIPT=upgrade_unit.sh
SPIN='/-\|'

################################
### include functions

. ../../../SCRIPTS/spinner.sh
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

echo -e "\nDebug status: $DEBUG"
sleep 1

STR="Purge old release";subtitulo
remove_ifx_app ${APP}

STR="Building and installing ${APP}";subtitulo
cd ${HERE} || exit 1

make clean &>/dev/null

if [ "$DEBUG" == "yes" ];then
     make && ok "Build done"
     sudo -E env PATH="$PATH:/System/Tools" make install && ok "Install done"
else
     make &> $LOG &
     PID=$!
     spinner
     ok "\r- Build done"
     sleep 2
     sudo -E env PATH="$PATH:/System/Tools" make install &>> $LOG &
     PID=$!
     spinner
     ok "\r- Install done"
fi

check "${APP}"
make clean &>/dev/null
sleep 2
