#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Functions to remove app
### whatever root in root of
### app_dir or in a subdir
###
### _PWD must be set in the parent
### script, never here
################################

function remove_ifx_app
{
APPNAME="$1"
if [ -z "$1" ];then
	exit 1
fi

DIR_APP=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)

cd $DIR_APP
find . -name "${APPNAME}.app" -print | xargs sudo rm -r -f
if [ $? -eq 0 ];then
	printf "$APPNAME Bundle was removed.\n"
fi

cd ../Tools
find . -name "${APPNAME}*" -print | xargs sudo rm -f
if [ $? -eq 0 ];then
	printf "$APPNAME link was removed.\n"
fi
ok "Done"
cd $_PWD
}
