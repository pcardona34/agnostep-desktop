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
### Logs viewer
################################

. SCRIPTS/colors.sh

FICHTEMP=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $FICHTEMP" EXIT

function view_desktop_log
{
. SCRIPTS/log.sh
if [ -f $LOG ];then
	clear
	less $LOG
else
	clear;warning "No log available."
fi
}

function view_theme_log
{
. ../build/agnostep-theme/install/SCRIPTS/log.sh
if [ -f $LOG ];then
	clear
	less $LOG
else
	clear;warning "No log available."
fi
}

function clear_logs
{
for LOG in /var/log/agno*.log
do
	echo $LOG;truncate $LOG --size 0
done
printf "All the logs were truncated.\n"
ok "Done"
}

dialog --no-shadow --backtitle "Agnostep Desktop and Theme Logs" \
 --title "Actions on Logs" \
 --menu "
 " 12 66 2 \
"Desktop" "Read Log of the Desktop Installation" \
"Theme" "Read Log of the Theme Installation" \
"Clear" "Clear all the logs" 2>> $FICHTEMP

# Answer?
if [ $? -eq 0 ];then
	for i in `cat $FICHTEMP`
	do
		case $i in
			"Desktop") view_desktop_log;;
			"Theme") view_theme_log;;
			"Clear") clear_logs;;
		esac
	done
fi
