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
### Functions for inst_extra_extra...
####################################################

if [ ! -d ../build ];then
	mkdir ../build
fi

########################## - C - ##########################

################################
## Cenon
### Repo/Release: Debian Salsa
### Not used with Cenon install from Debian
################################

function install_cenon_lib
{
ICI=`pwd`
LIB=CenonLibrary
RELEASE=""
BUILD=../build/lib
TARGET=/usr/lib/GNUstep/Library

STR="Cenon Libray"
subtitulo

if [ ! -d $BUILD ];then
	mkdir -p ${BUILD}
fi
cd ${BUILD}

printf "Fetching...\n"
if [ ! -d Cenon ];then
	wget https://cenon.download/source/${LIB}-${RELEASE}${EXT}
	bunzip2 --force ${LIB}-${RELEASE}${EXT}
	tar -xf ${LIB}-${RELEASE}.tar && rm ${LIB}-${RELEASE}.tar
fi
ok "Done"

printf "Installing the Library...\n"
if [ ! -d $TARGET ];then
	sudo mkdir -p ${TARGET}
fi
sudo rm -fR ${TARGET}/Cenon
sudo cp -r Cenon ${TARGET} 
ok "Done"
}

#########################################
function install_cenon()
{

cd ../build || exit 1

APPNAME="Cenon"
RELEASE="4.0.3"
DIR="cenon.app"
### Hub from Debian: GNUstep Team
HUB=https://salsa.debian.org/gnustep-team/cenon.app.git
#TARGET="${APPLICATIONS}"
CONFIG_ARGS=""
INSTALL_ARGS=""

printf "Dependencies...\n"
sudo apt -y install ${DEPS}
ok "Done"
sleep 2
clear

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ ! -d $DIR ];then
	git clone ${HUB}
	cd $DIR
else
	cd $DIR
	git pull
fi

printf "Patching...\n"
is_quilt
set_quilt
quilt push -a

#make clean
#make
_build
}

###############################################
## Cynthiune
### Repo/Release: Savannah/gnustep/gap: 1.0.0
### With a patch from Savannah
###############################################

function install_cynthiune
{
APPNAME=Cynthiune
RELEASE="1.0.0"
CONFIG_ARGS="disable-audiofile=yes disable-flac=yes disable-flactags=yes \
        disable-mod=yes disable-windowsmedia=yes disable-musepack=yes \
        disable-timidity=yes disable-asdtags=yes \
        disable-esound=yes disable-ao=yes"
# added wav: 'disable-waveout=yes' was removed from the args above

BUILD_ARGS="${CONFIG_ARGS}"
INSTALL_ARGS="${BUILD_ARGS}"
PATCH="Cynthiune-1.0.0_Bundles_ALSA_fails_to_build_due_to_memcheck_inclusion.patch"

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d Cynthiune ];then
        cd Cynthiune
        svn update &>/dev/null
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Cynthiune &>/dev/null
        cd Cynthiune
fi

### PATCH
cp $_PWD/RESOURCES/PATCHES/$PATCH ./
printf "A patch must be applied... "
TARGET=`grep -i -e "index" ./${PATCH} | awk '{print $2}'`
TARGET=./${TARGET}
patch --forward -u ${TARGET} -i ./${PATCH}
ok "Done"

_build
}

########################## - F - ##########################

#############################################
## FlexiSheet
### Repo/Release: github/gnustep/gap: 0.5.7
#############################################

function install_flexisheet()
{
cd ../build || exit 1

APPNAME="FlexiSheet"
REPO="gap"
OWNER="gnustep"
HUB="https://github.com"
BRANCH="master"
BUILD_DIR="user-apps" # "system-apps" | "ported-apps"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d $APPNAME ];then
        cd $APPNAME
        svn update &>/dev/null
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/FlexiSheet &>/dev/null
	cd $APPNAME
fi

_build
}

########################## - G - ########################## 

##########################################
## Graphos
### Repo/release: Savannah/gap: 0.6
##########################################

function install_graphos()
{

cd ../build || exit 1

APPNAME="Graphos"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $APPNAME ];then
        cd $APPNAME
        svn update &>/dev/null
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Graphos &>/dev/null
	cd $APPNAME
