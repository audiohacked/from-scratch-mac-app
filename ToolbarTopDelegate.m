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
#import "ToolbarTopDelegate.h"

@implementation ToolbarTopDelegate
-(NSToolbarItem *)toolbar:(NSToolbar*)toolbar itemForItemIdentifier:(NSString*)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	// We create and autorelease a new NSToolbarItem, and then go through the process of setting up its
	// attributes from the master toolbar item matching that identifier in our dictionary of items.
	NSToolbarItem *newItem = [[[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier] autorelease];
	NSToolbarItem *item=[toolbarItems objectForKey:itemIdentifier];

	[newItem setLabel:[item label]];
	[newItem setPaletteLabel:[item paletteLabel]];
	if ([item view]!=NULL)
	{
		[newItem setView:[item view]];
	}
	else
	{
		[newItem setImage:[item image]];
	}
	[newItem setToolTip:[item toolTip]];
	[newItem setTarget:[item target]];
	[newItem setAction:[item action]];
	[newItem setMenuFormRepresentation:[item menuFormRepresentation]];
	// If we have a custom view, we *have* to set the min/max size - otherwise, it'll default to 0,0 and the custom
	// view won't show up at all!  This doesn't affect toolbar items with images, however.
	if ([newItem view]!=NULL)
	{
		[newItem setMinSize:[[item view] bounds].size];
		[newItem setMaxSize:[[item view] bounds].size];
	}

	return newItem;
}

-(NSArray*)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar
{
	return [NSArray arrayWithObjects:@"FontStyle",@"FontSize",NSToolbarSeparatorItemIdentifier,@"BlueLetter", NSToolbarSpaceItemIdentifier,NSToolbarFlexibleSpaceItemIdentifier,NSToolbarPrintItemIdentifier,nil];
}

-(NSArray*)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar
{
	return [NSArray arrayWithObjects:@"FontStyle",@"FontSize",NSToolbarSeparatorItemIdentifier,@"BlueLetter",NSToolbarPrintItemIdentifier,nil];
}
@end
