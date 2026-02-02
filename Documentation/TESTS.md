# Tests protocol

To report a successfull test on a new hardware, please report to us the following steps:

First Core Installation on a fresh SD-card (Pi Systems) or bootkey, step by step:

1) AGNostepManager: shows main menu of installation with `agnostep.sh`
2)  Install stage 1: Core Desktop (prep - wmaker - GNUstep - Frameworks)
3)  Install stage 2: Core apps (first install)
4)  Install stage 3: User settings: installing a theme, setting Weather Station, Wallpaper, choosing a menu style...
5)  Testing the Desktop with: `startx`...
6)  Dunst notifications: you shall see the 'launching' notification, maybe 'Updates' (if available with the conky flavour)
7)  Window manager / Workspace: wmaker and GWorkspace are launching; also SimpleAgenda.
8)  Theming: expected Wallpaper (curves | cubes | one randomly from the chosen collection)
9)  Theming: expected menu and windows colors...
10) Customized clip icon with Classic.
11) SysInfo Panel is available: Conky Panel for Conky flavour; dockapps attached to the Clip for Classic. 
12) Detailed Sysinfo: Date
13) Detailed Sysinfo: City and Heat
14) Detailed Sysinfo: Time
15) Detailed Sysinfo: Uptime
16) Detailed Sysinfo: Memory usage (bar and percent)
17) Detailed Sysinfo: CPU usage
18) Detailed Sysinfo: Network monitoring
19) Detailed Sysinfo: Updater status
20) Detailed Sysinfo: Birthday/Feast status | notification with Conky flavour
21) Detailed Sysinfo: Storage bar
22) Dock position: WMDock at the right border on Classic flavour | GWorkspace own Dock at the left with Conky flavour
23) Dock icons: WPrefs (Classic flavour), SimpleAgenda, Terminal, Ink, GNUMail, InnerSpace, Recycler.
24) Dock: try to launch each app form its Docked Icon. Do not setup GNUmail now.
25) Recycler: at the bottom-right with Classic | docked within the Dock of GWorkspace with Conky flavour
26) Recycler: create a file. Drag its icon to the Recycler Icon. It should changes its aspect.
27) From the GWorkspace `File` menu, choose item: `Empty Recycler`: the Recycler Icon must change.
28) Menus: expected colors
29) Menus: expected style: vertical (NeXT) | horizontal (Mac)
30) Clock: themed
31) TimeMon: themed 
32) Battery: if a laptop, battery monitoring is showing on Conky Panel | batmon dockapp is launched on the Clip.
33) Home Folders: names localized: (English list is):  
Books, Bookshelf (on RPIs), Desktop, Documents, Downloads, Favorites, GNUstep, Help, Images, Music, Samples, SOURCES, Videos.
34) Home Folders:  Customized Icon on each folder
35) Applications: Icon shortcut on the Shelf
36) Applications: click on the Shelf icon opens `/Local/Applications`
37) Applications list: AClock, AddressManager, batmon, Firefox | Chromium, GNUMail, GWorkspace, Ink, InnerSpace, Innerspace, SimpleAgenda, SystemPreferences, Terminal, TimeMon, VolumeControl. Do not worry about others auto-installed like Recycler, MDFinder, GSMarkup..., GSSpeechServer.
38) Applications: `Utilities` subfolder has been created. It has: AgnostepManager, Nano, Printer, Rpi-imager (RPIs only), Upgrade.
39) Applications: Iconset (papirus inspired) has been applied.
40) Adding some new apps from Extra apps (two or more). Successfully added to the `Applications` folder.
41) Adding Devel env apps: subfolder `Dev` has been created. Devel apps added ine this subfolder.
42) Adding some new games from Games: Chess and NeXTGo. `Games` folder has been created. Games added to this subfolder.
43) Testing Chess: check fluidity.
44) Adding some new apps from Utilities
45) Adding some wrappers: choose a different Web Browser... Check it has replaced the previous choice.
46) Choose again **settings** items from AgnostepManager: then check the icon theme applied to the applications freshly installed.
47) Open TabbedShelf (CMD+s) and check categories. The content of each shelf will depend on the applications you have installed. 
48) Logout from GWorkspace menu close the whole X session: return to tty.
49)
50)  Install stage 4: Display Manager (LightDM) and reboot into Graphical env.
51) Display Manager (LightDM): is themed (wallpaper of the theme) 
52) Display Manager (LightDM): restart the computer
53)  Login from Display Manager
54) Updater: if updates are available, Updater notification with action (conky flavour) | Crimson color and number in wmtext with Classic flavour.
55) Birthday or Feast: change the date of Glinglin to create the event in `~/Documents/Private/Birthdays`. Log out and log in again. Color must change within wmtext: orange for birthday.
56) When upgradables packages are available: run successfully: `Utilities/Upgrade` wrapper to upgrade the packages of the Debian system.
57) Create and close a document with Ink: open it again: the Open/save Panel must provide a functioning home shortcut.
58) Web Browser and openURL service: try open a web browser window from a text link selected (from Ink); the same with a link clicked from a message within GNUMail
59) Printing: set default printer using Cups from 'Printer.app' wrapper; print a RTF file within Ink.
60) Scanning (with ScanImage): detect hardware, perform scan, open and save the Document.
61) Screensaver (InnerSpace): run and quit the app from the menu.
62) Modifiy the `/etc/fstab` following the **Help** of the *Agnostep User Guide* (folder: `Documents/Help`) and restart the computer.
63) Plug a removable device and mount it: with `wmudmount` in the classic flavour. With the `mount` command within the Conky flavour. The device icon must show on the desktop. Open it and browse its content.
64) Unmount with DND on the Recycler desktop icon (classic) or on the docked Recycler icon (conky)
65) Listen to music with `Cynthiune` (to be installed from 'Extra'): 'mp3' and 'ogg' samples (see `~/Samples` folder)
66) Set the sound level with `VolumeControl`.
67) Watch a video with `Player` (to be installed from 'Extra'): see again in `~/Samples` folder.
68) Misc. Theming: of FocusWriter: it must be installed first, then run again `settings`.
69) Misc. Theming and profile of Firefox with accurate pinned tab (agnostep-desktop) and favorites: agnostep-desktop, GNUstep, Debian, Raspberry PI...; DuckDuckGo as default Search Engine.
70) Display Manager (LightDM): shutdown the computer.
