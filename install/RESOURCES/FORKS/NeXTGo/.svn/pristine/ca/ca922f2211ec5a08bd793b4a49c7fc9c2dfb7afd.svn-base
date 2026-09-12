#
#  Test apps makefile for GNUstep X/RAW GUI Backend
#
#  Copyright (C) 1997 Free Software Foundation, Inc.
#
#  Author: Scott Christley <scottc@net-community.com>
#  Author: Felipe A. Rodriguez <far@ix.netcom.com>
#
#  This file is part of the GNUstep X/RAW GUI Backend.
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Library General Public
#  License as published by the Free Software Foundation; either
#  version 2 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
#  Library General Public License for more details.
#
#  If you are interested in a warranty or support for this source code,
#  contact Scott Christley at scottc@net-community.com
#
#  You should have received a copy of the GNU Library General Public
#  License along with this library; see the file COPYING.LIB.
#  If not, write to the Free Software Foundation,
#  59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

NeXTGo_MAIN_MODEL_FILE = NeXTGo.gorm

NeXTGo_APPLICATION_ICON = NeXTGo.tiff

include $(GNUSTEP_MAKEFILES)/common.make

# The application to be compiled
APP_NAME = NeXTGo
VERSION = 3.0
PACKAGE_NAME = NeXTGo

# Set the principal class
NeXTGo_PRINCIPAL_CLASS = GoApp

# The Objective-C source files to be compiled
NeXTGo_OBJC_FILES = \
	NeXTGo_main.m Board.m ClickCell.m Controller.m GameInspectorPanel.m \
	GoApp.m GoServer.m GoWindow.m igsglue.m igssocket.m

# C files
NeXTGo_C_FILES = \
	count.c countlib.c eval.c exambord.c findnext.c findopen.c\
        findpatn.c findsavr.c findwinr.c fioe.c genmove.c godict.c\
        igsparse.c initmark.c matchpat.c opening.c openregn.c\
        random.c score.c seed.c sethand.c smartgoeval.c\
        smartgoparse.c smartgotree.c suicide.c

# The Resource files to be copied into the app's resources directory
NeXTGo_RESOURCE_FILES = \
	Background.tiff NeXTGo.tiff NeXTGoFile.tiff \
	intergo.dct \
        NeXTGo.background-2.0.draw NeXTGo.background.draw \
        NeXTGoHelp.rtf

NeXTGo_LOCALIZED_RESOURCE_FILES = \
	NeXTGo.gorm

NeXTGo_LANGUAGES = English

-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/application.make
-include GNUmakefile.postamble

