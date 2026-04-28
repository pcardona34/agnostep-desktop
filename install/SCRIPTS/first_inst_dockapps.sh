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
### Dockapps:First install
####################################################

################################
### ENV

_PWD=`pwd`

### End of VARS
################################

################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh

### End of Include functions
################################

clear
STR="A G N o S t e p  -  Dockapps"
titulo

################################
### Is there a Dockapps Folder?

DOCKAPPS=RESOURCES/APPS/dockapps
cd ${DOCKAPPS} || exit 1
. ./install_dockapps.sh

cd ${_PWD}

printf "\nLinking... please wait...\n"
sudo ldconfig
ok "\rDone"
