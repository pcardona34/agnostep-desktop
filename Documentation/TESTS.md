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

### Serie CLANEXDEF

- Choose one flavour, let say:
  - Flavour: **Classic**
  - Style menu: **NeXT**
  - Wallpaper: **default theme wallpaper** (means: answer 'No' to the question 'Rotate wallpaper?').

1. Load the the Desktop within the default graphic session:

      ```console
      cd
	  startx
      ```

1. Check **Dunst notifications**: you shall see at last:
   >  Desktop is launching...
1. Check Window Manager and Workspace: **wmaker** and **GWorkspace** are launching; also **SimpleAgenda**.
1. Theming: check expected Wallpaper: i.e. **Curves**.
1. Theming: check expected menu and windows **colors**: see Screenshots...
1. Check customized **Clip icon**.
1. Infos are provided by dockapps attached to the **Clip**, at the **top center**, namely:
  1. Detailed Sysinfo: Date
  1. Detailed Sysinfo: Weather temperature
  1. Detailed Sysinfo: Time (AClock)
  1. Detailed Sysinfo: Uptime
  1. Detailed Sysinfo: Memory usage (bar if greater than 20% and percent)
  1. Detailed Sysinfo: CPU usage (TimeMon)
  1. Detailed Sysinfo: Network monitoring (wmnd)
  1. Detailed Sysinfo: Updater status
  1. Detailed Sysinfo: Birthday/Feast status (under the date)
  1. Detailed Sysinfo: Storage bar (provided by wmudmount)

1. **Dock** position: WMDock at the **top-right border**.
1. Dock appicons: WPrefs (GNUstep icon), SimpleAgenda, Terminal, Ink, GNUMail, InnerSpace, Recycler.
1. **Recycler** has only one icon, **docked**. The app is already launched.
1. Dock: try to launch each app - apart Recycler - using **one click** from its Docked AppIcon. Do not setup GNUmail now: chose 'Cancel'.
1. **Menus**: expected style: vertical (i.e.: **NeXT**)
1. Clock: is themed.
1. TimeMon: is themed (no blue circles...)
1. Battery: if a laptop, **batmon** dockapp is launched on the Clip.  
If not a laptop, ignore this item in the final count.
1. Birthday or Feast: change the date of Glinglin's Feast to create this event today:

      ```console
	  nano ~/Documents/Private/Birthdays
      ```

1. Menu of GWorkspace: choose command `Logout` the whole X session is closed: you return to 'tty1' console.
1. Start X again: `startx`: content must change under the date : a memo about Glinglin feast must be shown.

### Serie CONMACDEF

1. Log out. Then choose again **Settings** from the main menu of **AgnostepManager**:
   - Flavour: **Conky**
   - Menus Style: **Mac**
   - Wallpaper: **default** wallpaper.
   - Then launch the X session: `startx`...
1. **Dunst notification**: you shall see at last:
   > Desktop is launching...
1. **Updater status**: it is another notification provided at startup after the previous Loading notification.
1. Due to the change in 'Birthdays' file, a persitent notification **with a bell icon** must arise like this:
   > Today, we celebrate Glinglin" 
