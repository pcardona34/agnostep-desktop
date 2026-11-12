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

### Up to date release set by def. to 'u';otherwise, it has been set to 's'
### in the parent script
UTD="${UTD:-u}"
THERE=`pwd`

#################################################
# Checkout sources

### Grand Central Dispatch
function fetch_gcd
{
STR="Checking out sources for Grand Central Dispatch"
subtitulo
HUB="https://github.com"
OWNER=apple
GCD=swift-corelibs-libdispatch

if [ -d libdispatch ];then
    rm -fR libdispatch
fi

### The more up to date
git clone $HUB/$OWNER/${GCD} | tee -a $LOG
mv $GCD "libdispatch"

ok "Done"

}

#################################################
### Libobjc2
function fetch_libobjc2
{
STR="Checking out Sources for Libobjc2..."
subtitulo

HUB="https://github.com"
OBJC2="libobjc2"

printf "\nGNUstep ${OBJC2}\n"

if [ -d libobjc2 ];then
    rm -fR libobjc2
fi

if [ "$UTD" == "u"  ];then
    ### The more up to date
    git clone $HUB/gnustep/${OBJC2} | tee -a $LOG
else
    ### This is a more conservative choice
    fetch $HUB/gnustep/libobjc2/archive/refs/tags/v2.3.tar.gz
    gunzip --force v2.3.tar.gz
    tar -xf v2.3.tar && rm v2.3.tar
    mv libobjc2-2.3 "libobjc2"
fi

ok "Done"

}

##################################################
### Other GNustep core libs
function fetch_sources
{
STR="Checking out other GNUstep Sources..."
subtitulo

HUB="https://github.com"
GSMAKE="make"
BASE=base
#BASE=libs-base # Was a temporary fork
GUI=gui
BACK=back

printf "\nGNUstep Tools Make\n"

if [ "$UTD" == "u"  ];then
    ### The more up to date
    git clone $HUB/gnustep/$GSMAKE | tee -a $LOG
else
    ### This is a more conservative choice
    fetch $HUB/gnustep/tools-make/releases/download/make-2_9_3/gnustep-make-2.9.3.tar.gz
    gunzip --force gnustep-make-2.9.3.tar.gz
    tar -xf gnustep-make-2.9.3.tar && rm gnustep-make-2.9.3.tar
    mv gnustep-make-2.9.3 "make"
fi

ok "Done"

printf "\nGNUstep Base\n"

if [ "$UTD" == "u" ];then
    ### The more up to date
    git clone $HUB/gnustep/$BASE | tee -a $LOG
    ### We don not need to use a fork for a better localization in French: pull request was merged
    #git clone $HUB/pcardona34/$BASE | tee -a $LOG
else
    ### This is a more conservative choice
    fetch $HUB/gnustep/libs-base/releases/download/base-1_31_1/gnustep-base-1.31.1.tar.gz
    gunzip --force gnustep-base-1.31.1.tar.gz
    tar -xf gnustep-base-1.31.1.tar && rm gnustep-base-1.31.1.tar
    mv gnustep-base-1.31.1 base
fi

ok "Done"

printf "\nGNUstep Gui\n"
if [ "$UTD" == "u" ];then
    ### The more up to date
    git clone $HUB/gnustep/$GUI | tee -a $LOG
else
    ### This is a more conservative choice
    fetch $HUB/gnustep/libs-gui/releases/download/gui-0_32_0/gnustep-gui-0.32.0.tar.gz
    gunzip --force gnustep-gui-0.32.0.tar.gz
    tar -xf gnustep-gui-0.32.0.tar && rm gnustep-gui-0.32.0.tar
    mv gnustep-gui-0.32.0 gui
fi

ok "Done"

printf "\nGNUstep Back\n"
if [ "$UTD" == "u" ];then
    ### The more up to date
    git clone $HUB/gnustep/$BACK | tee -a $LOG
else
    ### This is a more conservative choice
    fetch $HUB/gnustep/libs-back/releases/download/back-0_32_0/gnustep-back-0.32.0.tar.gz
    gunzip --force gnustep-back-0.32.0.tar.gz
    tar -xf gnustep-back-0.32.0.tar && rm gnustep-back-0.32.0.tar
    mv gnustep-back-0.32.0 back
fi

ok "Done"
}
#################################################

