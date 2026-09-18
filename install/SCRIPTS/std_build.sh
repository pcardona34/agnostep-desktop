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
## standard configure and build app function
####################################################

function _build()
{
DEBUG=${DEBUG:no}
SYSTOOLS=$(gnustep-config --variable=GNUSTEP_SYSTEM_TOOLS)
if [ -z "$SYSTOOLS" ];then
    alert "Your GNUstep System Path is misconfigured! Aborting."
    exit 1
fi

if [ -z ${APPNAME} ];then
	alert "The Application Name is misconfigured. Aborting!"
    exit 1
fi

if [ -f configure ];then
        printf "Configuring...\n"
        ./configure ${CONFIG_ARGS} &>>$LOG &
        PID=$!
        spinner
        printf "\rBuilding...\n"
else
        printf "Building...\n"
fi

if [ "$DEBUG" == "yes" ];then
    if [ -z "$DLOG" ];then
        make ${BUILD_ARGS} || exit 1
    else
        printf "Look at ${DLOG}...in `pwd`\n\n"
        make ${BUILD_ARGS} &>$DLOG || exit 1
    fi
else
    make ${BUILD_ARGS} &>>$LOG &
    PID=$!
    spinner
fi

printf "\rInstalling...\n"
if [ "$DEBUG" == "yes" ];then
   sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" PATH="$PATH" -E make messages=yes ${INSTALL_ARGS} install
    ok "Done"
else
    sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" PATH="$PATH" -E make messages=yes ${INSTALL_ARGS} install &>>$LOG &
    #env PATH="$PATH:${SYSTOOLS}"
    PID=$!
    spinner
    ok "\rDone"
fi

### Cleaning
sudo chown -fR $USER:$USER . &>/dev/null
make clean &>/dev/null

cd $_PWD

if [ "$CHECK" == "YES" ];then
	check ${APPNAME}
fi

}

##################################################
## Special case: test apps
## Those lack of a 'make install'
##################################################

function _build_test()
{

if [ -z ${APPNAME} ];then
	alert "The application is misconfigured. Aborting!"
fi

if [ -f configure ];then
        printf "Configuring...\n"
        ./configure ${CONFIG_ARGS} &>>$LOG &
        PID=$!
        spinner
        printf "\rBuilding...\n"
else
        printf "Building...\n"
fi

make ${BUILD_ARGS} &>>$LOG &
PID=$!
spinner

printf "\rInstalling...\n"
sudo -E cp -a ${APPNAME} ${INSTALL_DIR}/ &>>$LOG &
PID=$!
spinner

#make_services

### Cleaning
sudo chown -fR $USER:$USER . &>/dev/null
make clean &>/dev/null

ok "\rDone"

cd $_PWD

check ${APPNAME}

}


###################################################
### Building Frameworks / Libs
###################################################

function _build_FW()
{

if [ -z ${FWNAME} ];then
	alert "The Name of Framework is misconfigured. Aborting!"
    exit 1
fi

if [ -f configure ];then
        printf "Configuring...\n"
        ./configure ${CONFIG_ARGS} &>>$LOG &
        PID=$!
        spinner
        printf "\rBuilding...\n"
else
        printf "Building...\n"
fi

make &>>$LOG &
PID=$!
spinner

printf "\rInstalling...\n"
sudo -E env PATH="$PATH:${SYSTOOLS}" make ${INSTALL_ARGS} install &>>$LOG &
PID=$!
spinner

### Cleaning
sudo chown -fR $USER:$USER . &>/dev/null
make clean &>/dev/null

sudo ldconfig

cd $_PWD

ok "\rDone"


if [ "${FWNAME}" == "Renaissance" ] || [ "${FWNAME}" == "Performance" ] || [ "${FWNAME}" == "WebServices" ];then
	check_LIB ${FWNAME}
else
	check_FW ${FWNAME}
fi

}

###################################################
### Building Themes
###################################################

function _build_Theme()
{

if [ -z ${APPNAME} ];then
	alert "The Name of the THEME is misconfigured. Aborting!"
    exit 1
fi

if [ -f configure ];then
        printf "Configuring...\n"
        ./configure ${CONFIG_ARGS} &>>$LOG &
        PID=$!
        spinner
        printf "\rBuilding...\n"
else
        printf "Building...\n"
fi

make &>>$LOG &
PID=$!
spinner

printf "\rInstalling...\n"
sudo -E env PATH="$PATH:${SYSTOOLS}" make ${INSTALL_ARGS} install &>>$LOG &
PID=$!
spinner

### Cleaning
make clean &>/dev/null

cd $_PWD

ok "\rDone"

check_THEME ${APPNAME}

}

######################################################
### Install forked apps
######################################################

function install_forked
{
FORKED="$1"
FORKS=RESOURCES/FORKS
if [ -n "$1" ];then
       cd ${FORKS}/${FORKED} || exit 1
       ./install.sh
        cd $_PWD
fi
}

######################################################
### Install native agnostep apps
######################################################

function install_native
{
NATIVE="$1"
APPS=RESOURCES/APPS
export DEBUG="no" # set to 'no' for a less verbose output, otherwise 'yes'

if [ -n "$1" ];then
    cd ${APPS}/${NATIVE} || exit 1
    ./install.sh
fi
}
