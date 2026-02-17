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
. SCRIPTS/functions_inst_tools.sh
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
DEP_Writer="focuswriter"
DEP_Upgrade="xterm"
DEP_Printer="xterm cups cups-client cups-filters hplip printer-driver-hpijs libsane-hpaio"
DEP_AgnostepManager="dialog xterm"
################################
### Is there a LOCAL APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	exit 1
fi
LG=${LANG:0:2}
case "$LG" in
"fr") TOOLS=Utilitaires;;
"en"|*) TOOLS=Utilities;;
esac

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
dialog --backtitle "$STR" --title "Other Wrappers" \
--ok-label "OK"  \
--checklist "
Check the Tools you want to install." 20 60 12 \
"Abiword" "Gnome Office Writer" off \
"AgnostepManager" "A menu to manage installation" off \
"EBookReader" "A wrapper for FBReader" off \
"Inkscape" "A wrapper for Inkscape Vectorial Draw" off \
"Nano" "The GNU Nano editor" off \
"Printer" "Printer Setup" off \
"Upgrade" "A useful wrapper for Debian upgrade" off \
"Web" "Web Browser Wrapper" off \
"Writer" "A wrapper for FocusWriter" off 2> $FICHTEMP

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
"AgnostepManager")
	WRAP="AgnostepManager"
	printf "You chose ${WRAP}\n"
	remove_ifx_app "$WRAP"
	CHECK=""
	install_wrapper "$WRAP" "$DEP_AgnostepManager"
	move_to_tools "$WRAP"
	check "$WRAP"
	set_conf "xterm";;
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
"Nano")
	printf "You chose Nano\n"
	remove_ifx_app Nano
	CHECK=""
	install_wrapper Nano "$DEP_Nano"
	move_to_tools Nano
	check Nano
	set_conf "nano"
	set_conf "xterm";;
"Printer")
	printf "You chose Printer\n"
	groups | grep -e "lpadmin" &>/dev/null
	if [ $? -ne 0 ];then
        	sudo usermod -aG lpadmin $USER
	fi
	remove_ifx_app Printer
	CHECK=""
	install_wrapper Printer "${DEP_Printer}"
	move_to_tools Printer
	check Printer
	set_conf "xterm";;
"Upgrade")
	printf "You chose Upgrade\n"
	remove_ifx_app Upgrade
	CHECK=""
	install_wrapper Upgrade "$DEP_Upgrade"
	move_to_tools Upgrade
	check Upgrade
	set_conf "xterm";;
"Web")
	printf "You chose Web\n"
	menu_webb;;
"Writer")
	printf "You chose Writer\n"
	remove_ifx_app "Writer"
	CHECK="YES"
	install_wrapper Writer "$DEP_Writer";;
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
