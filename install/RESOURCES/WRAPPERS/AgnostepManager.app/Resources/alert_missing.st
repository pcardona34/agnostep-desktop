| app |

Environment loadModule:'AppKit'.

app := NSApplication sharedApplication.

app runAlertPanelWithTitle: 'Caution!'
                   message: 'Main agnostep-desktop Folder was removed. We try to recover it.'
             defaultButton: 'OK'
           alternateButton: nil
               otherButton: nil.

