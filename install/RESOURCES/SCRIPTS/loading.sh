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
### Loading...
################################

PREFIX=`echo ${LANG%.UTF-8} | awk -F_ '{print $1}'`
TITLE="A G N o S t e p"

case "$PREFIX" in
	"fr")
	MSG="Démarrage du bureau...";;
	"en")
	MSG="Desktop is loading...";;
esac

dunstify "$TITLE" "$MSG" -u normal
