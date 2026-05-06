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

# Video (blacklist + purge Nvidia)
sudo cp --verbose ./20-intel.conf /etc/X11/xorg.conf.d/
sudo apt -y purge '^nvidia-.*' nvidia-driver nvidia-kernel-dkms
sudo cp --verbose ./blacklist-nvidia.conf /etc/modprobe.d/
sudo update-initramfs -u

# Sound basics (install ALSA utils and copy asound.conf)
sudo apt -y purge pulseaudio pipewire pipewire-audio-client-libraries
sudo apt -y install --no-install-recommends alsa-utils
sudo apt -y autoremove --purge
sudo cp --verbose ./asound.conf /etc/

# Pommed package only (config/service after reboot)
sudo apt -y install pommed

echo "Done. Reboot now to reload kernel modules and apply changes."

