#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Create the Conky conf file
################################

################################
### VARS

TRANS=`echo ${LANG%.UTF-8} | awk -F_ '{print $1}'`
. ../../SCRIPTS/functions_prep.sh
RPI=1
FOOT=foot.txt

###################################################
function assemble
{
laptop-detect
if [ $? -eq 0 ];then
	cat head.txt battery.txt $FOOT >> conky.conf.$TRANS
else
	cat head.txt $FOOT >> conky.conf.$TRANS
fi
}
###################################################

is_hw_rpi
if [ $RPI -eq 0 ];then
	FOOT=foot.rpi.txt
fi

if [ -n $TRANS ];then
	case $TRANS in
		"fr")
			cd fr && assemble
			mv conky.conf.fr ../conky.conf
			cd ..
			printf "The file 'conky.conf' has been generated\n";;
		"en" | *)
			cd en && assemble
			mv conky.conf.en ../conky.conf
			cd ..
			printf "The file 'conky.conf' has been generated\n";;
	esac
else
	printf "The LANG was not guessed. Aborting.\n"
	exit 1
fi
