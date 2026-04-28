#!/bin/bash

####################################################
### A G N o S t e p  -  Theme - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

if [ -z "$COLORS" ];then
	. ../../SCRIPTS/colors.sh
fi

################################
### Check Dockapps
################################

DAPPS="wmnd wmudmount"

for DA in ${DAPPS}
do
which -s $DA
if [ $? -eq 0 ];then
	info "Dockapp $DA was found."
else
	alert "Dockapp $DA was not found. This a major issue."
	exit 1
fi
done
