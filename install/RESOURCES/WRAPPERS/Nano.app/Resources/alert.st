| app |

Environment loadModule:'AppKit'.

app := NSApplication sharedApplication.

app runAlertPanelWithTitle: 'Caution!'
                   message: 'Nano is already running. You must close the opened buffer.'
             defaultButton: 'OK'
           alternateButton: nil
               otherButton: nil.

