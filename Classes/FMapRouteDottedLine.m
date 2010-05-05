//
//  FMapRouteDottedLine.m
//  MapRoutes
//
//  Created by Grant Davis on 5/3/10.
//  Copyright 2010 Factory Design Labs. All rights reserved.
//

#import "FMapRouteDottedLine.h"


@implementation FMapRouteDottedLine

@synthesize dotColor = _dotColor;
@synthesize dotDashes = _dotDashes;
@synthesize dotPhase = _dotPhase;
@synthesize lineColor = _lineColor;
@synthesize lineCap = _lineCap;
@synthesize lineJoin = _lineJoin;


- (id)initWithRoute:(FMapRoute*)route withMap:(MKMapView*)map
{
	if(( self = [super initWithRoute:route withMap:map]))
	{
		[self setLineColor:[UIColor clearColor]];
		[self setDotColor:[UIColor redColor]];
		[self setDotDashes:[NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:7], nil]];
		[self setDotPhase:[NSNumber numberWithInt:0]];
		[self setLineJoin:kCGLineJoinBevel];
		[self setLineCap:kCGLineCapSquare];
	}
	return self;
}

// style the route
- (void)drawRect:(CGRect)rect {
	
	// vars
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIColor *color;
	CGLayerRef lineLayer;
	CGContextRef lineContext;

	// create the solid white line.
	lineLayer = CGLayerCreateWithContext( context, rect.size, NULL);
	lineContext = CGLayerGetContext( lineLayer );
	color = _lineColor;
	[FMapRoute plotRoute:_route inContext:lineContext fromMap:_map inView:self];
	CGContextSetLineWidth( lineContext, [_thickness floatValue]);
	CGContextSetStrokeColorWithColor( lineContext, color.CGColor );
	CGContextSetLineJoin( lineContext, _lineJoin );
	CGContextSetLineCap( lineContext, _lineCap);
	CGContextStrokePath( lineContext );
	CGContextDrawLayerInRect( context, rect, lineLayer );
	CGLayerRelease( lineLayer );
	
	// create the red dotted line
	lineLayer = CGLayerCreateWithContext( context, rect.size, NULL);
	lineContext = CGLayerGetContext( lineLayer );
	color = _dotColor;
	[FMapRoute plotRoute:_route inContext:lineContext fromMap:_map inView:self];
	CGContextSetLineWidth( lineContext, [_thickness floatValue]);
	CGContextSetStrokeColorWithColor( lineContext, color.CGColor );
	
	// create array of dash values
	NSUInteger count = [_dotDashes count];
	float dashes[ count ];
	for (int i = 0; i < count; i++) 
	{
		NSNumber *num = [_dotDashes objectAtIndex:i];
		dashes[i] = [num floatValue];
	}
	
	CGContextSetLineDash( lineContext, [_dotPhase floatValue], dashes, count);
	CGContextSetLineJoin( lineContext, _lineJoin );
	CGContextSetLineCap( lineContext, _lineCap );
	CGContextStrokePath( lineContext );
	CGContextDrawLayerInRect( context, rect, lineLayer );
	CGLayerRelease( lineLayer );
}


- (void)dealloc {
	[_dotColor release];
	[_dotDashes release];
	[_dotPhase release];
	[_lineColor release];
    [super dealloc];
}


@end
