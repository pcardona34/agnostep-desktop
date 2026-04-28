#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

#######################################
### Save minimalist desktop config...
### Using:
### cd to install dir
### bash ./SCRIPTS/save_min_config.sh
#######################################

MINSET=RESOURCES/MINSET
AUTOSTA="$MINSET/_autostart"
WMSTATE=$MINSET/WMState
WINATTR=$MINSET/WMWindowAttributes
CACHED=$MINSET/CachedPixmaps

org.gnustep.GWorkspace.template
_profile
_xinitrc






