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
### Install current APP
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
SPIN='/-\|'
APPLOG="$APP.log"

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

if [ ! -d $DEST_BIN ];then
	sudo mkdir -p $DEST_BIN
fi

echo "Debug status: $DEBUG"
sleep 1

STR="Birthday tools...";subtitulo

cd SCRIPTS || exit 1
for BIN in birth2vcf feast2ics
do
chmod +x $BIN
sudo cp --verbose -u $BIN $DEST_BIN/
done

STR="Birthday database...";subtitulo

DEST_SAMP=$HOME/Documents/Private
if [ ! -d $DEST_SAMP ];then
        mkdir -p $DEST_SAMP
fi
if [ ! -f $DEST_SAMP/Birthdays ];then
	cp --verbose Birthdays.sample $DEST_SAMP/Birthdays
else
	info "We preserve already existing Birthdays file."
fi

STR="Purge old release";subtitulo
remove_ifx_app ${APP}

STR="Building and installing ${APP}";subtitulo
cd ${HERE} || exit 1

make clean &>/dev/null

if [ "$DEBUG" == "yes" ];then
     make && ok "Build done"
     sudo -E env PATH="$PATH:/System/Tools" make install && ok "Install done"
else
     make &> $APPLOG &
     PID=$!
     spinner
     ok "\r- Build done"
     sleep 2
     sudo -E env PATH="$PATH:/System/Tools" make install &>> $APPLOG &
     PID=$!
     spinner
     ok "\r- Install done"
fi

check "${APP}"
make clean &>/dev/null
sleep 2
