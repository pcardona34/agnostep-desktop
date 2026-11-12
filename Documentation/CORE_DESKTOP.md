# AGNoStep - agnostep-desktop - Core Compenents

## Within the Classic Flavour

### Window Manager

- We use **Window Maker**: 0.96.0. (debian default package version) 
- Since release 2.0.0, we removed `--static` option to permit again customization.
- By default, we use the **Clip** and the **Dock** of WindowMaker.

### Session manager

> [!IMPORTANT]
> GWorkspace is launched as the main xinit process from the `.xinitrc`/`.xsession` script. So the **logout** command is more consistent because GWorkspace send a *Terminate* message to all the running GNUstep applications, and then it terminates itself, which ends the X session.

### Auto-started commands

`autostart` script has been removed.

### The Workspace

- In the NeXT/OPENSTEP world, the *Workspace* is the main component: we use **GWorkspace** (release 1.1.0): the GNUstep implementation of the Workspace.  
It provides a Desktop layer, a FileViewer, a Finder panel, a Recycler.

## Within the Modern Flavour (available choice since 3.0.0)

- You can *experiment* **pkgdemon/gnustep-windowwmanager**, **gcasa/Finder** and **gcasa/apps-dock**.

> [!CAUTION]
> It is not yet intended for a daily use. 

## Some apps provided with the Core Desktop

See [Core Apps](CORE_APPS.md)...

## Wallpaper management

- With release 3.0.0, the wallpaper (background) will be handled by [agnostep-wall](../../../../agnostep-wall) module.

> [!WARNING]
> It seems not avaible within MODERN flavour due to gnustep-windowwmanager limitation.

### Under the ground

This section provides more technical infos.
 
- Notifyer: [dunst](https://dunst-project.org/) is just used at launching time. With GNUstep Applications like Updater or Birthday, we will use badges instead.
- [DBusKit](https://github.com/gnustep/libs-dbuskit) provides also Desktop Notification from SimpleAgenda. But it may fail to build.
- Compositing: picom has been removed. We do not use any since release 2.0.0.
- System Infos: [conky](https://github.com/brndnmtthws/conky) panel has been removed in favour of dockapps or native in purpose GNUstep apps.
- Weather data is fetched from [Wttr.in API](https://github.com/chubin/wttr.in). Used by Meteo.app. 
- [GNUstep](https://github.com/gnustep/): latest built from sources with **GNU Runtime** within Classic or with **libobjc2** within Modern Flavour. 
- All the apps are built from sources and so benefit from the latest official patches or commits.
- AGNOSTEP in purpose Theme: mostly inspired by Papirus Icon theme and GNUstep Sleek Theme: provided by separate the [agnostep-theme](../../../../agnoste-theme) module.
- Session Display Manager: [Lightdm](https://github.com/canonical/lightdm) and DBus (with DBUSKit support).
- Sound is handled by [Alsa](https://www.alsa-project.org/wiki/Main_Page) (not pulse-audio) and a compliant Audio Mixer: Mixer.app (forked from VolumeControl).
- RPI tools: only on RPI when the hardware is detected, if not substituted: cf. how to set default printer within CUPS in the Printer Help.
- Password Manager: [pass](https://www.passwordstore.org/) has a GNUstep interface since release 2.0.0. *Will be updated asap*.
- Installation scripts: they use [Bash](https://manpages.debian.org/trixie/bash/bash.1.en.html) and [Dialog](https://manpages.debian.org/stretch/dialog/dialog.1.en.html)

> [!TIP]
> Use: `agnostep --info` for a more complete release info.
