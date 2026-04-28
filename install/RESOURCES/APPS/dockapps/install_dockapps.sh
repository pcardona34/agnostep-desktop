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
### Display title and messages
### with colors
################################

### VARS
APT_OPT="-y --no-show-upgraded --no-upgrade --show-progress --color"
SPIN='/-\|'

if [ -z "$LOG" ];then
    . ../../../SCRIPTS/log.sh
fi
if [ -z "$COLORS" ];then
    . ../../../SCRIPTS/colors.sh
fi
. ../../../SCRIPTS/spinner.sh
. ../../../SCRIPTS/fetcher.sh

STR="D O C K    A P P S";titulo


####################################
### Dependencies

STR="Dependencies";subtitulo
sudo apt $APT_OPT install libxpm-dev libdockapp-dev libwings-dev libudisks2-dev udisks2 libsecret-1-dev libgcr-3-dev librsvg2-bin
ok "Done";sleep 2;clear

###################################################################
### wmnd: for Network checking

STR="Network monitoring: wmnd";subtitulo

which -s wmnd
if [ $? -ne 0 ];then
	sudo apt $APT_OPT install wmnd
	ok "Done";sleep 2;clear
else
	ok "Yet installed."
fi

####################################################
### Mountapp

STR="WMudmount";subtitulo

which -s wmudmount
if [ $? -ne 0 ];then
	### Fetching
	if [ ! -d wmudmount ];then
		printf "Fetching WMudmount source...\n"
		WMUDMOUNT=https://sourceforge.net/projects/wmudmount/files/wmudmount/wmudmount-3.0.tar.gz
		fetch $WMUDMOUNT && gunzip --force wmudmount-3.0.tar.gz && tar -xf wmudmount-3.0.tar && rm wmudmount-3.0.tar
		mv wmudmount-3.0 wmudmount
	fi
	cd wmudmount || exit 1
	### To avoid the config.guess type error:
	### We must update config.guess... and  config.sub

	printf "Updating config.guess and config.sub...\n"
	wget --no-verbose config.guess 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'

	wget --no-verbose -O config.sub 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'
	ok "Done"

	printf "Configuring...\n"
	./configure &>>$LOG &
	PID=$!
	spinner
	ok "\rDone"

	printf "Building...\n"
	if [ ! -f Makefile ];then
		alert "Aborting..."
		exit 1
	fi
	make &>>$LOG &
	PID=$!
	spinner
	ok "\rDone"

	printf "Installing...\n"
	sudo -E make install &>>$LOG &
	PID=$!
	spinner
	ok "\rDone"
	cd ..
else
	ok "Yet installed."
fi
################################################

STR="Post-install: cleaning...";subtitulo
for DIR in wmudmount
do
rm -fr $DIR
done
ok "Done"

#info "DockApps: all was done."
sleep 2
