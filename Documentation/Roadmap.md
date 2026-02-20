## Porting PISIN to AGNoStep Desktop

- [x] Porting PiSiN Desktop to an agnostic installation process means to better clarify and dispatch the steps:
- [x] 1) Setting the tools and the environment to build. Make them agnostic: no test about arch nor model.
- [x] 2) Installing the Window Manager;
- [x] 3) Installing the Core GNUstep (until now with GNU runtime);
- [x] 4) Installing the Frameworks;
- [x] 5) Installing the apps, the extra apps, the devel apps and the games;
    - [x] Subtask: a better Web Browser wrapper to handle openURL service. Or just add this service?
- [x] 6) Installing the wrappers for non-GNUstep applications
    - [x] Subtask: Testing/substituing specific tools like default printer settings. 
    - [x] *rpi-imager* (creating bootable image) - Now a test permit to install those only on RPI SBC.
- [x] 7) Installing the Desktop tools like *conky*, *dunst*, *Updater*, *BirthNotify* for all the users; the resources like the wallpaper;
    - [x] Subtask: changing the path of some tools to `/usr/local/bin` (no more `~/.local/bin`)
    - [x] AGNoStep-Art: a new wallpaper (without Pi ref) and new bannieres for the Help documents.
    - [x] Installing the walpaper in '/usr/share/wallpapers';
- [x] 8) Keeping the Themes of the Window Manager and in the Home Directory, because it is a matter of choice.
- [x] 9) Setting the user home directory and namely the chosen themes for each user.
    - [x] Subtask: updating some illustrations of the help files.
- [x] 10) Making tests:
    - [x] For each step
    - [x] For the global 'enjoy.sh' installer script.
- [x] 11) Installing the Display Manager (lightdm).

---

- [x] Review all the above to allow a single project (AGNoStep, of course) to handle all the case, comprising RPI machines.

---

- [x] Separate main Core Desktop and AGNOSTEP Theme: done
  - [x] AGNoStep became AGNosStep-desktop (this repo).
  - [x] [AGNOSTEP-theme](https://github.com/pcardona34/agnostep-theme) (name capitalized) became the new Theme project manager. 


## Translation

The whole desktop and apps mut be localized:
- [ ] See [L18N](L18N.md) file to follow this work in progress.

## Help

- [x] AGNostep User Guide
- [x] GWorkspace User Guide
- [x] Rework all git repo documentation
- [ ] Other apps...: wait until HelpViewer specs will be finalized.

## Testing

- [x] All tests with a fresh install on a Pi 400.
- [x] All tests with a fresh install on a Pi 500.
- [x] All tests with a new amd-64 Debian iso.
- [x] All tests with an Intel MacBook.

## Create and publish a Release

- [x] SOURCE stable release: 1.0.0 RC 4.3

> [!WARNING]
> Due to limitation size, I cannot publish ISOs nor SD-Card images on Github.

## Better wrappers with GNUstep menus

- [ ] Use NSTask to handle UNIX commands within GNUstep apps: until now, I failed to accomplish this.
- [ ] Provide all the XApp wrappers a GNUstep menu: same  as above.
- [ ] Target: see Xapps Wrappers.
- [ ] Handle scaling privileges (Xsudo?): until now, using `xterm -e command` and type password in the Xterm.

## Porting Application Manager and AGNOSTEP-theme

- [ ] Other projects to target? (NeXTSpace? GSDE? Gershwin-Desktop? ...)

## Universal Package for Installer

The idea is to propose an Universal way of installing a GNUstep app...

- [ ] Exchange with GNUstep community (all the projects to be concerned)
- [ ] Specs
- [ ] First Universal Package
- [ ] Adapt Installer.app to handle those UPs.

## A new Web Browser integrated within GNUstep

> [!NOTE]
> The community seems to wait for the [Laybug](https://ladybird.org/) project to accomplish: Alpha tagetted in 2026.

In the meanwhile, maybe using [Surf](https://surf.suckless.org/) with Xembed?
- [ ] Try to adapt existing projects (NetSurf, GS-WebBrowser...) with Surf as Web Engine?
