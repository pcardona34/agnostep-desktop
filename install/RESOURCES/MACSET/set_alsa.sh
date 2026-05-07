#!/bin/bash

sudo -v

if [ ! -f /etc/modeprobe.d/alsa-base ];then
    sudo touch /etc/modprobe.d/alsa-base
    echo "options snd-hda-intel model=mbp61" | sudo tee -a /etc/modprobe.d/alsa-base
    echo "You must reboot to apply the changes."
else
    printf "Alsa modprobe: already set.\n"
fi
