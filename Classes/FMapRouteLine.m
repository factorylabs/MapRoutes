//
//  FMapRouteLine.m
//  MapRoutes
//
//  Created by Grant Davis on 5/3/10.
//  Copyright 2010 Factory Design Labs. All rights reserved.
//

#import "FMapRouteLine.h"


@implementation FMapRouteLine

@synthesize thickness = _thickness;
@synthesize color = _color;

- (id)initWithRoute:(FMapRoute*)route withMap:(MKMapView*)map
{
	if((self =[super initWithFrame:CGRectMake(0, 0, map.frame.size.width, map.frame.size.height)]))
	{
		_map = map;
		_route = route;
		
		// init properties
		[self setClipsToBounds:YES];
		[self setBackgroundColor:[UIColor clearColor]];
		[self setThickness:[NSNumber numberWithInt:2]];
		[self setColor:[UIColor redColor]];
	}
	return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// create the path for the route
	[FMapRoute plotRoute:_route inContext:context fromMap:_map inView:self];
	
	// style the path
	CGContextSetStrokeColorWithColor(context, _color.CGColor );
	CGContextSetLineWidth(context, [_thickness floatValue]);
	CGContextStrokePath(context);
}

- (void)dealloc {
    [super dealloc];
}


@end
