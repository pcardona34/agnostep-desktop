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
### Functions for inst_core_apps
####################################################

### Up to date or more stable?
### By default, it is <u>p to date;otherwise,  it has been set to 's'.
export SLEEP=${SLEEP:-2}
export UTD="${UTD:-u}"

################################################
### Finder
### A FileViewer by gcasa
function install_finder
{
clear
HUB="https://github.com"
OWNER="pcardona34" # Localized fork
REPO="Finder"
APPNAME="FileViewer"
BUILD_ARGS=""
INSTALL_ARGS=""
CONFIG_ARGS=""
DEPS="libmount-dev"
STR="$REPO"
subtitulo

STR="Dependencies";subtitulo
sudo apt install -y ${DEPS}
ok "Done";sleep 2
clear

cd ../build || exit 1

printf "Fetching ${REPO}...\n"
if [ -d $REPO ];then
    rm -fR $REPO
fi

git clone ${HUB}/${OWNER}/${REPO}.git
cd ${REPO} || exit 1

clear
subtitulo
ok "$REPO: Fetched"

_build

cd $_PWD
sleep 3
}

#################################################
### GWorkspace

function set_GW_help
{
### Patch: add GSHelpContentsFile to Info.plist
    if [ "$HELP_BUNDLE" == "YES" ];then
        printf "Applying a patch for Help implementation...\n"
        PATCH=$_PWD/RESOURCES/PATCHES/GWorkspace_InfoPlist_Help.patch
        TARGET=GWorkspace/GWorkspaceInfo.plist
        patch --forward -u $TARGET -i $PATCH
        ok "Done"

        printf "Help bundles...\n"
        cp -r $_PWD/RESOURCES/HELP/en/GWorkspace.help GWorkspace/Resources/English.lproj/
        cp -r $_PWD/RESOURCES/HELP/fr/GWorkspace.help GWorkspace/Resources/French.lproj/
    fi
}

function install_gworkspace
{
clear
HUB="https://github.com"
APPNAME=GWorkspace
RELEASE="1.1.0"
BUILD_ARGS=""
INSTALL_ARGS=""
CONFIG_ARGS=""
STR="$APPNAME $RELEASE"
subtitulo
HELP_BUNDLE=YES

cd ../build || exit 1

printf "Fetching...\n"
### We do not know if it was up2date or stable old release
if [ -d gworkspace ];then
    rm -fR gworkspace
fi

if [ "$UTD" == "u" ];then
   	git clone --branch=master "https://github.com/gnustep/apps-gworkspace"
   	mv apps-gworkspace gworkspace
else
    fetch $HUB/gnustep/apps-gworkspace/releases/download/gworkspace-1_0_0/gworkspace-1.1.0.tar.gz
    gunzip --force gworkspace-1.1.0.tar.gz
    tar -xf gworkspace-1.1.0.tar && rm gworkspace-1.1.0.tar
    mv gworkspace-1.1.0 gworkspace
fi

clear
subtitulo
ok "$APPNAME: Fetched"

cd gworkspace || exit 1

if [ -f ${_PWD}/SCRIPTS/env_modern.sh ];then
    printf "We use modern ABI";sleep 3
    printf "\nConfiguring...\n"
    autoupdate -f
    autoconf -f
    ./configure &>>$LOG &
    PID=$!
    spinner
    ok "\rDone"

    set_GW_help

    printf "Building...\n"
    make &>>$LOG &
    PID=$!
    spinner
    ok "\rDone"
    printf "Installing...\n"
    sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" PATH="$PATH" -E make messages=yes ${INSTALL_ARGS} install &>>$LOG &
    PID=$!
    spinner
    ok "\rDone"
else
    CONFIG_ARGS="--with-inotify --enable-gwmetadata"

    if [ "$UTD" == "s" ];then
        ### Patch: fix 'Downloads' L18N in FSNode
        printf "Applying a L18N patch...\n"
        PATCH=$_PWD/RESOURCES/PATCHES/GWorkspace_FSNode_L18n.patch
        TARGET=FSNode/Resources/French.lproj/Localizable.strings
        patch --forward -u $TARGET -i $PATCH
        ok "Done"
    fi
    set_GW_help
    _build
fi

check "GWorkspace"
check "Recycler"
#check "MDFinder"

cd $_PWD
sleep 3
}


#######################################
## SystemPreferences
### Repo/release: github/gnustep: 1.2.0
########################################

function install_systempreferences()
{
clear
APPNAME="SystemPreferences"
RELEASE="1.2.1"
CONFIG_ARGS=""
BUILD_ARGS=""
INSTALL_ARGS=""
HUB="https://github.com"
STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"
if [ "$UTD" == "u" ];then
    if [ -d SystemPreferences ];then
    	cd SystemPreferences
    	git pull
        cd ..
    else
    	git clone --branch=master https://github.com/gnustep/apps-systempreferences
    	mv apps-systempreferences SystemPreferences
    fi
else
    fetch $HUB/gnustep/apps-systempreferences/releases/download/systempreferences-1_2_1/SystemPreferences-1.2.1.tar.gz
    gunzip --force SystemPreferences-1.2.1.tar.gz
    tar -xf SystemPreferences-1.2.1.tar && rm SystemPreferences-1.2.1.tar
    mv SystemPreferences-1.2.1 SystemPreferences
fi

subtitulo
ok "$APPNAME: Fetched"

cd SystemPreferences || exit 1

_build

sleep $SLEEP
}

#############################################
## Terminal
### Repo/Release: Savannah/svn
#############################################

function install_terminal()
{
clear
APPNAME=Terminal
RELEASE="0.9.8"
CONFIG_ARGS=""
BUILD_ARGS=""
HUB="https://github.com"
OWNER="gnustep"
REPO="gap"
INSTALL_ARGS=""

STR="$APPNAME $RELEASE"
subtitulo

cd ../build || exit 1

printf "Fetching...\n"

if [ -d gap/system-apps/Terminal ];then
	cd gap/system-apps/Terminal
	git pull
else
	#svn co svn://svn.savannah.nongnu.org/gap/trunk/system-apps/Terminal
    git clone ${HUB}/${OWNER}/${REPO}
    cd gap/system-apps/Terminal || exit 1
fi
clear
subtitulo
ok "$APPNAME: Fetched"

_build

sleep $SLEEP
}
