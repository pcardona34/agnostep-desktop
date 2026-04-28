####################################################
### A G N o S t e p  -  Desktop - by Patrick Cardona
### (c) 2026 - pcardona34 @ Github
###
### Thanks for the GNUstep Developers Community.
### This is Free and Open Source software.
### Read License in the root directory.
####################################################

####################################################
### AgnostepManager.app: Agnostep Manager
### for the Agnostep Desktop Project
### README.md
####################################################

This is a master piece of the Agnostep Desktop project as
it allows to install all the necessary software to create
the whole Desktop experience.

This is the UI interface of AgnostepManager to be used 
after a first installation of the core components.

# Dependency

AgnostepManager depends on agnostep-desktop project tools.
It is mandatory to keep this folder safe:

```
~/SOURCES/agnostep-desktop
```
If not present, to repair, just do this:

```
cd
mkdir -p SOURCES && cd SOURCES
git clone https://github.com/pcardona34/agnostep-desktop
``` 

# Install

You must have superuser privileges to type your password
when asked.

Execute:
```
./install.sh
```
This will copy necessary script in /usr/local/bin
then building and installing the application.

# Using

```
openapp AgnostepManager
```

Or run it from the `Applications` folder.

Then use menu item: `Manager...`

# Help

It is provided from the `Info/Help...` menu item.
