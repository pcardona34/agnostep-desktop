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
### We try to make and install
### an alternate window manager
### to replace wmaker:
### it is a fork of gershwin-windowmanger
### as kindly suggested by Joseph Maloney (alias pkgdemon)
#####################################################

####################################################
### Functions for inst_wm
####################################################

#############################################
### Dependencies on a debian system
#############################################
function gswm_deps
{
STR="Dependencies";titulo

### Checking if GNUstep base is already set
STR="Checking GNUstep base";subtitulo
LOCAL_LIBS=$(gnustep-config --variable=GNUSTEP_LOCAL_LIBRARIES)
GSBASE=${LOCAL_LIBS}/libgnustep-base.so

if [ ! -f ${GSBASE} ];then
    alert "GNUstep libs-base was not found! You must install GNUstep system first."
    exit 1
else
    ok "Base was found"
    sleep 2
fi
STR="XCBKit";subtitulo
pushd .
LIST="gswm" && install_deps
sleep 2
clear
popd
}

#############################################
### Fetching
#############################################

function install_gswm
{
clear
pushd .
if [ -f SCRIPTS/env_modern.sh ];then
    echo "We use the modern GNUstep ABI"
else
    warning "You should not try to build with Legacy GNUstep! Use instead Window Maker."
    exit 1
fi

cd ../build || exit 1

CHECK=NO
HUB="https://github.com"
OWNER="pcardona34" # We use a fork of pkgdemon's.
REPO="gnustep-windowmanager"
APPNAME="WindowManager"
CONFIG_ARGS=""
INSTALL_ARGS=""
STR="$APPNAME"

subtitulo

printf "Fetching...\n"
if [ ! -d $REPO ];then
	git clone ${HUB}/${OWNER}/${REPO}
fi

cd ${REPO} || exit 1

clear
subtitulo
ok "${APPNAME}: Fetched"

git switch master
git pull

printf "Building\n"
make &>>$LOG &
PID=$!
spinner
ok "\rDone"
sleep 2
if [ -d WindowManager/WindowManager.app ];then
    info "Window Manager was successfully built."
    printf "Installing...\n"
    cd WindowManager
    TARGET=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
    if [ ! -d ${TARGET} ];then
        sudo mkdir -p ${TARGET}
    fi
    sudo cp -a -v WindowManager.app ${TARGET}/
    if [ $? -ne 0 ];then
        alert "Installation of Window Manager failed!"
        exit 1
    else
        ok "Done"
    fi
    printf "\nUpdating services...\n"
    make_services
    ok "Done"
else
    alert "Window Manager building was not successful."
    exit 1
fi

ok "All was done for WindowManager."
sleep 2

popd

}