1. Theming: expected **Wallpaper**: **cubes**.
1. Menus: expected style: horizontal (**Mac**)
1. SysInfo **Conky Panel** must be avaiable on the **right border** and Sys Infos are provided by conky applets, namely:
1. Detailed Sysinfo: Date, Time.
1. Detailed Sysinfo: Debian main release info.
1. Detailed Sysinfo: Uptime
1. Detailed Sysinfo: Weathers infos: temperature, wind, rain, snow.
1. Detailed Sysinfo: CPU usage: freq. and percent.
1. Detailed Sysinfo: Memory usage (bar and percent)
1. Detailed Sysinfo: Storage: bar and percent)
1. Detailed Sysinfo: Network monitoring: IP, Up, Sent, Down, Received.
1. Dock position: GWorkspace own Dock at the left. Style is 'modern'.
1. Dock icons: GWorkspace, Ink, SimpleAgenda, Terminal, GNUMail, InnerSpace (...) Recycler.
1. **Recycler**: only the docked icon must be shown at the bottom of the Dock. You should not find any other instance of the Recycler, nor as a miniwindow nor as a icon on the Desktop.
1. Dock: try to launch each app not yet launched (with underlined icon with dots '...'). Again do not setup GNUmail.
1. Recycler: create a file. Drag its icon to the Recycler Icon. It should change its aspect.
1. Recycler: from the GWorkspace `File` menu, choose item: `Empty Recycler`: the Recycler Icon must revert to its previous state.
1. Battery: if a laptop, battery monitoring is showing on Conky Panel.  
If not a laptop, ignore this item in the final count.
1. Birthday or Feast: change the Glinglin's event: substitute `bd` key word `st`. Keep the date today. Logout to the tty. Start X session again: 59) Birthday: Now, the persistent notification has a 'Birthday Cake' as icon...

### Serie CLAMACRAN

- Log out to the tty, and run again **AgnostepManager**, then the **settings** item:
  - Flavour: **Classic**
  - Menus style: **Mac**
  - Wallpaper: select **random** wallpaper from the WINTER collection.
- Start the X session...

1. Check menu style : Mac.
1. The **Clip** (WMClip) is at the **bottom center**.
1. GWorkspace's Icon is attached to the left of the Clip.
1. Theming: expected Wallpaper:  one **randomly** from the chosen collection.
1. Log out and log in again: the wallpaper should change. If the same, as it is random, try again.
1. The Dock is at the middle-right border.
1. Only one Recycler icon.
1. As you already changed the date of Glinglin to create this event today in `~/Documents/Private/Birthdays`, you should now see the Color has changed: **orange**.

### Serie CONNEXRAN

- Log out to the tty, and run again **AgnostepManager**, then the **settings** item:
  - Flavour: **Conky**
  - Menus style: **NeXT**
  - Wallpaper: select **random** wallpaper from the WINTER collection.
- Start the X session...

1. Check menu style : NeXT.
1. The **Dock** of GWorkspace is at the **middel-left border**: modern style.
1. Theming: expected Wallpaper:  one **randomly** from the chosen collection.
1. Only one Recycler icon, docked.

### Home SubFolders and Applications

> [!NOTE]
> The following serie of tests does not depend on the flavour nor on the menu style.

1. **Home Folders**: names localized: (English list is):
   - Books,
   - Bookshelf (only on RPIs)
   - Desktop,
   - Documents
   - Downloads
   - Favorites
   - GNUstep
   - Help
   - Images
   - Music,
   - Samples,
   - SOURCES,
   - Videos.
1. Home Folders: all the above folders are decorated: i.e. a customized Icon on each folder: see Screenshots.
1. **Applications**: you must have an Icon shortcut on the **Shelf** of the FileViewer.
1. Applications: click on the Shelf icon opens `/Local/Applications`
1. Applications Core list[^1]
   - AClock,
   - AddressManager,
   - batmon,
   - Firefox | Chromium,
   - GNUMail,
   - GWorkspace,
   - Ink,
   - InnerSpace,
   - Innerspace,
   - SimpleAgenda,
   - SystemPreferences,
   - Terminal,
   - TimeMon,
   - VolumeControl.

[^1]: Do not worry about others auto-installed apps like Recycler, MDFinder, GSMarkup..., GSSpeechServer.

1. Applications: `Utilities` subfolder has been created. It has:
   - AgnostepManager
   - Nano,
   - Printer,
   - Rpi-imager (on RPIs only)
   - Upgrade.
