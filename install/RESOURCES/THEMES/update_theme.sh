#!/bin/bash

THEME=AGNOSTEP
_PWD=`pwd`

if [ -f BACKUP_THEME.tar ];then
	rm BACKUP_THEME.tar
fi
if [ -d ${THEME}.theme ];then
	tar -cvf BACKUP_THEME.tar ${THEME}.theme
	rm -r ${THEME}.theme
fi

cd $HOME/GNUstep/Library/Themes || exit 1

if [ -d ${THEME}.theme ];then
	cp -a ${THEME}.theme $_PWD/
fi

cd $_PWD
printf "Theme AGNOSTEP was updated and a backup created.\n"
ls -l

