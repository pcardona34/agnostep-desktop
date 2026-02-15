| app |

Environment loadModule:'AppKit'.

app := NSApplication sharedApplication.

app runAlertPanelWithTitle: 'Caution!'
                   message: 'Firefox-esr has not been found!'
             defaultButton: 'OK'
           alternateButton: nil
               otherButton: nil.

