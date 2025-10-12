#!/bin/bash

DEST_ICON=/usr/local/share/icons
if [ ! -d $DEST_ICON ];then
	sudo mkdir -p $DEST_ICON
fi
sudo cp birthday.tif $DEST_ICON/
sudo cp bell.tif $DEST_ICON/

DEST_BIN=/usr/local/bin
if [ ! -d $DEST_BIN ];then
	sudo mkdir -p $DEST_BIN
fi
for BIN in BirthNotify birth2vcf feast2ics
do
	sudo cp -u $BIN $DEST_BIN/
done

DEST_SAMP=$HOME/Documents/Private
if [ ! -d $DEST_SAMP ];then
        mkdir -p $DEST_SAMP
fi
if [ ! -f $DEST_SAMP/Birthdays ];then
	cp Birthdays.sample $DEST_SAMP/Birthdays
else
	printf "We preserve already exiting Birthdays file.\n"
fi

DEST_CONF=$HOME/.config/agnostep
if [ ! -d $DEST_CONF ];then
	mkdir -p $DEST_CONF
fi
cp birthday.conf $DEST_CONF

### Call from autostart
AUTO=$HOME/GNUstep/Library/WindowMaker/autostart
if [ ! -f $AUTO ];then
	printf "The file $AUTO was not found\n"
	exit 1
fi
grep -e "BirthNotify" $AUTO &>/dev/null
if [ $? -ne 0 ];then
	cat $AUTO autostart.txt > TMP && mv --force TMP $AUTO
	chmod +x $AUTO
fi
