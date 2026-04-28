You need some dockapps and some docked GNUstep apps to run within the Deamon (Clip) of WindowMaker at the top side:

Description from left to right:

- Default Clip icon

- Date and Weather temperature are provided by Meteo.app.
Command:
	$GNUSTEP_SYSTEM_TOOLS/openapp Meteo

- Clock
Command:
	$GNUSTEP_SYSTEM_TOOLS/openapp AClock

- Uptime, Memory usage are provided by UpMem.
Command:
	$GNUSTEP_SYSTEM_TOOLS/openapp UpMem

- CPU monitoring is provided by Timon (an app ported from OPENSTEP to GNUstep)
	$GNUSTEP_SYSTEM_TOOLS/openapp TimeMon

- Network activity is monitored by wmnd
Command:
	wmnd

- Debian System Updater notification is provided by Updater.app
Command:
	$GNUSTEP_SYSTEM_TOOLS/openapp Birthday

- Birthday/Feast notification is provided by Birthday.app

- Mounting/Unmouting removable media is provided by the interactive wmudmount dockapp
Command:
	wmudmount

INSTALL: see 'install_dockapps.sh' in the current folder and in each APPS subfolder.
