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
### Functions for inst_games...
####################################################

######################################
## Chess
### Repo/release: svn savannah gap ported-apps Games
######################################

function move_to_games
{
APPNAME="$1"
if [ -z "$APPNAME" ];then
	exit 1
fi

LG=${LANG:0:2}
case "$LG" in
"fr")
	GAMES=Jeux;;
"en"|*)
	GAMES=Games;;
esac

APP_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
if [ -z "$APP_DIR" ];then
	alert "Your GNUstep System seems misconfigured."
	exit 1
fi

GAME_DIR=${APP_DIR}/${GAMES}

if [ ! -d ${GAME_DIR} ];then
	sudo mkdir -p ${GAME_DIR}
fi

sudo mv ${APP_DIR}/${APPNAME}.app ${GAME_DIR}/
cd ${APP_DIR}
cd ../Tools
sudo ln --force --symbolic ${GAME_DIR}/${APPNAME}.app
sudo ln --force --symbolic ${GAME_DIR}/${APPNAME}.app/${APPNAME}
cd $_PWD
}

function install_chess
{
clear
APPNAME="Chess"
REL="2.7"

STR="$APPNAME $REL"
subtitulo


cd ../build || exit 1

printf "Fetching...\n"
if [ -d $APPNAME ];then
	cd $APPNAME
	svn update
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/ported-apps/Games/Chess
	cd $APPNAME || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}

##################################################
## Gomoku
### Repo/Release: github/pcardona34/Gomoku: 1.2.9
##################################################

function install_gomoku
{
clear
APPNAME="Gomoku"
REL="1.2.9"

STR="$APPNAME $REL"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d Gomoku ];then
	cd Gomoku
	git pull origin master
else
	git clone https://github.com/pcardona34/Gomoku.git
	cd Gomoku
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}


##################################################
## GHack
### Repo/Release: github/
### ???
##################################################

function install_ghack
{
clear
APPNAME="Ghack"
SITE=https://github.com/enrytheermit
REPO=gnustep

STR="$APPNAME"
subtitulo

### Deps
sudo apt -y install nethack-common nethack-spoilers

cd ../build || exit 1

printf "Fetching...\n"
if [ -d $REPO ];then
	cd $REPO
	git pull origin master
else
	git clone $SITE/$REPO
	cd $REPO || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

cd ghack/$APPNAME || exit 1
cp $_PWD/RESOURCES/ICONS/Ghack.tiff ./Resources/

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}


##################################
## LapisPuzzle
### Repo/Release:

function install_lapis
{
clear
APPNAME="LapisPuzzle"
REL="1.2"

STR="$APPNAME $REL"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d LapisPuzzle-1.2 ];then
	cd LapisPuzzle-1.2
else
	wget --quiet http://mirror.easyname.at/nongnu/gap/LapisPuzzle-1.2.tar.gz
	gunzip --force LapisPuzzle-1.2.tar.gz
	tar -xf LapisPuzzle-1.2.tar
	cd LapisPuzzle-1.2 || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}

##################################################
## Freecell
### Repo/Release: github/alexmyczko/Freecell.app: 0.1
##################################################

function install_freecell
{
clear
APPNAME="Freecell"
REL="0.1"

STR="$APPNAME $REL"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d Freecell.app ];then
	cd Freecell.app
	git pull origin master
else
	git clone https://github.com/alexmyczko/Freecell.app.git
	cd Freecell.app
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check ${APPNAME}
sleep $SLEEP
}

######################################
## GShisen
### Repo/Release: savannah/gap: 1.3.0
######################################

function install_gshisen
{

APPNAME="GShisen"
REL="1.3.0"

STR="$APPNAME $REL"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d GShisen ];then
	cd GShisen
	svn update
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/GShisen
	cd GShisen
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}

#######################################
## Ladder
### Repo: savannah/gap
#######################################

function install_ladder
{
clear
APPNAME="Ladder"
#REL="1.3.0"

cd ../build || exit 1

STR="Dependency: GNUGo"
subtitulo

sudo apt -y install gnugo
ok "Done"
sleep 2
clear

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d Ladder ];then
	cd Ladder
	svn update
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/Ladder
	cd Ladder
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}

#######################################
## Jigsaw
### Repo: savannah/gap
#######################################

function install_jigsaw
{
clear
APPNAME="Jigsaw"
#REL=""

STR="$APPNAME"
subtitulo

cd ../build || exit 1

### Dependency
### None

printf "Fetching...\n"
if [ -d Jigsaw ];then
        cd Jigsaw
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/Jigsaw
        cd Jigsaw || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}

#######################################
## GMines
### Repo: savannah/gap
#######################################

function install_gmines
{
clear
APPNAME="GMines"
#REL=""

STR="$APPNAME"
subtitulo

cd ../build || exit 1

### Dependency
### None

printf "Fetching...\n"
if [ -d GMines ];then
        cd GMines
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/GMines
        cd GMines || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}

#######################################
## Sudoku
### Repo: savannah/gap
#######################################

function install_sudoku
{
clear
APPNAME="Sudoku"
#REL=""

STR="$APPNAME"
subtitulo

cd ../build || exit 1

### Dependency
### None

printf "Fetching...\n"
if [ -d Sudoku ];then
        cd Sudoku
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/Sudoku
        cd Sudoku
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}

#######################################
## GMastermind
### Repo: savannah/gap
#######################################

function install_gmastermind
{
clear
APPNAME="GMastermind"
#REL=""

STR="$APPNAME"
subtitulo

cd ../build || exit 1

### Dependency
### None

printf "Fetching...\n"
if [ -d GMastermind ];then
        cd GMastermind
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/GMastermind
        cd GMastermind
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}


#######################################
## NeXTGo
### Repo/Release: svn savannah gap/ported-apps/Games
########################################

function install_nextgo
{
clear
APPNAME="NeXTGo"
REL="3.0"
BG=RESOURCES/BG/Background_GO.tiff

STR="$APPNAME $REL"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d NeXTGo ];then
	cd NeXTGo
	svn update
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/ported-apps/Games/NeXTGo
	cd NeXTGo || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

### Updating the GoBan background
cp -f ${_PWD}/${BG} ./Source/Background.tiff

CHECK=""
_build
move_to_games $APPNAME
check $APPNAME
sleep $SLEEP
}

#############################################
