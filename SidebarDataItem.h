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

@interface SidebarDataItem : NSObject
{
@private
	NSString * _name;
	//SidebarDataItem * _parent;
	//NSMutableArray * _children;
	
	BOOL expandable;
	BOOL selectable;
	BOOL container;
}

- (id)initWithName:(NSString*)name;
+ (SidebarDataItem *)nodeDataWithName:(NSString *)name;
- (NSString*)name;

@property(readwrite, copy) NSString * _name;
@property(readwrite, getter=isExpandable) BOOL expandable;
@property(readwrite, getter=isSelectable) BOOL selectable;
@property(readwrite, getter=isContainer) BOOL container;

- (NSComparisonResult)compare:(id)other;
@end
