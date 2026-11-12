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
SPIN='/-\|'
STATUS=0
### Setting required OS and required version
CONF=RESOURCES/CONF/AGNOSTEP.conf
RPI=1 # We assume no Raspberry Pi by default

### We keep working directory
pushd .

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
. SCRIPTS/functions_alsa.sh

### end of include functions
###############################################################

### Here it really begins...

reset_log

clear

STR="A G N o S t e p    D e s k t o p"
titulo

#########################

sanity_check || exit 1
debian_update || exit 1
sudo apt autoremove -y &>/dev/null

### First dependencies
######################
LIST="build" && install_deps

### Console
#######################
sudo dpkg-reconfigure console-setup

clear

titulo

### Getting infos...
# Timezone
if [ -f /etc/timezone ];then
	TZ=$(cat /etc/timezone)
else
	ZONE=$(ls -l /etc/localtime | awk '{print $11}' | awk -F/ '{print $5}')
	COUNTRY=$(ls -l /etc/localtime | awk '{print $11}' | awk -F/ '{print $6}')
	TZ="$ZONE/$COUNTRY"
fi
KB=$(tail -n 6 /etc/vconsole.conf | head -n 3)

dialog --no-shadow --backtitle "Localization" \
 --title "Locale and Timezone" \
 --yesno "
Your system is set with:
Timezone: $TZ
Lang: ${LANG}
$KB

Do you want to change these settings? " 15 50

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
### Sound
test_sound

#######################
### Syncing libs
sudo ldconfig

########################

APPLE=1 # We assume not an Apple computer by default
is_hw_apple
if [ $APPLE -eq 0 ];then
    warning "Before going on stage: 'Core', cd to install/RESOURCES/MACSET and read carefully actions to execute."
    sleep 6
else
    info "The System is up to date.\nYou may go on with stage: Core."
    sleep 3
fi
print_size

popd
