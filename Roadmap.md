# The way to do it
[x] Porting PiSiN Desktop to an agnostic installation process means to better clarify and dispatch the steps:
[x] 1) Setting the tools and the environment to build. Make them agnostic: no test about arch nor model.
[x] 2) Installing the Window Manager;
[x] 3) Installing the Core GNUstep (until now with GNU runtime);
[X] 4) Installing the Frameworks;
[x] 5) Installing the apps, the extra apps, the devel apps and the games;
    - [ ] Subtask: a better Web Browser wrapper to handle openURL service. Or just add this service?
[x] 6) Installing the wrappers for non-GNUstep applications
    - [x] Subtask: Testing/substituing specific tools like *rpinters* (setting the default printer) - *rpi-imager* (creating bootable image) - Now a test permit to install those only on RPI SBC.
[x] 7) Installing the Desktop tools like *conky*, *dunst*, *Updater*, *BirthNotify* for all the users; the resources like the wallpaper;
    - [x] Subtask: changing the path of some tools to `/usr/local/bin` (no more `~/.local/bin`)
    - [x] AGNoStep-Art: a new wallpaper (without Pi ref) and new bannieres for the Help documents.
    - [x] Installing the walpaper in '/usr/share/wallpapers';
[ ] 8) Installing the Themes of the Window Manager and of GNUstep for all the users; Still in the Home Directory
[x] 9) Setting the user home directory and namely the chosen themes for each user.
    - [x] Subtask: updating some illustrations of the help files.
[x] 10) Making tests:
    - [x] For each step
    - [x] For the global 'enjoy.sh' installer script.
[x] 11) Installing the Display Manager (lightdm).

---

[x] Review all the above to permit a single project (AGNoStep, of course) to handle all the case, comprising RPI machines.