#!/bin/bash

####################################################
### A G N o S t e p  -  Theme - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Functions for Install Themes
################################


###############################################
function install_gs_theme
{
#title "AGNOSTEP Theme for GNUstep"
printf "Installing the theme for GNUstep...\n"
if ! [ -d $HOME/GNUstep/Library/Themes ];then
	mkdir -p $HOME/GNUstep/Library/Themes
fi
cd RESOURCES/THEMES || exit 1
cp -a AGNOSTEP.theme $HOME/GNUstep/Library/Themes/
cd $_PWD
ok "Done"
}

###############################################
### !!! The funtion: install_wm_theme is obsolete
### DO NOT use it
###############################################
function install_wm_theme
{
title "AGNOSTEP Theme for WindowMaker"
printf "Installing the theme...\n"
cd RESOURCES/THEMES || exit 1

if [ ! -d $HOME/GNUstep/Library/WindowMaker/Themes ];then
	mkdir -p $HOME/GNUstep/Library/WindowMaker/Themes
fi

cp WMAGNOSTEP-C5C.tar.gz $HOME/GNUstep/Library/WindowMaker/Themes/
cd $HOME/GNUstep/Library/WindowMaker/Themes || exit 1
gunzip --force WMAGNOSTEP-C5C.tar.gz && tar -xf WMAGNOSTEP-C5C.tar
rm WMAGNOSTEP-C5C.tar
cd $_PWD
ok "Done"
}
