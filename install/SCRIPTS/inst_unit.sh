 #!/bin/bash

####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

#####################################
### inst_unit.sh: install one app
### Usefull to update the project
#####################################

### Include functions

. SCRIPTS/log.sh
. SCRIPTS/colors.sh
. SCRIPTS/check_app.sh
. SCRIPTS/size.sh
. SCRIPTS/spinner.sh
. SCRIPTS/patch_with_quilt.sh
. SCRIPTS/functions_inst_core_apps.sh
. SCRIPTS/functions_inst_extra.sh
. SCRIPTS/functions_inst_devel.sh
. SCRIPTS/functions_inst_games.sh
. SCRIPTS/functions_prep.sh
. SCRIPTS/functions_inst_wrappers.sh
. SCRIPTS/std_build.sh

### End of Include functions
################################


################################
### ENV

clear
if [ -n "$1" ];then
	APPTOINST="$1"
	printf "$APPTOINST\n"
else
	info "You must give the name app (only small caps) as argument."
	cli "$0 <app_name>"
	exit 1
fi

_PWD=`pwd`

echo $PATH | grep -e "/System/Tools" &>/dev/null
if [ $? -ne 0 ];then
	export PATH=/System/Tools:$PATH
fi
GSMAKE=$(gnustep-config --variable=GNUSTEP_MAKEFILES)
. ${GSMAKE}/GNUstep.sh
SPIN='/-\|'
INSTALL_DIR=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)

### End of VARS
################################

clear
STR="A G N o S t e p  -  Install apps one by one"
titulo

################################
### Is there a Build Folder?

if [ ! -d ../build ];then
	mkdir -p ../build
fi

################################
### Is there a LOCAL APPS Folder?

if ! [ -d $INSTALL_DIR ];then
	alert "$INSTALL_DIR was not found!"
	exit 1
fi

##############################################
## If you want some app to be installed
## Just write the function below...
## save and run...
##############################################

install_${APPTOINST}

sudo ldconfig
make_services
