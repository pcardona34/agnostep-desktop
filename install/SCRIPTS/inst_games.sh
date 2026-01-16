#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### Install some ported or native GNUtep Games
####################################################

####################################################
### ENV
_PWD=`pwd`
#. ./SCRIPTS/environ.sh
echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
LOG="$HOME/AGNOSTEP_BUILD_GAMES.log"
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT

#INSTALL_ARGS="GNUSTEP_INSTALLATION_DOMAIN=LOCAL"
### End of VARS
################################################

################################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_inst_games.sh
. SCRIPTS/std_build.sh

### End of Include functions
#################################################

clear
STR="A G N o S t e p  -  Games"
titulo

#################################################
### Is there a Build Folder?

if ! [ -d ../build ];then
	mkdir ../build
fi

##################################################
### Is there a LOCAL APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	mkdir $INSTALL_DIR
fi

#################################################

function remove_if_present
{
APP="$1"
if [ -d $INSTALL_DIR/${APP}.app ];then
	sudo rm -fR $INSTALL_DIR/${APP}.app
fi
printf "The previous installation of ${APP} has been removed.\n"
}

####################################################
function games_menu
{
dialog --no-shadow --backtitle "${STR:0:15}" --title "${STR:20:26}" \
--ok-label "OK"  \
--checklist "
The list below contains the games.

Check (space bar) the Games you want to (re)install." 20 70 13 \
"Chess" "3D board Chess ported from OPENSTEP" off \
"Freecell" "Game card with patience" off \
"GMastermind" "A Mastermind clone" off \
"GMines" "A Mine Sweeper game" off \
"GShisen" "A patience game with Mahjong tiles" off \
"Gomoku" "A kind of TicTacToe" off \
"Jigsaw" "A Puzzle game" off \
"LapisPuzzle" "A Tetris like game" off \
"NeXTGo" "The Go game ported from OPENSTEP" off \
"Sudoku" "Sudoku game" off 2> $TEMPFILE

# 0 if [OK] button was pushed;
# otherwise, exit the script.
if [ $? = 0 ];then
for i in `cat $TEMPFILE`
do
case "$i" in
"Chess")
	printf "You chose Chess\n"
	remove_if_present "Chess"
	install_chess;;
"Freecell")
	printf "You chose Freecell\n"
	remove_if_present "Freecell"
	install_freecell;;
"GMastermind")
	printf "You chose GMastermind\n"
	remove_if_present "GMastermind"
	install_gmastermind;;
"GMines")
	printf "You chose GMines\n"
	remove_if_present "GMines"
	install_gmines;;
"GShisen")
	printf "You chose GShisen\n"
	remove_if_present "GShisen"
	install_gshisen;;
"Gomoku")
	printf "You chose Gomoku\n"
	remove_if_present "Gomoku"
	install_gomoku;;
"Jigsaw")
	printf "You chose Jigsaw\n"
	remove_if_present "Jigsaw"
	install_jigsaw;;
"LapisPuzzle")
	printf "You chose LapisPuzzle\n"
	remove_if_present "LapisPuzzle"
	install_lapis;;
"NeXTGo")
	printf "You chose NeXTGo\n"
	remove_if_present "NeXTGo"
	install_nextgo;;
"Sudoku")
	printf "You chose Sudoku\n"
	remove_if_present "Sudoku"
install_sudoku
esac
done
else exit 0
fi
}
#################################################

games_menu

###################################

printf "Linking and making services: please wait...\n"

sudo ldconfig
make_services

print_size

sleep 2

