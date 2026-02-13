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
### Install localized help bundles
####################################################

sudo -v

clear

####################################################
### ENV
_PWD=`pwd`
echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT
SLEEP=2
LG=${LANG:0:2}

case "$LG" in
"fr")
	HELP_FOLDER="Aide";;
"en"|*)
	HELP_FOLDER="Help";;
esac

####################################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_inst_tools.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/std_build.sh
. SCRIPTS/misc_info.sh
. SCRIPTS/patch_with_quilt.sh
. SCRIPTS/functions_remove_app.sh
. SCRIPTS/functions_inst_tools.sh

### End of Include functions
#################################################



### End of functions
####################################################

####################################################
### Help
### As the way the help is provided
### within GNUstep is not yet clearly defined
### we provide .help in a in purpose folder
### $HELP_FOLDER

function set_help_folders
{
STR="Help Files"
HUB=https://github.com/pcardona34/agnostep-help
titulo


if [ ! -d $HOME/$HELP_FOLDER ];then
	mkdir -p $HOME/$HELP_FOLDER
fi

cd ../build || exit 1
if [ ! -d agnostep-help ];then
	printf "Fetching...\n"
	git clone $HUB
	cd agnostep-help || exit 1
else
	cd agnostep-help
	git pull
fi
sleep 2
clear
titulo
ok "Help Bundles Fetched"

for HLP in ${LG}/*.help
do
	cp -ruf ${HLP} $HOME/$HELP_FOLDER/
done

### miscellaneous
### Help of GWorkspace
#for LOCAL in English French
#do
#	if [ ! -d /Local/Applications/GWorkspace.app/Resources/${LOCAL}.lproj/Help ];then
#		sudo mkdir -p /Local/Applications/GWorkspace.app/Resources/${LOCAL}.lproj/Help
#		sudo cp -ruf ${LOCAL}/GWorkspace_${LOCAL}.help /Local/Applications/GWorkspace.app/Resources/${LOCAL}.lproj/Help/GWorkspace.help
#	fi
#done

cd $_PWD
ok "Done"
sleep 2
}

###############################################

set_help_folders

remove_ifx_app "HelpViewer"
install_helpviewer
update_info_plist "HelpViewer"


################################################

printf "Linking: wait please...\n"
sudo ldconfig &>/dev/null &
PID=$!
spinner
ok "\rDone"

printf "\nUpdating Services: wait please...\n"
make_services &>/dev/null &
PID=$!
spinner
ok "\rDone"

print_size

sleep 2
