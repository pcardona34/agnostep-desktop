# CHANGES: AGNoStep - agnostep-desktop

## Changes of the Release Beta 3.0.0 (work in progress)

### New Modern architecture provided

- This Toolchain and runtime both provide a **modern GNUstep system**:  
with namely: Apple Grand Central Dispatch, GNUstep **libobjc2**  
compiled with **Clang**.
  - The relevant modern Desktop uses three pure objective C components:
  - **gnustep-windowmanager** (forked form Joe's Maloney) as an alternative to   
wmaker.
  - **apps-dock** (by Greg Casamento) as a modern Dock.
  - **Finder (FileViewer)** : as an alternative to GWorkspace.
  - Menu style is MacOS style.

Of course, if you do not want this modern feature yet, you can   
still install the Classic desktop: see below.

### Classic is still there

- Of course, agnostep-desktop still provides a **Classic** Desktop with  
stability and daily use in mind with both Window Maker and  
GWorkspace, with NeXTSyle like menus and GNUstep Legacy runtime with  
GCC compiler.

### Simplified Core Apps List

- **Core Apps list** was reduced to improve testing of the Desktop  
installation: i.e. SystemPreferences, GWorkspace, and Terminal.

### New Frameworks

Two frameworks were added from GSDE project:

- **SystemKit**
- **DesktopKit**

### Theming 

Theming was removed from agnostep-desktop and ported to a separate module.

- See [agnostep-theme](../../../../agnostep-theme)

### Wallpapers

Wallpapers collection management was also removed and ported to a separate module.

- See [agnostep-wall](../../../../agnostep-wall)

### Applications management

AgnostepManager was removed and ported to its own repository:

- See [agnostep-apps-maanger](../../../../agnostep-apps-manager)

### Improved Bash Scripts

- Fixed an issue within `misc_info.sh`: path of `INFOS` folder  
 was broken since `Agnostep-theme` was included in the core  
Agnostep project.
- All installation scripts revised and improved.


## Changes of the previous Release 2

See in its respective release commits.
