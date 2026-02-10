# AGNoStep - agnostic GNUstep Desktop

## About dev releases (Beta Status)

All dev release are for my convenience.
Do not use them if you are not a developer understanding the code used.
Do not try nor report any issue until a release is tagged Stable.

## Changes

### Changes of the Release Candidate 1.0.0 - RC 3

This release begins the serie of tests on a x86_64 architecture.
First tests with Qemu/Kvm: bad graphic rendering.
We will move the future tests to virtualbox?

- Dispatched prep and core because prep needs often to log out to apply the new settings.
- Fixed an issue with `lo.sh`: substituted `pkill` to `killall`.
- Added console-setup into prep stage.
- Removed X keyboard hack from 6_user_settings.sh
- Fixed an issue in Firefox wrapper installer: we must use 'esr' release now.

### Changes of the Release Candidate 1.0.0 - RC 2

- Enhanced fetching to avoid a wget fail issue with a more strong fetch function: see install/SCRIPTS/fetcher.sh.
- Propagate the use of fetch there were simple wget use: many scripts concerned.

### Changes of the Release Candidate 1.0.0 - RC 1

This release begins the serie of tests on a pi 500.

- Fixed a path issue in Xorg Hack and moved it to 6_user_settings.sh.
- Removed obsolete code about logs in 6_user_settings.sh.
- Fixed an ambiguous grep on release info. Now right info is written in release.info.
- Updated messages info at the end of user settings.
- Auto-reboot if a pi 500 to apply Xorg Hack.
- Install agnostep CLI: before was done by agnostep-theme, which was inconsistent.

### Changes of the dev release 0.9.9.4 - beta

This release ends the serie of tests on a pi 400.

- AgnostepManager.app: Fixed a path issue in AgnostepManager and in Recover: auto-repair was successfully tested then.

### Changes of the dev release 0.9.9.3 - beta

- Added more tests items: unsetting the theme; listening to cuckoo.
- Added Locales and Timezone settings.
- Added a timer and logout even in a shell script.
- Tweaked better installation presentation with Frameworks and apps.
- Fixed some issues within Frameworks building.

### Changes of the dev release 0.9.9.2 - beta

- Added wrapper Abiword.app
- More grained tests protocol in Documentation/TESTS.md
- Fixed missing dep: 'gv' needed for printing and preview. 

### Changes of the dev release 0.9.9.1 - beta

- Set Firefox profile. Remove -esr.
- Fix path issue reading release from `agnostep` cli tool.
- Add option `--am` to launch 'AgnosteManager' from `agnostep` cli tool.

### Changes of the dev release 0.9.9.0 - beta

This is a main dev release with many changes and improvements:

- Changes to allow new AGNOSTEP-theme feature: wallpaper rotate.
- Changes to comply with the subcategories in the 'Applications' folder.
- Testing and improvements with AgnostepManager, the menu of installation tasks.
- Mostly all the scripts and functions were improved due to heavy testing and to the changes above. Better way to find installed apps, even in subfolders, and cleaner removing too.
- Documentation updated to reflect Applications subcategories, namely new 'Core Apps' and 'Utilities' folder.
- New wrappers: AgnostepManager, Printer, RPI_TOOLS/Rpi-Bookshelf.
- New Resources to handle the case of pi500 and vc4 driver (still to be tested and validated).
- Updating Xresources (XTerm) with no conflict with AGNOSTEP-theme.
- New way to log all the scripts in a single consistent journal in /var/log : see log.sh.
- Better nano config within Nano wrapper to handle more common shortkeys.

### Changes of the dev release 0.9.8.4 - Beta

- Added ftp (fixed webservices fetching issue); fixed conf issue with quilt (solved popplerkit install).

### Changes of the dev release 0.9.8.3 - Beta

- Fixing many issues (typos, path) while testing on new fresh platfom. 

### Changes of the dev release 0.9.8.2 - Beta

- New: main `agnostep.sh` script at the top level to provide a general menu for install core, apps, and so on.
- New: `remove.sh` script to handle removing of a selected app: to be continued.

### Changes of the dev release 0.9.8.1 - Beta

- Fix Service openURL: (to be installed after Firefox wrapper: done)
- New Wrapper: Nano to handle .sh .md .path
- Complete reorganization of stage 5: see 5_install_core_apps.sh
- Bash Dialog menus to handle installation of extra apps, devel, games, wrappers...
- In Wrappers: choice between Chromium.app and Firefox.app
- New app in devel: Emacs built '--with-ns' build arg.
- New apps in Extra: Affiche, Cenon, Zipper. DictionaryReader (from etoile) replaces Dictionary (from GSDE). Preview replaces ImageViewer.

### Changes of the dev release 0.9.8 - Beta

- Updater: fixing sudo issues with Updater notifications witin 5c5 flavour. New wrapper: Upgrade.app.
- GWorkspace: Patch to fix L18N issue of 'Downloads' folder in Franch context.
- New way to install wrappers (first stage. To be continued) 
- Misc: updating deps list.

### Changes of the dev release 0.9.7 - Beta

- Using 'gnustep-config' and 'GNUstep.conf' to retrieve GNUstep env.
- AGNOSTEP theme now reached 0.5 stable release. But will go soon on new Beta to add more features.

### Changes of the dev release 0.9.6

- Cleaning obsolete things.

### Changes of the dev release 0.9.5

Some issues fixed: better integration of agnostep-theme: dockapp 'wminfo' will install now within 'c5c' flavour of the theme.

### Changes of the dev release 0.9.4

The new 0.9.4 release introduces a major change: now the theme will be available on its own at [agnostep-theme](https://github.com/pcardona/agnostep-theme).
The new theme will also provide two flavours: 'conky' and 'c5c': see the them site to know more about this.
Of course, AGNoStep Desktop will provide an integrated way of smoothly install it within the Desktop.
The User may also choose to not install the theme: so the default theme would be GNUstep, not AGNOSTEP.

Also new apps are available. See below the detailed list.

### Changes of the dev relase 0.9.3

Since 0.9.3 release, AGNoStep should run on all possible hardware, comprising all the Raspberry Pi's
known to work previously on the PiSiN project, mutatis mutandis. 
See the [HCL](HCL) file to know how to report a successful installation on your hardware.

## Removed

- Rpinters.app: obsolete

## INFO

- We started from the release 0.8.3 and then 0.8.6 of PiSiN to make it agnostic. Many changes in the meanwhile.
