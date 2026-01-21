#!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Install the Password Manager
### Until now, only the CLI
################################

################################
### VARS

. ../../SCRIPTS/colors.sh 

DEPS="pass"

sudo apt -y install ${DEPS}

ok "Done"
sleep 2
clear
