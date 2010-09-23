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
#import "SidebarDataItem.h"

@implementation SidebarDataItem
- (id)init
{
    self = [super init];
    self._name = @"Untitled";
    self.expandable = YES;
    self.selectable = YES;
    self.container = YES;
    return self;
}

- (id)initWithName:(NSString*)name
{
	self = [self init];
	self._name = name;
	return self;
}

- (void)dealloc
{
	[_name release];
	[super dealloc];
}

+ (SidebarDataItem*)nodeDataWithName:(NSString*)name
{
	return [[[SidebarDataItem alloc] initWithName:name] autorelease];
}

@synthesize _name, expandable, selectable, container;

- (NSString*)name
{
	return _name;
}

- (NSComparisonResult)compare:(id)anOther {
    // We want the data to be sorted by name, so we compare [self name] to [other name]
    if ([anOther isKindOfClass:[SidebarDataItem class]]) {
        SidebarDataItem *other = (SidebarDataItem *)anOther;
        return [_name compare:[other name]];
    } else {
        return NSOrderedAscending;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - '%@' expandable: %d, selectable: %d, container: %d", [super description], self._name, self.expandable, self.selectable, self.container];
}

@end
