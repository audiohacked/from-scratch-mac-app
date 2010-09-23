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

#import "BadgeView.h"
@interface BadgeView (Private)
- (void) badge:(NSImage*)badge string:(NSString*)string atHeight:(CGFloat)height adjustForQuit:(BOOL)quit;
@end

@implementation BadgeView

- (id) initWithFrame:(NSRect)frame
{
	if ((self = [super initWithFrame:frame])) {
		fQuitting = NO;
	}
	return self;
}

- (void) dealloc
{
    [fAttributes release];
	[super dealloc];
}

- (void) setQuitting
{
	fQuitting = YES;
}

- (void) drawRect: (NSRect)rect
{
	[[NSApp applicationIconImage] drawInRect:rect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	if (fQuitting)
	{
		NSImage * quitBadge = [NSImage imageNamed:@"QuitBadge.png"];
		[self badge:quitBadge string:NSLocalizedString(@"Quitting", "Dock Badger -> quit")
			atHeight: (NSHeight(rect) - [quitBadge size].height)*0.5 adjustForQuit:YES];
		return;
	}
}
@end

@implementation BadgeView (Private)
- (void) badge: (NSImage *) badge string: (NSString *) string atHeight: (CGFloat) height adjustForQuit: (BOOL) quit
{
    if (!fAttributes)
    {
        NSShadow * stringShadow = [[NSShadow alloc] init];
        [stringShadow setShadowOffset: NSMakeSize(2.0, -2.0)];
        [stringShadow setShadowBlurRadius: 4.0];
        
        fAttributes = [[NSMutableDictionary alloc] initWithCapacity: 3];
        [fAttributes setObject: [NSColor whiteColor] forKey: NSForegroundColorAttributeName];
        [fAttributes setObject: stringShadow forKey: NSShadowAttributeName];
        
        [stringShadow release];
    }
    
    NSRect badgeRect;
    badgeRect.size = [badge size];
    badgeRect.origin.x = 0.0;
    badgeRect.origin.y = height;
    
    [badge drawInRect: badgeRect fromRect: NSZeroRect operation: NSCompositeSourceOver fraction: 1.0];
    
    //make sure text fits on the badge
    CGFloat fontSize = 26.0;
    NSSize stringSize;
    do
    {
        [fAttributes setObject: [NSFont boldSystemFontOfSize: fontSize] forKey: NSFontAttributeName];
        stringSize = [string sizeWithAttributes: fAttributes];
        fontSize -= 1.0;
    } while (NSWidth(badgeRect) < stringSize.width);
    
    //string is in center of image
    NSRect stringRect;
    stringRect.origin.x = NSMidX(badgeRect) - stringSize.width * 0.5;
    stringRect.origin.y = NSMidY(badgeRect) - stringSize.height * 0.5 + (quit ? 2.0 : 1.0); //adjust for shadow, extra for quit
    stringRect.size = stringSize;
    
    [string drawInRect: stringRect withAttributes: fAttributes];
}
@end
