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
### Functions for Misc Folders
################################

###############################################
function icon_folder
{
FOLDER="$1"
cd $_PWD/RESOURCES/ICONS
if [ -f dir_${FOLDER}.tiff ];then
	### We only set an icon for non standard folders
	cp --verbose -u dir_${FOLDER}.tiff $HOME/${FOLDER}/.dir.tiff
fi
cd $_PWD
}

function l18n_folder
{
### manage the case when folders with English names has been already created.
LG=${LANG:0:2}
case $LG in
	"fr")
	if [ -d $HOME/Books ];then
		if [ -d $HOME/Livres ];then
			alert "Vous avez déjà deux dossiers pour gérer les livres: Books et Livres. Vous devez les fusionner manuellement ou supprimer celui qui est vide."
			exit 1
		fi
		mv $HOME/Books $HOME/Livres
	fi
	if [ -d $HOME/Favorites ];then
		if [ -d $HOME/Favoris ];then
			alert "Vous avez déjà deux dossiers pour gérer les signets: Favoris et Favorites. Vous devez en supprimer un."
			exit 1
		fi
		mv $HOME/Favorites $HOME/Favoris
	fi
	if [ -d $HOME/Samples ];then
		if [ -d $HOME/Exemples ];then
			alert "Vous avez déjà deux dossiers pour gérer les exemples: Samples et Exemples. Vous devez en supprimer un."
			exit 1
		fi
		mv $HOME/Samples $HOME/Exemples
	fi

	printf "\nLes dossiers ont été francisés autant que faire se peut.\n\n";;
	"en"|*)
	printf "\nThe Folders names were not changed: default is English.\n\n";;
esac
}
