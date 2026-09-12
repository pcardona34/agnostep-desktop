/*
                GNU GO - the game of Go (Wei-Chi)
                Version 1.1   last revised 3-1-89
           Copyright (C) Free Software Foundation, Inc.
                      written by Man L. Li
                      modified by Wayne Iba
                    documented by Bob Webber
                    NeXT version by John Neil
*/
/*
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation - version 1.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License in file COPYING for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

Please report any bug/fix, modification, suggestion to

mail address:   Man L. Li
                Dept. of Computer Science
                University of Houston
                4800 Calhoun Road
                Houston, TX 77004

e-mail address: manli@cs.uh.edu         (Internet)
                coscgbn@uhvax1.bitnet   (BITNET)
                70070,404               (CompuServe)

For the NeXT version, please report any bug/fix, modification, suggestion to

mail address:   John Neil
                Mathematics Department
                Portland State University
                PO Box 751
                Portland, OR  97207

e-mail address: neil@math.mth.pdx.edu  (Internet)
                neil@psuorvm.bitnet    (BITNET)
*/


#import "Controller.h"
#import "GoServer.h"

@implementation Controller

- init {

    id key;

    NSEnumerator *enumerator;

    [super init];

    myGoServers  = [[NSMutableDictionary dictionaryWithDictionary:[ [NSUserDefaults standardUserDefaults] dictionaryForKey:@"GoServers"] ] retain];

    enumerator = [myGoServers keyEnumerator];

    while ((key = [enumerator nextObject])) {
        id aGoServer = [myGoServers objectForKey:key];
        [myGoServers setObject:[ [ [ [GoServer alloc] init] initFromString:aGoServer] retain] forKey:key];
    }

    [myGoServers retain];
    
    return self;
}

- (void)awakeFromNib  {

    [GoServerSelectionList setDataSource:self];
    [GoServerSelectionList setDelegate:self];
    [GoServerSelectionList sizeLastColumnToFit];

    [GoServerSelectionList setDoubleAction:@selector(connectToServer:)];

}

- openGoServer:sender  {
    [GoServerSelectionPanel makeKeyAndOrderFront:self];
    return self;
}

- connect:sender {
    NSString *key = [[NSString alloc] initWithFormat:@"%@%d",@"Server", [GoServerSelectionList selectedRow]];
    GoServer *server = (GoServer *)[myGoServers objectForKey:key];
    [LoginDefinition setTitle:[server serverName]];
    [ServerLogin setStringValue:[server login]];
    [ServerPassword setStringValue:[server password]];
    [ServerPort setIntValue:[server port]];
    [ServerPort selectText:self];
	
    [LoginDefinition makeKeyAndOrderFront:self];

    return self;
}

- connectToServer:sender {
    NSString *key = [[NSString alloc] initWithFormat:@"%@%d",@"Server", [GoServerSelectionList selectedRow]];
    GoServer *server = (GoServer *)[myGoServers objectForKey:key];
    if ([sender isMemberOfClass:[NSButton class]]) {
	[server setLogin:[ServerLogin stringValue] ];
	[server setPassword:[ServerPassword stringValue] ];
	[server setPort:[ServerPort intValue] ];
        [myGoServers setObject:server forKey:key];
    }
				/* sender is NSTableView   */
				/* so server is yet initialized */
    [GoServerSelectionPanel orderOut:self];
    [LoginDefinition orderOut:self];
    [GoApplication connect:server];
	
    return self;	
}

- remove:sender {
    id anObject;
    int i, numberOfGoServers;
    NSString *key;
    numberOfGoServers = [myGoServers count];
    key = [[NSString alloc] initWithFormat:@"%@%d",@"Server", [GoServerSelectionList selectedRow]];
    [myGoServers removeObjectForKey:key ];
    for (i = [GoServerSelectionList selectedRow]+1; i < numberOfGoServers;i++) {
        [key release];
        key = [[NSString alloc] initWithFormat:@"%@%d",@"Server", i];
        anObject = [myGoServers objectForKey:key];
        [myGoServers removeObjectForKey:key ];
        [key release];
        key = [[NSString alloc] initWithFormat:@"%@%d",@"Server", i-1];
        [myGoServers setObject:anObject forKey:key];
    }
    [GoServerSelectionList reloadData];
    [key release];
    return self;
}

- add:sender {
    NSString *key;
    id newServer;
    if (0 == [ [GoServerName stringValue] length]) {
        return self;
    }
    key = [[NSString alloc] initWithFormat:@"%@%d",@"Server", [myGoServers count]];
    newServer = [ [GoServer alloc] init];
    [newServer setServerName:[GoServerName stringValue] ];
    [GoServerName setStringValue:@""];

    [myGoServers setObject:newServer forKey:key];
    [GoServerSelectionList reloadData];
    return self;
}

/* NSTableView data source methods */

- (int)numberOfRowsInTableView:(NSTableView *)theTableView
{
    return [myGoServers count];
}

- (id)tableView:(NSTableView *)theTableView
      objectValueForTableColumn:(NSTableColumn *)theColumn
            row:(int)rowIndex
{
    NSString *key = [[NSString alloc] initWithFormat:@"%@%d",@"Server", rowIndex];
    if ([[theColumn identifier] intValue]==0) 
        // only the names should be displayed
        return [ [ [NSString stringWithString:[ [myGoServers objectForKey:key] login]] stringByAppendingString:@"@"] stringByAppendingString:[ [myGoServers objectForKey:key] serverName]];
    else
        return nil;
}
      
@end

@implementation Controller(ApplicationDelegate)

- (BOOL)applicationShouldTerminate:(id)sender {

    id key;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSEnumerator *enumerator = [myGoServers keyEnumerator];

    while ((key = [enumerator nextObject])) {
        id aGoServer = [myGoServers objectForKey:key];
        [myGoServers setObject:[aGoServer dumpToString] forKey:key];
    }

    [defaults setObject:myGoServers forKey:@"GoServers"];

    [defaults synchronize];

    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [GoApplication applicationDidFinishLaunching:notification];
}

@end
