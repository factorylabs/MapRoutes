//
//  FMapRoute.h
//  MapRoutes
//
//  Created by Grant Davis on 5/3/10.
//  Copyright 2010 Factory Design Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class FMapRouteLine;

// object used as both a map annotation and annotation view
@interface FMapRoute : MKAnnotationView <MKAnnotation> {
	// points that make up the route. 
	NSMutableArray* _points;
	
	// computed span of the route
	MKCoordinateSpan _span;
	
	// computed center of the route. 
	CLLocationCoordinate2D _center;	
	
	// reference to the view that displays this route
	FMapRouteLine *_line;
	
	// hit area
	UIView *_hit;
}

@property (readonly) MKCoordinateRegion region;
@property (nonatomic, readonly) NSMutableArray *points;
@property (nonatomic, retain) FMapRouteLine *lineView;

// initialize with an array of points representing the route. 
- (id) initWithPoints:(NSArray*) points andFrame:(CGRect)frame;

// tells the route view to refresh
- (void)mapRegionChanged:(MKMapView*)map;

- (void)show;
- (void)hide;

// static utility method to start a line path and draw it within the context specified. 
// this only plots the line, and you are left to apply stroke and fills to it.
+ (void)plotRoute:(FMapRoute*)route inContext:(CGContextRef)context fromMap:(MKMapView*)map inView:(UIView*)view;

@end