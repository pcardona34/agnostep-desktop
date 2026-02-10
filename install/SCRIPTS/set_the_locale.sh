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
### Set the Locale and TZ
################################

################################
### Include functions

if [ -z "$COLORS" ];then
	. SCRIPTS/colors.sh
fi
. SCRIPTS/log.sh
. SCRIPTS/spinner.sh

################################

function set_the_locale
{
sudo -v
if [ $? -ne 0 ];then
	alert "You are not allowed to execute ${0}."
	exit 1
fi

clear
# Setting the Timezone
sudo dpkg-reconfigure tzdata
# Setting the Locale
sudo dpkg-reconfigure locales
# Setting the Keyboard
sudo dpkg-reconfigure keyboard-configuration

clear

ok "All done."
warning "You should log out and back in again to apply the locale changes.\nThen, come back here and run again:"
cli "./agnostep.sh"
}
