# MacBook Pro Intel laptop setup

This is a setup tied to my MacBook Pro Intel 6,2 (2010)
DO NOT use nor try with a different hardware.

## What is concerned

- [x] Setup of keyboard
- [x] Setup sound with Intel card by default
- [x] Setup Trackpad
- [x] Provide a convenient Xsession init script used by agnostep setup

## Usage

### cd in directory
``` console
    cd install/RESOURCES/MACSET
```

### Execute first stage
``` console
    ./install_before_reboots.sh
```

### Reboot the MacBook
``` console
    sudo reboot
```

### Post install
``` console
    cd SOURCES/agnostep-desktop/install/RESOURCES/MACSET
    ./post_reboot_setup.sh
```

## Known issues

- Mixer.app nor VolumeControl can set the volume. Use instead alsamixer.
