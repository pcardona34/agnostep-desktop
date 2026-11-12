#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop
### (c) 2025-2026 Patrick Cardona
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Stop to debug the script...
################################

MSG_STOP="Stop: type <Enter> to continue."

function stop
{
if [ $STOP -ne 0 ];then
	read -p "$MSG_STOP" R
fi
}
