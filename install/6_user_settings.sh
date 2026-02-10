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
### User home settings
### This set GNUstep Library, defaults, .xinitrc...
####################################################

clear

function stop
{
if [ $STOP -ne 0 ];then
	read -p "$MSG_STOP" R
fi
}

RPI=1 # We assume not a rpi by default
_HERE=`pwd`
SPIN='\-/|'
STOP=0 # Set to 0 to avoid stops; to 1 to make stops and debug
#set -v
MSG_STOP="Stop: type <Enter> to continue."
LG=${LANG:0:2}

case "$LG" in
"fr")
	SAMPLE_FOLDER="Exemples"
	HELP_FOLDER="Aide";;
"en"|*)
	SAMPLE_FOLDER="Samples"
	HELP_FOLDER="Help";;
esac

####################################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/setup_misc_tools.sh

### End of functions
####################################################

####################################################
### Samples
STR="Sample Files"
subtitulo

if [ ! -d $HOME/$SAMPLE_FOLDER ];then
	mkdir -p $HOME/$SAMPLE_FOLDER
fi

cd RESOURCES || exit 1
cp -u Samples.tar.gz $HOME/$SAMPLE_FOLDER/
cd $HOME/$SAMPLE_FOLDER
gunzip --force Samples.tar.gz
tar -xf Samples.tar && rm Samples.tar

cd $_HERE
ok "Done"

stop

###########################################
### Help
### As the way the help is provided
### within GNUstep is not yet clearly defined
### we provide .help in a in purpose folder
### $HELP_FOLDER
STR="Help Files"
subtitulo

if [ ! -d $HOME/$HELP_FOLDER ];then
	mkdir -p $HOME/$HELP_FOLDER
fi

cd RESOURCES/HELP
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

cd $_HERE
ok "Done"

stop

###########################################
### Miscellaneous Tools
STR="Miscellaneous Tools"
titulo

###########################################
### Installing Tools and confs...

install_agnostep_cli
sleep 2
check_tools
cd $_HERE

stop

#######################################################
### Info release
STR="Info release"
subtitulo

RELEASE=$(grep -e "Release:" ../Documentation/RELEASE.md | awk '{print $3}')
STATUS=$(grep -e "Status" ../Documentation/RELEASE.md | awk '{print $3}')

if [ ! -d $HOME/.local/etc ];then
	mkdir -p $HOME/.local/etc
fi
cat > $HOME/.local/etc/release.info << ENDOF
DESKTOP=AGNoStep
REL=$RELEASE
STATUS=$STATUS
ENDOF

ok "Done"
stop

######################################################
### Set default profile sourcing GNUstep.sh
STR="Home Bash profile"
subtitulo

cat $HOME/.bash_profile | grep -e "GNUstep.sh" &>/dev/null
if [ $? -ne 0 ];then
	cat RESOURCES/MINSET/_profile >> $HOME/.bash_profile
fi
ok "Done"
stop

####################################################
### Install the theme
####################################################

clear

function fetch_agnostep-theme
{
printf "Fetching the theme installer...\n"
if [ ! -d ../build ];then
	mkdir -p ../build
fi
cd ../build || exit 1
if [ -d agnostep-theme ];then
	rm -fR agnostep-theme
fi

git clone https://github.com/pcardona34/agnostep-theme
cd agnostep-theme
}

function install_agnostep-theme
{
cd install
./install_theme.sh
}

function gnustep-theme
{
cd install
./uninstall_theme.sh
}

########################################
function yesno_AGNOSTEP_theme
{
fetch_agnostep-theme

dialog --backtitle "AGNoStep Setup" --title "Theme Choice" \
--yesno "
The recommended theme for AGNoStep Desktop
 is AGNOSTEP-theme.

Do you want to install the recommended theme?" 12 60

if [ $? = 0 ];then
	install_agnostep-theme
else
	info "The default GNUstep theme will apply.\n"
	gnustep-theme
fi
}

#######################################

STR="Setting a theme..."
titulo

yesno_AGNOSTEP_theme

cd "$PWD"

stop

###########################################

cd $_HERE
clear

MESSAGE="A G N o S t e p Desktop is ready to use now."

info "$MESSAGE"

info "To install the Graphic Login/Display Manager: after testing the Desktop, log out, back in, execute AgnostepManager and select DM item:"
cli "./agnostep.sh"

sleep 6

### If a pi 500: we must reboot the first time to apply Xorg Hack.

is_hw_rpi
if [ $RPI -eq 0 ];then
	NUMBER=`echo $MODEL | awk '{print $3}'`
	if [ "$NUMBER" == "500" ] || [ "${NUMBER:0:1}" == "5" ];then
		clear
		STR="Xorg Hacking on pi500"
		subtitulo
		info "Xorg Hacking is necessary for this model on RPI OS Lite...\n";sleep 2
		DESTX=/etc/X11/Xorg.conf.d
		if [ ! -d $DESTX ];then
			sudo mkdir -p $DESTX
		fi
		sudo cp --verbose --force RESOURCES/CONF/99-vc4.conf ${DESTX}/
		sleep 2
		DEP="gldriver-test"
		sudo apt -y install ${DEP}
		ok "Done"
		warning "The pi 500 will reboot to apply the Xorg hack... Back in, to test the Desktop,  execute:"
		cli "startx"
		MSG="Seconds before reboot: "
		DELAY=9
		timer
		sudo reboot;exit
	fi
fi

warning "You need to logout and login again to apply the changes.\nThen, after the new login, execute:"
cli "startx"
sleep 3
MSG="Seconds before logout: "
DELAY=9
timer
exec SCRIPTS/lo.sh
