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
### Agnostep install Wizard
### To handle install, post-install
################################

################################
### Include functions

. install/SCRIPTS/colors.sh
. install/SCRIPTS/log.sh

################################

################################
### Vars

DEPS="dialog"
FICHTEMP=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $FICHTEMP" EXIT

###############################
### Current User must be a member of sudoers

sudo -v

if [ $? -ne 0 ];then
	alert "User $USER is not allowed to execute this script. Aborting."
	exit 1
fi

###############################
function is_dialog
{
which -s dialog
if [ $? -ne 0 ];then
	STR="Dependencies"
	subtitulo
	sudo apt -y install ${DEPS}
	ok "Done";sleep 2
	clear
fi
}

# Main menu
function main_menu
{
. $HOME/.local/etc/release.info
if [ -z "$DISPLAY" ];then
	BACK="AGNoStep Wizard $REL $STATUS"
else
	BACK="Wizard $REL $STATUS"
fi

dialog --no-shadow --backtitle "${BACK}" \
 --title "Installation helper" \
 --menu "
First time: prepare, then install Core, Apps, Settings and DM.

What to do now?" 21 66 21 \
"Prep" "Prepare the installation" \
"Core" "Install Core Desktop" \
"Apps" "Install Core Apps" \
"Settings" "Desktop Settings" \
"DM" "Install Display Manager" \
"Theming" "Choose a theme" \
"Update" "Update AGNoStep" \
"Logs" "Desktop and Theme Logs" 2>> $FICHTEMP

# traitement de la réponse
if [ $? = 0 ]
then
for i in `cat $FICHTEMP`
do
case $i in
"Prep") printf "You chose Prep\n"
	cd install || exit 1
	./1_prep.sh;;
"Core") printf "You chose: Core\n"
	cd install || exit 1
	./core.sh;;
"Apps") printf "You chose: Apps\n"
	cd install || exit 1
	./5_install_core_apps.sh;;
"Settings") printf "You chose: Settings\n"
	cd install || exit 1
	./6_desktop_settings.sh;;
"DM") printf "You chose: DM\n"
	cd install || exit 1
	./7_install_DM.sh;;
"Theming") printf "You chose Theming\n"
    cd install || exit 1
    ./theming.sh;;
"Update") printf "You chose Update\n"
	dialog --title "Updating AGNoStep" \
	--yesno "
	If you modified this repository by yourself, you should not try to update. \
	Do you want to update the whole agnostep-desktop repository?" 12 50
	if [ $? -eq 0 ];then
		git pull
	fi;;
"Logs") printf "You chose Logs\n"
	cd install || exit
	./view_logs.sh;;
esac
done
fi
}
################################################

################################################
### Main section

is_dialog
main_menu
