#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

#####################################
### Wrappers
#####################################

################################
### ENV

_PWD=`pwd`
echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
LOG="$HOME/AGNOSTEP_BUILD_WRAPPERS.log"
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
#INSTALL_ARGS="GNUSTEP_INSTALLATION_DOMAIN=LOCAL"
WEBB=""
RPI=1 # by default, we guess the computer is not a RPI one
FICHTEMP=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $FICHTEMP" EXIT

### End of VARS
################################

################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_inst_wrappers.sh
. SCRIPTS/functions_prep.sh

### End of Include functions
################################

clear
STR="A G N o S t e p  -  Wrappers"
titulo

################################

### Declare_deps_wrappers
### Name after DEP_ must follow the wrapper name.
LG=${LANG:0:2}
DEP_Firefox="firefox-esr firefox-esr-l10n-${LG}"
DEP_Chromium="chromium-l10n"

### RPI case?
is_hw_rpi
if [ $RPI -eq 0 ];then
	DEP_Firefox="${DEP_Firefox} rpi-firefox-mods"
	DEP_Chromium="${DEP_Chromium} rpi-chromium-mods"
fi

### Pass installed?
whereis pass &>/dev/null
if [ $? -eq 0 ];then
	DEP_Firefox="${DEP_Firefox} webext-browserpass"
	# Pass ext is not more allowed from now
	#DEP_Chromium="${DEP_Chromium} webext-browserpass"
	REMOVE="webext-browserpass"
fi

DEP_EBookReader="fbreader"
DEP_Inkscape="inkscape"
DEP_Nano="nano"
DEP_Writer="focuswriter"
DEP_Upgrade="xterm"

################################
### Is there a LOCAL APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	exit 1
fi

#################################################

function webb_menu
{
# Menu box
dialog --backtitle "$STR" --title "Web Browser" \
--menu "

Choose one Web Browser Wrapper:" 18 66 2 \
"Chromium" "The free Chrome Web Browser" \
"Firefox" "The Mozilla Foundation Web Browser" 2> $FICHTEMP
# traitement de la réponse
if [ $? = 0 ]
then
for i in `cat $FICHTEMP`
do
case $i in
"Chromium")
	printf "You chose: Chromium\n"
	if [ -d $INSTALL_DIR/Firefox.app ];then
		sudo rm -fR $INSTALL_DIR/Firefox.app
	fi
	install_wrapper Chromium "$DEP_Chromium"
	sudo apt -y remove ${REMOVE}
	sudo update-alternatives --set x-www-browser $(whereis -b chromium | awk '{print $2}');;
"Firefox")
	printf "You chose: Firefox\n"
	if [ -d $INSTALL_DIR/Chromium.app ];then
		sudo rm -fR $INSTALL_DIR/Chromium.app
	fi
	install_wrapper Firefox "$DEP_Firefox"
	sudo update-alternatives --set x-www-browser $(whereis -b firefox-esr | awk '{print $2}');;
esac
done
	install_openURLService
fi
}

function other_menu
{
# checkbox dialog
dialog --backtitle "$STR" --title "Other Wrappers" \
--ok-label "OK"  \
--checklist "
Check the Tools you want to install." 18 60 10 \
"EBookReader" "A wrapper for FBReader" on \
"Inkscape" "A wrapper for Inkscape Vectorial Draw" on \
"Nano" "The GNU Nano editor" on \
"Upgrade" "A useful wrapper for Debian upgrade" on \
"Writer" "A wrapper for FocusWriter" off 2> $FICHTEMP
# traitement de la réponse
# 0 est le code retour du bouton Valider
# ici seul le bouton Valider permet de continuer
# tout autre action (Quitter, Esc, Ctrl-C) arrête le script.
if [ $? = 0 ]
then
for i in `cat $FICHTEMP`
do
case "$i" in
"EBookReader")
	printf "You chose EBookReader.\n"
	install_wrapper EBookReader "$DEP_EBookReader";;
"Inkscape")
	printf "You chose Inkscape"
	install_wrapper Inkscape "$DEP_Inkscape";;
"Nano")
	printf "You chose Nano"
	install_wrapper Nano "$DEP_Nano";;
"Upgrade")
	printf "You chose Upgrade"
	install_wrapper Upgrade "$DEP_Upgrade";;
"Writer")
	printf "You chose Writer"
	install_wrapper Writer "$DEP_Writer";;
esac
done
else exit 0
fi
}

#############################################

sudo apt -y update && sudo apt -y upgrade && sudo apt -y autoremove

webb_menu
other_menu

printf "Linking and making services: wait, please...\n"
sudo ldconfig
make_services
