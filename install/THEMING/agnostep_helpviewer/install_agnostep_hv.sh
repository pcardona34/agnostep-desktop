#!/bin/bash

####################################################
### A G N o S t e p  -  Theme - by Patrick Cardona
### pcardona34 @ Github
###
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################
### Theming HelpViewer for AGNOSTEP
####################################

################################
### VARS
THERE=`pwd`
TARGET=/Local/Applications/HelpViewer.app/Resources/MainMenu.gorm
if [ ! -d $TARGET ];then
	printf "The target $TARGET was not found."
	exit 1
fi

for ICO in *.tiff *.tif
do
	sudo cp $ICO $TARGET/
done
