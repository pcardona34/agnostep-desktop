| app |

Environment loadModule:'AppKit'.

app := NSApplication sharedApplication.

app runAlertPanelWithTitle: 'Recovering'
                   message: 'Main agnostep-desktop Folder was repaired. Try again.'
             defaultButton: 'OK'
           alternateButton: nil
               otherButton: nil.

