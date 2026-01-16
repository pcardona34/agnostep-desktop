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
### Setup Miscellaneous Tools...
################################

_PWD=`pwd`

DEPS="dialog"
STR="Dependencies..."
subtitulo

sudo apt -y install ${DEPS}
ok "Done"
sleep 2;clear

TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT

###########################################
### Installing Tools and confs... Pass
function install_pass
{
STR="Pass: the Unix Passwords Manager CLI"
subtitulo

cd TOOLS/agnostep_pass || exit 1
. ./install_agnostep_pass.sh
cd $_PWD
ok "Done"
}

###########################################
### Printer Setup
function install_print
{
STR="Setup_Printer"
subtitulo

cd TOOLS || exit 1
sudo cp Setup_Printer /usr/local/bin/
cd $_PWD
ok "Done"
}

##################################################
### Installing Tools and confs... Shooting CLI
function install_shooting
{
STR="Screenshot Shooting CLI"
subtitulo

cd TOOLS || exit 1
sudo cp Shooting /usr/local/bin/
cd $_PWD
ok "Done"
}

###########################################
function check_tools
{
# boîte de cases à cocher proprement dite
dialog --backtitle "Agnostep Setup" --title "Miscellaneous Tools" \
--ok-label "OK"  \
--checklist "
Check the Tools you want to install." 18 60 10 \
"pass" "Unix Passwords Manager CLI" off \
"print" "Printer Setup" off \
"shooting" "Screenshot Shooting CLI" off 2> $TEMPFILE
# traitement de la réponse
# 0 est le code retour du bouton Valider
# ici seul le bouton Valider permet de continuer
# tout autre action (Quitter, Esc, Ctrl-C) arrête le script.
if [ $? = 0 ]
then
for i in `cat $TEMPFILE`
do
case "$i" in
"pass")
	echo "You chose Pass CLI"
	install_pass;;
"print")
	echo "You chose Printer Setup"
	install_print;;
"shooting")
	echo "You chose Shooting CLI"
	install_shooting;;
esac
done
else exit 0
fi

echo "END OF MISC TOOLS"
sleep 5
}
