# AGNoStep - agnostic GNUstep Desktop

## The Core Apps

These apps are provided with the Core Desktop and installed the first time. They all are official GNUstep applications.
With new 2.0 release, many apps and tools have been also created in purpose: see following section.

- AClock: a digital clock
- AddressManager: contacts
- Batmon: Battery monitor (on laptop only)
- GNUMail: Mail User Agent
- GWorkspace: the NeXT like Workspace manager.
- InnerSpace: screen saver
- MDFinder: builtin GWorkspace indexing
- Recycler: see GWorkspace.
- SimpleAgenda: agenda
- SystemPreferences: to set Time Zone...
- Terminal: a Terminal emulator
- Ink(\*): text editor (RTF and plain text) and note taking
- TimeMon: a CPU monitoring (with the Classic flavour)

### Native GNUstep in purpose apps

- AgnostepManager: a better wrapper with GNUstep menus to access Agnostep Manager and its relevant help.
- Birthday: the app icon has a badge notification to alert about events like birthday or feast. You can see then detailed panel of the current event. As all is local on your computer, you will never let personal family data go out to the social networks.
- Dico: a French Dictionary Lookup app and service based on the DVLF of the University of Chicago.
- Launcher: it opens the Applications folder in Icon view type.
- Meteo: a dockable weather app using the Wttr.in API and prediction. It also displays the current date. 
- Mixer: a simplified ALSA compliant mixer with only PCM chanel. It was forked from VolumeControl.
- OpenDisk: it is a companion to the dockapp wmudmount. The later will mount removable disks while OpenDisk will open the content  in a Fileviewer. It was necessary to do things like this due to an issue with GWorkspace Background on which we used to show drive icons.
- Pass: a GNUstep interface to use the Unix Password Manager (pass CLI).
- Printer: a better wrapper  to access CUPS (Common Unix Printer Settings) and its associated help.
- SaveLink: an Internet Shortcuts Manager.
- ScreenLock: screen locker based on xtrlock.
- Sound: help and diagnostic about sound setting.
- Updater: the app icon has a badge notification to alertabout available upgradable Debian packages. You can perform the upgrade from the list displayed: you will see then a progress bar indicator.
- UpMem: a dockable app to monitor uptime and Memory usage.

> [!NOTE]
> Why Ink and not the classic expected TextEdit? TextEdit 4 has been modified to fit on GSDE. TextEdit 5 (namely from Debian/Salsa sources) was unstable, crashing or frozing the system: we do not want such an app. Instead, Ink revealed itself to be a good and consistent alternative, with history management available, which was also broken with TextEdit.
 
## Dockapps

- wmnd: Network monitoring
- wmudmount: it helps managing removable medias: see OpenDisk above.

> [!NOTE]
> Several Native Apps also provide dockapps functionalities like:
> - Auto-updating  displayed content: **Meteo.app**, **UpMem.app**.
> - Badge notifications: **Birthday.app**, **Updater.app**. 

## More apps?

Of course, you can add more apps with **AgnostepManager** later. Execute:

- Within a TTY console:

````agnostep.sh````

- From the GNUstep Workspace, in the **Applications** folder, select and open **AgnostepManager.app**.

From the menu, choose the category of the apps to add.

See respective documentations for each category: 

- [EXTRA APPS](./EXTRA_APPS.md)
- [DEVEL ENV](./DEVEL_ENV.md)
- [GAMES](./GAMES.md)
- [UTILITIES](./UTIL.md)
- [WRAPPERS](./WRAPPERS/md)
