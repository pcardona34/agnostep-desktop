#!/bin/bash

####################################################
### A G N o S t e p  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### Setting the Core AGNOSTEP Desktop
### defaults, .xsession...
####################################################

####################################################
### You must be superuser to install
sudo -v
if [ $? -ne 0 ];then
	exit 1
fi

clear

SPIN='\-/|'
STOP=0 # Set to 0 to avoid stops; to 1 to make stops for debugging purpose
export SLEEP=2
#set -v # uncomment only to debug the main script
GWDEF="org.gnustep.GWorkspace"
DEFDIR=RESOURCES/DEFAULTS
RPI=1 # By default, we assume the hw is not a RPI one. If not, it will be detected.
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT
LG=${LANG:0:2}

### Non standard folders localization
case "$LG" in
"fr")
	SAMPLE_FOLDER="Exemples"
	FAVORITE_FOLDER="Favoris";;
"en"|*)
	SAMPLE_FOLDER="Samples"
	FAVORITE_FOLDER="Favorites";;
esac

####################################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh
. SCRIPTS/stop.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/functions_misc_folders.sh
. SCRIPTS/setup_misc_tools.sh

### End of functions
####################################################

####################################################
### DO NOT RUN under an existent X session
####################################################

if [ -n "$DISPLAY" ];then
	alert "You should not install within an XTERM!"
    info "Logout the Graphical session, open a tty console and try again."
    sleep 10
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
###################################################
### Here it begins...

STR="Installing AGNOSTEP Desktop Common Tools"
titulo

####################################################
### Dependencies
pushd .
LIST="settings" && install_deps
sleep 2;clear
popd

####################################################
### Subfolders of the User Home Directory
### Folders names and l18n
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
is_hw_rpi
if [ $RPI -eq 0 ];then
	FOLDERS="$FOLDERS Bookshelf"
fi

for FOLD in ${FOLDERS}
do
if [ ! -d $HOME/$FOLD ];then
    mkdir -p $HOME/$FOLD
fi
done

### We manage the case of existing folders in English or in French
l18n_folder

####################################################
### Samples
STR="Sample Files"
subtitulo

if [ ! -d $HOME/$SAMPLE_FOLDER ];then
	mkdir -p $HOME/$SAMPLE_FOLDER
fi

pushd .
cd RESOURCES || exit 1
cp -u Samples.tar.gz $HOME/$SAMPLE_FOLDER/
cd $HOME/$SAMPLE_FOLDER
gunzip --force Samples.tar.gz
tar -xf Samples.tar && rm Samples.tar
popd

ok "Done"

stop

####################################################
### Favorites
STR="Favorites"
subtitulo

if [ ! -d $HOME/$FAVORITE_FOLDER ];then
	mkdir -p $HOME/$FAVORITE_FOLDER
fi

pushd .
cd RESOURCES/FAVORITES || exit 1
for FAV in *.url
do
cp --verbose $FAV $HOME/$FAVORITE_FOLDER/
done
popd

ok "Done"

stop

###################################################
### Screenshots folder
### Only for wmaker
###################################################
USER_APPS=$(gnustep-config --variable=GNUSTEP_USER_APPS)
if [ -d ${USER_APPS}/WindowManager.app ];then
    echo "Window Manager is not Window Maker."
else
    STR="Screenshots subdirectory link for wmaker built-in"
    subtitulo

    pushd .
    cd $HOME/Images || exit 1
    SHOTS=$HOME/GNUstep/Library/WindowMaker/Screenshots
    if [ ! -d $SHOTS ];then
	    mkdir -p $SHOTS
    fi
    if [ ! -h Screenshots ];then
	    ln -s $SHOTS
    fi
    popd
fi

ok "Done"
sleep ${SLEEP:-2}

###############################################
### Keyboard
STR="Keyboard..."
titulo

### French User Keyb Layout?
pushd .
. SCRIPTS/setting_kb.sh || exit 1
set_french_layout
popd

##############################################
### X session
clear
STR="Xinitrc and Xsession"
subtitulo

if [ -f RESOURCES/COMMONSET/_xinitrc ];then
    cp --verbose RESOURCES/COMMONSET/_xinitrc $HOME/.xinitrc
    cp --verbose $HOME/.xinitrc $HOME/.xsession
else
    alert "The X session template was not found."
    exit 1
fi
if [ -f RESOURCES/SCRIPTS/xprofile ];then
    cp --verbose RESOURCES/SCRIPTS/xprofile $HOME/.xprofile
fi

ok "Done"
sleep ${SLEEP:-2}

