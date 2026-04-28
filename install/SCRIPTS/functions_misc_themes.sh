#!/bin/bash

####################################################
### A G N o S t e p  -  Theme - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

################################
### Functions for Misc Themes
################################

function update_info()
{
. $_PWD/SCRIPTS/find_app.sh

cd $_PWD/RESOURCES/INFOS
for INFO in Info-gnustep.plist_*
do
	APPNAME="${INFO#Info-gnustep.plist_}"
	CHEMAPP="" && findapp ${APPNAME}
	if [ $? -eq 0 ] && [ -n "$CHEMAPP" ];then
		printf "Updating ${APPNAME} Info...\n"
		TARGET="${CHEMAPP}/Resources/Info-gnustep.plist"
		sudo cp --remove-destination ${INFO} ${TARGET} && ok "Done"
	fi
done
}

##########################################
### Customize Clip icon
##########################################
function customize_clip
{
CLIP_ICON=$_PWD/RESOURCES/ICONS/clip_c5c.tiff
DESTINATION_ICON=$HOME/GNUstep/Library/Icons
if [ ! -d $DESTINATION_ICON ];then
	mkdir -p $DESTINATION_ICON
fi
cp ${CLIP_ICON} ${DESTINATION_ICON}/clip.tiff
if [ -f $HOME/GNUstep/Defaults/WMWindowAttributes ];then
	cat $HOME/GNUstep/Defaults/WMWindowAttributes | sed s#/usr/share/WindowMaker#~/GNUstep/Library# > TEMP && mv TEMP $HOME/GNUstep/Defaults/WMWindowAttributes
fi
}
