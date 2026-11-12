# AGNoStep - agnostep-desktop

## I. How to install the Core Desktop (from SOURCES)

### CAUTION!

> [!CAUTION]
> NEVER install any related GNUstep Debian or Redhat package: this would conflict with the GNUstep System built by AGNoStep and break your System. To install the Desktop, use ever AGNoStep Wizard.
> In the console: `./agnowiz.sh`
> Then, to add more applications, install [AGNoStep-Apps-Manager](../../../../agnostep-apps-manager).

### Lite OS expected

1) Install Minimal Debian: you can download the minimal installation image from the Debian website and create a bootable USB drive.

Then, boot from the USB and follow the installation prompts to set up your system:

See: <https://www.debian.org/distrib/netinst>

> [!TIP]
> **On a Raspberry Pi**, use instead `RPI Imager` to copy the Raspberry Pi 64-Bit Lite OS image on your SD card.

2) Boot with your USB key or SD-card to load the Debian Lite System.

3) Your User account must belongs to the group 'sudo': 
You must have root privileges:

```console
	sudo -v
```

Otherwise, namely on Debian Lite, install sudo, then add the current user (by example'patrick' below) to the 'sudo' group:

```console
   su
   apt install sudo
   /usr/sbin/usermod -aG sudo patrick
   exit
   exit
```

> [!NOTE]
> Until now, most of the installation scripts are only in English.  
> L18N of AGNoStep depends of the state of the respective translations of the apps in the GNUstep project.
> The installer script will let you choose the most accurate locale.

### Prerequisites

- Install 'git':

```console
	sudo apt install git
```

- Create a 'SOURCES' directory to build all is needed:

```console
	mkdir SOURCES && cd SOURCES
```

- Clone this repository:

```console
	git clone https://github.com/pcardona34/agnostep-desktop
```
	
### Start AGNoStep Wizard

```console
	cd agnostep-desktop
```

- If you already installed a previous version, udpdate with:

```console
	git pull
```

- Now you are ready to execute the main Agnostep Wizard script:

```console
	./agnowiz.sh
```

The first time, you should run from the above menu these items in this order:

1. Prep: set the locale,update the system, install needed tools.
1. Core: will install the Core Desktop.
1. Apps: will install all the Core Apps.
1. Settings: will set and prepare the X session...
1. DM: will install the Display Manager.

You can view progress and info messages while AGNoStep Wizard is installing.
After several minutes, you should be able to start the AGNoStep Desktop:

- With `startx` (after stage 4) 
- From `Lightdm` graphical Login (after stage 5). 

> [!TIP]
> After the Display Manager has been set, if you need to use CLI again, use TTY2 to log into the console: `CTRL-ALT-F2`.  
> Then go back to the graphical environment with: `CTRL-ALT-F7`.
	
---

## If something inexpected happens

If the above 'Core' stage failed for some reason,  
try the following alternative manual stages to be able to note the issue concerned.

### Manual Alernative Install Way

#### A-1) Prepare the installation (mainly build tools and debian dependencies):
	
> [!TIP]
> The point './' before a command means to search and execute the script in the current directory:

```console
	cd install
	./1_prep.sh
```

#### A-2) Install Window Maker:

```console
	./2_install_wmaker.sh
```

#### A-3) Install the Core GNUstep:

```console
	./3_install_gnustep.sh	
```

#### A-4) Install the Frameworks:

```console
	./4_install_frameworks.sh
```

#### A-5) Install Core apps and Wrappers:

```console
	./5_install_core_apps.sh
```
#### A-6) Set the X session:

```console
	./6_desktop_settings.sh
```

##### Testing: start the X server and AGNoStep Desktop:
	
```console
	cd && startx
```

> [!Note]
> If you want to regenerate your default user's setting, log out the Desktop, log in a tty console and do the following:

```console
	cd ~/SOURCES/agnostep-desktop
	./agnowiz.sh
```

- Choose item "Settings" from the menu.

#### A-7) If all is right, logout again and install the Display Manager from a tty console:

```console
	./7_install_DM.sh
```

## II. Theming your Desktop

By default, Agnostep Desktop has been installed with default GNUstep theme. To use the in purpose AGNOSTEP theme, 
or another theme, get it from its repo: [agnostep-theme](../../../../agnostep-theme).

## III. How to install more apps?

You must install and use [AGNoStep-Apps-Manager](../../../../agnostep-apps-manager).

## IV. How to reinstall/update Core Desktop after an udpate of the project repo

- Log in a TTY session.
- Run again Agnostep Wizard.
- Then, choose item: **Update**.

Then, from the main menu:

1. Core
2. Apps
3. Settings

> [!CAUTION]
> You will rebuild all!
