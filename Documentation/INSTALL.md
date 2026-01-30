# A G N o S t e p

## I. How to install the Core Desktop (from SOURCES)

### CAUTION!

/!\ Do NEVER install any related GNUstep debian package: this would conflict with the GNUstep built by AGNoStep and break your Desktop. To install something, use ever AGNoStep provided tools.

### Base OS and Locale

1) Install Minimal Debian: you can download the minimal installation image from the Debian website and create a bootable USB drive.

Then, boot from the USB and follow the installation prompts to set up your system:

See: <https://www.debian.org/distrib/netinst>

1-BIS) **On a Raspberry Pi**, use instead `RPI Imager` to copy the Raspberry Pi Lite OS image on your SD card.

2) Boot with your USB key or SD card to load the lite Debian System.

3) Update the Debian System. Your User account must belongs to the group 'sudo'.

- You must have root privileges:

````
	sudo -v
````

Otherwise, add the current user to the 'sudo' group.

Then:

````
	sudo apt update && sudo apt upgrade
````

You should get the latest Debian Trixie release: 13.x as shown by:

````	
	cat /etc/debian_version
````

3) Enable and install your desired locale:

Until now, AGNoStep Desktop is localized in English (default) and in French.

If you choose default, you may skip the following step. Otherwise, it is mandatory to get a well localized French Desktop.


````
	sudo dpkg-reconfigure locales
	
````

- Set your locale (adapt the command below to your locale):

````
	sudo localectl set-locale fr_FR.UTF-8
````

- Log out and Log in again to apply the new locale in your context.
- Verify the locale is correctly set:

````
	locale
````

- **Nota**: until now, most of the installation scripts are only in English.  
L18N of AGNoStep depends of the state of the respective translations of the apps in the GNUstep project. For the Conky Panel or the dockapps of the Classic flavour (see agnostep-theme) French and English are available.

### Prerequisites

- Install 'git':

````
	sudo apt install git
````

- Create a 'SOURCES' directory to build all is needed:

````
	mkdir SOURCES && cd SOURCES
````

- Clone this repository:

````
	git clone https://github.com/pcardona34/agnostep-desktop
````
	
### Start Main AGNoStep menu

````
	cd agnostep-desktop
````

- If you already installed a previous version, udpdate with:

````
	git pull
````

- Now you are ready to execute the main script:

````
	./agnostep.sh
````

The first time, you should run from the above menu these three items in this order:

1) Core: will install the Core Desktop.
2) Apps: will install all the Core Apps.
3) Settings: will set the theme...
4) DM: will install the display manager.

You can view progress and info messages while AGNoStep is installing.
After several minutes, you should be able to start the AGNoStep Desktop:
- With `startx` (after stage 3) 
- From 'Lightdm' graphical Login (after stage 4). 

**TIP:** If you need to use CLI again, use TTY2 to login to the console: `CTRL-ALT-F2`.  
Then go back the graphical environment with: `CTRL-ALT-F7`.
	
---

If the above 'Core' stage failed for some reason,  
try the following alternative manual stages to note the issue concerned.

## Manual Alernative Install Way

### A-1) Prepare the installation (mainly build tools on debian dependencies):
	
- **(i) Tip:** the point './' below means to search and execute the script in the current directory:

````
	cd install
	./1_prep.sh
````

### A-2) Install Window Maker:

````
	./2_install_wmaker.sh
````

### A-3) Install the Core GNUstep:

````
	./3_install_gnustep.sh	
````

### A-4) Install the Frameworks:

````
	./4_install_frameworks.sh
````

### A-5) Install Core apps and Wrappers:

````
	./5_install_core_apps.sh
````
### A-6) Set the current user's environment and AGNOSTEP-theme:

````
	./6_user_settings.sh
````

#### Testing: start the X server and AGNoStep Desktop:
	
````
	cd && startx
````

#### Notes

- If you want to regenerate your default user's setting or change the theme, log out the Desktop, log in a tty console and do that:

````
	cd ~/SOURCES/agnostep-desktop
	./agnostep.sh
````

- Choose item "Settings" of the menu.

### A-7) If all is right, logout again and install the Display Manager from a tty console:

````
	./7_install_DM.sh
````

## II. How to install more apps?

- Logout the Desktop if you want to Change Core Desktop components. Otherwise, you can open a Terminal window.
- cd ~/SOURCES/agnostep-desktop
- Run the Anostep Manager tool:

````
	./agnostep.sh
````

1) From the menu shown, choose the software category: core, extra apps, developper, games...
2) Update the User settings to apply the theme to newly installed apps: choose item 'Settings'.

**Tip!** DO NOT forget the 'settings' stage to apply correctly the theme to the app just installed.

## III. How to remove some app?

- Run the Anostep Manager tool:

````
	./agnostep.sh
````

- Then choose the item 'Remove' and follow the Assistant to select and remove the App.

## IV. How to reinstall/update Core Desktop after an udpate of the project repo

````
	cd ~SOURCES/agnostep-desktop
	git pull
	./agnostep.sh
````

From the main menu, execute these tasks:

1) Core
2) Apps
3) Settings
