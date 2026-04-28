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
### Install wmrotate
### Rotate the wallpaper
### at each X login
################################

################################
### VARS
HERE=`pwd`
FICHTEMP=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $FICHTEMP" EXIT
WPCONFDIR=$HOME/.config/agnostep
if [ ! -d $WPCONFDIR ];then
	mkdir -p $WPCONFDIR
fi
WPCONF=${WPCONFDIR}/wprotate.conf

################################
### Functions

if [ -z "$COLORS" ];then
	. ../../SCRIPTS/colors.sh
fi
. ../../SCRIPTS/log.sh

################################
STR="Wallpaper Rotate Utility"
subtitulo

WPDIR=$HOME/.local/share/wallpapers
if [ ! -d $WPDIR ];then
	mkdir -p $WPDIR
fi

cd ../../RESOURCES/WALLPAPERS || exit 1
for SERIE in WINTER WORLD MAJORQUE
do
if [ ! -d $WPDIR/${SERIE} ];then
	cp -r ${SERIE} $WPDIR/
fi
done

for AGNO in *.png
do
cp -f $AGNO $WPDIR/
done

info "The collection of the Wallpapers has been installed."

##################################################
function menu
{
BT="Wallpapers"
TIT="Collection Setting"

dialog --no-shadow --erase-on-exit --backtitle "$BT" --title "${TIT}" \
 --radiolist "

Select the collection: " 12 60 2 \
"Mallorca" "Pictures of a trip to Mallorca" on \
"Winter" "Winter Pictures of French Margeride mountains" off \
"World" "Pictures from Wikimedia" off 2> $FICHTEMP

if [ $? -eq 0 ];then
	for i in `cat $FICHTEMP`
	do
	case "$i" in
    "Mallorca")
        echo "You chose Mallorca."
        echo "COLLECTION=MAJORQUE" > $WPCONF;;
	"Winter")
		echo "You chose Winter."
		echo "COLLECTION=WINTER" > $WPCONF;;
	"World")
		echo "You chose World."
		echo "COLLECTION=WORLD" > $WPCONF;;
	esac
	done
fi
}

###########################################
menu

cd $HERE

TARGET=/usr/local/bin
if [ ! -d $TARGET ];then
	sudo mkdir -p $TARGET
fi

if [ -f wprotate.sh ];then
	sudo cp -f wprotate.sh $TARGET/
fi

cd $HERE

info "The script wprotate.sh has been installed."
