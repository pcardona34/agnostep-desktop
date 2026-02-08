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
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT
SLEEP=2

### End of VARS
################################################

################################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/find_app.sh
. SCRIPTS/misc_info.sh
. SCRIPTS/functions_remove_app.sh
. SCRIPTS/std_build.sh
. SCRIPTS/fetcher.sh
. SCRIPTS/functions_inst_games.sh

### End of Include functions
#################################################

#clear
#STR="A G N o S t e p  -  Games"
#titulo

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

function games_menu
{
dialog --no-shadow --clear --backtitle "${STR:0:15}" --title "${STR:20:26}" \
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

clear

# 0 if [OK] button was pushed;
# otherwise, exit the script.
if [ $? = 0 ];then
for i in `cat $TEMPFILE`
do
case "$i" in
"Chess")
	printf "You chose Chess\n"
	remove_ifx_app "Chess"
	install_chess
	update_info_plist "Chess";;
"Freecell")
	printf "You chose Freecell\n"
	remove_ifx_app "Freecell"
	install_freecell
	update_info_plist "Freecell";;
"GMastermind")
	printf "You chose GMastermind\n"
	remove_ifx_app "GMastermind"
	install_gmastermind
	update_info_plist "GMastermind";;
"GMines")
	printf "You chose GMines\n"
	remove_ifx_app "GMines"
	install_gmines
	update_info_plist "GMines";;
"GShisen")
	printf "You chose GShisen\n"
	remove_ifx_app "GShisen"
	install_gshisen
	update_info_plist "GShisen";;
"Gomoku")
	printf "You chose Gomoku\n"
	remove_ifx_app "Gomoku"
	install_gomoku
	update_info_plist "Gomoku";;
"Jigsaw")
	printf "You chose Jigsaw\n"
	remove_ifx_app "Jigsaw"
	install_jigsaw
	update_info_plist "Jigsaw";;
"LapisPuzzle")
	printf "You chose LapisPuzzle\n"
	remove_ifx_app "LapisPuzzle"
	install_lapis
	update_info_plist "LapisPuzzle";;
"NeXTGo")
	printf "You chose NeXTGo\n"
	remove_ifx_app "NeXTGo"
	install_nextgo
	update_info_plist "NeXTGo";;
"Sudoku")
	printf "You chose Sudoku\n"
	remove_ifx_app "Sudoku"
	install_sudoku
	update_info_plist "Sudoku";;
esac
done
else exit 0
fi
}
#################################################

games_menu

###################################

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



