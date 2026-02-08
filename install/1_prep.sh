#!/bin/bash

####################################################
### AGNoStep Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Sanity check, update, deps...
################################

###############################################################
### Vars
THERE=`pwd`
SPIN='/-\|'
STATUS=0
CONF=RESOURCES/CONF/AGNOSTEP.conf
RPI=1

### End of Vars
###############################################################

###############################################################
### include functions
. SCRIPTS/log.sh
. /etc/os-release
. ${CONF}
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/size.sh
. SCRIPTS/functions_prep.sh

### end of include functions
###############################################################

### Here it really begins...

echo "AGNoStep Desktop: init log" >> $LOG
date >> $LOG

clear

STR="A G N o S t e p    D e s k t o p"
titulo

#########################

sanity_check || exit 1
debian_update || exit 1
sudo apt autoremove -y &>/dev/null

LIST="build" && install_deps

#######################

### Getting infos
# Timezone
TZ=$(cat /etc/timezone)

dialog --no-shadow --backtitle "Localization" \
 --title "Locale and Timezone" \
 --yesno "
Your system is set with:

Timezone: $TZ
Lang: ${LANG}

Do you want to change these settings? " 12 50

if [ $? -eq 0 ];then
	. SCRIPTS/set_the_locale.sh
	set_the_locale
	MSG="Seconds before logout: "
	DELAY=9
	timer
	exec SCRIPTS/lo.sh
	exit
fi

#######################

sudo ldconfig

########################

info "The System is up to date.\nYou may go on with stage 2."
print_size
sleep 3

cd $THERE
