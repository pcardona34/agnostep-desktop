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
### Install Birthday
################################

################################
### VARS
STR="${PWD##*/}"
APP="${STR}"
HERE=`pwd`
DEST_BIN=/usr/local/bin

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

if [ ! -d $DEST_BIN ];then
	sudo mkdir -p $DEST_BIN
fi

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
make && ok "Build done"
sudo -E env PATH="$PATH:/System/Tools" make install && ok "Install done"

check "${APP}"
make clean &>/dev/null
sleep 2

