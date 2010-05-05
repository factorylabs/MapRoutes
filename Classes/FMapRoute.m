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


// override the hit test to always return this object so we can touch events
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	return self;
}


- (id) initWithPoints:(NSArray*) points andFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		// store points
		_points = [[NSArray alloc] initWithArray:points];
		
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

// override setter to only apply visibility to the line
-(void)setHidden:(BOOL)isHidden
{
	[_line setHidden:isHidden];
}

- (void)dealloc
{
	[self killLineView];
	[_points release];
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
//	NSLog(@"checkToches:");
	BOOL isHidden = ([touches count] >= 2 ) ? YES : NO;
	if( isHidden ) [self setHidden:YES];
	else [self setHidden:NO];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
//	NSLog(@"touchesBegan");
	[self checkTouches:[event allTouches]];
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
//	NSLog(@"touchesMoved");
//	NSLog(@"moved. do we have touches? %i", [[event allTouches] count]);
	[self checkTouches:[event allTouches]];
	[super touchesMoved:touches withEvent:event];
}



@end
