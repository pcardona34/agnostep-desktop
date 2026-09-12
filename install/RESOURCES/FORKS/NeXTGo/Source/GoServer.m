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


#import "GoServer.h"

@implementation GoServer

+ (GoServer*)initFromPref:(int)i {
    NSString *buf = [[NSString alloc] initWithFormat:@"%@%d",@"Server", i];
    return [ [NSUserDefaults standardUserDefaults] objectForKey:buf] ;
}

- init {
	name = [ [NSString alloc] init];
	port = 0;
	login = [ [NSString alloc] init];
	password = [ [NSString alloc] init];
	return self;
}

- (GoServer*)initFromString:(NSString*)aString {

    NSString *buf;
    NSArray *listItems = [aString componentsSeparatedByString:@" "];

    if (name) {
        [name release];
        name = 0;
    }
    name = [ [listItems objectAtIndex:0] retain];

    buf = [listItems objectAtIndex:1];
    sscanf([buf cString], "%d", &port);

    if (login) {
        [login release];
        login = 0;
    }
    login = [ [listItems objectAtIndex:2] retain];

    if (password) {
        [password release];
        password = 0;
    }
    password = [ [listItems objectAtIndex:3] retain];

    return self;
}

- (NSString*)dumpToString {
    id portbuf = [ [NSString localizedStringWithFormat:@"%d", port] retain];
    return [ [NSArray arrayWithObjects:name, portbuf, login, password, nil] componentsJoinedByString:@" "];
}
/*
- (void)saveToPref:(int)i {
    NSString *buf = [[NSString alloc] initWithFormat:@"%@%d",@"Server", i];
    [[NSUserDefaults standardUserDefaults] setObject:[self dumpToString] forKey:buf];
}

- (void)removeFromPref:(int)i {
    NSString *buf = [[NSString alloc] initWithFormat:@"%@%d",@"Server", i];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:buf];
}
*/
- (NSString *)serverName {
	return name;
}

- (int) port {
	return port;
}

- (NSString*) login {
	return login;
}

- (NSString*) password {
	return password;
}

- setServerName:(NSString *) aName {
    [name release];
    name = [ [NSString alloc]initWithString:aName];
    return self;
}

- setPort:(int) aPort {
	port = aPort;
	return self;
}

- setLogin:(NSString*) aLogin {
    [login release];
    login = [ [NSString alloc] initWithString:aLogin];
    return self;
}

- setPassword:(NSString *) aPassword {
    [password release];
    password = [ [NSString alloc] initWithString:aPassword];
    return self;
}

- (void)dealloc {
	[name release];
	[login release];
	[password release];	
	{ [super dealloc]; return; };
}



@end
