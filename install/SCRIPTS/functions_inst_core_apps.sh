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
### Functions for inst_apps
####################################################

#############################################
### AClock: analogic clock for the C5C flavour
### of the desktop
############################################# 
function install_aclock
{
cd ../build || exit 1

APPNAME="AClock"
REPO="user-apps"
CONFIG_ARGS=""
INSTALL_ARGS=""

echo "$APPNAME" >> $LOG
title "$APPNAME"

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

#######################################
## Addresses
### Repo/Release: savannah/gap svn
#######################################

function install_addressmanager()
{

APPNAME=AddressManager
#RELEASE="0.5.0"

echo "$APPNAME" >>$LOG
title "$APPNAME"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

cd ../build || exit 1

printf "Fetching...\n"
if [ -d Addresses ];then
	cd Addresses
	svn update
	cd AddressManager || exit 1
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/system-apps/Addresses
	cd Addresses
	cd AddressManager || exit 1
fi

_build
}


##############################################
function install_batmon
{
PATCH=batmon_AGNOSTEP.patch
THEME=`defaults read NSGlobalDomain GSTheme | awk '{print $3}'`
APPNAME="batmon"
STR="Batmon";subtitulo

cd ../build || exit 1

### We must start from a clean repo
if [ -d batmon ];then
	rm -fR batmon
fi

printf "Fetching...\n"
svn co svn://svn.savannah.nongnu.org/gap/trunk/system-apps/batmon
cd batmon || exit 1

if [ "$THEME" == "AGNOSTEP" ];then
	### PATCH begins...
	cp $_PWD/RESOURCES/PATCHES/$PATCH ./
	printf "A patch must be applied... "
	TARGET=./AppController.m
	patch --forward -u ${TARGET} -i ./${PATCH}
	ok "Done"
	### End of Patch
fi

_build

}

#################################################
## GNUMail (current / stable tarball)
### Repo/Release: Savannah/gnustep-nonfsf: 1.4.0
#################################################

function install_gnumail()
{
APPNAME=GNUMail
RELEASE="1.4.0 - stable release"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME - $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d GNUMail-1.4.0 ];then
	cd GNUMail-1.4.0
else
    wget --silent http://download.savannah.nongnu.org/releases/gnustep-nonfsf/GNUMail-1.4.0.tar.gz
    gunzip --force GNUMail-1.4.0.tar.gz
    tar -xf GNUMail-1.4.0.tar && rm GNUMail-1.4.0.tar
	cd GNUMail-1.4.0
fi

if [ -d /Local/Applications/GNUMail.app ];then
	sudo rm -fR /Local/Applications/GNUMail.app
	make_services
fi

_build
}

#################################################
## GNUMail (current / svn)
### Repo/Release: svn Savannah/gnustep-nonfsf
#################################################

function install_gnumail_svn()
{
APPNAME=GNUMail
RELEASE="Last svn version"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

STR="$APPNAME - $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ -d gnumail ];then
	cd gnumail
        svn update
else
    svn co svn://svn.savannah.nongnu.org/gnustep-nonfsf/apps/gnumail
	cd gnumail
fi

_build
}

########################################
## GWorkspace
### Repo/Release: github/gnustep: 1.1.0
########################################

function install_gworkspace()
{

APPNAME=GWorkspace
RELEASE="1.1.0"
CONFIG_ARGS="--with-inotify --enable-gwmetadata"
BUILD_ARGS=""
INSTALL_ARGS=""


echo "$APPNAME $RELEASE" >> $LOG
title "$APPNAME $RELEASE"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d apps-gworkspace ];then
	cd apps-gworkspace
	git pull &> /dev/null
else
	git clone --branch=master "https://github.com/gnustep/apps-gworkspace" &> /dev/null
	cd apps-gworkspace
fi

### Patch: fix 'Downloads' L18N in FSNode
printf "Applying a L18N patch...\n"
PATCH=$_PWD/RESOURCES/PATCHES/GWorkspace_FSNode_L18n.patch
TARGET=FSNode/Resources/French.lproj/Localizable.strings
patch --forward -u $TARGET -i $PATCH
ok "Done"

_build

#check "Recycler"
#check "MDFinder"
}

###################################################
## InnerSpace
### Repo/Release: github/onflapp/gs-desktop: 0.1
###################################################

