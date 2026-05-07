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
### Setting Alsa
### To be called within 1_prep.sh
################################

######## Include functions ###########
if [ -z "$COLORS" ];then
	. SCRIPTS/colors.sh
fi

### Uncomment below only for testing without 1_prep.sh
#. SCRIPTS/functions_prep.sh

#####################################
### Not a RPI / Not an Apple...
RPI=1
APPLE=1
### RPI CONFIG
RPI_CONFIG=/boot/firmware/config.txt
SOUND=RESOURCES/SOUNDS/Simple_music_box_rythm.wav

function test_sound
{

STR="Testing Sound"
titulo

aplay $SOUND

dialog --title "Sound test" \
 --yesno "
 Did you ear the sound?" 12 50

if [ $? -eq 0 ];then
	info  "Sound config is ok."
else
	alert "Sound badly set."
	is_hw_rpi
	if [ $RPI -eq 0 ];then
		MOD=$(echo $MODEL | awk '{print $3}')
		case "$MOD" in
		"400"|"500")
			grep -e "dtoverlay=vc4-kms-v3d,noaudio" $RPI_CONFIG
			if [ $? -eq 0 ];then
				info "$RPI_CONFIG has been set."
				cat /proc/asound/cards | grep -e "0 \[UC02"
				if [ $? -eq 0 ];then
					info "USB2JACK is the default sound card."
					alert "You must init, then set sound level with alsamixer command and finaly store it..."
					cli "sudo alsactl init\n\talsamixer\n\tsudo  alsactl store\n\tsudo reboot"
					exit 1
				fi

			else
				alert "You must set $RPI_CONFIG with the noaudio flag and reboot."
				exit 1
			fi;;
		*) warning "Read documentation about your sound device.";;
		esac
	else
		is_hw_apple
		if [ $APPLE -eq 0 ];then
			info "Cd to install/RESOURCES/MACSET to set your hardware. Then get back here."
			exit 1
		fi
	fi
fi
}

### Uncomment for Testing without 1_prep.sh
#test_sound
