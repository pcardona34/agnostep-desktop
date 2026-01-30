# AGNoStep - agnostic GNUstep Desktop

## The Core Apps

These apps are provided with the Core Desktop and installed the first time.

- AClock: a digital clock (shown within the Classic flavour only).
- AddressManager: contacts
- Batmon: Battery monitor (with the Classic flavour and on laptop only)
- GNUMail: Mail User Agent
- GWorkspace: the Workspace manager: see above.
- InnerSpace: screen saver
- MDFinder: builtin GWorkspace indexing
- Recycler: see GWorkspace.
- SimpleAgenda: agenda
- SystemPreferences: to set Time Zone...
- Terminal: a Terminal emulator
- Ink(\*): text editor (RTF and plain text) and note taking
- TimeMon: a CPU monitoring (with the Classic flavour)
- VolumeControl: an ALSA compliant Mixer

### Why Ink and not the classic expected TextEdit? TextEdit 4 has been modified to fit on GSDE. TextEdit 5 (namely from Debian/Salsa sources) was unstable, crashing or frozing the system: we do not want such an app. Instead, Ink revealed to be a good and consistent alternative, with history management available.
 
## Dockapps

Within the Classic flavour only:

- wmnd: Network monitoring
- wmtext: it provides date, weather health, uptime, memory usage, Birthday notification, Debian System Update.
- wmudmount: it helps managing removable medias. 

### Conky Panel

If you choose the Conky flavour, a System infos Panel will provide most of the above monitoring tasks.

### More apps?

Of course, you can add more apps with **AgnostepManager** later. execute:

- Within a TTY console:

````agnostep.sh````

- In the FileViewer Panel, click on the Icon Applications on the Shelf. Open then the **Utilities** folder, select and open **AgnostepManager.app**.

From the menu, choose the category of apps to add.

See respective documents for each category: 

- [EXTRA APPS](./EXTRA_APPS.md)
- [DEVEL ENV](./DEVEL_ENV.md)
- [GAMES](./GAMES.md)
- [UTILITIES](./UTIL.md)
- [WRAPPERS](./WRAPPERS/md)
