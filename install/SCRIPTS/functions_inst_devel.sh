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
### Functions for Desktop Devel - GNUstep apps
####################################################

function move_to_devel
{
APPNAME="$1"
if [ -z "$APPNAME" ];then
	exit 1
fi

APP_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
if [ -z "$APP_DIR" ];then
        alert "Your GNUstep System seems misconfigured."
        exit 1
fi

LG=${LANG:0:2}
case "$LG" in
"fr") DEVEL=Prog;;
"en"|*) DEVEL=Dev;;
esac

DEVEL_DIR=${APP_DIR}/${DEVEL}

if [ ! -d ${DEVEL_DIR} ];then
        sudo mkdir -p ${DEVEL_DIR}
fi

sudo mv ${APP_DIR}/${APPNAME}.app ${DEVEL_DIR}/
cd ${APP_DIR}
cd ../Tools
sudo ln --force --symbolic ${DEVEL_DIR}/${APPNAME}.app
sudo ln --force --symbolic ${DEVEL_DIR}/${APPNAME}.app/${APPNAME}
cd $_PWD
}

########################## - E - ##########################

#############################################
## Emacs built with NS menus
#############################################

function install_emacs()
{

APPNAME="Emacs"
HUB="https://git.savannah.gnu.org/git/emacs.git"
DIR="emacs"
CONFIG_ARGS="--with-ns"
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)

STR="$APPNAME"
subtitulo

cd ../build || exit 1

warning "Emacs is a very big piece of software: be patient.."

printf "Fetching...\n"
if [ ! -d emacs ];then
	git clone $HUB
	ok "Done"
	sleep 2
	clear
	cd $DIR || exit 1
else
	cd $DIR
	git pull
	ok "Done"
fi

WD=`pwd`
printf "Configuring...\n"
make clean
./autogen.sh
./configure ${CONFIG_ARGS}
ok "Done"
sleep 2

printf "Building...\n"
make &>>$LOG &
PID=$!
spinner
ok "\rDone"

if [ ! -d nextstep/Emacs.app ];then
	alert "The Bundle Emacs.app was not found."
	exit 1
fi

printf "Packaging the Bundle\n"
cp -r lisp nextstep/Emacs.app/Resources/
mkdir -p nextstep/Emacs.app/libexec
for FIC in exec/loader*.s
do cp ${FIC} nextstep/Emacs.app/libexec/
done

printf "Installing...\n"
cd nextstep || exit 1
sudo -E cp -a Emacs.app ${INSTALL_DIR}/
move_to_devel ${APPNAME}
check $APPNAME

}

########################################
## Gorm
### Repo/Release: github/gnustep: 1.5.0
########################################

function install_gorm()
{

APPNAME=Gorm
RELEASE="1.5.0"

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d apps-gorm ];then
        cd apps-gorm
        git pull origin master &>/dev/null
else
        git clone --branch=master "https://github.com/gnustep/apps-gorm" &>/dev/null
        cd apps-gorm
fi

CHECK=""
_build
move_to_devel ${APPNAME}
check $APPNAME

}

########################################
## ProjectCenter
### Repo/Release: github/gnustep: 0.7.0
########################################

function install_PC()
{

APPNAME=ProjectCenter
RELEASE="0.7.0"

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d apps-projectcenter ];then
        cd apps-projectcenter
        git pull origin master &>/dev/null
else
        git clone --branch=master "https://github.com/gnustep/apps-projectcenter" &>/dev/null
        cd apps-projectcenter
fi

CHECK=""
_build
move_to_devel ${APPNAME}
check $APPNAME

}

########################################
## EasyDiff
### Repo/Release: github/gnustep: 0.4.1
########################################

function install_easydiff()
{

APPNAME=EasyDiff
RELEASE="0.4.1"

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d apps-easydiff ];then
        cd apps-easydiff
        git pull origin master &>/dev/null
	make clean &>/dev/null
else
        git clone --branch=master "https://github.com/gnustep/apps-easydiff.git" &>/dev/null
        cd apps-easydiff
fi

CHECK=""
_build
move_to_devel ${APPNAME}
check $APPNAME

}


################################################
## Gemas
### Repo/Release: savannah/gnustep-nonfsf: 0.4
################################################

function install_gemas()
{
cd ../build || exit 1

APPNAME="Gemas"
RELEASE="0.4"
EXT=".tar.gz"
HUB=http://download.savannah.nongnu.org/releases/gnustep-nonfsf
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d ${APPNAME}-${RELEASE} ];then
	cd ${APPNAME}-${RELEASE}
else
	wget --quiet ${HUB}/${APPNAME}-${RELEASE}${EXT}
	gunzip --force ${APPNAME}-${RELEASE}${EXT}
	tar -xf ${APPNAME}-${RELEASE}.tar
	cd ${APPNAME}-${RELEASE} || exit 1
fi

CHECK=""
_build
move_to_devel ${APPNAME}
check $APPNAME

}


################################################
## Thematic
### Repo/Release: github/gnustep
################################################

function install_thematic()
{
cd ../build || exit 1

APPNAME="Thematic"
CONFIG_ARGS=""
INSTALL_ARGS="GNUSTEP_INSTALLATION_DOMAIN=LOCAL"

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d apps-thematic ];then
	cd apps-thematic
	git pull
else
	git clone https://github.com/gnustep/apps-thematic.git &>/dev/null
	cd apps-thematic
fi

CHECK=""
_build
move_to_devel ${APPNAME}
check $APPNAME

}
