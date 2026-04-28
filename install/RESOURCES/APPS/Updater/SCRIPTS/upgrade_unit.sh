#!/bin/bash

#################################################
### Updater
# (c) 2026 Agnostep Desktop Project
# Author: Patrick Cardona
##################################################

### IMPORTANT ###
# This script must run with setuid sticky bit.
# If not, it will fail.

if [ -n "$1" ];then
    PNAME="$1"
else
    exit 1
fi

echo $PNAME

### We do not use --upgrade-only option to allow new packages too
sudo apt-get --yes install ${PNAME}

# Uncomment below for test purpose only
#sleep 10