function install_innerspace()
{
APPNAME=InnerSpace
RELEASE="0.1"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

PATCH="spordefs.patch"
TARGET="spordefs.m"
PROJ="SporView.bproj"
PATCH2="InnerSpace_GNUMakefile.patch"
TARGET2="GNUMakefile"
title "$APPNAME $RELEASE" | tee -a $LOG

cd ../build || exit 1

printf "Fetching...\n"
if [ -d InnerSpace ];then
        cd InnerSpace
        svn update &>/dev/null
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/user-apps/InnerSpace &>/dev/null
        cd InnerSpace
fi

if ! [ -d $HOME/GNUstep/Library/InnerSpace ];then
	mkdir -p $HOME/GNUstep/Library/InnerSpace
fi
printf "Building and installing the subprojects...\n"
for SUB in *.bproj
do
	cd $SUB
	printf "\t${SUB}...\n"
	if [ "$SUB" == "$PROJ" ];then
		### PATCH
		cp $_PWD/RESOURCES/PATCHES/$PATCH ./
		printf "\tA patch must be applied...\n"
		patch --forward -u ${TARGET} -i ${PATCH} &>>$LOG
		ok "\tPatch applied"
	fi
	make &>>$LOG
	cd ..
	cp --recursive $SUB $HOME/GNUstep/Library/InnerSpace/
	ok "\r\tDone"
done

printf "Building Main InnerSpace...\n"
### PATCH
cp $_PWD/RESOURCES/PATCHES/$PATCH2 ./
printf "\tA patch must be applied...\n"
patch --forward -u ${TARGET2} -i ${PATCH2} &>>$LOG
ok "\tPatch applied"

_build
}
### End of InnerSpace
##############################################

##########################################
## SimpleAgenda
### Repo/Release: github/poroussel: 0.4.7
##########################################

function install_simpleagenda()
{
APPNAME=SimpleAgenda
RELEASE="0.4.7"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

echo "$APPNAME $RELEASE" >>$LOG
title "$APPNAME $RELEASE"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d simpleagenda ];then
	cd simpleagenda
	git pull &>/dev/null
else
	git clone https://github.com/poroussel/simpleagenda.git &>/dev/null
	cd simpleagenda
fi

_build
}


#######################################
## SystemPreferences
### Repo/release: github/gnustep: 1.2.0
########################################

function install_systempreferences()
{
APPNAME="SystemPreferences"
RELEASE="1.2.0"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

echo "$APPNAME $RELEASE" >> $LOG
title "$APPNAME $RELEASE"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d apps-systempreferences ];then
	cd apps-systempreferences
	git pull &>/dev/null
else
	git clone --branch=master https://github.com/gnustep/apps-systempreferences &>/dev/null
	cd apps-systempreferences
fi

_build
}



#############################################
## Terminal
### Repo/Release: Savannah/svn
#############################################

function install_terminal()
{

APPNAME=Terminal
RELEASE="0.9.8"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

echo "$APPNAME $RELEASE" >>$LOG
title "$APPNAME $RELEASE"

cd ../build || exit 1

printf "Fetching...\n"


if [ -d Terminal ];then
	cd Terminal
	svn update &>/dev/null
else
	svn co svn://svn.savannah.nongnu.org/gap/trunk/system-apps/Terminal &>/dev/null
	cd Terminal
fi

_build
}


###################################################
## TextEdit
### Repo/Release: github/onflapp/gs-textedit: 4.0
###################################################

function install_textedit()
{
APPNAME=TextEdit
RELEASE="4.0"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

echo "$APPNAME $RELEASE" >>$LOG
title "$APPNAME $RELEASE"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d gs-textedit ];then
	cd gs-textedit
	git pull &>/dev/null
else
	git clone https://github.com/onflapp/gs-textedit.git &>/dev/null
	cd gs-textedit
fi

_build
}


##########################################
## TimeMon
### Repo/Release: Savannah/gap: 4.1
##########################################

function install_timemon()
{
APPNAME=TimeMon
RELEASE="4.1"
HUB=

echo "$APPNAME $RELEASE" >>$LOG
title "$APPNAME $RELEASE"

printf "Fetching...\n"
cd ../build || exit 1

if [ -d $APPNAME ];then
        cd $APPNAME
        svn update
else
        svn co svn://svn.savannah.nongnu.org/gap/trunk/ported-apps/Util/$APPNAME
        cd $APPNAME || exit 1
fi

_build
}




###################################################
## VolumeControl
### Repo/Release: Github/Alexmyczko
###################################################

function install_volumecontrol()
{

APPNAME=VolumeControl
RELEASE=""
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""

echo "$APPNAME $RELEASE" >>$LOG
title "$APPNAME $RELEASE"

cd ../build || exit 1

printf "Fetching...\n"
if [ -d ${APPNAME}.app ];then
	cd ${APPNAME}.app
	git pull &>/dev/null
else
	git clone https://github.com/alexmyczko/VolumeControl.app.git &>/dev/null
	cd ${APPNAME}.app
fi

_build
}


