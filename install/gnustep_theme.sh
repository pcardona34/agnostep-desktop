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
### Uninstall AGNOSTEP Theme if present
### This set GNUstep Default Theme...
####################################################

sudo -v
if [ $? -ne 0 ];then
	exit 1
fi

clear

function stop
{
if [ $STOP -ne 0 ];then
	read -p "$MSG_STOP" R
fi
}

_PWD=`pwd`
SPIN='\-/|'
STOP=0 # Set to 0 to avoid stops; to 1 to make stops
SLEEP=2
#set -v
MSG_STOP="Stop: type <Enter> to continue."
LG=${LANG:0:2}

case "$LG" in
"fr")
	SAMPLE_FOLDER="Exemples"
	FAVORITE_FOLDER="Favoris"
	BOOKS_FOLDER="Livres";;
"en"|*)
	SAMPLE_FOLDER="Samples"
	FAVORITE_FOLDER="Favorites"
	BOOKS_FOLDER="Books";;
esac

####################################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/spinner.sh

### End of functions
####################################################

####################################################
### DO NOT RUN under an existent X session
####################################################

if [ -n "$DISPLAY" ];then
        alert "You should not uninstall this theme within an XTERM!"
        info "Logout the Graphical session, open a tty console and try again."
        exit 1
fi

function minimal_setting
{
STR="Session minimal settings"
subtitulo

cd $_PWD

### Setup GWorkspace...
cat RESOURCES/MINSET/org.gnustep.GWorkspace.template | sed s/patrick/${USER}/g >> RESOURCES/MINSET/org.gnustep.GWorkspace.plist
mv RESOURCES/MINSET/org.gnustep.GWorkspace.plist $HOME/GNUstep/Defaults/

### Removing themed plist of TimeMon and AClock
for PLIST in org.gap.AClock TimeMon
do
	rm --force $HOME/GNUstep/Defaults/${PLIST}.plist
done

### Defaults
for DEF in RESOURCES/MINSET/*.plist
do
    cp $DEF $HOME/GNUstep/Defaults/
done

defaults write NSGlobalDomain GSTheme GNUstep
if [ ! -f $HOME/GNUstep/Defaults/WindowMaker ];then
    cp RESOURCES/MINSET/WindowMaker $HOME/GNUstep/Defaults/WindowMaker
fi
setstyle RESOURCES/STYLES/Tradition.style

### Retrieving default Clip icon and WMWindowAttributes
if [ -f $HOME/GNUstep/Library/Icons/clip.tiff ];then
	rm $HOME/GNUstep/Library/Icons/clip.tiff
	cat $HOME/GNUstep/Defaults/WMWindowAttributes | sed s#~/GNUstep/Library#/usr/share/WindowMaker# > TEMP && mv TEMP $HOME/GNUstep/Defaults/WMWindowAttributes
fi

### Cached Pixmaps
if [ -d $HOME/GNUstep/Library/WindowMaker/CachedPixmaps ];then
	cd $HOME/GNUstep/Library/WindowMaker
	rm -r CachedPixmaps
fi

if [ ! -d $HOME/GNUstep/Library/WindowMaker ];then
    mkdir -p $HOME/GNUstep/Library/WindowMaker
fi

cd $_PWD/RESOURCES/MINSET
cp -r CachedPixmaps $HOME/GNUstep/Library/WindowMaker/
cd $_PWD

### Reinitialising themed folders
LG=${LANG:0:2}
case "$LG" in
fr)
    FOLDERS="Bookshelf Exemples Favoris GNUstep Livres SOURCES Mailboxes";;
en)
	FOLDERS="Bookshelf Samples Favorites GNUstep Books SOURCES Mailboxes";;
esac
for FOLD in ${FOLDERS}
do
	if [ -d $HOME/$FOLD ];then
		rm -f $HOME/$FOLD/.dir.tiff
	fi
done
}

cd $_PWD

clear
info "The default GNUstep theme will apply.\n"
sleep $SLEEP
minimal_setting

#######################################

if [ -z "$SINGLE_THEME" ];then

    MESSAGE="GNUstep Default Theme has been set."

    info "$MESSAGE"

    warning "If you are not using a Display Manager, You need to logout and login again to apply the changes..."
    MSG="Seconds before logout: "
    DELAY=6
    timer
    exec SCRIPTS/lo.sh
fi