1. Applications: Iconset (papirus inspired) has been applied.
1. Whith `AgnostepManager`, let add some new apps from the **Extra** category (two or more).
1. Chech they have been added to the `Applications` folder.
1. Whith `AgnostepManager`, let add some new apps from the **Devel** category (two or more).
1. Check that the subfolder `Dev` has been created. And related Devel apps added in this subfolder.
1. Whith `AgnostepManager`, let add some new games from the **Games** category (two or more): let say Chess and NeXTGo.
1. Check those games were added to the expected subfolder.
1. Testing Chess: check fluidity of the game.
1. Adding some new apps from **Utilities**: these apps must be in this subfolder.
1. Adding some wrappers: choose a different Web Browser... Check it has replaced the previous choice.
1. Log out and log in again to test if the theme applied to the freshly installed applications.
1. Log out and select **Settings** from **AgnostepManager**. Log in again: check the subfolders of `Applications` have been themed with their customized icon.
1. Open the **TabbedShelf**: click on the desktop, then `CMD+s`: check **categories** tabs: Devel, Utilities, Games.
1. The content of each tab will depend on the applications you have installed. DND some app. Close the TabbedShelf (CMD+s). Open it again. See if things were saved.
1. If upgradables packages are available: run `Utilities/Upgrade.app` wrapper to upgrade the packages of the Debian system. If not, try another day...

### Printing and scanning

1. Printing: set default printer using Cups from `Utilities/Printer.app` wrapper: see 'Agnostep_English.help' in the `Help` folder: **chap. Printing**. 

> [!IMPORTANT]
> You must select and then declare your printer as the "Default Server" within CUPS: otherwise, printing will fail with a GNUstep application. 

1. Create and save a document with Ink: open it again: the Open/save Panel must provide a functioning home shortcut.
1. Print previous RTF file document from Ink 'Print' menu: select you printer and perform the print.

### Firefox theming / OpenURL Service

1. Theming and profile of **Firefox**; DuckDuckGo as default Search Engine. The favorites (bookmarks) will be available in the Favorite Folder (to be done).
1. OpenURL service: try open a web browser window from a text link selected (from Ink); the same with a link clicked from a message within GNUMail (to done when GNUMail will be set up). If the test fails the first attempt, try again. It should work then.
1. Scanning (with ScanImage): install `ScanImage` from the **Utilities**. Detect hardware, perform scan, open and save the Document.
1. Screensaver (InnerSpace): open, then run and quit the app from its menu.

### Removable device

> [!CAUTION]
> Unlike what I wrote about editing `/etc/fstab`, you DO NOT need anymore to do that because we use
> now `libudisks2`. Help must be updated about this.

1. Removable devices: plug an USB thumb and mount it with `wmudmount`[^2]. The device icon must show on the desktop.
1. Open the mounted device with its icon and browse its content.
1. Close the FileViewer window and DND the removable device on the Recycler desktop icon: it should be unmounted.
1. Eject using `wmudmount`, then unplug it. 

[^2]: Since agnostep-theme 0.9.6, the Conky flavour will also provide wmudmount. If you accidently closedit, open a Terminal and execute `wmudmount &` to open it again.

### Multimedia

1. On RPI: fix Alsa Mixer issue as explained in *Agnotep-Help*: chap. 3 Sound.
1. Install `Cynthiune` from **Extra** apps.
1. Listen to music with `Cynthiune`: 'mp3' and 'ogg' samples (see `~/Samples` folder)
1. Set the sound level with `VolumeControl`: using **PCM** chanel.
1. Open AClock preferences and test the Cuckoo.wav.
1. Install `Player` from **Extra** apps.
1. Watch a video with `Player`: see again in `~/Samples` folder 'mp4' and 'mkv' files.

### Theming Wrappers

1. Install `Writer.app` from **wrappers**.
1. Logout to a tty and run `Settings` from `AgnostepManager`.
1. Log in again. Open `Writer.app`: check if the Theme was applied.
1. Open `Nano.app` in `Utilities`: the XTerm must be themed.

### Unset the theme

1. Log out and log in a TTY. There run `agnostep --am`.
1. Choose **Settings** item.
1. When asked to apply the default theme, answer 'No'.
1. When **Settings** has finished, log out, back in and execute: `startx`.
1. The default GNUstep theme should apply: check it for the Home folders and in the `Applications` folder.

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

1. Try to run `Applications / Utilities / AgnostepManager.app`:

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
