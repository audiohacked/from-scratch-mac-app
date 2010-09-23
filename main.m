/*
 * This file is part of the MacAppsFromScratch project.
 *
 * Copyright (C) 2010 Sean Nelson
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
 */
#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"
#import "ToolbarTop.h"
#import "WindowDelegate.h"
#import "WindowView.h"

int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	NSApplication *NSApp = [NSApplication sharedApplication];

	int style = NSClosableWindowMask | 
		NSResizableWindowMask |
		NSTexturedBackgroundWindowMask |
		NSTitledWindowMask | 
		NSMiniaturizableWindowMask;
	NSRect windowSize = NSMakeRect(0, 0, 920, 700);

	NSWindow *window = [[NSWindow alloc] 
		initWithContentRect: windowSize
		styleMask: style
		backing: NSBackingStoreBuffered
		defer: NO];

	[window setTitle:@"Audiohacked"];
	[window setContentMinSize: windowSize.size];
	[window setToolbar:[[ToolbarTop alloc] initWithIdentifier:@"TopToolbar"]];
	[window setContentView:[[WindowView alloc] initWithFrame: [window frame] ]];
	[window setDelegate:[[WindowDelegate alloc] init]];
	[window makeKeyAndOrderFront:nil];

	[NSApp setDelegate:[[AppDelegate alloc] init]];
	[NSApp run];
	[pool release];
	return ( EXIT_SUCCESS );
}
