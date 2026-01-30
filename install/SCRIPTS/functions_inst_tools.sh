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

### Patching
is_quilt
set_quilt
quilt push -a

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
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
        git pull origin $BRANCH &>/dev/null
else
	git clone ${HUB}/${OWNER}/${REPO}.git &>/dev/null
	cd $REPO
fi

cd $BUILD_DIR/$APPNAME || exit 1

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}

########################## - D - ########################## 

#####################################################
## DictionaryReader
### Repo/Release: Debian Salsa
#####################################################

function install_dictionaryreader()
{

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
	cd $DIR
fi

### Patching
is_quilt
set_quilt
quilt push -a

cd "$BUILD_DIR"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}



########################## - F - ##########################

##################################################
## FontManager
### Repo/Release: Debian Salsa
##################################################

function install_fontmanager()
{

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
	cd $DIR
fi

### Patching
is_quilt
set_quilt
quilt push -a

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}

#########################################
### FTP
#########################################

function install_ftp()
{
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
ok "Done"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}

########################## - G - ########################## 

##########################################
## GSPdf
### Repo/Release: Savannah/gap: subversion
##########################################

function install_gspdf()
{
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
        svn update &>/dev/null
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/GSPdf &>/dev/null
        cd GSPdf
fi

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}

########################## - H - ########################## 

#################################################
## HelpViewer
#################################################

function install_helpviewer()
{

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
        svn update &>/dev/null
else
	svn co ${HUB}/${APPNAME} &>/dev/null
	cd $APPNAME
fi

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}
### End of HelpViewer
##############################################


########################## - I - ########################## 


###############################################
### Installer
function install_installer
{

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

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}

}
#########################################

########################## - L - ########################## 

#################################################
## Librarian
### Repo/Release: github/onflapp/gs-desktop: 0.1
#################################################

function install_librarian()
{

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
        git pull origin $BRANCH &>/dev/null
else
	git clone ${HUB}/${OWNER}/${REPO}.git &>/dev/null
	cd $REPO
fi

cd $BUILD_DIR/$APPNAME

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}


########################## - M - ########################## 

###########################################################################
### Experimental
###########################################################################
### Memory app

function install_memory
{
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
ok "Done"

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}


########################## - N - ########################## 

########################## - O - ########################## 

#####################################################
## OpenUp
### Repo/Release: github/onflapp/gs-desktop: 0.1
#####################################################

function install_openup()
{
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
        git pull &>/dev/null
else
        git clone https://github.com/onflapp/gs-desktop.git &>/dev/null
        cd gs-desktop
fi

cd Applications/OpenUp

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
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
        git pull &>/dev/null
else
        git clone https://github.com/onflapp/gs-desktop.git &>/dev/null
        cd gs-desktop
fi

cd Applications/ScanImage

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}


##################################################
## Screenshot
### Repo/Release: github/onflapp/gs-desktop: 0.1
##################################################

function install_screenshot()
{
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
        git pull &>/dev/null
else
        git clone https://github.com/onflapp/gs-desktop.git &>/dev/null
        cd gs-desktop
fi

cd Applications/ScreenShot

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}


############################################
## StepSync
### Repo/Release: Savannah/gap: 1.1
############################################

function install_stepsync()
{
cd ../build || exit 1

APPNAME="StepSync"
CONFIG_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME"
subtitulo

printf "Fetching...\n"
if [ -d $APPNAME ];then
        cd $APPNAME
        svn update &>/dev/null
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/system-apps/StepSync &>/dev/null
	cd $APPNAME
fi

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}


#################################################
## Vindaloo: PDF Viewer
### Repo: Debian Salsa GNUstep Team
#################################################

function install_vindaloo
{
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
        git pull &>/dev/null
else
	git clone ${HUB} &>/dev/null
	cd $DIR
fi

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
}



########################## - Z - ##########################

#######################################
## Zipper
#######################################
function install_zipper
{

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
	cd $DIR
fi

CHECK=""
_build
move_to_tools ${APPNAME}
check ${APPNAME}
}