### This is obsolete and will be removed
#if [ ! -f SCRIPTS/env_modern.sh ];then
#    STR="Autostart"
#    subtitulo
#
#    cp --verbose RESOURCES/MINSET/_autostart $HOME/GNUstep/Library/WindowMaker/autostart && ok "Done"
#    sleep ${SLEEP:-2}
#fi

stop

###########################################
### Default Desktop state
STR="Default Desktop State"
subtitulo

if [ ! -f SCRIPTS/env_modern.sh ];then
    if [ ! -d $HOME/GNUstep/Library/WindowMaker/CachedPixmaps ];then
        mkdir -p $HOME/GNUstep/Library/WindowMaker/CachedPixmaps
    fi
fi

if [ ! -d $HOME/GNUstep/Defaults ];then
    mkdir -p $HOME/GNUstep/Defaults
fi

if [ -f SCRIPTS/env_modern.sh ];then
    pushd .
    cd RESOURCES/MODERNSET || exit 1
    cat org.gnustep.GWorkspace.TEMPLATE | sed s/patrick/${USER}/g > org.gnustep.GWorkspace.plist
    echo "GWorkspace Template was updated."
    cp --verbose --force DockWM.plist NSGlobalDomain.plist org.gnustep.GWorkspace.plist $HOME/GNUstep/Defaults/
    rm org.gnustep.GWorkspace.plist
    popd
else
    pushd .
    cd RESOURCES/MINSET || exit 1
    for STATE in WMState WMWindowAttributes
    do
        if [ -f $STATE ];then
            cp --verbose --update $STATE $HOME/GNUstep/Defaults/
        fi
    done
    popd
fi

if [ ! -f SCRIPTS/env_modern.sh ];then
    STR="Cached Pixmaps"
    subtitulo
    pushd .
    cd RESOURCES/MINSET/CachedPixmaps || exit 1
    cp --verbose *.xpm $HOME/GNUstep/Library/WindowMaker/CachedPixmaps/
    ok "Done"
    popd
fi

sleep ${SLEEP:-2}

stop

###########################################
### ... agnostep_cli

if [ ! -d /usr/local/bin ];then
	sudo mkdir -p /usr/local/bin
fi

pushd .
install_agnostep_cli
popd
sleep ${SLEEP:-2}

stop

##########################################
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
sleep ${SLEEP:-2}
stop

######################################################
### Set default profile sourcing GNUstep.sh
STR="Home Bash profile"
subtitulo

if [ -f $HOME/.bash_profile ];then
    rm $HOME/.bash_profile
fi

if [ -f SCRIPTS/env_modern.sh ];then
    if [ -f RESOURCES/MODERNSET/_bash_profile ];then
        cp --verbose RESOURCES/MODERNSET/_bash_profile $HOME/.bash_profile
    else
        alert "MODERNSET Bash profile template was not found."
        exit 1
    fi
else
    if [ -f RESOURCES/MINSET/_profile ];then
	    cp --verbose RESOURCES/MINSET/_profile $HOME/.bash_profile
    else
        alert "MINSET Bash profile template was not found."
        exit 1
    fi
fi

ok "Done"
sleep ${SLEEP:-2}

stop

###########################################
STR="Loading notification script"
subtitulo

## Dunst settings
if [ ! -d $HOME/.config ];then
    mkdir -p $HOME/.config
fi
cp --verbose RESOURCES/CONF/dunstrc $HOME/.config/dunstrc

### We do not install anymore loading.sh: see new .xinitrc/.xsession
#sudo cp --verbose RESOURCES/SCRIPTS/loading.sh /usr/local/bin/

ok "Done"
sleep ${SLEEP:-2}

stop

####################################################
MESSAGE="AGNoStep common Desktop was set.\nDefault theme is GNUstep."

info "$MESSAGE" | tee -a $LOG
date >> $LOG
cd $_PWD

MESSAGE="AGNoStep Desktop is ready to use now."

info "$MESSAGE"

info "To install the Graphic Login/Display Manager: after testing the Desktop, log out, back in, execute Agnostep Wizard and select DM item:"
cli "./agnowiz.sh"

sleep 6
stop

##################################################################
### RPI 500 Hack
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
		if [ -f $DESTX/99-vc4.conf ];then
			info "Xorg Hack already applied."
		else
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
else

    warning "You need to logout and login again to apply the changes.\nThen, after the new login, execute:"
    cli "startx"
    sleep 3
    MSG="Seconds before logout: "
    DELAY=9
    timer
    exec SCRIPTS/lo.sh
fi

