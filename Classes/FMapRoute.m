//
//  FMapRoute.m
//  MapRoutes
//
//  Created by Grant Davis on 5/3/10.
//  Copyright 2010 Factory Design Labs. All rights reserved.
//


#import "FMapRoute.h"
#import "FMapRouteLine.h"


@interface FMapRoute (Private)

- (void)checkTouches:(NSSet*)touches;
- (void)killLineView;

@end




@implementation FMapRoute

@synthesize coordinate = _center;
@synthesize points = _points;
@synthesize lineView = _line;


#pragma mark -
#pragma mark Static Methods

// static
+ (void)plotRoute:(FMapRoute*)route inContext:(CGContextRef)context fromMap:(MKMapView*)map inView:(UIView*)view
{
	for(int i=0; i < route.points.count; i++)
	{
		CLLocation* location = [route.points objectAtIndex:i];
		CGPoint point = [map convertCoordinate:location.coordinate toPointToView:view];
		
		if(i == 0)
		{
			// move to the first point
			CGContextMoveToPoint(context, point.x, point.y);
		}
		else
		{
			CGContextAddLineToPoint(context, point.x, point.y);
		}
	}
}


#pragma mark -
#pragma mark Public API


// override the hit test to only return the hit view
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	return _hit;
}


- (id) initWithPoints:(NSArray*) points andFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
//		[self setBackgroundColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:.2]];
		
		// create hit area that moves to match the rect of the map.
		_hit = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//		[_hit setBackgroundColor:[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:.2]];
//		[_hit setUserInteractionEnabled:YES];
//		[_hit setMultipleTouchEnabled:YES];
		[self addSubview:_hit];
		
		// store points
		_points = [[NSMutableArray alloc] initWithArray:points];
		
		// determine a logical center point for this route based on the middle of the lat/lon extents.
		double maxLat = -91;
		double minLat =  91;
		double maxLon = -181;
		double minLon =  181;
		
		for(CLLocation* currentLocation in _points)
		{
			CLLocationCoordinate2D coordinate = currentLocation.coordinate;
			
			if(coordinate.latitude > maxLat)
				maxLat = coordinate.latitude;
			if(coordinate.latitude < minLat)
				minLat = coordinate.latitude;
			if(coordinate.longitude > maxLon)
				maxLon = coordinate.longitude;
			if(coordinate.longitude < minLon)
				minLon = coordinate.longitude;
		}
		
		_span.latitudeDelta = (maxLat + 90) - (minLat + 90);
		_span.longitudeDelta = (maxLon + 180) - (minLon + 180);
		
		// the center point is the average of the max and mins
		_center.latitude = minLat + _span.latitudeDelta / 2;
		_center.longitude = minLon + _span.longitudeDelta / 2;
	}
	return self;
}

- (void)mapRegionChanged:(MKMapView*)map
{
	// move the internal line view.
	CGPoint origin = CGPointMake(0, 0);
	origin = [map convertPoint:origin toView:self];
	_line.frame = CGRectMake(origin.x, origin.y, map.frame.size.width, map.frame.size.height);
	[_line setNeedsDisplay];
	
	// move the hit area to the current region
	CGRect curRect = [map convertRegion:[map region] toRectToView:self];
	[_hit setFrame:curRect];
}


- (void)setLineView:(FMapRouteLine*)newLine
{
	// remove previous view
	if( _line ) [self killLineView];
	
	// retain and display view
	_line = newLine;
	[_line retain];
	
	[self addSubview:_line];
}


// getter for this route's region
- (MKCoordinateRegion)region
{
	MKCoordinateRegion region;
	region.center = _center;
	region.span = _span;
	return region;
}


- (void)show
{
	[_line setHidden:NO];
}

- (void)hide
{
	[_line setHidden:YES];
}

- (void)dealloc
{
	[self killLineView];
	[_points release];
	[_hit release];
	[super dealloc];
}

#pragma mark -
#pragma mark Private Methods


- (void)killLineView
{
	if( _line )
	{
		[_line removeFromSuperview];
		[_line release];
		_line = nil;
	}
}



#pragma mark -
#pragma mark Touch Handlers

- (void)checkTouches:(NSSet*)touches
{
	BOOL isHidden = ([touches count] >= 2 ) ? YES : NO;
	if( isHidden ) [self hide];
	else [self show];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	NSLog(@"touchesBegan");
	[self checkTouches:[event allTouches]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	NSLog(@"touchesMoved");
	[self checkTouches:[event allTouches]];
}



@end
