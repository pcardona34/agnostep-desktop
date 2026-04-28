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
### Install AgnostepManager
################################

STR="${PWD##*/}"
APP="${STR}"
HERE=`pwd`
DEST=/usr/local/bin
DEPS="dialog xterm"

################################
### include functions

. ../../../SCRIPTS/colors.sh
. ../../../SCRIPTS/find_app.sh
. ../../../SCRIPTS/log.sh
. ../../../SCRIPTS/check_app.sh
. ../../../SCRIPTS/functions_remove_app.sh

################################
### You must be superuser to install
sudo -v

titulo

if [ ! -d $DEST ];then
    sudo mkdir -p $DEST
fi

STR="Dependencies";subtitulo

sudo apt -y install ${DEPS}
ok "Done"
sleep 2;clear

STR="Dependencies: scripts";subtitulo

cd SCRIPTS || exit 1
for SC in *.sh
do
chmod +x $SC
sudo cp --verbose $SC $DEST/
done

STR="Purge old release";subtitulo
remove_ifx_app ${APP}

STR="Building and installing ${APP}...";subtitulo
cd ${HERE} || exit 1

make clean &>/dev/null
make && ok "Build done"
sudo -E env PATH="$PATH:/System/Tools" make install && ok "Install done"

check "${APP}"
make clean &>/dev/null
sleep 2
