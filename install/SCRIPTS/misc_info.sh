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
### Updating Info.plist
### To apply theme 
### after an app install
################################

function update_info_unit
{
LA=`pwd`
THEME=$(defaults read NSGlobalDomain GSTheme | awk '{print $3}')

if [ "$THEME" != "AGNOSTEP" ] || [ -z "$APPNAME" ];then
	printf "No Info updating.\n"
else
	DIR_INFO=../build/agnostep-theme/install/RESOURCES/INFOS
	if [ ! -d ${DIR_INFO} ];then
		warning "The INFOS folder was not found. Theme will not apply."
		sleep 2
	else
		APP_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
		cd $DIR_INFO
		if [ -f Info-gnustep.plist_${APPNAME} ];then
			sudo cp --remove-destination Info-gnustep.plist_${APPNAME} ${APP_DIR}/${APPNAME}.app/Resources/Info-gnustep.plist
			printf "Info was updated." 
		fi
	fi
fi
cd $LA
}
