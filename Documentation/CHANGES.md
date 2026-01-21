# AGNoStep - agnostic GNUstep Desktop

## Changes

### Changes of the 0.9.8.2 release

- New: main `agnostep.sh` script at the top level to provide a general menu for install core, apps, and so on.
- New: `remove.sh` script to handle removing of a selected app: to be continued.

### Changes of the 0.9.8.1 release

- Fix Service openURL: (to be installed after Firefox wrapper: TODO)
- New Wrapper: Nano to handle .sh and .md
- Complete reorganization of stage 5: see 5_install_core_apps.sh
- Bash Dialog menus to handle installation of extra apps, devel, games, wrappers...
- In Wrappers: choice between Chromium.app and Firefox.app
- New app in devel: Emacs built '--with-ns' build arg.
- New apps in Extra: Affiche, Cenon, Zipper. DictionaryReader (from etoile) replaces Dictionary (from GSDE). Preview replaces ImageViewer.
### Changes of the 0.9.8 release

- Updater: fixing sudo issues with Updater notifications witin 5c5 flavour. New wrapper: Upgrade.app.
- GWorkspace: Patch to fix L18N issue of 'Downloads' folder in Franch context.
- New way to install wrappers (first stage. To be continued) 
- Misc: updating deps list.

### Changes of the 0.9.7 release

- Using 'gnustep-config' and 'GNUstep.conf' to retrieve GNUstep env.
- AGNOSTEP theme now reached 0.5 stable release.

### Changes of the 0.9.6 release

- Cleaning obsolete things.

### Changes of the 0.9.5 release

Some issues fixed: better integration of agnostep-theme: dockapp 'wminfo' will install now within 'c5c' flavour of the theme.

### Changes of the 0.9.4 release

The new 0.9.4 release introduces a major change: now the theme will be available on its own at [agnostep-theme](https://github.com/pcardona/agnostep-theme).
The new theme will also provide two flavours: 'conky' and 'c5c': see the them site to know more about this.
Of course, AGNoStep Desktop will provide an integrated way of smoothly install it within the Desktop.
The User may also choose to not install the theme: so the default theme would be GNUstep, not AGNOSTEP.

Also new apps are available. See below the detailed list.

### Changes of the 0.9.3 release

Since 0.9.3 release, AGNoStep should run on all possible hardware, comprising all the Raspberry Pi's
known to work previously on the PiSiN project, mutatis mutandis. 
See the [HCL](HCL) file to know how to report a successful installation on your hardware.


## Removed

- Rpinters.app: obsolete

## INFO

- We started from the release 0.8.3 and then 0.8.6 of PiSiN to make it agnostic. Many changes in the meanwhile.
