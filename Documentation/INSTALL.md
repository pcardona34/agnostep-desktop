# A G N o S t e p

## I. How to install the Core Desktop (from SOURCES)

### CAUTION!

> [!CAUTION]
> NEVER install any related GNUstep debian package: this would conflict with the GNUstep built by AGNoStep and break your System. To install something, use ever AgnostepManager.
> In the console: `./agnostep.sh` or `agnostep --am` (after first install).
> Within the Desktop: `Applications / Utilities / AgnostepManager.app`.

### Base OS and Locale

1) Install Minimal Debian: you can download the minimal installation image from the Debian website and create a bootable USB drive.

Then, boot from the USB and follow the installation prompts to set up your system:

See: <https://www.debian.org/distrib/netinst>

> [!TIP]
> **On a Raspberry Pi**, use instead `RPI Imager` to copy the Raspberry Pi 64-Bit Lite OS image on your SD card.

2) Boot with your USB key or SD-card to load the Lite Debian System.

3) Update the Debian System. Your User account must belongs to the group 'sudo': you must have root privileges:

```
	sudo -v
```

Otherwise, add the current user to the 'sudo' group.

Then:

```
	sudo apt -y update && sudo apt -y full-upgrade
```

You should get the latest Debian Trixie release: 13.x as shown by:

```	
	cat /etc/debian_version
```

> [!NOTE]
> Until now, most of the installation scripts are only in English.  
> L18N of AGNoStep depends of the state of the respective translations of the apps in the GNUstep project. For the Conky Panel or the dockapps of the Classic flavour (see agnostep-theme) French and English are available.
> The installer script will let you choose the most accurate locale.

### Prerequisites

- Install 'git':

```
	sudo apt install git
```

- Create a 'SOURCES' directory to build all is needed:

```
	mkdir SOURCES && cd SOURCES
```

- Clone this repository:

```
	git clone https://github.com/pcardona34/agnostep-desktop
```
	
### Start Main AGNoStep menu

```
	cd agnostep-desktop
```

- If you already installed a previous version, udpdate with:

```
	git pull
```

- Now you are ready to execute the main AgnostepManager script:

```
	./agnostep.sh
```

The first time, you should run from the above menu these four items in this order:

1. Core: will install the Core Desktop.
1. Apps: will install all the Core Apps.
1. Settings: will set the theme...
1. DM: will install the display manager.

You can view progress and info messages while AGNoStep is installing.
After several minutes, you should be able to start the AGNoStep Desktop:

- With `startx` (after stage 3) 
- From `Lightdm` graphical Login (after stage 4). 

> [!TIP]
> After the Display Manager has been set, you need to use CLI again, use TTY2 to login to the console: `CTRL-ALT-F2`.  
> Then go back to the graphical environment with: `CTRL-ALT-F7`.
	
---

## If something inexpected happens

If the above 'Core' stage failed for some reason,  
try the following alternative manual stages to be able to note the issue concerned.

### Manual Alernative Install Way

#### A-1) Prepare the installation (mainly build tools and debian dependencies):
	
> [!TIP]
> The point './' before a command means to search and execute the script in the current directory:

```
	cd install
	./1_prep.sh
```

#### A-2) Install Window Maker:

```
	./2_install_wmaker.sh
```

#### A-3) Install the Core GNUstep:

```
	./3_install_gnustep.sh	
```

#### A-4) Install the Frameworks:

```
	./4_install_frameworks.sh
```

#### A-5) Install Core apps and Wrappers:

```
	./5_install_core_apps.sh
```
#### A-6) Set the current user's environment and AGNOSTEP-theme:

```
	./6_user_settings.sh
```

##### Testing: start the X server and AGNoStep Desktop:
	
```
	cd && startx
```

> [!Note]
> If you want to regenerate your default user's setting or change the theme, log out the Desktop, log in a tty console and do the following:

```
	cd ~/SOURCES/agnostep-desktop
	./agnostep.sh
```

- Choose item "Settings" from the menu.

#### A-7) If all is right, logout again and install the Display Manager from a tty console:

```
	./7_install_DM.sh
```

## II. How to install more apps?

Logout the Desktop if you want to Change **Core Desktop** or **Settings** components. Otherwise, you can open a Terminal window.

1. cd ~/SOURCES/agnostep-desktop
1. Run the AnostepManager:

```
	./agnostep.sh
```

> [!TIP]
> Within the Desktop, use `Applications / Utilities / AgnostepManager.app`.

Then:

1. From the menu shown, choose the software category: core, extra apps, developper, games...
1. Update the User settings to apply the theme to newly installed apps: choose item 'Settings'.

> [!TIPT]
> DO NOT forget the 'settings' stage to apply correctly the theme to the app just installed if you note if was not applied.

## III. How to remove some app?

1. Run the `AnostepManager` tool...
1. Then choose the item 'Remove' and follow the Assistant to select and remove the App.

## IV. How to reinstall/update Core Desktop after an udpate of the project repo

```
	cd ~SOURCES/agnostep-desktop
	git pull
	./agnostep.sh
```
> [!TIP]
> Once installed, `AgnostepManager.app` has an auto-repair feature. If you accidently removed the `~/SOURCES` folder or the repo `agnostep-desktop`, it will fetch it again for you.

From the main menu, execute these tasks:

1. Core
2. Apps
3. Settings
