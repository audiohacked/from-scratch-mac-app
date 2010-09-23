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
#import "SplitViewDelegate.h"
@implementation SplitViewDelegate
-(BOOL)splitView:(NSSplitView*)splitView canCollapseSubView:(NSView*)subview
{
	return NO;
}

#if 1
-(CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex
{
	if (dividerIndex == 0)
	{
		return 200.0;
	}
	else
	{
		return  400.0;
	}
}

-(CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex
{
	if (dividerIndex == 0)
	{
		return 200.0;
	}
	else
	{
		return  400.0;
	}
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainSplitPosition:(CGFloat)proposedPosition ofSubviewAt:(NSInteger)dividerIndex
{
	if (dividerIndex == 0)
	{
		return 200.0;
	}
	else
	{
		return 400.0;
	}
}
#endif

#if 0
-(void)splitView:(NSSplitView *)sender resizeSubviewsWithOldSize: (NSSize)oldSize
{
	CGFloat dividerThickness = [sender dividerThickness];
	NSRect leftRect = [[[sender subviews] objectAtIndex:0] frame];
	NSRect rightRect = [[[sender subviews] objectAtIndex:1] frame];
	NSRect newFrame = [sender frame];

	leftRect.size.height = newFrame.size.height;
	leftRect.origin = NSMakePoint(0, 0);
	rightRect.size.width = newFrame.size.width - leftRect.size.width - dividerThickness;
	rightRect.size.height = newFrame.size.height;
	rightRect.origin.x = leftRect.size.width + dividerThickness;

	[[[sender subviews] objectAtIndex:0] setFrame:leftRect];
	[[[sender subviews] objectAtIndex:1] setFrame:rightRect];
}
#endif

- (CGFloat)minPossiblePositionOfDividerAtIndex:(NSInteger)dividerIndex
{
	return 200.0;
}

- (CGFloat)maxPossiblePositionOfDividerAtIndex:(NSInteger)dividerIndex
{
	return 200.0;
}
@end
