//
//  MapRoutesAppDelegate.h
//  MapRoutes
//
//  Created by Grant Davis on 5/1/10.
//  Copyright Factory Design Labs 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapRoutesViewController;

@interface MapRoutesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapRoutesViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapRoutesViewController *viewController;

@end

