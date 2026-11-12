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
### Functions for 1_prep.sh
################################

#############################################
### Sanity check
function sanity_check
{

STR="Checking your environment"
subtitulo

ARCHI=`uname -a | awk '{print $10}'`
MSG="On $ID - $DEBIAN_VERSION_FULL - ${ARCHI}\nYou are welcome!\n\n"

if [ "$ID" == "$REQUIRED_OS" ] && [ "$VERSION_ID" == "$REQUIRED_RELEASE" ];then
	info "$MSG"
else
	alert "A G N o S t e p  Desktop should not be installed without $REQUIRED_OS ${REQUIRED_RELEASE}.\nAborting!\n"
	exit 1
fi
}

#############################################
### Debian update
function debian_update
{

info "It is time to have a cup of tea or coffee. ;-)"

STR="Updating Debian Lite OS"
subtitulo

printf "Updating...\n"

sudo apt update
sudo apt -y upgrade

ok "Done"
sleep 2
clear
}
### End of Debian update
#############################################

#############################################
### Core dependencies for GNUstep
### and Window Maker Desktop
### Use: LIST="name" && install_deps
### See in RESOURCES available lists of deps

function install_deps
{
REF="${LIST:-build}"
OPTIONS="--no-show-upgraded --no-upgrade --yes"
STR="Installing Dependencies"
subtitulo

. /etc/os-release
prefix="#"
local STATUS=0

FILE="RESOURCES/DEPS/dep_${REF}_debian_${VERSION_ID}.txt"
if ! [ -f $FILE ];then
	alert "The file ${FILE} was not found."
	exit 1
fi
STRING=""
while read DEP
do
if [ -z "$DEP" ];then
	# This line is empty...
	continue
fi
echo "$DEP" | grep -e "$prefix" &>/dev/null
if [ $? -eq 0 ];then
	# This line is commented out...
	continue
else
	STRING="${DEP} ${STRING}"
fi
done < $FILE

if [ ! -z "STRING" ];then
	sudo apt-get ${OPTIONS} install ${STRING}
	if [ $? -ne 0 ];then
		alert "ERROR: a dependency was not resolved.\nAborting!!!" | tee -a $LOG
		warning "You must resolve this dependency trap.\nSee and fix ${FILE}. Then execute again:\n\n\t ${0}\n\n"
		exit 1
	else
		ok "\nDone"
	fi
else
	alert "The dependency list was empty."
	warning "You must check ${FILE}."
	exit 1
fi

}

#############################################
### SPEC Raspberry Pi
### Is the current hardware a Raspberry Pi
### If yes, it has a specific Device Tree

function is_hw_rpi
{
### By default global RPI has been set to 1: no RPI
### Arm architecture 64 bit?
ARCH=`uname -m`
printf "Architecture: ${ARCH}\n"

if [ "$ARCH" == "aarch64" ];then
	if [ -f /sys/firmware/devicetree/base/model ];then
		MODEL=`head --bytes=-1 /proc/device-tree/model`
		echo "$MODEL" | grep -e "Raspberry Pi" &>/dev/null
		if [ $? -eq 0 ];then
			printf "Your model is a RPI: $MODEL\n"
			RPI=0
		else
			printf "Not a Raspberry Pi.\n"
		fi
	else
		printf "Model: no Device Tree Model info\n"
	fi
fi
}

################################################
### SPEC Apple computer
### Is the current hardware an Apple one?
### If yes, it must return the key word apple

function is_hw_apple
{
if [ -f /sys/class/dmi/id/sys_vendor ] && [ -f /sys/class/dmi/id/product_name ];then
	VENDOR=$(cat /sys/class/dmi/id/sys_vendor)
	PRODUCT=$(cat /sys/class/dmi/id/product_name)
	if [ -n "$VENDOR" ] && [ "$VENDOR" == "Apple Inc." ] && [ -n "$PRODUCT" ] && [ "$PRODUCT" == "MacBookPro6,2" ];then
    		printf "This is an Apple ${PRODUCT}.\n"
    		APPLE=0
	else
    		printf "Not a known Apple computer.\n"
    		printf "You may help to improve this script: functions_prep.sh\n"
	fi
fi
}
