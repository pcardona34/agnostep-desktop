#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

### Banniere
clear
#cat RESOURCES/logo.txt
dialog --backtitle "AGNoStep Desktop" --title "Core Installer" \
--sleep 5 --infobox "
Welcome to an  AGNoStep World!

CORE installer script will start soon..." 8 50

####################################################
### VARS
LOGENJ="$HOME/CORE.log"
IS_OK=0
### LITE=0 means full install - LITE=1 means lite install: only basic apps
LITE=0
#LITE=1
_PWD=`pwd`
THERE=${_PWD}
####################################################
### Functions

. SCRIPTS/colors.sh
. SCRIPTS/functions_prep.sh

####################################################

### Abort script if EXIT is not 0
set -e

####################################################
### Builds and launches A G N o S t e p
####################################################

function core_install
{
####################################################
### Timer (1)
BEG=`date`
echo "AGNOSTEP: Begining of script $0 at: $BEG" > $LOGENJ

####################################################
### Install steps
####################################################

./1_prep.sh || exit 1

cd ${THERE}
./2_install_wmaker.sh || exit 1

cd ${THERE}
./3_install_gnustep.sh || exit 1

cd ${THERE}
./4_install_frameworks.sh || exit 1

cd ${THERE}
./5_install_core_apps.sh || exit 1

warning "Do not forget to install User settings and Theme now."


##################################################
### Timer (2)
END=`date`
echo "AGNOSTEP: End of script $0 at: $END" >> $LOGENJ

cd

### Cleaner
if [ ! -d $HOME/Documents/LOGS ];then
	mkdir -p $HOME/Documents/LOGS
fi
mv --force *.log $HOME/Documents/LOGS

}
### End of function core_install

##################################################################
### Main part of the script
##################################################################
clear

if [ -f $HOME/.xinitrc ] || [ -f $HOME/.xsession ];then

	dialog --backtitle "AGNoStep Desktop" --title "Core Installation" \
	--yesno "
	A script to start the X session was found in your home directory.

	Do you want to reinstall AGNoStep Core Desktop?" 10 50

	if [ $? -eq 0 ];then
		printf "Starting AGNoStep Core install script...\n";sleep 2
		core_install
	else
		printf "Aborting...\n"
		exit 1
	fi

fi

