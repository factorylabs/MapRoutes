//
//  MapRoutesViewController.m
//  MapRoutes
//
//  Created by Grant Davis on 4/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MapRoutesViewController.h"
#import "FMapRouteLine.h"
#import "FMapRouteDottedLine.h"

@interface MapRoutesViewController (Private)

- (void)showRoutes;

@end


@implementation MapRoutesViewController

@synthesize map = _map;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// create map view
	_map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[_map setMapType:MKMapTypeSatellite];
	[_map setShowsUserLocation:YES];
	[_map setDelegate:self];
	[self setView:_map];
	
	// create points
	_points = [[NSMutableArray alloc] init];
	
	// glendale
	CLLocation* loc = [[CLLocation alloc] initWithLatitude:39.706835 longitude:-104.93093];
	[_points addObject:loc];
	[loc release];
	
	// the office
	loc = [[CLLocation alloc] initWithLatitude:39.718903 longitude:-104.95326];
	[_points addObject:loc];
	[loc release];
	
	// mile-high stadium
	loc = [[CLLocation alloc] initWithLatitude:39.744511 longitude:-105.020699];
	[_points addObject:loc];
	[loc release];
	
	
	// create route annotation and init
	_route = [[[FMapRoute alloc] initWithPoints:_points andFrame:CGRectMake(0, 0, 320, 480)] autorelease];
	[_map addAnnotation:_route];

	
	FMapRouteDottedLine *line = [[FMapRouteDottedLine alloc] initWithRoute:_route withMap:_map];
	[line setThickness:[NSNumber numberWithInt:10]];
	[line setDotColor:[UIColor redColor]];
	[line setLineColor:[UIColor whiteColor]];
	[_route setLineView:line];
	[line release];
	
	// center on the region
	[_map setRegion:[_route region]];
	
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_map release];
	[_points release];
	[_route release];
    [super dealloc];
}


#pragma mark -
#pragma mark MKMapViewDelegate Methods


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKAnnotationView* annotationView = nil;
	
	// check if the annotation is a route. if so, return the as the annotation route
	if([annotation isKindOfClass:[FMapRoute class]])
	{
		FMapRoute *routeAnnotation = (FMapRoute*) annotation;
		annotationView = routeAnnotation;
	}
	
	return annotationView;
}


- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	// tell the route the map has changed
	[_route mapRegionChanged:_map];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	// tell the route the map has changed, and also tell it to show if it has been hidden
	NSLog(@"regionDidChangeAnimated");
	[_route mapRegionChanged:_map];
	[_route show];
	
//	[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(showRoutes) userInfo:nil repeats:NO];
}

- (void) showRoutes
{
	NSLog(@"showRoutes");
	[_route show];
}



@end
