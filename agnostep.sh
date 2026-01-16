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
### Agnostep main script and menu
### To handle install, post-install
### and applications installation
################################

################################
### Include functions

. install/SCRIPTS/colors.sh
################################

################################
### Vars

DEPS="dialog"
FICHTEMP=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $FICHTEMP" EXIT

###############################
function is_dialog
{
whereis dialog
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
# boîte de menu
dialog --no-shadow --backtitle "A G N o S t e p" --title "Applications Manager" \
--menu "
First time: install Core, Settings and DM.

What to do now?" 18 66 13 \
"Core" "Install Core Desktop and Apps" \
"Settings" "User Settings and Theme" \
"DM" "Install Display Manager" \
"Devel" "Install Developer Apps" \
"Extra" "Install more User Apps" \
"Games" "Install Games" \
"Wrappers" "Install Wrappers" \
"Remove" "Remove some App" 2>> $FICHTEMP

# traitement de la réponse
if [ $? = 0 ]
then
for i in `cat $FICHTEMP`
do
case $i in
"Core") printf "You chose: Core\n"
	cd install || exit 1
	./core.sh;;
"Settings") printf "You chose: Settings\n"
	cd install || exit 1
	./6_user_settings.sh;;
"DM") printf "You chose: DM\n"
	cd install || exit 1
	./7_install_DM.sh;;
"Devel") printf "You chose: Devel\n"
	cd install || exit 1
	./SCRIPTS/inst_devel.sh;;
"Extra") printf "You chose Extra\n"
	cd install || exit 1
	./SCRIPTS/inst_extra.sh;;
"Games") printf "You chose Games\n"
	cd install || exit 1
	./SCRIPTS/inst_games.sh;;
"Wrappers") printf "You chose Wrappers\n"
	cd install || exit 1
	./SCRIPTS/inst_wrappers.sh;;
"Remove") printf "You chose Remove\n"
	cd install || exit 1
	./remove.sh;;
esac
done
fi
}
################################################

is_dialog
main_menu
