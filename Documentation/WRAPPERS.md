# AGNoStep - agnostic GNUstep Desktop

## What are apps wrappers?

Non native GNUstep Applications are used from bundles named 'Wrappers'. By e.g. we wrap 'Firefox-esr' in a wrapper called 'Firefox.app'.

Not only App-wrappers make easy to find and launch an application from the 'Applications' Folder, but still they make services or associate the mime types or file extensions to the app. So the system knows what app to use to open such kind of files.

## Wrappers yet provided by AGNoStep

Use **AgnostepManager** (see `Applications/Utilities` subfolder) and choose **Wrappers** item in the menu.

- Chromium: a wrapper for the Chromium Web Browser: extend with an openURLService.
- EBookReader: a wrapper for FBReader.
- Firefox: a wrapper for the firefox web browser: extend with an openURLService.
- Inkscape: a wrapper for inkscape SVG editor.
- Nano: a Wrapper for the GNU Nano Editor. It handles bash script (\*.sh) patches (\*.patch)
- RPI-imager: only on Pi's SBC.
- ScreenLock: launch the screen locker `xtrlock`.
- Upgrade: an helper to run Debian upgrade. Related to Updater monitor deamon.
- Writer: a wrapper for Focuswriter with an AGNOSTEP theme.

> [!NOTE]
> You will choose Firefox or Chromium. You can ever change it from the same menu of AgnostepManager: **Wrappers**...

## Removed

- Rpinters.app: obsolete

## More ready wrappers?

In the build folder of GWorkspace, you could find more Wrappers to install. 

### Method: how to install, by e.g. 'LibreOffice' wrapper.

First, be sure that the original app has been installed:

```console
sudo apt -y install libreoffice
```

Then, open a new shell window in 'Terminal' and cd to the root of 'agnostep-desktop' project. Then:
```console
cd build/apps-gworkspace/Apps_wrappers
TARGET=$(gnustep-config --variable=GNUSTEP_LOCAL_APPS)
sudo cp -a LibreOffice.app $TARGET/
make_services
```
That's all. Do the same *mutatis mutandis* for another wrapper.