#################################################
### Install GCD
#################################################
function install_gcd
{
STR="Building Libdispatch..."
subtitulo

cd libdispatch || exit 1
if [ -d build ];then
    rm -fR build
fi
cmake -S . -B build \
  -G "Unix Makefiles" \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++

cmake --build build -j"$(nproc)"
sudo cmake --install build
sudo ldconfig
ok "Done"
}

#################################################
### Libobjc2: modern ABI
#################################################
function install_libobjc2
{
STR="Building Libobjc2..."
subtitulo

cd libobjc2 || exit 1
rm -rf Build
mkdir Build
cd Build

cmake .. \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++

make -j8

printf "\rInstalling\n"
### The command below was modified according to issue 925 of libs-gui
### and the comment by rfm

sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" PATH="$PATH" -E make messages=yes install

ok "\rDone"

}
################################################


#################################################
### Tools make installation
#################################################
function install_make
{
STR="Building GNUstep-make..."
subtitulo

cd make || exit 1

sudo make distclean &>/dev/null

printf "Configuring...\n"
./configure \
    --enable-native-objc-exceptions \
  	--enable-objc-arc \
  	--with-runtime-abi=gnustep-2.2 \
  	--with-library-combo=ng-gnu-gnu \
  	CC="clang" CXX="clang++" CPP="clang -E" LDFLAGS="-fuse-ld=lld" \
    --prefix=/ &>>$LOG &
PID=$!
spinner
printf "\rBuilding...\n"
make -j8 &>>$LOG &
PID=$!
spinner
printf "\rInstalling\n"
### The command below was modified according to issue 925 of libs-gui
### and the comment by rfm
sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" PATH="$PATH" -E make messages=yes install &>>$LOG &
PID=$!
spinner
ok "\rDone"

sudo ldconfig
}
################################################

#################################################
## Build GNUstep base
#################################################

function install_base
{
STR="Building Foundation: GNUstep Base..."
subtitulo

cd $BASE || exit 1

printf "Configuring...\n"
./configure &>>$LOG &
PID=$!
spinner
printf "\rBuilding...\n"
make -j8 &>>$LOG &
PID=$!
spinner
printf "\rInstalling...\n"
### The command below was modified according to issue 925 of libs-gui
### and the comment by rfm
sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" PATH="$PATH" -E make messages=yes install &>>$LOG &
PID=$!
spinner
ok "\rDone"

sudo ldconfig
}
#################################################

#################################################
## Build GNUstep GUI
#################################################

function install_gui
{
STR="Building AppKit: GNUstep Gui"
subtitulo

cd $GUI || exit 1

#if [ "$UTD" == "u" ];then
#    BRANCH="issue_927_GSIconManager_protocol_change"
#    PURPOSE="test DockWM by gcasa"
#
#    dialog --no-shadow --backtitle "Building GNUstep" --title "GUNstep Gui" \
#    --yesno "
#    Experimental branch allows to ${PURPOSE}.
#
#    Do you want to include the experimental branch
#    ${BRANCH}?" 14 50
#
#    if [ $? -eq 0 ];then
#        clear;printf "\nSwitching to ${BRANCH}"
#	    git switch ${BRANCH}
#    else
#        git switch master
#    fi
#    git pull
#fi

printf "Configuring...\n"
./configure &>>$LOG &
PID=$!
spinner

printf "\rBuilding...\n"
make -j8 &>>$LOG &
PID=$!
spinner

printf "\rInstalling...\n"
### The command below was modified according to issue 925 of libs-gui
### and the comment by rfm
sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" PATH="$PATH" -E make messages=yes install &>>$LOG &
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

cd $BACK || exit 1
printf "Configuring...\n"
./configure &>>$LOG &
PID=$!
spinner
printf "\rBuilding...\n"
make &>>$LOG &
PID=$!
spinner
printf "\rInstalling...\n"
### The command below was modified according to issue 925 of libs-gui
### and the comment by rfm
sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" PATH="$PATH" -E make messages=yes install &>>$LOG &
PID=$!
spinner
ok "\rDone"

sudo ldconfig
}
###############################################

########################################
### Enf of functions
########################################
