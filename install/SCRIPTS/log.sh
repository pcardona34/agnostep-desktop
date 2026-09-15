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
### Log
### Managing Agnostep Log
################################

LOG=/var/log/agnostep.log
if [ ! -f $LOG ];then
	sudo touch $LOG
	sudo chown $USER:$USER $LOG
fi

date >> $LOG

######################################
### is_log_ok
######################################

function is_log_ok
{
PART="$1"
STR="Checking $PART installation..."
subtitulo

local _COUNT=0

grep -v -e " (ignor" $LOG | grep -e " Error " &>/dev/null
if [ $? -eq 0 ];then
	_COUNT=$(( $_COUNT + 1 ))
fi
grep -v -e " error: nil" $LOG | grep -v -e " error: &" | grep -e " error: " &>/dev/null
if [ $? -eq 0 ];then
	_COUNT=$(( $_COUNT + 1 ))
fi

if [ ${_COUNT} -ne 0 ];then
	alert "$PART installation has generated ${_COUNT} errors: check the logs."
	exit 1
else
	info "$PART installation was successful. You can go forward."
	sleep 5
fi
}
