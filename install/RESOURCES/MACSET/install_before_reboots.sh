#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

# Keyboard
sudo cp --verbose ./keyboard /etc/default/
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
sudo udevadm trigger --subsystem-match=input --action=change

# Trackpad
sudo apt update
sudo apt -y install xserver-xorg-input-libinput libinput-tools xinput
sudo cp --verbose ./40-libinput.conf /etc/X11/xorg.conf.d/

# Sound basics (install ALSA utils and copy asound.conf)
sudo apt -y install --no-install-recommends alsa-utils
. ./set_alsa.sh
sudo cp ./asound.conf /etc/

echo "Done. Reboot now to reload kernel modules and apply changes."
