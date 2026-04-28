#!/bin/bash

####################################################
### A G N o S t e p  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### Install a theme for the AGNoStep Desktop
####################################################

####################################################
### You must be superuser to install
sudo -v
if [ $? -ne 0 ];then
	exit 1
fi

clear

_PWD=`pwd`
SPIN='\-/|'
STOP=0 # Set to 0 to avoid stops; to 1 to make stops for debugging purpose
SLEEP=4
#set -v
MSG_STOP="Stop: type <Enter> to continue."
GWDEF="org.gnustep.GWorkspace"
DEFDIR=RESOURCES/DEFAULTS
RPI=1 # By default, we assume the hw is not a RPI one. If not, it will be detected.
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT

LG=${LANG:0:2}

####################################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_inst_themes.sh
. SCRIPTS/functions_misc_themes.sh

function stop
{
if [ $STOP -ne 0 ];then
	read -p "$MSG_STOP" R
fi
}

####################################################
### DO NOT RUN under an existent X session
####################################################

if [ -n "$DISPLAY" ];then
	alert "You should not install within an XTERM!"
	info "Logout the Graphical session, open a tty console and try again."
	exit 1
fi

### PATH

which -s gnustep-config
if [ $? -ne 0 ];then
	alert "Your GNUstep System seems not correctly set. Aborting!"
	info "You should log out and back in to update your environment. When it will be done, try again the 'Settings' stage."
	MSG="Seconds before logout: "
	DELAY=8
	timer
	exec SCRIPTS/lo.sh
	exit 1
fi

export APP_DIR=`gnustep-config --variable=GNUSTEP_LOCAL_APPS`
export GNUSTEP_SYSTEM_TOOLS=`gnustep-config --variable=GNUSTEP_SYSTEM_TOOLS`
echo $PATH | grep -e "${GNUSTEP_SYSTEM_TOOLS}" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=${GNUSTEP_SYSTEM_TOOLS}:$PATH
fi

### End of functions
####################################################

####################################################
### Install the theme
####################################################

clear

########################################
function yesno_AGNOSTEP_theme
{
dialog --backtitle "AGNoStep Setup" --title "Theme Choice" \
--yesno "
The recommended theme for AGNoStep Desktop
 is AGNOSTEP-theme.

Do you want to install the recommended theme?" 12 60

if [ $? = 0 ];then
	. agnostep_theme.sh
else
	info "The default GNUstep theme will apply.\n"
    sleep $SLEEP
	. gnustep_theme.sh
fi
}

#######################################

STR="Setting a theme..."
titulo

yesno_AGNOSTEP_theme

cd "$PWD"

stop

##################################################

MESSAGE="Theme was set."
echo "$MESSAGE" >> $LOG
date >> $LOG
cd $_PWD
