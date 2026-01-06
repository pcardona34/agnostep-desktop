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
LOG="$HOME/DISPLAY_MGR.log"

. SCRIPTS/colors.sh
. SCRIPTS/functions_prep.sh

####################################################
### Copy the template into the home directory

STR="Installing the Display Manager"
titulo

BG=fond_agnostep.png
CONF=lightdm-gtk-greeter.conf
DM=lightdm

sudo apt -y install ${DM}

### Wallpaper
if [ ! -f /usr/share/wallpapers/${BG} ];then
	sudo cp RESOURCES/WALLPAPERS/fond_agnostep_waves.png /usr/share/wallpapers/${BG}
fi

cd RESOURCES/CONF || exit 1
### Config
sudo cp ${CONF} /etc/lightdm/

cp $HOME/.xinitrc $HOME/.xsession

cd

sudo systemctl set-default graphical.target
info "The Display Manager ${DM} has been set."

warning "The System will reboot in 5 seconds to apply the changes..."
sleep 5
sudo reboot
