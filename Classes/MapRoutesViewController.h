//
//  MapRoutesViewController.h
//  MapRoutes
//
//  Created by Grant Davis on 4/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FMapRoute.h"

@interface MapRoutesViewController : UIViewController <MKMapViewDelegate> {
	MKMapView* _map;
	NSMutableArray* _points;
	FMapRoute* _route;
}

@property(nonatomic, readonly)MKMapView* map;

@end