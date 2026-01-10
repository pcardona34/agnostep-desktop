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
### Functions for wrappers
####################################################

##############################################
### All the Wrappers
#### Those are in RESOURCES/WRAPPERS
##############################################

function install_wrapper
{
WRAP=$1
DEP=${2}
APPNAME=${WRAP}
echo "$APPNAME" >> $LOG
title "Installing the wrapper for $APPNAME"

if [ -n "$DEP" ];then
	STR="Dependencies";subtitulo
	sudo apt -y install ${DEP}
fi

sudo cp -a $_PWD/RESOURCES/WRAPPERS/${APPNAME}.app $INSTALL_DIR/
check $APPNAME

cd $_PWD
}

#########################################################
function install_rpi_tools
{
cd $_PWD/RESOURCES/RPI_TOOLS || exit 1

for WRAP in *.app
do
        APPNAME=${WRAP%.app}

        echo "$APPNAME" >> $LOG
        title "Installing the wrapper for $APPNAME"

        sudo cp -a ${APPNAME}.app $INSTALL_DIR/
        check $APPNAME
done

cd $_PWD
}

##############################################
### End of functions
##############################################
