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
@synthesize lineColor = _lineColor;


- (id)initWithRoute:(FMapRoute*)route withMap:(MKMapView*)map
{
	if(( self = [super initWithRoute:route withMap:map]))
	{
		[self setLineColor:[UIColor clearColor]];
		[self setDotColor:[UIColor redColor]];
	}
	return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
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
	CGContextSetLineJoin( lineContext, kCGLineJoinRound );
	CGContextSetLineCap( lineContext, kCGLineCapRound);
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
	float dashes[] = { 2.0, 7.0 };
	CGContextSetLineDash( lineContext, 0.0, dashes, 2);
	CGContextSetLineJoin( lineContext, kCGLineJoinRound );
	CGContextSetLineCap( lineContext, kCGLineCapRound );
	CGContextStrokePath( lineContext );
	CGContextDrawLayerInRect( context, rect, lineLayer );
	CGLayerRelease( lineLayer );
}


- (void)dealloc {
    [super dealloc];
}


@end
