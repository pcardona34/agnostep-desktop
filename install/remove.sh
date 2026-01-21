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
### Remove
### Allow to select and remove
### an installed app
################################

################################
### Include functions

. SCRIPTS/colors.sh

################################
### Temp file

FILETEMP=$(mktemp /tmp/agno-XXXXX)
trap "rm --force $FILETEMP" EXIT

################################

APP_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
if [ -z "$APP_DIR" ];then
	alert "The Local Applications Folder was not guessed!"
	exit 1
else
	info "The Local Applications Folder is: $APP_DIR"
fi

dialog --no-shadow --sleep 4 --infobox "
Use Arrows to move and Space bar to select an application.
" 8 50

# DirBox
dialog --no-shadow --backtitle "Agnostep Manager" --title "Application Selection" \
--ok-label "Remove" --dselect ${APP_DIR}/ 8 60 2> $FILETEMP

if [ $? -eq 0 ];then
	APP=$(cat $FILETEMP)
	grep -e ".app" $FILETEMP &>/dev/null
	if [ $? -eq 0 ];then
		case ${APP} in
		"${APP_DIR}/GWorkspace.app"|"${APP_DIR}/Recycler.app")
			alert "You CANNOT remove ${APP}: it is a master piece of the Workspace."
			exit 1;;
		*)
		dialog --no-shadow --backtitle "Agnostep Manager" --title "Removing Selected Application" \
		--yesno "
		Do you want to remove ${APP}?" 12 60
		if [ $? -eq 0 ];then
			sudo -E rm -fR ${APP} && make_services
			info "${APP} was removed."
		else
			info "You finally chose to keep the application ${APP}."
		fi;;
		esac
	else
		echo "Bad selection: not an app."
	fi
else
	echo "You did not select an Application: aborting."
fi

