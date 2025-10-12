#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### Install a Display Manager
####################################################

RPI=1
_PWD=`pwd`
clear

. SCRIPTS/colors.sh
. SCRIPTS/functions_prep.sh

####################################################
### Copy the template into the home directory

TITLE="Installing the Display Manager"
title "$TITLE"

is_hw_rpi
if [ $RPI -eq 0 ];then
	BG=fond_agnostep_pi.png
	cp RESOURCES/lightdm-gtk-greeter.conf.pi RESOURCES/lightdm-gtk-greeter.conf
else
	BG=fond_agnostep.png
	cp RESOURCES/lightdm-gtk-greeter.conf.std RESOURCES/lightdm-gtk-greeter.conf
fi
CONF=lightdm-gtk-greeter.conf
DM=lightdm

sudo apt -y install ${DM}

cd RESOURCES
### Wallpaper
cd WALLPAPERS || exit 1
sudo cp ${BG} /usr/share/wallpapers/
cd ..
### Config
sudo cp ${CONF} /etc/lightdm/

cp $HOME/.xinitrc $HOME/.xsession

sudo systemctl set-default graphical.target
info "The Display Manager ${DM} has been set."

warning "The System will reboot in 5 seconds to apply the changes..."
sleep 5
sudo reboot
