# Tests protocol

    To report a successfull test on a new hardware, please report to us the following steps:

First Core Installation on a fresh SD-card (Pi Systems) or bootkey, step by step:

1) AGNostepManager: main menu of installation with `agnostep.sh`
2)  Install stage 1: Core Desktop (prep - wmaker - GNUstep - Frameworks)
3)  Install stage 2: Core apps (first install)
4)  Install stage 3: User settings: installing a theme, setting Weather Station, choosing a menu style...
5)  Testing the Desktop with: `startx`
6)  Install stage 4: Display Manager (LightDM) and reboot into Graphical env
7)  Login from Display Manager
8) Window manager: launching and theming as expected
9) Workspace: launching and theming
10) Dock: WMDock on Classic flavour - GWorkspace own Dock with Conky flavour
11) Default Wallpaper: curves with Classic, Cubes with Conky
12) Random collection wallpaper
13) Home customized: Folders names and Themed Icons
14) Applications Folder with a shortcut Icon on the Shelf
15) Adding some new apps from Extra apps (two or more)
16) Adding Devel env apps
17)  Adding some new games from Games: Chess and NeXTGo.
18)  Testing Chess.
19) Adding some new apps from Utilities
20) Adding some wrappers: choose a Web Browser...
21) Open TabbedShelf and see with Categories tabs
22) Open Applications folder: check subfolders of Categories: Games, Devel, Utilities.
23) Autostart: namely check conky panel: date, weather heat, time, uptime, memory usage, cpu, network...
24) Autostart: Dunst notifications: launching, Birthday or Feast (conky flavour), maybe Updates...
25) Autostart: namely check docked apps with Classic flavour on Clip and Dock: same monitoring infos as above...
26) Sysinfo Panel: if a laptop, battery monitoring is showing
27) Dockapps: if a laptop, batmon is launched.
28) Notify: Updater with action (conky flavour)
29) Colors changing within wmtext: orange for birthday, crimson for upgradable packages: modify the GlinGlin date in the conf file to see changes.
30) Run successfully Upgrade wrapper to update the Debian system: needs upgradable packages available.
31) Open/save Panel with the home shortcut available (Ink)
32) Web Browser and openURL service: text link selected (from Ink), link clicked from a message within GNUMail
33) Printing: set default printer using Cups from 'Printer.app' wrapper; print a RTF file within Ink.
34) Scanning (with ScanImage): detect hardware, perform scan, open and Document.
35) Screensaver (InnerSpace): run and quit.
36) Display Manager (LightDM): login, shutdown, theming.
37) Mount a removable device: with wmudmount in the classic flavour. With `mount` command with Conky flavour.
38) Unmount with DND on the Recycler desktop icon (classic) or on the docked icon (conky)
39) Listening to music (with Cynthiune) and setting the level (with VolumeControl)
40) Watching a video (with Player)
41) Misc. Theming: of FocusWriter
42) Misc. Theming and profile of Firefox with accurate pinned tabs; DuckDuckGo as default Search Engine.
