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
### Install Tools...
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
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
TEMPFILE=$(mktemp /tmp/agno-XXXXX)
trap "rm -f $TEMPFILE" EXIT
SLEEP=2

### End of Vars
#################################################

################################################
### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/std_build.sh
. SCRIPTS/misc_info.sh
. SCRIPTS/patch_with_quilt.sh
. SCRIPTS/functions_remove_app.sh
. SCRIPTS/functions_inst_tools.sh

### End of Include functions
#################################################

STR="A G N o S t e p  -  Utilitiess"
echo "$STR" >> $LOG

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
function tools_menu
{
dialog --no-shadow --clear --backtitle "AGNoStep Desktop" --title "Utilities" \
--ok-label "OK"  \
--checklist "
The list below contains the utilities.

Check (space bar) the Applications you want to (re)install." 20 70 10 \
"Affiche" "Sticky Notes" off \
"Calculator" "Calculator from GNUstep Examples" off \
"Dictionary" "Dict client" off \
"FontManager" "Font Previewer and Installer" off \
"FTP" "FTP Client" off \
"GSPdf" "PDF Reader" off \
"HelpViewer" "Help Viewer" off \
"Installer" "Applications installer not yet finished" off \
"Librarian" "A clone of NeXT Librarian from GSDE" off \
"Memory" "A yet not finished Memory Monitor" off \
"OpenUp" "An Archive Manager from GSDE" off \
"ScanImage" "Scan Client from GSDE" off \
"ScreenShot" "Screen Grabber from GSDE" off \
"StepSync" "File Synchronizer" off \
"Vindaloo" "PDF Viewer" off \
"Zipper" "An Archive Manager" off 2> $TEMPFILE

clear

# 0 if [OK] button was pushed;
# otherwise, exit the script.
if [ $? = 0 ];then
for i in `cat $TEMPFILE`
do
case "$i" in
"Affiche")
	printf "You chose Affiche\n"
	remove_ifx_app "Affiche"
	install_affiche
	update_info_plist "Affiche";;
"Calculator")
	printf "You chose Calculator\n"
	remove_ifx_app "Calculator"
	install_calculator
	update_info_plist "Calculator";;
"Dictionary")
	printf "You chose Dictionary\n"
	remove_ifx_app "DictionaryReader"
	install_dictionaryreader
	update_info_plist "DictionaryReader";;
"FontManager")
	printf "You chose FontManager\n"
	remove_ifx_app "FontManager"
	install_fontmanager
	update_info_plist "FontManager";;
"FTP")
	printf "You chose FTP\n"
	remove_ifx_app "FTP"
	install_ftp
	update_info_plist "FTP";;
"GSPdf")
	printf "You chose GSPdf\n"
	remove_ifx_app "GSPdf"
	install_gspdf
	update_info_plist "GSPdf";;
"HelpViewer")
	printf "You chose HelpViewer\n"
	remove_ifx_app "HelpViewer"
	install_helpviewer
	update_info_plist "HelpViewer";;
"Installer")
	printf "You chose Installer\n"
	remove_tool__if_present "Installer"
	install_installer
	update_info_plist "Installer";;
"Librarian")
	printf "You chose Librarian\n"
	remove_ifx_app "Librarian"
	install_librarian
	update_info_plist "Librarian";;
"Memory")
	printf "You chose Memory\n"
	remove_ifx_app "Memory"
	install_memory
	update_info_plist "Memory";;
"OpenUp")
	printf "You chose OpenUp\n"
	remove_ifx_app "OpenUp"
	install_openup
	update_info_plist "OpenUp";;
"ScanImage")
	printf "You chose ScanImage\n"
	remove_ifx_app "ScanImage"
	install_scanimage
	update_info_plist "ScanImage";;
"ScreenShot")
	printf "You chose ScreenShot\n"
	remove_ifx_app "ScreenShot"
	install_screenshot
	update_info_plist "ScreenShot";;
"StepSync")
	printf "You chose StepSync\n"
	remove_ifx_app "StepSync"
	install_stepsync
	update_info_plist "StepSync";;
"Vindaloo")
	printf "You chose Vindaloo\n"
	remove_ifx_app "ViewPDF"
	install_vindaloo;;
	#update_info_plist ViewPDF
"Zipper")
	printf "You chose Zipper\n"
	remove_ifx_app "Zipper"
	install_zipper
	update_info_plist "Zipper";;
esac
done
else exit 0
fi
}
#################################################

tools_menu

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



