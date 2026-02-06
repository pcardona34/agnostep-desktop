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
### Functions for inst_tools...
####################################################

if [ ! -d ../build ];then
	mkdir ../build
fi

####################################################
### ARG: APPNAME (without ext .app)
####################################################
function move_to_tools
{
APPNAME="$1"
if [ -z "$APPNAME" ];then
	exit 1
fi
LG=${LANG:0:2}
case "$LG" in
"fr")
	TOOLS=Utilitaires;;
"en"|*)
	TOOLS=Utilities;;
esac

APP_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)

if [ -z "$APP_DIR" ];then
	alert "Your GNUstep System seems misconfigured."
	exit 1
fi

TOOL_DIR=${APP_DIR}/${TOOLS}

if [ ! -d ${TOOL_DIR} ];then
	sudo mkdir -p ${TOOL_DIR}
fi

sudo mv ${APP_DIR}/${APPNAME}.app ${TOOL_DIR}/
cd ${APP_DIR}
cd ../Tools
sudo ln --force --symbolic ${TOOL_DIR}/${APPNAME}.app
sudo ln --force --symbolic ${TOOL_DIR}/${APPNAME}.app/${APPNAME}
cd $_PWD
}

########################## - A - ##########################

###################################################
## Affiche
### Repo/Release: Debian Salsa GNUstep Team
###################################################

function install_affiche()
{
clear
cd ../build || exit 1

APPNAME=Affiche
RELEASE="0.6.0"
DIR="affiche.app"
STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ ! -d affiche.app ];then
	git clone https://salsa.debian.org/gnustep-team/affiche.app.git
   	cd $DIR || exit 1
else
	cd $DIR
	git pull
fi
clear
subtitulo
ok "$APPNAME fetched"

### Patching
is_quilt
set_quilt
quilt push -a

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}

########################## - C - ########################## 

##########################
## Calculator
##########################

function install_calculator()
{

cd ../build || exit 1

APPNAME="Calculator"
REPO="tests-examples"
OWNER="gnustep"
HUB="https://github.com"
BRANCH="master"
BUILD_DIR="gui"
CONFIG_ARGS=""
INSTALL_DIR="/Local/Applications"
INSTALL_ARGS="GNUSTEP_INSTALLATION_DOMAIN=LOCAL"

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d $REPO ];then
        cd $REPO
        git pull origin $BRANCH
else
	git clone ${HUB}/${OWNER}/${REPO}.git
	cd $REPO || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

cd $BUILD_DIR/$APPNAME || exit 1

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}

########################## - D - ########################## 

#####################################################
## DictionaryReader
### Repo/Release: Debian Salsa
#####################################################

function install_dictionaryreader()
{
clear
cd ../build || exit 1

APPNAME="DictionaryReader"
RELEASE="0.2"
HUB="https://salsa.debian.org/gnustep-team/etoile"
DIR="etoile"
BUILD_DIR="Etoile/Services/User/DictionaryReader"
CONFIG_ARGS=""
INSTALL_DIRS=""

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d $DIR ];then
        cd $DIR
        git pull
else
	git clone ${HUB}
	cd $DIR || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

### Patching
is_quilt
set_quilt
quilt push -a

cd "$BUILD_DIR"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}

########################## - F - ##########################

##################################################
## FontManager
### Repo/Release: Debian Salsa
##################################################

function install_fontmanager()
{
clear
cd ../build || exit 1

APPNAME="FontManager"
HUB="https://salsa.debian.org/gnustep-team/fontmanager.app.git"
CONFIG_ARGS=""
INSTALL_ARGS=""
DIR="fontmanager.app"

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $DIR ];then
        cd $DIR
        git pull
else
	git clone ${HUB}
	cd $DIR || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

### Patching
is_quilt
set_quilt
quilt push -a

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}

#########################################
### FTP
#########################################

function install_ftp()
{
clear
cd ../build || exit 1

APPNAME="FTP"
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
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}

########################## - G - ########################## 

##########################################
## GSPdf
### Repo/Release: Savannah/gap: subversion
##########################################

function install_gspdf()
{
clear
APPNAME=GSPdf
RELEASE="0.5"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d GSPdf ];then
        cd GSPdf
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/GSPdf
        cd GSPdf
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}

########################## - H - ########################## 

#################################################
## HelpViewer
#################################################

function install_helpviewer()
{
clear
APPNAME="HelpViewer"
HUB="svn://svn.savannah.nongnu.org/gap/trunk/system-apps"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

cd ../build || exit 1

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d $APPNAME ];then
        cd $APPNAME
        svn update
else
	svn co ${HUB}/${APPNAME}
	cd $APPNAME || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}
### End of HelpViewer
##############################################


########################## - I - ########################## 


