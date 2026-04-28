# AGNoStep Desktop

## Developer or Contributor Tests protocol

> [!NOTE]
> To report a successfull test on a new hardware, please report to us the following steps.

### First Core Installation on a fresh SD-card (Pi Systems) or bootkey, step by step

> [!TIP]
> A point before a slash means that the command or the script is executed from the current (.) directory.

1. Run AGNostepManager to get the main menu:

      ```console
	  cd ~/SOURCES/agnostep-desktop
      ./agnostep.sh
      ```

1. Execute item: **Core Desktop** (i.e.: prep - wmaker - GNUstep - Frameworks)
1. Execute item: **Core Apps** (i.e.: first install of Core Apps)
1. Execute item **Settings** (i.e.: installing a theme, setting Weather Station, Wallpaper, choosing a menu style...)

### Clip, Dock and System Infos

1. Load the the Desktop within the default graphic session:

      ```console
      cd
	  startx
      ```

1. Check **Dunst notifications**: you shall see at last:
   >  Desktop is launching...
1. Check Window Manager and Workspace: **wmaker** and **GWorkspace** are launching; also **SimpleAgenda**.
1. Theming: check expected Wallpaper...
1. Theming: check expected menu and windows **colors**: see Screenshots...
1. Check customized **Clip icon**.
1. Infos are provided by dockapps attached to the **Clip**, at the **top center**, namely:
  1. Detailed Sysinfo: Date and weather temperature
  1. Detailed Sysinfo: Time (AClock)
  1. Detailed Sysinfo: Uptime and Memory usage
  1. Detailed Sysinfo: CPU usage (TimeMon)
  1. Detailed Sysinfo: Network monitoring (wmnd)
  1. Detailed Sysinfo: Updater status (badge)
  1. Detailed Sysinfo: Birthday/Feast status (badge) 
  1. Detailed Sysinfo: Storage (provided by wmudmount)

Also within the Clip:
- OpenDisk (not autolaunched)
- Launcher (not autolaunched)

1. **Dock** position: WMDock at the **top-right border**.
1. Dock appicons: WPrefs (GNUstep icon), SimpleAgenda, Terminal, Ink, GNUMail, ScreenLock, Pass, Mixer, Recycler.
1. **Recycler** has only one icon, **docked**. The app is already launched.
1. Dock: try to launch each app - apart Recycler - using **double click** from its Docked AppIcon. Do not setup GNUmail now: chose 'Cancel'.
1. **Menus**: expected style: vertical (i.e.: **NeXT**)
1. Clock: is themed with AGNOSTEP theme.
1. TimeMon: is themed (no blue circles...) with AGNOSTEP theme.
1. Battery: if a laptop, **batmon** dockapp is launched on the Clip.  
If not a laptop, ignore this item in the final count.
1. Birthday or Feast: change the date of Glinglin's Feast to create this event today:

      ```console
	  nano ~/Documents/Private/Birthdays
      ```

1. Menu of GWorkspace: choose command `Logout` the whole X session is closed: you return to 'tty1' console.
1. Start X again: `startx`: content must change: a badge is displayed.
1. Birthday or Feast: change the Glinglin's event: substitute `bd` key word `st`. Keep the date today. Logout to the tty. Start X session again: 59) Birthday: Now, the persistent notification has a 'Birthday Cake' as icon...

### Wallpaper

In AgnostepManager, choose **Theming**, then AGNOSTEP theme...

- Wallpaper: select **random** wallpaper from the WINTER collection.
- Restart the X session...

1. Theming: expected Wallpaper:  one **randomly** from the chosen collection.
1. Log out and log in again: the wallpaper should change. If the same, as it is random, try again.
1. As you already changed the date of Glinglin to create this event today in `~/Documents/Private/Birthdays`, you should now see the event detail has changed from the menu of Birthaday.app.

#### Home SubFolders and Applications

1. **Home Folders**: names localized: (English list is):
   - Books,
   - Bookshelf (only on RPIs)
   - Desktop,
   - Documents
   - Downloads
   - Favorites
   - GNUstep
   - Images
   - Music,
   - Samples,
   - SOURCES,
   - Videos.
1. Home Folders: all the above folders are decorated: i.e. a customized Icon on each folder: see Screenshots.
1. Applications: double click on the Launcher Icon app: it opens `/Local/Applications` in a new FileViewer.
1. Typing a fist-letter (with Shift pressed) should move the selection to the firt app begining with this letter.
1. Applications Core list[^1]
   - AClock,
   - AddressManager,
   - AgnostepManager,
   - batmon,
   - Birthday,
   - Dico,
   - Firefox | Chromium,
   - GNUMail,
   - GWorkspace,
   - HelpViewer,
   - Ink,
   - Launcher,
   - MDFinder,
   - Meteo,
   - Mixer,
   - Nano,
   - OpenDisk,
   - Pass,
   - Printer,
   - Recycler
   - Rpi-imager (on RPIs only)
   - SaveLink,
   - ScreenLock,
   - SimpleAgenda,
   - Sound,
   - SystemPreferences,
   - Terminal,
   - TimeMon,
   - Updater,
   - UpMem,
   - Xpdf

[^1]: Do not worry about others auto-installed apps like MDFinder, GSMarkup..., GSSpeechServer.

