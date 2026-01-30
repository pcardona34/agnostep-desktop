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
### App finder
################################

################################
### VARS
### CHEMAPP must  be set in the top parent script
### like: export CHEMAPP="" && findapp MyApp

function findapp
{
### VAR: APP is the exact APP_NAME without .app ext.
APP="$1"
if [ -n "$APP" ];then
	REP=$(openapp --find ${APP} | grep -e "Using")
	if [ $? -eq 0 ];then
		CHEM=$(echo ${REP} | awk '{print $3}')
		CHEMAPP=${CHEM%/${APP}}
	else
		CHEMAPP=""
	fi
else
	CHEMAPP=""
fi
}

### Testing
#CHEMAPP="" && findapp GMines
#if [ $? -eq 0 ] && [ -n "$CHEMAPP" ];then
#	echo $CHEMAPP
	# We can do somethig inside the App Bundle
#	ls $CHEMAPP
#fi
