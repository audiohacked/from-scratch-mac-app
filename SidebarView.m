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
#import "SidebarView.h"
#import "SidebarDataItem.h"
#import "SidebarViewDelegate.h"

@implementation SidebarView
-(id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	rootTreeNode = [[self initRoot] retain];

	NSTableColumn * col = [[[NSTableColumn alloc] initWithIdentifier:@"(root)"] autorelease];

	[col setEditable:NO];
	[col setDataCell:[[[NSCell alloc] initTextCell:@""] autorelease]];
	[col setHeaderCell:[[[NSCell alloc] initTextCell:@"(root)"] autorelease]];
	[col setWidth: 200];
	[col setMinWidth: 200];
	[col setMaxWidth: 200];

	[self setSelectionHighlightStyle: NSTableViewSelectionHighlightStyleSourceList];
	[self setDataSource: self];
	[self setDelegate: [[SidebarViewDelegate alloc] init]];

	[self setAutoresizesOutlineColumn:YES];

	[self addTableColumn: col];
	[self setOutlineTableColumn: col];

	[self reloadData];

	return self;
}

-(void)dealloc
{
	[rootTreeNode release];
	[favoritesNode release];
	[listNode release];

	[super dealloc];
}

- (NSTreeNode*)initRoot
{
	SidebarDataItem * node = [SidebarDataItem nodeDataWithName:@"(root)"];
	NSTreeNode * result = [NSTreeNode treeNodeWithRepresentedObject:node];

	// create two containers
	SidebarDataItem *child1 = [[SidebarDataItem alloc] initWithName:@"Favorites"];
	SidebarDataItem *child2 = [[SidebarDataItem alloc] initWithName:@"Items"];
	favoritesNode = [[NSTreeNode treeNodeWithRepresentedObject:child1] retain];
	listNode = [[NSTreeNode treeNodeWithRepresentedObject:child2] retain];
	[child1 release];
	[child2 release];
	[[result mutableChildNodes] addObject:favoritesNode];
	[[result mutableChildNodes] addObject:listNode];

	return result;
}

- (NSArray*)childrenForItem:(id)item
{
	if (item == nil) {
		return [rootTreeNode childNodes];
	} else {
		return [item childNodes];
	}
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	return (item == nil) ? [[rootTreeNode childNodes] count] : [[item childNodes] count];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	SidebarDataItem * node = [item representedObject];
	return node.container;
}

- (id)outlineView:(NSOutlineView*)outlineView child:(NSInteger)index ofItem:(id)item
{
	NSArray * children = [self childrenForItem:item];
	return [children objectAtIndex:index];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	return [[item representedObject] name];
}

- (void)setOutlineTableColumn:(NSTableColumn *)outlineTableColumn
{
	
}

@end