1. Applications: Iconset (papirus inspired) has been applied.
1. Whith `AgnostepManager`, let add some new apps from the **Extra** category (two or more).
1. Chech they have been added to the `Applications` folder.
1. Whith `AgnostepManager`, let add some new apps from the **Devel** category (two or more).
1. Check related Devel apps have been added.
1. Whith `AgnostepManager`, let add some new games from the **Games** category (two or more): let say Chess and NeXTGo.
1. Check those games were added too.
1. Testing Chess: check fluidity of the game.
1. Adding some new apps from **Utilities**: check these apps.
1. Adding some wrappers: choose a different Web Browser... Check it has replaced the previous choice.
1. Log out and log in again to test if the theme applied to the freshly installed applications.
1. Log out and select **Theming** from **AgnostepManager**. Log in again: check the subfolders of `Applications` have been themed with their customized icon.
1. Open the **TabbedShelf**: click on the desktop, then `CMD+s`: customize **categories** tabs: by example, add Devel, Utilities, Games... And drag icons from the Applications folder on the selected tab...
1. Close the TabbedShelf (CMD+s). Open it again. See if things were saved.
1. If upgradables packages are available (see a badge on the Updater Icon): run from its menu: `List upgrades` and then perform an upgrade. If not, try another day...

### Printing and scanning

1. Printing: set default printer using Cups from `Printer.app`: read its provided help too. 

> [!IMPORTANT]
> You must select and then declare your printer as the "Default Server" within CUPS: otherwise, printing will fail with a GNUstep application. 

1. Create and save a document with Ink: open it again: the Open/save Panel must provide a functioning home shortcut.
1. Print previous RTF file document from Ink 'Print' menu: select you printer and perform the print.
1. Create a PDF export of the previous document.
1. Open the PDF document with the 'XPdf' wrapper.
1. Print the PDF document.

### Firefox theming / OpenURL Service

1. Theming and profile of **Firefox**; DuckDuckGo as default Search Engine. Some favorites (bookmarks) are available in the Favorite Folder.
1. OpenURL service: try open a web browser window from a text link selected (from Ink); the same with a link clicked from a message within GNUMail (to done when GNUMail will be set up). If the test fails the first attempt, try again. It should work then.
1. Scanning (with ScanImage): install `ScanImage` from the **Utilities**. Detect hardware, perform scan, open and save the Document(You must install Preview.app first).
1. ScreenLock: read the Help, then lock and inlock the screen.
1. Screensaver: install InnerSpace from **Utilities**, then open, then run and quit the app from its menu.

### Removable device

> [!CAUTION]
> You DO NOT need anymore to edit /etc/fstab.
> Because we use now `libudisks2`. Read Help from **OpenDisk** app.

1. Do not yet display the desktop of GWorkspace.
1. Removable devices: plug an USB thumb and mount it with `wmudmount`[^2]. 
1. Run then `OpenDisk`: menu `Open Media Folder...`
1. Open the mounted device with its icon and browse its content.
1. Close the FileViewer window.
1. Eject it using `wmudmount`, then unplug it.

1. Now, show the Desktop of GWorkspace.
1. Plug an USB thumb and mount it with `wmudmount`[^2]. 
1. The device icon must show on the desktop.
1. Drag the removable device on the Recycler desktop icon: it should be unmounted.
1. Eject it using `wmudmount`, then unplug it.

### Multimedia

1. On RPI: fix Alsa Mixer issue as explained in the Help of **Sound.app**.
1. Install `Cynthiune` from **Extra** apps.
1. Listen to music with `Cynthiune`: 'mp3' and 'ogg' samples (see `~/Samples` folder)
1. Set the sound level with `VolumeControl`: using **PCM** chanel.
1. From **Sound** menu, execute `Test Sound`: you should ear cuckoo.wav.
1. Install `Player` from **Extra** apps.
1. Watch a video with `Player`: see again in `~/Samples` folder 'mp4' and 'mkv' files.

### Theming Wrappers

1. Install `Writer.app` from **wrappers**.
1. Logout to a tty and run `Theming` from `AgnostepManager`. Choose AGNOSTEP theme.
1. Log in back. Open `Writer.app`: check if the Theme was applied.
1. Open `Nano.app`: the XTerm must be themed.

### Unset the theme

1. Log out and log in a TTY. There run `agnostep --am`.
1. Choose **Theming** item.
1. When asked to apply the default theme, answer **No**.
1. When **Theming** has finished, log out, back in and execute: `startx`.
1. The default GNUstep theme should apply: check it for the Home folders icons and in the `Applications` folder.

### Managing Persons and Events

1. Open `AddressManager`: create a Person with a Birthday today. Quit and confirm to save the database.
1. Open `SimpleAgenda`: a violet Birthday event should be shown.
1. Create a feast event today: a Yellow event should be shown.
1. SimpleAgenda: set Alarm preferences to use to DBus Desktop Notification.
1. Create and save an event with an alarm. Wait. You should see then a Dunster notification:
   > Test alarm Reminder... 

### Display Manager

1. Log out and select **DM** from the main menu of **AgnostepManager**
1. Display Manager (LightDM): it will reboot into Graphical env.
1. Display Manager (LightDM): is themed (wallpaper of the last default theme chosen) 
1. Display Manager (LightDM): restart the computer
1. Login from Display Manager
1. Display Manager (LightDM): shutdown the computer.

### agnostep cli command

1. Open a new shell in `Terminal`.
1. Execute:

      ```console
	  agnostep --info
      ```
	
1. You should see infos on the Agnostep release.
1. Execute:

      ```console
	  agnostep --am
	  ```

1. You should see the main menu of **AgnostepManager**.

### AgnostepManager auto-repair

1. Remove the `SOURCES` folder:

      ```console
      cd
      rm -fr SOURCES
      ```

1. Try to run `Applications / AgnostepManager.app`:

      ```console
      openapp AgnostepManager
      ```

1. An Alert Panel will inform you that `AgnostepManager` will try to recover itself. Close the panel.
1. A second Alert will invite you to try again.
1. Run again `AgnostepManager`:

      ```console
      openapp AgnostepManager
      ```
1. The main menu should be available now.
