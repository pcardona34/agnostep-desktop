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
### Functions for wrappers
####################################################

##############################################
### All the Wrappers
#### Those are in RESOURCES/WRAPPERS
##############################################

function install_wrapper
{
WRAP=$1
DEP=${2}
APPNAME=${WRAP}

STR="Installing the wrapper for $APPNAME"
subtitulo

if [ -n "$DEP" ];then
	STR="Dependencies";subtitulo
	sudo apt -y install ${DEP}
fi

sudo cp -a $_PWD/RESOURCES/WRAPPERS/${APPNAME}.app $INSTALL_DIR/
if [ "$CHECK" == "YES" ];then
	check $APPNAME
fi
cd $_PWD
}

#########################################################
function install_rpi_tools
{
RPI_TOOLS=RESOURCES/WRAPPERS/RPI_TOOLS || exit 1
cd ${RPI_TOOLS}

for WRAP in *.app
do
        APPNAME=${WRAP%.app}
	STR="Installing the wrapper for $APPNAME"
	subtitulo

	case "$APPNAME" in
	"Rpi-imager")
		remove_ifx_app $APPNAME
		cd ${RPI_TOOLS}
	        sudo cp -a ${APPNAME}.app $INSTALL_DIR/
		move_to_tools $APPNAME;;
	*)
	        sudo cp -a ${APPNAME}.app $INSTALL_DIR/;;
	esac
        check $APPNAME
done
cd $_PWD
}
##############################################

##############################################
function install_openURLService
{
### With Firefox or any Web Browser

SRC=RESOURCES/SERVICES/openURLService
LIB=$(gnustep-config --variable=GNUSTEP_LOCAL_LIBRARY)
TARGET=$LIB/Services/openURLService.service

STR="Installing openURLService"
subtitulo

cd ${SRC} || exit 1
printf "Building service...\n"
make clean &>/dev/null
make &>>$LOG &
PID=$!
spinner
ok "\rDone"
printf "Installing the service...\n"
sudo -E make install &>>$LOG &
PID=$!
spinner
ok "\rDone"

printf "Checking...\n"
if [ -d $TARGET ];then
	info "Service found.";sleep 3
else
	alert "Service not found: please, report this issue.";sleep 3
	exit 1
fi
printf "Updating Services... Wait please.\n"
make_services &>/dev/null &
PID=$!
spinner
ok "\rDone"

make clean
cd $_PWD
}

##############################################
function set_conf
{
CONF="$1"
DIRCONF=RESOURCES/CONF

if [ -z "$CONF" ];then
	exit 1
fi

case "$CONF" in
"nano")
RC=nanorc;;
"xterm")
RC=Xresources;;
esac

if [ -f ${DIRCONF}/$RC ];then
	cp ${DIRCONF}/$RC $HOME/.${RC} && info "$CONF conf has been set."
fi
}
##############################################
### Test
#set_conf "nano"
#set_conf "xterm"

##############################################
### End of functions
##############################################
