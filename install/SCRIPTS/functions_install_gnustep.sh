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
### Installation of GNUstep: Functions
### with GNU Runtime
####################################################

#################################################
### Thanks to the Riccardo Mottola
### to recommend GNU Runtime
#################################################

function install_make
{
STR="Building GNUstep-make..."
subtitulo

cd make || exit 1

sudo make distclean &>/dev/null

printf "Configuring...\n"
./configure \
    --with-layout=gnustep \
    --prefix=/ &>>$LOG &
PID=$!
spinner
printf "\rBuilding...\n"
make -j8 &>>$LOG &
PID=$!
spinner
printf "\rInstalling\n"
sudo -E make install &>>$LOG &
PID=$!
spinner
ok "\rDone"
sudo ldconfig
}
################################################

#################################################
# Checkout sources
function fetch_sources
{
STR="Checking out Sources..."
subtitulo

HUB=https://github.com/
GSMAKE=make
BASE=base
GUI=gui
BACK=back

printf "\nGNUstep Tools Make\n"
git clone $HUB/gnustep/$GSMAKE | tee -a $LOG
ok "Done"

printf "\nGNUstep Base\n"
git clone $HUB/gnustep/$BASE | tee -a $LOG
ok "Done"

printf "\nGNUstep Gui\n"
git clone $HUB/gnustep/$GUI | tee -a $LOG
ok "Done"

printf "\nGNUstep Back\n"
git clone $HUB/gnustep/$BACK | tee -a $LOG
ok "Done"
}

#################################################
## Build GNUstep base
function install_base
{
STR="Building Fundation: GNUstep Base..."
subtitulo

cd base || exit 1

printf "Configuring...\n"
./configure &>>$LOG &
PID=$!
spinner
printf "\rBuilding...\n"
make -j8 &>>$LOG &
PID=$!
spinner
printf "\rInstalling...\n"
sudo -E make install &>>$LOG &
PID=$!
spinner
ok "\rDone"

sudo ldconfig
}
#################################################

#################################################
## Build GNUstep GUI
function install_gui
{
STR="Building AppKit: GNUstep Gui"
subtitulo

cd gui || exit 1
dialog --no-shadow --backtitle "Building GNUstep" --title "GUNstep Gui" \
 --yesno "
Experimental branch allow to fix some issue with
openURL Service.

Do you want to include experimental branch
app-wrapper-open-url?" 14 50

clear

if [ $? -eq 0 ];then
	### Try to fix 'open URL' issue
	printf "\nSwitching to app-wrapper-open-url branch"
	git switch app-wrapper-open-url
fi

printf "Configuring...\n"
./configure &>>$LOG &
PID=$!
spinner

printf "\rBuilding...\n"
make -j8 &>>$LOG &
PID=$!
spinner

printf "\rInstalling...\n"
sudo -E make install &>>$LOG &
PID=$!
spinner
ok "\rDone"

sudo ldconfig
}
#################################################

#################################################
## Build GNUstep back
function install_back
{
STR="Building the Backend: GNUstep Back..."
subtitulo

cd back || exit 1
printf "Configuring...\n"
./configure &>>$LOG &
PID=$!
spinner
printf "\rBuilding...\n"
make &>>$LOG &
PID=$!
spinner
printf "\rInstalling...\n"
sudo -E make install &>>$LOG &
PID=$!
spinner
ok "\rDone"

sudo ldconfig
}
###############################################

######################################
### is_gnustep_ok

function is_gnustep_ok
{
STR="Checking GNUstep installation..."
subtitulo

local _COUNT=0

grep -e " Error " $LOG &>/dev/null
if [ $? -eq 0 ];then
	_COUNT=$(( $_COUNT + 1 ))
fi
grep -v -e " error: nil" $LOG | grep -v -e " error: &" | grep -e " error: " &>/dev/null
if [ $? -eq 0 ];then
	_COUNT=$(( $_COUNT + 1 ))
fi

if [ ${_COUNT} -ne 0 ];then
	alert "GNUstep installation has generated ${_COUNT} errors: check the logs in your home directory."
	exit 1
else
	info "GNUstep installation was successful. You can go forward."
	sleep 5
fi
}
########################################

### Enf of functions
########################################
