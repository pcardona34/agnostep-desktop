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

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
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

if [ ! -f $HOME/.xsession ];then
    cp $HOME/.xinitrc $HOME/.xsession
fi

info "The Display Manager ${DM} has been set."

cd

### Default Runlevel
DEFAULT=$(systemctl get-default)
if [ "$DEFAULT" == "graphical.target" ];then
    info "The Default Runlevel Target has already been set."
    sleep 2
else
    sudo systemctl set-default graphical.target
    MSG="The System will reboot to apply the changes..."
    timer
    sudo reboot
fi
