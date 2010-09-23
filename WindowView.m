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
#import "WindowView.h"
#import "BrowserView.h"
#import "SidebarView.h"
#import "SplitViewDelegate.h"
#import "ToolBarBottom.h"

#import "SidebarViewDelegate.h"

@implementation WindowView

- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];

	NSView *browser = [[BrowserView alloc] initWithFrame:NSMakeRect(10, 10, 600, 600) frameName:@"WebKit" groupName:@"App"];
	NSView *sidebar = [[SidebarView alloc] initWithFrame:NSMakeRect(10, 10, 400, 600)];
	splitView = [[NSSplitView alloc] initWithFrame:NSMakeRect(10, 75, 900, 600)];
	[splitView setVertical:YES];
	[splitView setDelegate:[[SplitViewDelegate alloc] init]];
	[splitView addSubview: sidebar];
	[splitView addSubview: browser];
	[self addSubview:splitView];

	NSView *toolBar = [[ToolBarBottom alloc] initWithFrame:NSMakeRect(0, 0, 375, 75)];
	[self addSubview:toolBar];

	return self;
}

-(void)dealloc
{
	[super dealloc];
}

@end
