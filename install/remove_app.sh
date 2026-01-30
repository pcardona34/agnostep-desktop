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
### VARS
SPIN='/-\|'

################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/log.sh
. SCRIPTS/functions_remove_app.sh

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

dialog --clear --no-shadow --sleep 6 --infobox "
Use Arrows to move and Space bar to select an application. Slash to list the selected folder.
" 8 50

# DirBox
dialog --no-shadow --backtitle "Agnostep Manager" --title "Application Selection" \
--ok-label "Remove" --dselect ${APP_DIR}/ 8 60 2> $FILETEMP

clear

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

		clear

		if [ $? -eq 0 ];then
			BASEN=$(basename $APP)
			APPNAME=${BASEN%.app}
			clear
			STR="Removing an Application: $APPNAME"
			titulo
			remove_ifx_app $APPNAME
			printf "Updating Services... Wait, please.\n"
			make_services &>/dev/null &
			PID=$!
			spinner
			ok "\rDone"
			info "${APP} was removed."
		else
			info "You finally chose to keep the application ${APP}."
		fi;;
		esac
	else
		alert "Bad selection: not an app."
	fi
else
	printf "You did not select an Application: aborting.\n"
fi