fi

_build
}

###################################################
## Grr
### Repo/Release: Savannah/gap: 1.1 Subversion
###################################################

function install_grr()
{

APPNAME=Grr
RELEASE="1.1"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d $APPNAME ];then
	cd $APPNAME
	svn update &>/dev/null
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/Grr &>/dev/null
	cd $APPNAME
fi

_build
}

########################## - L - ########################## 

#########################################
### LaternaMagica
#########################################

function install_laternamagica()
{
cd ../build || exit 1

APPNAME="LaternaMagica"
REPO="user-apps"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $APPNAME ];then
        cd $APPNAME
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/$REPO/$APPNAME
        cd $APPNAME || exit 1
fi
ok "Done"

_build
}


########################## - N - ########################## 

######################################
## NetSurf-GNUstep
### 3.11
#
### Dependency: duktape and duktape-dev
######################################

function install_netsurf
{

APPNAME=NetSurf
RELEASE="3.11"

### Dependencies
printf "Installing the dependencies...\n"
sudo apt -y install duktape-dev duktape
clear

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching NetSurf Workspace...\n"
wget --quiet https://github.com/netsurf-browser/netsurf/raw/refs/heads/master/docs/env.sh || exit 1
unset HOST
. env.sh
printf "Installing the packages...\n"
ns-package-install
ok "Done"
sleep 2;clear

unset HOST
. env.sh

printf "Fetching Netsurf...\n"
ns-clone &>>$LOG &
PID=$!
spinner
ok "\rDone"

printf "Building...\n"
ns-pull-install &>>$LOG &
PID=$!
spinner
ok "\rDone"

rm env.sh
cd ~/dev-netsurf/workspace
rm -fR netsurf
printf "Fetching gnustep-netsurf...\n"
wget --quiet https://github.com/anthonyc-r/netsurf-gnustep/archive/refs/tags/3.11-gnustep.tar.gz
gunzip --force 3.11-gnustep.tar.gz
tar xvf 3.11-gnustep.tar
mv netsurf-gnustep-3.11-gnustep netsurf
cd netsurf || exit 1

printf "Building GNUstep-NetSurf app...\n"
make TARGET=gnustep NETSURF_USE_DUKTAPE=YES build/Linux-gnustep/duktape/polyfill.js.inc &>>$LOG &
PID=$!
spinner

make TARGET=gnustep NETSURF_USE_DUKTAPE=YES build/Linux-gnustep/duktape/generics.js.inc &>>$LOG &
PID=$!
printf "\r"
spinner

make TARGET=gnustep &>>$LOG &
PID=$!
printf "\r"
spinner
ok "\rDone"

printf "Installing...\n"
export LOCAL_INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
sudo cp -r NetSurf.app $LOCAL_INSTALL_DIR/

### Cleaning
make clean &>/dev/null
rm -fR $HOME/dev-netsurf

ok "Done"

cd $_PWD

check "$APPNAME"
}
### End of NetSurf
############################################"


########################## - P - ########################## 

#######################################################
## PikoPixel
### Repo/Release: github/onflapp/gs-pikopixel: 1.0.b10
#######################################################

function install_pikopixel()
{

cd ../build || exit 1

APPNAME="PikoPixel"
REPO="gs-PikoPixel"
OWNER="onflapp"
HUB="https://github.com"
BRANCH="main"
BUILD_DIR="." # "system-apps" | "ported-apps"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d $REPO ];then
        cd $REPO
        git pull origin $BRANCH &>/dev/null
else
	git clone ${HUB}/${OWNER}/${REPO}.git &>/dev/null
	cd $REPO
fi

cd $BUILD_DIR/$APPNAME

_build
}

###################################################
## Player
### Repo/Release: github/onflapp/gs-desktop: 0.1
###################################################

function install_player()
{
APPNAME=Player
RELEASE="0.1"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d gs-desktop ];then
        cd gs-desktop
        git pull &>/dev/null
else
        git clone https://github.com/onflapp/gs-desktop.git &>/dev/null
        cd gs-desktop
