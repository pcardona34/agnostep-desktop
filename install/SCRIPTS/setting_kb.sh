#!/bin/bash

####################################################
### A G N o S t e p  -  Theme - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### Keyboard: setting a French layout
####################################################

function set_french_layout
{
APPLE=1 # Not an apple
LG=${LANG:0:2}
KB=""
KBFR=RESOURCES/KB/KBFR
KBFRMAC=RESOURCES/KB/KBFRMAC
USER_BIN=$HOME/.local/bin

if [ ! -d ${USER_BIN} ];then
    mkdir -p ${USER_BIN}
fi

if [ "$LG" == "fr" ];then
	dialog --no-shadow --backtitle "French Environment" \
	 --title "X Keyboard Layout" \
	 --yesno "
	Voulez-vous un clavier français lors de votre session graphique ?" 12 60

    clear

	if [ $? -eq 0 ];then
        is_hw_apple
        if [ $APPLE -eq 0 ];then
            cp --verbose $KBFRMAC ${USER_DIR}/set_kb.sh
        else
	    	cp --verbose $KBFR ${USER_BIN}/set_kb.sh
        fi
	fi
fi
}
