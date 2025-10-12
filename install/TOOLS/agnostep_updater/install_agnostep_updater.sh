#!/bin/bash

####################################################
### A G N o S t e p  -  Updater - by Patrick Cardona
### pcardona34 @ Github
###
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Install the Updater Tool
################################

################################
### VARS

AUTO=$HOME/GNUstep/Library/WindowMaker/autostart
ICON_DEST=/usr/local/share/icons
BIN_DEST=/usr/local/bin
DEPS="suckless-tools"

sudo apt -y install ${DEPS}

if [ ! -d $BIN_DEST ];then
	sudo mkdir -p $BIN_DEST
fi
sudo cp -u Updater /usr/local/bin/

###  Copy of dunstrc
DUNSTRC=$HOME/.config/dunst
if ! [ -d $DUNSTRC ];then
	mkdir -p $DUNSTRC
fi
cp _dunstrc $DUNSTRC/dunstrc

if [ ! -d $ICON_DEST ];then
	mkdir -p $ICON_DEST
fi
sudo cp -u bell.tif $ICON_DEST/

AUTO=$HOME/GNUstep/Library/WindowMaker/autostart
if [ ! -f $AUTO ];then
	printf "The file $AUTO was not found\n"
	exit 1
fi
grep -e "Updater " $AUTO &>/dev/null
if [ $? -ne 0 ];then
	cat $AUTO autostart.txt > TMP && mv --force TMP $AUTO
	chmod +x $AUTO
fi

printf "\nUpdater has been set.\n"