fi

cd Applications/Player

_build
}

##########################
## PowerPaint
##########################

function install_powerpaint()
{

cd ../build || exit 1

APPNAME="PowerPaint"
REPO="tests-examples"
OWNER="gnustep"
HUB="https://github.com"
BRANCH="master"
BUILD_DIR="gui" # "system-apps" | "ported-apps"
CONFIG_ARGS=""
INSTALL_DIR="/Local/Applications"

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d $REPO ];then
        cd $REPO
        git pull origin $BRANCH &>/dev/null
else
	git clone ${HUB}/${OWNER}/${REPO}.git &>/dev/null
	cd $REPO
fi

cd $BUILD_DIR/$APPNAME

_build
}


#########################################
### PPC
#########################################

function install_ppc()
{
cd ../build || exit 1

APPNAME="PPC"
REPO="user-apps"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $APPNAME ];then
        cd $APPNAME
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/$REPO/$APPNAME
        cd $APPNAME || exit 1
fi
ok "Done"

_build
}

##################################################
## Preview
### Repo/Release: Salsa debian
##################################################

function install_preview
{
APPNAME=Preview
RELEASE="0.8.5"
HUB="https://salsa.debian.org/gnustep-team/preview.app"
DIR="preview.app"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1
subtitulo

printf "Fetching...\n"
if [ ! -d $DIR ];then
	git clone $HUB
	cd $DIR
else
	cd $DIR
	git pull
fi
printf "Patching...\n"
is_quilt
set_quilt
quilt push -a

make clean
_build

}

#####################################
## PRICE
### Repo/Release: sourceforge: 1.3.0
#####################################

function install_price()
{

cd ../build || exit 1

APPNAME="PRICE"
RELEASE="1.3.0"
EXT=".tar.gz"
HUB=https://master.dl.sourceforge.net/project/price/1.3.0
TARGET="${APPLICATIONS}"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d ${APPNAME}-${RELEASE} ];then
	cd ${APPNAME}-${RELEASE}
else
	wget --quiet ${HUB}/${APPNAME}-${RELEASE}${EXT}
	gunzip ${APPNAME}-${RELEASE}${EXT}
	tar -xf ${APPNAME}-${RELEASE}.tar
	cd ${APPNAME}-${RELEASE}
fi

_build
}


########################## - T - ########################## 

#########################################
### Talksoup
#########################################

function install_talksoup()
{
cd ../build || exit 1

APPNAME="TalkSoup"
REPO="user-apps"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $APPNAME ];then
        cd $APPNAME
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/$REPO/$APPNAME
        cd $APPNAME || exit 1
fi
ok "Done"

_build
}


########################## - V - ########################## 

###################################################
## Vespucci: GNUstep WebBrowser with SimpleWebKit
### Repo/Release: github/gnustep/gap: 0.1
###################################################

function install_vespucci()
{

cd ../build || exit 1

APPNAME="Vespucci"
REPO="gap"
OWNER="gnustep"
HUB="https://github.com"
BRANCH="master"
BUILD_DIR="user-apps"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d $REPO ];then
        cd $REPO
        git pull origin $BRANCH &>/dev/null
else
	git clone ${HUB}/${OWNER}/${REPO}.git &>/dev/null
	cd $REPO
fi

cd $BUILD_DIR/$APPNAME

_build

}

#######################################

########################## - W - ########################## 

#######################################
## Weather.app
#######################################
function install_weather
{

cd ../build || exit 1

APPNAME="Weather.app"
REPO="${APPNAME}"
OWNER="paulodelgado"
HUB="https://github.com"
BRANCH="main"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $REPO ];then
        cd $REPO
        git pull origin $BRANCH &>/dev/null
else
	git clone ${HUB}/${OWNER}/${REPO}.git &>/dev/null
	cd $REPO
fi

_build

printf "Adding the missing icon...\n"
ICON=RESOURCES/ICONS/weather.tiff
TARGET=${INSTALL_DIR}/Weather.app/Resources
sudo cp $ICON ${TARGET}/
ok "Done"
}
##################################
