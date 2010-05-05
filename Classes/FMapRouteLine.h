//
//  FMapRouteLine.h
//  MapRoutes
//
//  Created by Grant Davis on 5/3/10.
//  Copyright 2010 Factory Design Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FMapRoute.h"

// object that draws a line for a FMapRoute
@interface FMapRouteLine : UIView {
	MKMapView *_map;
	FMapRoute *_route;
	NSNumber *_thickness;
	UIColor *_color;
}

// sets thickness of the line
@property (nonatomic, retain) NSNumber *thickness;

// sets the primary color of the line
@property (nonatomic, retain) UIColor *color;

- (id)initWithRoute:(FMapRoute*)route withMap:(MKMapView*)map;

@end
