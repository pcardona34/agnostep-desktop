#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

# Ensure ALSA modules active (if needed)
sudo modprobe snd_hda_intel || true

# Test for Master control and set initial volume
if amixer scontrols | grep -q "Master"; then
  amixer set Master 80%
  sudo alsactl store
else
  echo "Master not found; ensure /etc/asound.conf softvol configured and rebooted."
fi

### Setting TLP
. ./install_tlp.sh

# Xinit
# Will be set separately

echo "Post-reboot setup done."
