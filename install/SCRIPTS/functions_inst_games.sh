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

function install_chess()
{

APPNAME="Chess"
REL="2.7"

echo "$APPNAME $REL" >>$LOG
title "$APPNAME $REL"

printf "Fetching...\n"

cd ../build || exit 1

if [ -d $APPNAME ];then
	cd $APPNAME
	svn update &>/dev/null
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/ported-apps/Games/Chess &>/dev/null
	cd $APPNAME
fi

_build
}


##################################################
## Gomoku
### Repo/Release: github/pcardona34/Gomoku: 1.2.9
##################################################

function install_gomoku(){

APPNAME="Gomoku"
REL="1.2.9"

echo "$APPNAME $REL" >>$LOG
title "$APPNAME $REL"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d Gomoku ];then
	cd Gomoku
	git pull origin master &>/dev/null
else
	git clone https://github.com/pcardona34/Gomoku.git &>/dev/null
	cd Gomoku
fi

_build
}


##################################################
## GHack
### Repo/Release: github/
##################################################

function install_ghack
{

APPNAME="Ghack"
SITE=https://github.com/enrytheermit
REPO=gnustep

echo "$APPNAME" >>$LOG
title "$APPNAME"

### Deps
sudo apt -y install nethack-common nethack-spoilers

cd ../build || exit 1

printf "Fetching...\n"
if [ -d $REPO ];then
	cd $REPO
	git pull origin master &>/dev/null
else
	git clone $SITE/$REPO &>/dev/null
	cd $REPO || exit 1
fi

cd ghack/$APPNAME || exit 1
cp $_PWD/RESOURCES/ICONS/Ghack.tiff ./Resources/

_build
}


##################################
## LapisPuzzle
### Repo/Release:

function install_lapis()
{
APPNAME="LapisPuzzle"
REL="1.2"

echo "$APPNAME $REL" >>$LOG
title "$APPNAME $REL"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d LapisPuzzle-1.2 ];then
	cd LapisPuzzle-1.2
else
	wget --quiet http://mirror.easyname.at/nongnu/gap/LapisPuzzle-1.2.tar.gz
	gunzip --force LapisPuzzle-1.2.tar.gz
	tar -xf LapisPuzzle-1.2.tar
	cd LapisPuzzle-1.2
fi

_build
}

##################################################
## Freecell
### Repo/Release: github/alexmyczko/Freecell.app: 0.1
##################################################

function install_freecell()
{

APPNAME="Freecell"
REL="0.1"

echo "$APPNAME $REL" >>$LOG
title "$APPNAME $REL"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d Freecell.app ];then
	cd Freecell.app
	git pull origin master &>/dev/null
else
	git clone https://github.com/alexmyczko/Freecell.app.git &>/dev/null
	cd Freecell.app
fi

_build
}

######################################
## GShisen
### Repo/Release: savannah/gap: 1.3.0
######################################

function install_gshisen(){

APPNAME="GShisen"
REL="1.3.0"

echo "$APPNAME $REL" >>$LOG
title "$APPNAME $REL"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d GShisen ];then
	cd GShisen
	svn update
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/GShisen &>/dev/null
#	wget --quiet http://mirror.netcologne.de/savannah/gap/GShisen-1.3.0.tar.gz
#	gunzip --force GShisen-1.3.0.tar.gz
#	tar -xf GShisen-1.3.0.tar
	cd GShisen
fi

_build
}

#######################################
## Ladder
### Repo: savannah/gap
#######################################

function install_ladder
{

APPNAME="Ladder"
#REL="1.3.0"

echo "$APPNAME" >>$LOG
title "$APPNAME"

cd ../build || exit 1

### Dependency
sudo apt -y install gnugo 

printf "Fetching...\n"
if [ -d Ladder ];then
	cd Ladder
	svn update
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/Ladder
	cd Ladder
fi

_build
}

#######################################
## Jigsaw
### Repo: savannah/gap
#######################################

function install_jigsaw
{

APPNAME="Jigsaw"
#REL=""

echo "$APPNAME" >>$LOG
title "$APPNAME"

cd ../build || exit 1

### Dependency
### None

printf "Fetching...\n"
if [ -d Jigsaw ];then
        cd Jigsaw
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/Jigsaw
        cd Jigsaw
fi

_build
}

#######################################
## GMines
### Repo: savannah/gap
#######################################

function install_gmines
{

APPNAME="GMines"
#REL=""

echo "$APPNAME" >>$LOG
title "$APPNAME"

cd ../build || exit 1

### Dependency
### None

printf "Fetching...\n"
if [ -d GMines ];then
        cd GMines
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Games/GMines
        cd GMines
fi

_build
}

#######################################
## Sudoku
### Repo: savannah/gap
#######################################

function install_sudoku
{

APPNAME="Sudoku"
#REL=""

echo "$APPNAME" >>$LOG
title "$APPNAME"

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

_build
}

#######################################
## GMastermind
### Repo: savannah/gap
#######################################

function install_gmastermind
{

APPNAME="GMastermind"
#REL=""

echo "$APPNAME" >>$LOG
title "$APPNAME"

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

_build
}


#######################################
## NeXTGo
### Repo/Release: svn savannah gap/ported-apps/Games
########################################

function install_nextgo
{

APPNAME="NeXTGo"
REL="3.0"
BG=RESOURCES/WALLPAPERS/Background_GO.tiff

echo "$APPNAME $REL" >>$LOG
title "$APPNAME $REL"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d NeXTGo ];then
	cd NeXTGo
	svn update
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/ported-apps/Games/NeXTGo
	cd NeXTGo || exit 1
fi

### Updating the GoBan background
cp -f ../../install/${BG} ./Source/Background.tiff

_build
}

#############################################
