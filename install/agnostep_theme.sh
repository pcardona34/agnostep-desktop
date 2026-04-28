#!/bin/bash

####################################################
### A G N o S t e p  Theme - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### Install the Theme AGNOSTEP
### And set the User settings: defaults, .xsession...
### accordingly.
####################################################

sudo -v
if [ $? -ne 0 ];then
	exit 1
fi

clear

_PWD=`pwd`
SPIN='\-/|'
STOP=0 # Set to 0 to avoid stops; to 1 to make stops for debugging purpose
SLEEP=2
#set -v
MSG_STOP="Stop: type <Enter> to continue."
GWDEF="org.gnustep.GWorkspace"
DEFDIR=RESOURCES/DEFAULTS
RPI=1 # By default, we assume the hw is not a RPI one. If not, it will be detected.
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT

####################################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/functions_misc_folders.sh
. SCRIPTS/functions_inst_themes.sh
. SCRIPTS/functions_misc_themes.sh
. ../Documentation/RELEASE_THEME.txt

####################################################
### Local functions

function stop
{
if [ $STOP -ne 0 ];then
	read -p "$MSG_STOP" R
fi
}

####################################################
### DO NOT RUN under an existent X session
####################################################

if [ -n "$DISPLAY" ];then
	alert "You should not install this theme within an XTERM!"
	info "Logout the Graphical session, open a tty console and try again."
	exit 1
fi

### PATH

which -s gnustep-config
if [ $? -ne 0 ];then
	alert "Your GNUstep System seems not correctly set. Aborting!"
	info "You should log out and back in to update your environment. When it will be done, try again the 'Settings' stage."
	MSG="Seconds before logout: "
	DELAY=8
	timer
	exec SCRIPTS/lo.sh
	exit 1
fi

export APP_DIR=`gnustep-config --variable=GNUSTEP_LOCAL_APPS`
export GNUSTEP_SYSTEM_TOOLS=`gnustep-config --variable=GNUSTEP_SYSTEM_TOOLS`
echo $PATH | grep -e "${GNUSTEP_SYSTEM_TOOLS}" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=${GNUSTEP_SYSTEM_TOOLS}:$PATH
fi

### End of functions
####################################################

STR="Installing AGNOSTEP theme"
titulo

###################################################
### GNUstep apps needed (1/2)
STR="Checking installed apps (1)";titulo

APPS="GWorkspace SimpleAgenda Terminal Ink GNUMail InnerSpace AClock TimeMon Meteo UpMem OpenDisk Pass ScreenLock"
for APP in ${APPS}
do
	echo -e "Looking for: ${APP_DIR}/${APP}.app"
	if [ -d ${APP_DIR}/${APP}.app ];then
		info "$APP has been found."
	else
		alert "$APP was not found. Install it before, please."
		exit 1
	fi
done
ok "Done"
sleep $SLEEP

####################################################
### FreeDesktop User filesystem

STR="Customizing the User Home folder contents"
subtitulo

LG=${LANG:0:2}
case "$LG" in
"fr")
	# Some folders are auto-translated by GNUstep, others none: we only care about the others;
	# The same is for the folder icon...
	FOLDERS="Livres Desktop Documents Downloads Favoris GNUstep Images Mailboxes Music Exemples SOURCES Videos";;
"en"|*)
	FOLDERS="Books Desktop Documents Downloads Favorites GNUstep Images Mailboxes Music Samples SOURCES Videos";;
esac

### Bookshelf on RPI's
RPI=1
is_hw_rpi
if [ $RPI -eq 0 ];then
	FOLDERS="$FOLDERS Bookshelf"
fi

### We manage the case of existing folders in English or in French
l18n_folder

stop

STR="Customizing the Icons of User Home folder contents"
subtitulo

for FOLD in ${FOLDERS}
do
	printf "Setting Icon for the Folder ${FOLD}\n"
	if [ -d $HOME/${FOLD} ];then
    	icon_folder $FOLD
	    ok "Done"
    fi
