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
### Install Extra Apps...
################################

####################################################
### ENV
_PWD=`pwd`
echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
LOG="$HOME/AGNOSTEP_BUILD_EXTRA.log"
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT

#INSTALL_ARGS="GNUSTEP_INSTALLATION_DOMAIN=LOCAL"
#################################################

################################################
### Include functions

. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/std_build.sh
. SCRIPTS/misc_info.sh
. SCRIPTS/patch_with_quilt.sh
. SCRIPTS/functions_inst_extra.sh

### End of Include functions
#################################################

clear
STR="A G N o S t e p  -  Extra applications"

#################################################
### Is there a Build Folder?

if ! [ -d ../build ];then
	mkdir ../build
fi

#################################################
### Is there a USER APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!" && exit 1
fi

#################################################
function remove_if_present
{
APP="$1"
if [ -d $INSTALL_DIR/${APP}.app ];then
	sudo rm -fR $INSTALL_DIR/${APP}.app
fi
printf "The previous installation of ${APP} has been removed.\n"
}

####################################################
function extra_apps_menu
{
dialog --no-shadow --backtitle "${STR:0:15}" --title "${STR:20:37}" \
--ok-label "OK"  \
--checklist "
The list below contains the extra apps.

Check (space bar) the Applications you want to (re)install." 20 70 13 \
"Affiche" "Sticky Notes" off \
"Calculator" "Calculator from GNUstep Examples" off \
"Cenon" "Vetorial Drawing" off \
"Cynthiune" "Romantic Music Player" off \
"Dictionary" "Dict client" off \
"FlexiSheet" "Quantrix like Spreadsheet" off \
"FontManager" "Font Previewer and Installer" off \
"FTP" "FTP Client" off \
"Graphos" "Vector Drawing" off \
"Grr" "Günters Reliable RSS Reader" off \
"GSPdf" "PDF Reader" off \
"HelpViewer" "Help Viewer" off \
"Ink" "An alternative to TextEdit from GNUstep Examples" off \
"Installer" "Applications installer not yet finished" off \
"LaternaMagica" "Image Collection Viewer" off \
"Librarian" "A clone of NeXT Librarian from GSDE" off \
"Memory" "A yet not finished Memory Monitor" off \
"NetSurf" "NetSurf Web Browser ported to GNUstep" off \
"OpenUp" "An Archive Manager from GSDE" off \
"PikoPixel" "Pixel Art Editor" off \
"Player" "A Video Player from GSDE" off \
"PowerPaint" "Bitmap Drawing from GNUstep Examples" off \
"PPC" "PowerPC Emulator" off \
"Preview" "Image Viewer" off \
"PRICE" "Image Manipulation" off \
"ScanImage" "Scan Client from GSDE" off \
"ScreenShot" "Screen Grabber from GSDE" off \
"StepSync" "File Synchronizer" off \
"TalkSoup" "IRC Client" off \
"Vindaloo" "PDF Viewer" off \
"Weather" "A Weather app" off \
"Zipper" "An Archive Manager" off 2> $TEMPFILE

# 0 if [OK] button was pushed;
# otherwise, exit the script.
if [ $? = 0 ];then
for i in `cat $TEMPFILE`
do
case "$i" in
"Affiche")
	printf "You chose Affiche\n"
	remove_if_present "Affiche"
	install_affiche
	update_info_unit;;
"Calculator")
	printf "You chose Calculator\n"
	remove_if_present "Calculator"
	install_calculator
	update_info_unit;;
"Cenon")
	printf "You chose Cenon\n"
	remove_if_present "Cenon"
	install_cenon
	update_info_unit;;
"Cynthiune")
	printf "You chose Cynthiune\n"
	remove_if_present "Cynthiune"
	install_cynthiune
	update_info_unit;;
"Dictionary")
	printf "You chose Dictionary\n"
	remove_if_present "DictionaryReader"
	install_dictionaryreader
	update_info_unit;;
"FlexiSheet")
	printf "You chose FlexiSheet\n"
	remove_if_present "FlexiSheet"
	install_flexisheet
	update_info_unit;;
"FontManager")
	printf "You chose FontManager\n"
	remove_if_present "FontManager"
	install_fontmanager
	update_info_unit;;
"FTP")
	printf "You chose FTP\n"
	remove_if_present "FTP"
	install_ftp;;
"Graphos")
	printf "You chose Graphos\n"
	remove_if_present "Graphos"
	install_graphos;;
"Grr")
	printf "You chose Grr\n"
	remove_if_present "Grr"
	install_grr;;
"GSPdf")
	printf "You chose GSPdf\n"
	remove_if_present "GSPdf"
	install_gspdf;;
"HelpViewer")
	printf "You chose HelpViewer\n"
	remove_if_present "HelpViewer"
	install_helpviewer;;
"Ink")
	printf "You chose Ink\n"
	remove_if_present "Ink"
	install_ink;;
"Installer")
	printf "You chose Installer\n"
	remove_if_present "Installer"
	install_installer;;
"LaternaMagica")
	printf "You chose LaternaMagica\n"
	remove_if_present "LaternaMagica"
	install_laternamagica;;
"Librarian")
	printf "You chose Librarian\n"
	remove_if_present "Librarian"
	install_librarian
	update_info_unit;;
"Memory")
	printf "You chose Memory\n"
	remove_if_present "Memory"
	install_memory;;
"NetSurf")
	printf "You chose NetSurf\n"
	remove_if_present "NetSurf"
	install_netsurf;;
"OpenUp")
	printf "You chose OpenUp\n"
	remove_if_present "OpenUp"
	install_openup
	update_info_unit;;
"PikoPixel")
	printf "You chose PikoPixel\n"
	remove_if_present "PikoPixel"
	install_pikopixel
	update_info_unit;;
"Player")
	printf "You chose Player\n"
	remove_if_present "Player"
	install_player
	update_info_unit;;
"PowerPaint")
	printf "You chose PowerPaint\n"
	remove_if_present "PowerPaint"
	install_powerpaint
	update_info_unit;;
"PPC")
	printf "You chose PPC\n"
	remove_if_present "PPC"
	install_ppc;;
"Preview")
	printf "You chose Preview\n"
	remove_if_present "Preview"
	install_preview
	update_info_unit;;
"PRICE")
	printf "You chose PRICE\n"
	remove_if_present "PRICE"
	install_price
	update_info_unit;;
"ScanImage")
	printf "You chose ScanImage\n"
	remove_if_present "ScanImage"
	install_scanimage
	update_info_unit;;
"ScreenShot")
	printf "You chose ScreenShot\n"
	remove_if_present "ScreenShot"
	install_screenshot
	update_info_unit;;
"StepSync")
	printf "You chose StepSync\n"
	remove_if_present "StepSync"
	install_stepsync
	update_info_unit;;
"TalkSoup")
	printf "You chose TalkSoup\n"
	remove_if_present "TalkSoup"
	install_talksoup;;
"Vindaloo")
	printf "You chose Vindaloo\n"
	remove_if_present "ViewPDF"
	install_vindaloo;;
"Weather")
	printf "You chose Weather\n"
	remove_if_present "Weather"
	install_weather
	update_info_unit;;
"Zipper")
	printf "You chose Zipper\n"
	remove_if_present "Zipper"
	install_zipper;;
esac
done
else exit 0
fi
}
#################################################

extra_apps_menu

################################################
### Removed

#install_vespucci
#install_notebook

################################################

printf "Linking and making services: wait please...\n"

sudo ldconfig
make_services

print_size

sleep 2
