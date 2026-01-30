# AGNoStep - agnostic GNUstep Desktop

## The Core Desktop Components

### Window Manager

- We use **Window Maker**: 0.96.0. (debian default package version) with AGNOSTEP.themed.

Otions depend on the Theme flavour chosen: 

- Classic flavour: `--static`: it is to prevent mistakes. ;-)
- Conky Flavour: `--no-dock  --no-clip --static`. In this case, the provided Dock belongs to GWorspace: see below. 

Some apps and tools are launched with the 'autostart' script of Window Maker, others form the Dock. Again, it depends on the flavour chosen.


### The Workspace

- In the NeXT/OPENSTEP world, the *Workspace* is the main component: we use **GWorkspace** (1.1.0), the GNUstep implementation of the Workspace.  
It provides a Desktop layer, a FileViewer, a Finder panel, a Recycler, and, wether you choose the Conky flavour, its own Dock.

### Some apps provided with the Core Desktop

See [CORE_APPS.md]

### Under the ground

This section provides more technical infos. Components are used within Desktop or AGNOSTEP-theme.
 
- Notifyer: [dunst](https://dunst-project.org/)
- [DBusKit](https://github.com/gnustep/libs-dbuskit) provides also Desktop Notification from SimpleAgenda.
- Compositing: [picom](https://github.com/yshui/picom).
- System Infos: [conky](https://github.com/brndnmtthws/conky) panel or dockapps wether you chose 'conky' or 'classic' flavour of the AGNOSTEP-theme.
- Weather data is fetched from [Wttr.in API](https://github.com/chubin/wttr.in). 
- [GNUstep](https://github.com/gnustep/): latest built from sources with GNU Runtime (not OBJC2). Use: `agnostep --info` for a more complete release info.
- All the apps are built from sources and so are the latest.
- Theme: see [AGNOSTEP-theme](https://github.com/pcardona34/agnostep-theme) (previously PISIN) mostly inspired by Papirus Icon theme and GNUstep Sleek Theme.
- Session Display Manager: [Lightdm](https://github.com/canonical/lightdm) and DBus (with DBUSKit support).
- Sound is handled by [Alsa](https://www.alsa-project.org/wiki/Main_Page) (not pulse-audio) and a compliant Audio Mixer: see VolumeControl in the Extra apps.
- RPI tools: only on RPI when the hardware is detected, if not substituted: cf. how to set default printer within CUPS in the AGNoStep User Guide.
- Password Manager: [pass](https://www.passwordstore.org/)
- Installation scripts: [Bash](https://manpages.debian.org/trixie/bash/bash.1.en.html) and [Dialog](https://manpages.debian.org/stretch/dialog/dialog.1.en.html)