done
sleep $SLEEP
stop

cd $_PWD

###########################################
### Installing the main AGNOSTEP theme
STR="Main AGNOSTEP Theme"
titulo

#printf "GNUstep Theme..."
install_gs_theme

cd $_PWD
sleep $SLEEP

stop

### Clip
printf "Clip Icon...\n"
customize_clip
ok "Done";sleep $SLEEP 

cd $_PWD
stop

### Some Apps known to not comply with Theme: workaround
### We need to update Info-gnustep.plist for these apps
### Adding 'CFBundleIdentifier' property in the Dictionary
### Updating too Help path

update_info

cd $_PWD
sleep $SLEEP
stop

###

###########################################
### Setting the Defaults...
STR="GNUstep Defaults Setting"
subtitulo

################################
### Prep defaults...
################################

HOME_GNUSTEP_DEF=$HOME/GNUstep/Defaults
if [ ! -d ${HOME_GNUSTEP_DEF} ];then
	mkdir -p ${HOME_GNUSTEP_DEF}
fi

cd $DEFDIR || exit 1

GWD=${GWDEF}.TEMPLATE

cat ${GWD} | sed -e s/patrick/$USER/g | sed -e s#/Local/Applications#${APP_DIR}#g > ${GWDEF}.plist

cd $_PWD
if [ ! -f $HOME_GNUSTEP_DEF/WindowMaker ];then
	cd RESOURCES/DEFAULTS && cp WindowMaker $HOME_GNUSTEP_DEF/
	cd $_PWD
fi

cp --force $_PWD/RESOURCES/DEFAULTS/WMWindowAttributes $HOME/GNUstep/Defaults/

### Cached Pixmaps
if [ -d $HOME/GNUstep/Library/WindowMaker/CachedPixmaps ];then
		cd $HOME/GNUstep/Library/WindowMaker
		rm -fR CachedPixmaps
fi
### CachedPixmaps ###
cd $_PWD/RESOURCES/THEMES
cp -a CachedPixmaps_c5c $HOME/GNUstep/Library/WindowMaker/
mv $HOME/GNUstep/Library/WindowMaker/CachedPixmaps_c5c $HOME/GNUstep/Library/WindowMaker/CachedPixmaps
cd $_PWD

### Laptop? ###
laptop-detect
if [ $? -eq 0 ];then
    WMSTATE="WMState_laptop"
    cp $_PWD/RESOURCES/ICONS/batmon.GNUstep.xpm $HOME/GNUstep/Library/WindowMaker/CachedPixmaps/
else
	WMSTATE="WMState"
fi

cd RESOURCES/DEFAULTS
if [ ! -f $WMSTATE ];then
	alert "The file $WMSTATE was not found. This is a major issue."
	exit 1
else
	cp --force $WMSTATE $HOME_GNUSTEP_DEF/WMState
	### Setting to the user env
	cat $HOME_GNUSTEP_DEF/WMState | sed -e s#/System/Tools#${GNUSTEP_SYSTEM_TOOLS}#g > $TEMPFILE
	cat $TEMPFILE > $HOME_GNUSTEP_DEF/WMState
fi

cd $_PWD
ok "Done"
sleep $SLEEP
stop

################################
### Set the defaults
### for a AGNoStep Desktop
################################

############################################
### Applying a style for WMaker:
printf "Applying a Style to WMaker...\n"
#### Syntax: setstyle style.style

STYLE=RESOURCES/THEMES/wmaker.style
if [ ! -f $STYLE ];then
	alert "$STYLE was not found!\nThis is a major issue."
	exit 1
fi

setstyle --no-cursors --no-fonts $STYLE
ok "Done"
sleep $SLEEP
stop

############################################
#### Applying Defaults for GNUstep
############################################

