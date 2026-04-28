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
### Setup Miscellaneous Tools...
################################

_PWD=`pwd`

DEPS="dialog"
STR="Dependencies..."
subtitulo

sudo apt -y install ${DEPS}
ok "Done"
sleep 2;clear

###########################################
### agnostep cli
function install_agnostep_cli
{
STR="Agnostep CLI"
subtitulo

cd RESOURCES/SCRIPTS || exit 1
sudo cp agnostep /usr/local/bin/
cd $_PWD
cd SCRIPTS
sudo cp colors.sh /usr/local/bin/
cd $_PWD
ok "Done"
}
