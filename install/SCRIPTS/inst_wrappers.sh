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
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
WEBB=""
RPI=1 # by default, we guess the computer is not a RPI one
FICHTEMP=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $FICHTEMP" EXIT

### End of VARS
################################

################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_remove_app.sh
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
case "$LG" in
"en")
	DEP_Firefox="firefox-esr"
	DEP_Chromium="chromium";;
*)
	DEP_Firefox="firefox-esr firefox-esr-l10n-${LG}"
	DEP_Chromium="chromium chromium-l10n";;
esac

### RPI case?
is_hw_rpi
if [ $RPI -eq 0 ];then
	DEP_Firefox="${DEP_Firefox} rpi-firefox-mods"
	DEP_Chromium="${DEP_Chromium} rpi-chromium-mods"
fi

### Pass installed?
which -s pass
if [ $? -eq 0 ];then
	DEP_Firefox="${DEP_Firefox} webext-browserpass"
	# Pass ext is not more allowed from now
	#DEP_Chromium="${DEP_Chromium} webext-browserpass"
	REMOVE="webext-browserpass"
fi

DEP_Abiword="abiword"
DEP_EBookReader="fbreader"
DEP_Inkscape="inkscape"
DEP_Nano="nano xterm"
DEP_Scribus="scribus"
DEP_Writer="focuswriter"
DEP_Xpdf="xpdf"
DEP_LibreOffice="libreoffice"

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

clear

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
	sudo apt -y remove firefox ${REMOVE} && sudo apt -y autoremove
	sudo update-alternatives --set x-www-browser $(whereis -b chromium | awk '{print $2}');;
"Firefox")
	printf "You chose: Firefox\n"
	if [ -d $INSTALL_DIR/Chromium.app ];then
		sudo rm -fR $INSTALL_DIR/Chromium.app
	fi
	install_wrapper Firefox "$DEP_Firefox"
	sudo update-alternatives --set x-www-browser $(whereis -b firefox-esr | awk '{print $2}')
	if [ ! -d $HOME/.mozilla ];then
		printf "Firefox profile...\n"
		cp RESOURCES/CONF/firefox_profile.tar.gz $HOME/
		cd $HOME
		gunzip firefox_profile.tar.gz
		tar -xf firefox_profile.tar &
		PID=$!
		spinner
		ok "\rDone"
		rm firefox_profile.tar
		cd $_PWD
	fi
	sudo apt -y remove chromium && sudo apt -y autoremove;;
esac
done
	install_openURLService
fi
}

function other_menu
{
# checkbox dialog
dialog --backtitle "$STR" --title "Wrappers" \
--ok-label "OK"  \
--checklist "
Check the Wrappers you want to install." 20 60 10 \
"Abiword" "Gnome Office Writer" off \
"EBookReader" "A wrapper for FBReader" off \
"Inkscape" "A wrapper for Inkscape Vectorial Draw" off \
"Libreoffice" "A wrapper for LibreOffice" off \
"Nano" "The GNU Nano editor" off \
"Scribus" "Desktop Publishing Scribus" off \
"Web" "Web Browser Wrapper" off \
"Writer" "A wrapper for FocusWriter" off \
"Xpdf" "A wrapper for Xpdf" off 2> $FICHTEMP

clear

# traitement de la réponse
# 0 est le code retour du bouton Valider
# ici seul le bouton Valider permet de continuer
# tout autre action (Quitter, Esc, Ctrl-C) arrête le script.
if [ $? = 0 ]
then
for i in `cat $FICHTEMP`
do
case "$i" in
"Abiword")
	WRAP="Abiword"
	printf "You chose ${WRAP}\n"
	remove_ifx_app "$WRAP"
	CHECK="YES"
	install_wrapper "$WRAP" "$DEP_Abiword";;
"EBookReader")
	printf "You chose EBookReader.\n"
	remove_ifx_app "EBookReader"
	CHECK="YES"
	install_wrapper EBookReader "$DEP_EBookReader";;
"Inkscape")
	printf "You chose Inkscape.\n"
	remove_ifx_app "Inkscape"
	CHECK="YES"
	install_wrapper Inkscape "$DEP_Inkscape";;
"Libreoffice")
	printf "You chose LibreOffice.\n"
	remove_ifx_app "LibreOffice"
	CHECK="YES"
	install_wrapper LibreOffice "$DEP_LibreOffice";;
"Nano")
	printf "You chose Nano\n"
	remove_ifx_app Nano
	CHECK="YES"
	install_wrapper Nano "$DEP_Nano"
	set_conf "nano"
	set_conf "xterm";;
"Scribus")
    printf "You chose Scribus\n"
    remove_ifx_app Scribus
    CHECK="YES"
    install_wrapper Scribus "$DEP_Scribus";;
"Web")
	printf "You chose Web\n"
	webb_menu;;
"Writer")
	printf "You chose Writer\n"
	remove_ifx_app "Writer"
	CHECK="YES"
	install_wrapper Writer "$DEP_Writer";;
"Xpdf")
    printf "You chose Xpdf\n"
    remove_ifx_app "Xpdf"
    CHECK="YES"
    install_wrapper "Xpdf" "$DEP_Xpdf";;
esac
done
else exit 0
fi
}

#############################################

sudo apt -y update && sudo apt -y upgrade

other_menu

#############################################

printf "Linking: wait please...\n"
sudo ldconfig &>/dev/null &
PID=$!
spinner
ok "\rDone"

printf "\nUpdating Services: wait please...\n"
make_services &>/dev/null &
PID=$!
spinner
ok "\rDone"

print_size

sleep 2