DEST=$HOME/GNUstep/Defaults
if ! [ -d $DEST ];then
	alert "$DEST was not found!"
	exit 1
fi

stop

cd RESOURCES/DEFAULTS || exit 1

for PLIST in "Addresses" "NSGlobalDomain" "org.gap.InnerSpace" "org.gap.Terminal" "org.gnustep.GNUMail" "org.gnustep.GWorkspace" "org.poroussel.SimpleAgenda" "org.gap.AClock" "TimeMon"
do
	if [ -f ${PLIST}.plist ];then
		printf "Setting Defaults for ${PLIST}\n"
		if [ -f $DEST/${PLIST}.plist ] && [ "${PLIST}" == "org.gnustep.GNUMail" ];then
			info "We preserve GNUMail settings."
			continue;
		else
			cp --force ${PLIST}.plist $DEST/
			if [ "$PLIST" == "org.gnustep.GWorkspace" ];then
				rm -f ${PLIST}.plist
			fi
		fi
		ok "Done"
		stop
	else
		warning "The File ${PLIST}.plist was not found."
		stop
	fi
done

STR="GWorkspace: Dock position and visibility"
subtitulo

DOCKPOS=1
HIDE=1
printf "Hidden.\n"
#esac
defaults write org.gnustep.GWorkspace hidedock $HIDE
defaults write org.gnustep.GWorkspace dockposition $DOCKPOS

cd $_PWD
ok "Done"
sleep $SLEEP
stop

STR="Recycler: is Docked?"
subtitulo

ISDOCKED=1
printf "Recycler will be docked.\n"


defaults write org.gnustep.GWorkspace.Recycler docked $ISDOCKED

ok "Done"

#################################################
### Wallpaper
STR="Generic Wallpaper"
subtitulo

WP="fond_agnostep_waves.png"

### The following folder will be searched too by Lightdm
WP_FOLDER=/usr/local/share/wallpapers
if [ ! -d $WP_FOLDER ];then
	sudo mkdir -p $WP_FOLDER
fi

cd RESOURCES/WALLPAPERS || exit 1
sudo cp -f ${WP} ${WP_FOLDER}/fond_agnostep.png
cp ${WP_FOLDER}/fond_agnostep.png $HOME/GNUstep/Library/WindowMaker/Backgrounds/
### We cannot set this here out a display
#wmsetbg --smooth -u fond_agnostep.png # to be called elsewhere

### Obsolete: the Wallpaper is now handled by the window manager
#DEFGW=org.gnustep.GWorkspace.plist
#cd $HOME/GNUstep/Defaults || exit 1
#sed -i -r "s#.*wallpapers.*#<string>$WP_FOLDER/fond_agnostep.png</string>#" $DEFGW

stop

cd $_PWD
ok "Done"
sleep $SLEEP

#################################################
### User Wallpaper
STR="User Wallpaper Collection"
subtitulo

function is_wprotate
{
dialog --no-shadow --erase-on-exit --backtitle "Wallpaper" \
 --title "Rotation ask" \
 --yesno "
Do you want to rotate the wallpaper 
from a collection of pictures?" 12 60

if [ $? -eq 0 ];then
	cd THEMING/agnostep_wprotate || exit 1
	./install_wprotate.sh
else
	WPRCONF=$HOME/.config/agnostep/wprotate.conf
	if [ -f $WPRCONF ];then
		rm $WPRCONF
	fi
fi
}
is_wprotate
cd $_PWD
sleep $SLEEP
stop

###########################################
### Theme for FocusWriter
STR="Theme for FocusWriter"
subtitulo

cd THEMING/agnostep_fw || exit 1
. ./install_agnostep_fw.sh
cd $_PWD
ok "Done"
sleep $SLEEP
stop

###########################################

#set_menus
#sleep $SLEEP

##################################################
MESSAGE="A G N o S t e p  Theme  was set."

info "$MESSAGE" | tee -a $LOG
date >> $LOG
cd $_PWD
