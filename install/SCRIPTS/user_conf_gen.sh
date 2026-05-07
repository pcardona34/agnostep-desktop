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
### User configuration files generator
####################################################

####################################################
### Keyboard: setting a French layout

function set_french_layout
{
APPLE=1 # Not an apple
LG=${LANG:0:2}
XIFR=RESOURCES/MINSET/_xinitrc_KBFR
XI=RESOURCES/MINSET/_xinitrc
XIM=RESOURCES/MACSET/xinitrc

if [ "$LG" == "fr" ];then
	dialog --no-shadow --backtitle "French Environment" \
	 --title "X Keyboard Layout" \
	 --yesno "
	Do You want a French keyboard Layout within X session?" 12 50

    clear

	if [ $? -eq 0 ];then
        is_hw_apple
        if [ $APPLE -eq 0 ];then
            cp --verbose $XIM $XI
        else
	    	cp --verbose $XIFR $XI
        fi
        sleep 2
	fi
fi
}
