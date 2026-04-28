####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### (c) 2026 - pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community.
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### Updater.app: Debian packages updater
### README.md
####################################################


Based on AgnostepText_Template.

- [x] 1. It permits: displaying some text info on the AppIcon.
- [x] 2. It provides a menu: with 'Quit' action.
- [x] NSTask to get some sys infos: number of upgradable packages.
- [x] NSTimer loop to refresh the displayed content.
- [x] Badge notification.
- [x] Action to perform debian upgrade: upgrade the packages.

# Install

Within Agnostep Desktop, all is automated.
Below, instructions in another context.
Updater needs a bash script with setuid to perform silently the upgrades.

## 1) Install 'upgrade_unit.sh' script

```
cd SCRIPT
./install.sh
```

You will be prompted to type your password as a sudoers member.

## 2) Build and install Updater.app

You must have a GNUstep system correctly setup.

```
cd ..
make clean
make
sudo -E make install
``` 

# Using

Read help within the app from Info/Help... menuItem.
