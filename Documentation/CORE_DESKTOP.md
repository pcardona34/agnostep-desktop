# AGNoStep - agnostic GNUstep Desktop

## The Core Desktop Components

### Window Manager

- We use **Window Maker**: 0.96.0. (debian default package version) with AGNOSTEP.themed when the AGNOSTEP theme is set.
- Since release 2.0.0, we removed `--static` option to permit again customisation.
- Since release 2.0.0, the wallpaper (background) is handled by Window Maker.
- By default, we use the **Clip** and the **Dock** of WindowMaker.

Some apps and tools are launched with the 'autostart' script of Window Maker, others from the Dock or the Clip with `autolaunch`.

#### AutoLaunched apps

- Meteo
- AClock
- UpMem
- TimeMon
- wmnd
- Updater
- Birthday
- wmudmount
- SimpleAgenda

> [!CAUTION]
> GWorkspace is launched a main xinit process form the `.xinitrc`/`.xsession` script. So the **logout** command is more consistent because GWorkspace send a Terminate message to all the running GNUsstep applications, and then it terminates itself, which ends the X session.

#### Auto-started commands

`autostart` script has been simplified.

> [!NOTE]
> Namely, all `xset` commands have been removed.

It only starts:

- dunst (notification daemon)
- `loading.sh` script.

### The Workspace

- In the NeXT/OPENSTEP world, the *Workspace* is the main component: we use **GWorkspace** (release 1.1.0): the GNUstep implementation of the Workspace.  
It provides a Desktop layer, a FileViewer, a Finder panel, a Recycler, and, wether you choose the Conky flavour, its own Dock.

### Some apps provided with the Core Desktop

See [Core Apps](CORE_APPS.md)...

### Under the ground

This section provides more technical infos.
 
- Notifyer: [dunst](https://dunst-project.org/) is less used since release 2.0.0 because we prefred to use badges within GNUstep apps. 
- [DBusKit](https://github.com/gnustep/libs-dbuskit) provides also Desktop Notification from SimpleAgenda.
- Compositing: picom has been removed. We do not use any since release 2.0.0.
- System Infos: [conky](https://github.com/brndnmtthws/conky) panel has been removed in favour of dockapps or native in purpose GNUstep apps.
- Weather data is fetched from [Wttr.in API](https://github.com/chubin/wttr.in). 
- [GNUstep](https://github.com/gnustep/): latest built from sources with GNU Runtime (not OBJC2). 
- All the apps are built from sources and so benefit from the latest official patches.
- AGNOSTEP in purpose Theme: mostly inspired by Papirus Icon theme and GNUstep Sleek Theme.
- Session Display Manager: [Lightdm](https://github.com/canonical/lightdm) and DBus (with DBUSKit support).
- Sound is handled by [Alsa](https://www.alsa-project.org/wiki/Main_Page) (not pulse-audio) and a compliant Audio Mixer: Mixer.app (forked from VolumeControl).
- RPI tools: only on RPI when the hardware is detected, if not substituted: cf. how to set default printer within CUPS in the Printer Help.
- Password Manager: [pass](https://www.passwordstore.org/) has a GNUstep interface since release 2.0.0.
- Installation scripts: they use [Bash](https://manpages.debian.org/trixie/bash/bash.1.en.html) and [Dialog](https://manpages.debian.org/stretch/dialog/dialog.1.en.html)

> [!TIP]
> Use: `agnostep --info` for a more complete release info.
