//
//  MapRoutesAppDelegate.m
//  MapRoutes
//
//  Created by Grant Davis on 5/1/10.
//  Copyright Factory Design Labs 2010. All rights reserved.
//

#import "MapRoutesAppDelegate.h"
#import "MapRoutesViewController.h"

@implementation MapRoutesAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
