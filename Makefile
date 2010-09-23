##
##  This file is part of the MacAppsFromScratch project.
##
##  Copyright (C) 2010 Sean Nelson
##
##  This program is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation; either version 2 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program; if not, write to the Free Software
##  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
##

CC := gcc

#CFLAGS += -x objective-c
CFLAGS += -Wno-import -Werror

LDFLAGS += -lobjc -framework Foundation -framework Cocoa -framework WebKit

TARGET := test
OBJS := \
	AppDelegate.o \
	Badger.o \
	BadgeView.o \
	BrowserDelegate.o \
	BrowserView.o \
	MenuPopulator.o \
	SidebarDataItem.o \
	SidebarView.o \
	SidebarViewDelegate.o \
	SplitViewDelegate.o \
	ToolbarBottom.o \
	ToolbarTop.o \
	ToolbarTopDelegate.o \
	WindowDelegate.o \
	WindowView.o \
	main.o

default: $(TARGET)
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

%.o: %.m
	$(CC) $(CFLAGS) -c -o $@ $<

clean: 
	rm -rf *.o $(TARGET) $(TARGET).app

AppBundle: $(TARGET)
	mkdir -p $(TARGET).app/Contents/{_CodeSignature,Frameworks,MacOS,Plugins,Resources,Versions}
	cp Info.plist $(TARGET).app/Contents/Info.plist
	touch $(TARGET).app/Contents/PkgInfo
	cp $(TARGET) $(TARGET).app/Contents/MacOS/
