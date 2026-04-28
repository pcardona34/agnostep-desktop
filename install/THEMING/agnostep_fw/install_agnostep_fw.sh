#!/bin/bash

####################################################
### A G N o S t e p  -  Theme - by Patrick Cardona
### pcardona34 @ Github
###
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Install the theme for FocusWriter
################################

if [ -z "$COLORS" ];then
	. ../../SCRIPTS/colors.sh
fi

################################
### VARS
SLEEP=1
THERE=`pwd`

which -s focuswriter
if [ $? -eq 0 ];then
	THEMES_DIR=$HOME/.local/share/GottCode/FocusWriter
	CONF_DIR=$HOME/.config/GottCode
	WP_DIR=/usr/local/share/wallpapers

	for DIR in "$THEMES_DIR" "$CONF_DIR"
	do
		if [ ! -d $DIR ];then
			mkdir -p $DIR
		fi
	done
	if [ ! -d $WP_DIR ];then
		sudo mkdir -p $WP_DIR
	fi
	sudo cp fond_agnostep_fw.png $WP_DIR/
	cp FocusWriter_Themes.tar.gz $THEMES_DIR/
	cd $THEMES_DIR
	gunzip --force FocusWriter_Themes.tar.gz
	tar -xf FocusWriter_Themes.tar
	rm FocusWriter_Themes.tar
	cd "$THERE"
	cp --remove-destination FocusWriter.conf $CONF_DIR/
else
	info "FocusWriter not found. You should install the wrapper first. This theme will not be installed."
	sleep $SLEEP
fi
cd "$THERE"
