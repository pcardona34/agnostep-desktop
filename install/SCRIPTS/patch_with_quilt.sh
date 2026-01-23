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
### Quilt patch utility setting
###
### Quilt is namely used by the Debian Salsa
### GNUstep Team
####################################################

############################################################
### Quilt deps
function is_quilt
{
which -s quilt
if [ $? -eq 0 ];then
	printf "Quilt is already installed.\n"
else
	DEP="quilt"
	STR="Dependencies: ${DEP}";subtitulo
	sudo apt -y install ${DEP}
	ok "Done";sleep 2;clear
fi
}

############################################################
### Setting quilt patching tool
function set_quilt
{
if [ -f $HOME/.quilt ] && grep -e "debian/patches" $HOME/.quilt &>/dev/null;then
	printf "Quilt is already set.\n"
else

cat << ENDOFQUILT > $HOME/.quiltrc
QUILT_DIFF_ARGS="--no-timestamps --no-index"
QUILT_REFRESH_ARGS="--no-timestamps --no-index"
QUILT_PATCHES="debian/patches"
ENDOFQUILT

fi
}
