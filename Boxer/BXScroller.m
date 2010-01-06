/* 
 Boxer is copyright 2009 Alun Bestor and contributors.
 Boxer is released under the GNU General Public License 2.0. A full copy of this license can be
 found in this XCode project at Resources/English.lproj/GNU General Public License.txt, or read
 online at [http://www.gnu.org/licenses/gpl-2.0.txt].
 */


#import "BXScroller.h"
#import "NSBezierPath+MCAdditions.h"

@implementation BXScroller

//Appearance properties
//---------------------

//Todo: is there an easier way to determine this?
- (BOOL) isVertical
{
	NSSize size = [self frame].size;
	return size.height > size.width;
}

- (NSSize) knobMargin	{ return NSMakeSize(3.0, 0); }
- (NSSize) slotMargin	{ return NSMakeSize(3.0, 4.0); }

- (NSColor *)slotFill
{
	return [NSColor colorWithCalibratedWhite: 0.0 alpha: 0.2];
}

- (NSShadow *)slotShadow
{
	NSShadow *slotShadow	= [[NSShadow new] autorelease];
	[slotShadow setShadowOffset: NSMakeSize(0, -1)];
	[slotShadow setShadowBlurRadius: 3];
	[slotShadow setShadowColor: [NSColor colorWithCalibratedWhite: 0.0 alpha: 0.5]];

	return slotShadow; 
}

- (NSGradient *)knobGradient
{
	NSGradient *knobGradient = [[NSGradient alloc] initWithStartingColor: [NSColor colorWithCalibratedWhite: 0.25 alpha: 1.0]
															 endingColor: [NSColor colorWithCalibratedWhite: 0.20 alpha: 1.0]
								];
	return [knobGradient autorelease];
}


//Draw methods
//------------

- (BOOL) isOpaque	{ return NO; }

- (void) drawRect: (NSRect)dirtyRect
{
	[self drawKnobSlotInRect: [self bounds] highlight: NO];
	[self drawKnob];
}

- (void) drawKnob
{
	NSRect regionRect = [self rectForPart: NSScrollerKnob];
	if (NSEqualRects(regionRect, NSZeroRect)) return;	
	
	NSRect	knobRect;
	CGFloat	knobRadius;
	CGFloat	knobGradientAngle;
	NSGradient *knobGradient	= [self knobGradient];
	NSSize	knobMargin			= [self knobMargin];
	
	if ([self isVertical])
	{
		knobRect			= NSInsetRect(regionRect, knobMargin.width, knobMargin.height);
		knobRadius			= knobRect.size.width / 2;
		knobGradientAngle	= 0;
	}
	else
	{
		knobRect			= NSInsetRect(regionRect, knobMargin.height, knobMargin.width);
		knobRadius			= knobRect.size.height / 2;
		knobGradientAngle	= 90;
	}

	NSBezierPath *knobPath = [NSBezierPath bezierPathWithRoundedRect: knobRect
															 xRadius: knobRadius
															 yRadius: knobRadius];
	
	[knobGradient drawInBezierPath: knobPath angle: knobGradientAngle];
}

- (void) drawKnobSlotInRect: (NSRect)regionRect highlight:(BOOL)flag
{
	if (NSEqualRects(regionRect, NSZeroRect)) return;
	
	NSColor *slotFill		= [self slotFill];
	NSShadow *slotShadow	= [self slotShadow];
	
	
	NSRect slotRect;
	CGFloat slotRadius;
	NSSize slotMargin = [self slotMargin];
	
	if ([self isVertical])
	{	
		slotRect = NSInsetRect(regionRect, slotMargin.width, slotMargin.height);
		slotRadius = slotRect.size.width / 2;
	}
	else
	{
		slotRect = NSInsetRect(regionRect, slotMargin.height, slotMargin.width);
		slotRadius = slotRect.size.height / 2;
	}
	
	NSBezierPath *slotPath	= [NSBezierPath	bezierPathWithRoundedRect: slotRect
															 xRadius: slotRadius
															 yRadius: slotRadius];
	
	[slotFill set];
	[slotPath fill];
	[slotPath fillWithInnerShadow: slotShadow];
}
@end

@implementation BXHUDScroller

//Make the knob 1px thinner than the slot on each side
- (NSSize) knobMargin	{ return NSMakeSize(4.0, 1.0); }

- (NSGradient *)knobGradient
{
	NSGradient *knobGradient = [[NSGradient alloc] initWithStartingColor: [NSColor colorWithCalibratedWhite: 0.40 alpha: 1.0]
															 endingColor: [NSColor colorWithCalibratedWhite: 0.30 alpha: 1.0]
								];
	return [knobGradient autorelease];
}
@end