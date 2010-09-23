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

#import "Badger.h"
#import "BadgeView.h"

@implementation Badger

- (id) init
{
	if ((self = [super init])) {
		BadgeView * view = [[BadgeView alloc] initWithFrame:[[[NSApp dockTile] contentView] frame]];
		[view release];
	
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBadge) name:@"DockBadgeChange" object:nil];
	}
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[super dealloc];
}

- (void) updateBadge
{
	[[NSApp dockTile] display];
}

- (void) clearBadge
{
	[[NSApp dockTile] setBadgeLabel: @""];	
}

- (void) setQuitting
{
	[(BadgeView*)[[NSApp dockTile] contentView] setQuitting];
	[[NSApp dockTile] display];
}

- (void) setRunning
{
	[[NSApp dockTile] setBadgeLabel: @"Runn'"];
}

- (void) setUpdating
{
	[[NSApp dockTile] setBadgeLabel: @"Updating App"];
}

@end