###############################################
### Installer
function install_installer
{
clear
APPNAME="Installer"
STR="$APPNAME";subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d $APPNAME ];then
        cd $APPNAME
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/system-apps/$APPNAME
        cd $APPNAME || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}
#########################################

########################## - L - ########################## 

#################################################
## Librarian
### Repo/Release: github/onflapp/gs-desktop: 0.1
#################################################

function install_librarian()
{
clear
cd ../build || exit 1

APPNAME="Librarian"
RELEASE="0.1"
REPO="gs-desktop"
OWNER="onflapp"
HUB="https://github.com"
BRANCH="main"
BUILD_DIR="Applications"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

printf "Fetching...\n"
if [ -d $REPO ];then
        cd $REPO
        git pull origin $BRANCH
else
	git clone ${HUB}/${OWNER}/${REPO}.git 
	cd $REPO
fi
clear
subtitulo
ok "$APPNAME fetched"

cd $BUILD_DIR/$APPNAME

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}


########################## - M - ########################## 

###########################################################################
### Experimental
###########################################################################
### Memory app

function install_memory
{
clear
cd ../build || exit 1

APPNAME="Memory"
REPO="memory"
SITE="https://github.com/pcardona34"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME";subtitulo

printf "Fetching...\n"
if [ -d $REPO ];then
        cd $REPO
        git pull origin main
else
        git clone $SITE/${REPO}.git
        cd $REPO || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}


########################## - N - ########################## 

########################## - O - ########################## 

#####################################################
## OpenUp
### Repo/Release: github/onflapp/gs-desktop: 0.1
#####################################################

function install_openup()
{
clear
APPNAME=OpenUp
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
        git pull
else
        git clone https://github.com/onflapp/gs-desktop.git
        cd gs-desktop
fi

cd Applications/OpenUp || exit 1
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}


########################## - S - ########################## 

#################################################
## ScanImage
### Repo/Release: github/onflapp/gs-desktop: 0.1
#################################################

function install_scanimage()
{
APPNAME=ScanImage
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
        git pull
else
        git clone https://github.com/onflapp/gs-desktop.git
        cd gs-desktop || exit 1
fi

cd Applications/ScanImage || exit 1
clear
subtitulo
ok "$APPNAME fetched"


CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}


##################################################
## Screenshot
### Repo/Release: github/onflapp/gs-desktop: 0.1
##################################################

function install_screenshot()
{
clear
APPNAME=ScreenShot
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
        git pull
else
        git clone https://github.com/onflapp/gs-desktop.git
        cd gs-desktop || exit 1
fi
cd Applications/ScreenShot || exit 1
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}

############################################
## StepSync
### Repo/Release: Savannah/gap: 1.1
############################################

function install_stepsync()
{
clear
cd ../build || exit 1

APPNAME="StepSync"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $APPNAME ];then
        cd $APPNAME
        svn update
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/system-apps/StepSync
	cd $APPNAME
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}


#################################################
## Vindaloo: PDF Viewer
### Repo: Debian Salsa GNUstep Team
#################################################

function install_vindaloo
{
clear
APPNAME="Vindaloo"
DIR=vindaloo.app
HUB="https://salsa.debian.org/gnustep-team/vindaloo.app.git"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME (ViewPDF)"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d $DIR ];then
        cd $DIR
        git pull
else
	git clone ${HUB}
	cd $DIR || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

printf "Patching..."
is_quilt
set_quilt
quilt push -a

#_build
printf "Building...\n"
make clean &>/dev/null
make &>>$LOG &
PID=$!
spinner
ok "\rDone"

printf "Adding the missing icon...\n"
ICON=$_PWD/RESOURCES/ICONS/ViewPDF.tiff
TARGET=./ViewPDF.app/Resources
cp $ICON ${TARGET}/
printf "Fixing Info-gnustep.plist...\n"
PATCH=$_PWD/RESOURCES/PATCHES/ViewPDF_plist.patch
patch --forward -u $TARGET/Info-gnustep.plist -i $PATCH
ok "Done"

printf "Installing...\n"
sudo -E make install &>>$LOG &
PID=$!
spinner
ok "\rDone"

APPNAME=ViewPDF
move_to_tools $APPNAME
check $APPNAME
sleep $SLEEP
}



########################## - Z - ##########################

#######################################
## Zipper
#######################################
function install_zipper
{
clear
cd ../build || exit 1

APPNAME="Zipper"
HUB="svn://svn.savannah.nongnu.org/gap/trunk/system-apps/Zipper"
DIR="Zipper"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $DIR ];then
        cd $DIR
        svn update
else
	svn co ${HUB}
	cd $DIR || exit 1
fi
clear
subtitulo
ok "$APPNAME fetched"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
sleep $SLEEP
}
